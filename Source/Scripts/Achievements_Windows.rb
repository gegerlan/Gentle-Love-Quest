# Contains all achievement in the game
class Achievements
  # Default achievements
  ACHIEVEMENTS = {
    0  => ["Like A Virgin", false, "Fucked for the very first time"],
    1  => ["Nymphomania", false, "Fucked 1,000 times"],
    2  => ["Sex bomb", false, "Fucked 1,000,000 times"],

    3  => ["Exploration", false, "Masturbated"],
    4  => ["Self Esteem", false, "Masturbated 1,000 times"],
    5  => ["Narcissism", false, "Masturbated 1,000,000 times"],
    
    6  => ["My First Candle", false, "Sucked a cock"],
    7  => ["Like The Wind", false, "Sucked 1,000 cocks"],
    8  => ["Cock Smoker!", false, "Sucked 1,000,000 cocks"],
    
    9  => ["No Pain, No Gain", false, "Fucked in the ass"],
    10 => ["Vaseline Optional", false, "Fucked in the ass 1,000 times"],
    11 => ["Where's The Backdoor?", false, "Fucked in the ass 1,000,000 times"],      
    
    12 => ["Experimentation", false, "Fucked by a woman"],
    13 => ["Indiscrimination", false, "Fucked by a woman 1,000 times"],
    14 => ["Thanks For All The Fish", false, "Fucked by a woman 1,000,000 times"],
    
    15 => ["Inibitions, me?", false, "Exposed indecently to someone"],
    16 => ["The Naked Maja", false, "Exposed indecently to 1,000 people"],
    17 => ["Lady Godiva", false, "Exposed indecently to 1,000,000 people"],

    18 => ["A Rock And A Hard Place", false, "Worked as whore"],
    19 => ["Like A Pro", false, "Worked as whore 1,000 times"],
    20 => ["A Ticket to Paradise", false, "Worked as whore 1,000,000 times"],

    21 => ["My New Mascot", false, "Fucked by an animal"],
    22 => ["Animal Love", false, "Fucked by 1,000 animals"],
    23 => ["Who's The Pet Now?", false, "Fucked by 1,000,000 animals"],
    
    24 => ["Poke-lover", false, "Fucked by a Pokemon"],
    25 => ["Gotta Catch Them All", false, "Fucked by 1,000 pokemons"],
    26 => ["Pokemon Mistress", false, "Fucked by 1,000,000 pokemons"],

    27 => ["Naughty Spiral", false, "Fucked under mind control"],
    28 => ["Lose Your Senses", false, "Fucked under mind control 1,000 times"],
    29 => ["Fuck Doll", false, "Fucked under mind control 1,000,000 times"],

    30 => ["An Unwanted Guest", false, "Raped"],
    31 => ["Broken Lock", false, "Raped 1,000 times"],
    32 => ["Free Buffet", false, "Raped 1,000,000 times"],
    
    33 => ["Got Milk?", false, "Produced 1 liter of milk"],
    34 => ["Udderly delicious", false, "Produced 1,000 liter of milk"],
    35 => ["The Milky Way", false, "Produced 1,000,000 liter of milk"],

    36 => ["Zidane", false, "Rescue Vivi! She needs help!"],
    37 => ["For the Horde!", false, "Enslaved by The Horde"],
    38 => ["The Beast's Pet", false, "Enslaved by an Orc Soldier"],      
    39 => ["Lost Lost Number", false, "Became Lost Number's mascot"],
    40 => ["White Knight", false, "Rescue Princess Elisabeth"],
    41 => ["Green Kids", false, "Enslaved for Orc Breeding"]
  }
  # Where unlocked achievements are stored
  SAVE_FILE = "Data/Achievements.rvdata"
  def initialize
    @data_achievements = {}
    load_data
  end
  # Get achievement instance
  def self.instance
    return (@@instance ||= self.new)
  end
  # Get achievement at index
  def [](index)
    return get(index)
  end
  # Get achievement at index
  def get(index)
    return @data_achievements[index]
  end
  # Return number of achievements
  def size
    return @data_achievements.length
  end
  def load_save(fi = nil)
    begin
      fi = File.open(SAVE_FILE, "rb") if fi == nil
      completes = Marshal.load(fi)
    rescue
      completes = []
    end
    completes
  end
  # Load store achievement data
  def load_data
    completes = load_save
    ACHIEVEMENTS.each do |index, content|
      title, passed, description = content
      completed = completes.include?(index)
      @data_achievements[index] = Achievement.new(title, description, completed)
    end
  end
  # Save cleared achievements to SAVE_FILE
  def save
    completed_achievements = []
    @data_achievements.each do |index, achievement|
      completed_achievements << index if achievement.completed?
    end
    
    File.open(SAVE_FILE, "wb+") do |f|
      f.flock File::LOCK_EX
      completed_achievements |= load_save(f)
      Marshal.dump(completed_achievements, f)
    end
  end
  # Remove all achievements
  def clear
    @data_achievements = nil
  end
end
# An achievement
class Achievement
  attr_reader :title
  attr_reader :description
  attr_reader :completed
  def initialize(title, description, completed = false)
    @title = title
    @description = description
    @completed = completed
  end
  # Has the achievement been unlocked?
  def completed?
    return @completed
  end
  # Set the achievement's unlocked state
  def completed=(value)
    return @completed = value
  end
end

class Window_Achievement_Complete < Window_NoModal
  def initialize
    super(70, 150,400, 55)
    @queue = []
    @achievements = Achievements.instance
  end
  def show_achievement(id)
    return if @achievements[id] == nil
    @queue.push(id)
  end
  def update
    if !@queue.empty?
      if !self.visible
        achiev = @queue.shift
        show_message("Achievement! [" + @achievements[achiev].title + "] obtained!", 180)
        Sound.play_recovery
      end
    end
    super
  end
end

class Scene_Map < Scene_Base
  
  alias emt_start start
  alias emt_update update
  alias emt_terminate terminate
  
  def start
    emt_start
    @achievements = Achievements.instance
    @achievement_complete_window = Window_Achievement_Complete.new
  end

  def complete_achievement(id)
    return unless !@achievements[id].completed?
    @achievements[id].completed = true
    @achievements.save
    @achievement_complete_window.show_achievement(id)
  end
  
  def update
    emt_update
    @achievement_complete_window.update
  end
  
  def terminate
    emt_terminate
    @achievement_complete_window.dispose
  end

end

#==============================================================================
# ** Window_Achievement
#------------------------------------------------------------------------------
#  This window displays a list of achievements
  #==============================================================================
class Window_Achievements < Window_Selectable
  #--------------------------------------------------------------------------
  # * Object Initialization
  #     x      : window x-coordinate
  #     y      : window y-coordinate
  #     width  : window width
  #     height : window height
  #--------------------------------------------------------------------------
  def initialize(x, y, width, height)
    super(x, y, width, height)
    @column_max = 2
    self.index = 0
    @data = Achievements.instance
    @item_max = @data.size
    create_contents
    for i in 0...@data.size
      draw_achievement(i)
    end
  end
  #--------------------------------------------------------------------------
  # * Draw Achievement
  #     index : Achievement number
  #--------------------------------------------------------------------------
  def draw_achievement(index)
    rect = item_rect(index)
    self.contents.clear_rect(rect)
    achievement = @data[index]
    if achievement != nil
      rect.width -= 4
      self.contents.font.color = normal_color
      self.contents.font.color.alpha = @data[index].completed? ? 255 : 128
      self.contents.draw_text(rect.x + 24, rect.y, 172, WLH, @data[index].title)
    end
  end
  #--------------------------------------------------------------------------
  # * Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(@data[self.index].description)
  end
end

#==============================================================================
# ** Scene_Achievements
#------------------------------------------------------------------------------
#  This class performs the item screen processing.
#==============================================================================
class Scene_Achievements < Scene_Base
  #--------------------------------------------------------------------------
  # * Start processing
  #--------------------------------------------------------------------------
  def start
    super
    create_menu_background
    @viewport = Viewport.new(0, 0, 544, 416)
    @help_window = Window_Help.new
    @help_window.viewport = @viewport
    @achievement_window = Window_Achievements.new(0, 56, 544, 360)
    @achievement_window.viewport = @viewport
    @achievement_window.help_window = @help_window
    @achievement_window.active = true;
  end
  #--------------------------------------------------------------------------
  # * Termination Processing
  #--------------------------------------------------------------------------
  def terminate
    super
    dispose_menu_background
    @viewport.dispose
    @help_window.dispose
    @achievement_window.dispose
  end
  #--------------------------------------------------------------------------
  # * Update Frame
  #--------------------------------------------------------------------------
  def update
    super
    update_menu_background
    @help_window.update
    @achievement_window.update
    update_item_selection
  end
  #--------------------------------------------------------------------------
  # * Update Item Selection
  #--------------------------------------------------------------------------
  def update_item_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      return_scene
    end
  end
  #--------------------------------------------------------------------------
  # * Return to Original Screen
  #--------------------------------------------------------------------------
  def return_scene
    $scene = Scene_Menu.new(5)
  end
end