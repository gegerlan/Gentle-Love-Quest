class Game_System
  alias emt_initialize initialize
  
  def initialize
    emt_initialize
    @Achievements = {
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
  end
  
  def Achievements
    return @Achievements
  end
end

class Window_Achievement_Complete < Window_NoModal
  
  def initialize
    super(70, 150,400, 55)
    @queue = []
  end
  
  def show_achievement(id)
    return if !$game_system.Achievements.include?(id)
    @queue.push(id)
  end

  def update
    if !@queue.empty?
      if !self.visible
        achiev = @queue.shift
        show_message("Achievement! [" + $game_system.Achievements[achiev][0] + "] obtained!", 180)
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
    @achievement_complete_window = Window_Achievement_Complete.new
  end

  def complete_achievement(id)
    return unless !$game_system.Achievements[id][1]
    $game_system.Achievements[id][1] = true
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
    @data = $game_system.Achievements
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
      self.contents.font.color.alpha = @data[index][1] ? 255 : 128
      self.contents.draw_text(rect.x + 24, rect.y, 172, WLH, @data[index][0])
    end
  end
  #--------------------------------------------------------------------------
  # * Update Help Text
  #--------------------------------------------------------------------------
  def update_help
    @help_window.set_text(@data[self.index][2])
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