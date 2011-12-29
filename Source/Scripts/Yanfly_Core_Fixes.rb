#===============================================================================
# 
# Yanfly Engine Melody - Core Fixes and Upgrades
# Last Date Updated: 2010.05.04
# Level: Easy
# 
# Rather than making individual scripts of things that need fixing, this giant
# compilation will include all of the necessary fixes dedicated towards making
# RGSS2 for RPG Maker VX run correctly. It is recommended that you place this
# script at the top of your custom script selection to allow for the best
# possible compatibility.
# 
# The fixes include:
# 
# - Animation Overlay Fix -
# In battle, when an animation targeting the whole screen is being used, the
# animation is actually played multiple times. This causes an exponentially
# growing overlay in both graphics and sound and plays out rather choppy, too.
# The fix will cause the animation to play only once if it is an overlay. And
# unlike the YERD version, this one also allows non-overlayed enemies to flash.
# 
# - Bitmap Error Fix -
# If any selectable window has more than 341 rows for whatever reason, the game
# will crash with a "failed to create bitmap error" leaving the player curious
# as to what just happened. This essentially means that you cannot have more
# than 682 items in your item menu, skill menu, or equip menu at all without
# risking a crash. This is because RGSS2, by default, can only create bitmaps
# in size of up to 8192 pixels in width or height.
# 
# - Disposed Window Debug -
# Sometimes when a window is disposed but hasn't been set to nil, the game will
# crash without even telling you which window has been disposed. Although this
# will prevent the crash, in $TEST and $BTEST mode (test play mode), a pop up
# appears to list which window variable needs to be cleared so you can maximize
# your code better. The latter feature is mostly for debug purposes.
# 
# - Enemy Reappear Fix -
# In the event that a state is applied to a monster and that monster dies, if
# the state's timer runs out, a message appears that the monster is suddenly
# cured of poison or whatever. Not only does the message appear, the monster's
# sprite reappears in battle, too. The monster, however, is not selectable. This
# script will fix that problem by halting the automatic state removal process.
# 
# - Game Interpreter Fix -
# By default, the English version of RPG Maker VX has faulty coding for the ever
# used Control Variables event command. The Game Interpreter Fix corrects the
# problem and makes it function as it should.
# 
# - Help Window Codes Upgrade -
# Now, you can use \n[x] and \v[x] in the help window. Using \n[0] will return
# the user's name if applicable. If not, the "User" will be returned. Use this
# to personalize the description windows a bit more. Colour codes not included
# to preserve engine efficiency.
# 
# - Interface Fix and Upgrades -
# The fixes include things such as modifying MaxHP and gauges not changing to
# lower current values if they're above the maximum values. Upgrades include
# adding an exhaust colour for lower than base value MaxHP/MaxMP values. Other
# upgrades include allowing you to easily change the colour of the gauges, text
# colours, etc. in the module. Furthermore, whenever contents are reset, the
# default colour used is pure white regardless of whatever colour is was set as
# the first colour inside of the window skin. This fix will adjust it to the
# first windowskin colour instead.
# 
# - Menu Actor Switch Fix -
# When using L or R to switch between actors in the Skill and Equip menus, what
# is strange is that upon leaving those menus and selecting the Skill or Equip
# option again, it will not target the newly switched actor, but rather, the
# previous. This little fix will help update that method.
# 
# - Message Window Actor Fix -
# Previously, when using \n[0] in the message window, it would not return the
# leading actor like it did normally before in RPG Maker 2000 and 2003. Now,
# it will have the functionality to do so again. And as an added bonus, using
# the \f[0] tag will cause the message window to use the leading actor's face.
# 
# - Outlined Text and Gauge Upgrade -
# A bit of a visual effect, but at the same time, it really helps make text a
# whole lot easier to read. Gauges will also not blend in with the backgrounds
# as much either. This will replace the shadow text effect and cause that font
# flag to create an outline instead.
# 
# - Prevent Skill Scene Actor Switch -
# By default, pressing L and R in the Skill Scene causes the scene to swap to
# the previous actor and next actor respectively. This is problematic if the
# actor has a lot of skills that would require scrolling and thus, the L and R
# buttons will be locked if more than 22 skills are present (the amount that
# would require L and R to scroll). This amount is adjustable in the module to
# change accordingly to different sized lists should the Skill Scene be affected
# by other scripts.
# 
# - Shown States Fix and Upgrade -
# More technical RPG's use states to produce additional effects. However, the
# creators of those games would encounter problems if they were to use states
# with invisible icons. This fix will cause states with an icon index of 0 to
# be omitted from the shown states. The upgrade of this script will also allow
# the option to display the number of turns left for a state in the upper left
# corner of that state.
# 
# - State Resist Fix - 
# When RPG Maker VX checks if an enemy is resistant against a certain state for
# applying states, it will always return false regardless of what probability
# rate given to the enemy. This script will change the definition altogether for
# enemies and returns the check as true if the state has a working chance of 10%
# or lower against that particular enemy. Nothing will be considered resistant
# against the death state, however.
# 
# - Turn Order Fix -
# For those that are using the default battle system, you've probably realized
# sooner or later that turn order is only calculated once at the start of each
# turn and retains that order even if speed has been changed in between turns.
# This means that enemies which your actors have slowed on the same turn will
# still act in the same order calculated for that turn. Agility status effects
# and the like do not take effect until the following turn, which may become
# rather useless for some. This script fixes that and recalculates turn order
# after each and every action.
# 
# - Usable Item Fix -
# This prevents non-battle usable items to be included into the item menu during
# battle. What VX did originally was allow any kind of item so long as it was
# an item type (not weapon type or armour type) despite whether or not it was
# usable in battle. This one just limits the item menu to the ones usable in a
# battle. For those with KGC's Usable Equipment script, this also works.
# 
# - Wait for Animation Fix -
# In battle, the wait for animation method should technically work fine. It in
# general should run endless graphical updating loops until the animation is
# done playing. However, the method is ran before the animation is loaded so it
# kills itself before even really doing its own function.
# 
# - Variance Fix -
# Skills have a variable called variance that gives them a random modifier for
# damage so that it doesn't appear the same as always. However, the formula for
# applying variance for a damage skill and the formula for a healing skill are
# completely incompatible since the variance treats healing calculations as
# damage calculations. This fix will adjust the calculations properly.
# 
#===============================================================================
# Updates
# -----------------------------------------------------------------------------
# o 2010.05.04 - Prevent Skill Scene next_actor and prev_actor.
# o 2010.02.16 - wait_for_animation fix
# o 2010.01.07 - create_contents font colour reset fix
# o 2010.01.05 - Animation frame rate adjustment for 60fps animations.
# o 2009.12.17 - Added <hide state> tag for states.
# o 2009.12.15 - Variance Fix added.
# o 2009.12.14 - Menu Actor Switch fix added.
#              - Message Window Actor fix added.
#              - Help Window Codes upgrade added.
# o 2009.12.04 - Started Script and finished.
#===============================================================================
# Instructions
# -----------------------------------------------------------------------------
# To install this script, open up your script editor and copy/paste this script
# to an open slot below ▼ Materials but above ▼ Main. Remember to save.
# 
# -----------------------------------------------------------------------------
# State Tags - Insert the following tags into State noteboxes.
# -----------------------------------------------------------------------------
# <turn colour: x>
# If you want certain states to display the turns remaining in a different
# colour for the sake of distinguishing them or so they'll show up better on
# the state due to colour incompatibility, use this tag in the state's notebox.
# x is equal to the text colour value found in your window skin file.
# 
# <hide state>
# This will cause the state to be not drawn even if it has has no icon. The
# state will appear elsewhere in other state lists, but not in the actor window
# where it'll be extremely intrusive.
# 
#===============================================================================
# Compatibility
# -----------------------------------------------------------------------------
# Note: This script may not work with former Yanfly Engine ReDux scripts.
#       Use Yanfly Engine Zealous scripts to work with this if available.
#===============================================================================

$imported = {} if $imported == nil
$imported["CoreFixesUpgradesMelody"] = true

module YEM
  module FIXES
    
    # If the success rate is under this percentage, the enemy will be considered
    # resistant against that state.
    MIN_STATE_RESIST = 10
    
    # This adjusts the animation rate played by battle animations. By default,
    # animations are played at 40fps with a rate of 4. By changing it to 3, the
    # animations will change to 60fps for a smoother effect. Beware of using
    # heavy animations that may cause the player's computer to explode.
    ANIMATION_RATE = 3
    
    # This adjusts the amount of skills needed to prevent the L and R buttons
    # from scrolling across different actors in the Skill Scene.
    SKILL_LIST_SIZE = 22
    
  end # FIXES
  module UPGRADE
    
    # By enabling this option, shadowed text will instead, become outlined text
    # and gauges will also show an outline around them, too. This visual effect
    # is to allow for easier reading and viewing.
    OUTLINE = true
    
    # This determines what will be displayed when using \n[0] in a description
    # and no main actor is present.
    HELP_WINDOW_0 = "User"
    
    # The following hash allows you to change the text colour values used for
    # various common interface
    COLOURS ={
    # Used For   => Colour ID
      :normal    =>  0,  # Normal text colour.
      :system    => 16,  # System use. Namely vocab.
      :crisis    => 17,  # Low HP colour.
      :lowmp     => 17,  # Low MP colour.
      :knockout  => 18,  # Knocked out text colour.
      :gaugeback => 19,  # Generic gauge back.
      :exhaust   =>  7,  # Exhausted HP and MP bars.
      :hp_back   => 19,  # HP gauge back.
      :hp_gauge1 => 20,  # HP gradient no 1.
      :hp_gauge2 => 21,  # HP gradient no 2.
      :mp_back   => 19,  # MP gauge back.
      :mp_gauge1 => 22,  # MP gradient no 1.
      :mp_gauge2 => 23,  # MP gradient no 2.
      :power_up  => 24,  # Boosted stat colour.
      :power_dn  => 25,  # Nerfed stat colour.
    } # Do not remove.
    
    # This determines at what percentage will HP and MP display their crisis
    # colours rather than a set 25%. Default value is 25%.
    CRISIS_HP = 25
    CRISIS_MP = 25
    
    # This will determine the default gauge height used for HP and MP gauges.
    GAUGE_HEIGHT = 6
    
    # Enable this to show the turns remaining on a state. This will only appear
    # if a state has a turn counter and has more than an initial state release
    # probability of greater than 0%. The next values adjust the default text
    # colour used if no <turn colour n> tag is used. 
    DRAW_STATE_TURNS  = true
    STATE_TURN_COLOUR = 0
    STATE_TURN_F_SIZE = 16       # Font size used for the state.
    STATE_TURN_BOLD   = false    # Should the font be bold?
    
  end # UPGRADE
end # YEM

#===============================================================================
# Editting anything past this point may potentially result in causing computer
# damage, incontinence, explosion of user's head, coma, death, and/or halitosis.
# Therefore, edit at your own risk.
#===============================================================================

module YEM
  module REGEXP
  module STATE
      
    TURN_COLOUR = /<(?:TURN_COLOUR|turn colour|turn color):[ ]*(\d+)>/i
    HIDE_STATE  = /<(?:HIDE_STATE|hide state)>/i
      
  end # STATE
  end # REGEXP
end # YEM

#===============================================================================
# RPG::State
#===============================================================================

class RPG::State
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :turn_colour
  attr_accessor :hide_state
  
  #--------------------------------------------------------------------------
  # common cache: yem_cache_state_cfu
  #--------------------------------------------------------------------------
  def yem_cache_state_cfu
    @turn_colour = YEM::UPGRADE::STATE_TURN_COLOUR; @hide_state = false
    
    self.note.split(/[\r\n]+/).each { |line|
      case line
      when YEM::REGEXP::STATE::TURN_COLOUR
        @turn_colour = $1.to_i
      when YEM::REGEXP::STATE::HIDE_STATE
        @hide_state = $1.to_i
      end
    } # end self.note.split
  end # yem_cache_state_cfu
  
end # RPG::State

#===============================================================================
# Scene_Title
#===============================================================================

class Scene_Title < Scene_Base
  
  #--------------------------------------------------------------------------
  # new method: load_bt_database
  #--------------------------------------------------------------------------
  alias load_bt_database_cfu load_bt_database unless $@
  def load_bt_database
    load_bt_database_cfu
    load_cfu_cache
  end
  
  #--------------------------------------------------------------------------
  # alias method: load_database
  #--------------------------------------------------------------------------
  alias load_database_cfu load_database unless $@
  def load_database
    load_database_cfu
    load_cfu_cache
  end
  
  #--------------------------------------------------------------------------
  # new method: load_cfu_cache
  #--------------------------------------------------------------------------
  def load_cfu_cache
    groups = [$data_states]
    for group in groups
      for obj in group
        obj.yem_cache_state_cfu if obj.is_a?(RPG::State)
      end
    end
  end
  
end # Scene_Title

#===============================================================================
# Bitmap
#===============================================================================

class Bitmap

  #--------------------------------------------------------------------------
  # alias method: draw_text
  #--------------------------------------------------------------------------
  if YEM::UPGRADE::OUTLINE
  alias draw_text_cfu draw_text unless $@
  def draw_text(*args)
    unless self.font.shadow
      draw_text_cfu(*args)
      return
    end
    case args.size
    when 2, 3
      dx, dy, dw, dh, text, align =
      args[0].x, args[0].y, args[0].width, args[0].height, args[1],
      args[2].nil? ? 0 : args[2]
    else
      dx, dy, dw, dh, text, align =
      args[0], args[1], args[2], args[3], args[4],
      args[5].nil? ? 0 : args[5]
    end
    original_colour = self.font.color.clone
    self.font.shadow = false
    alpha = self.font.color.alpha
    self.font.color = Color.new(0, 0, 0, alpha)
    draw_text_cfu(dx-1, dy-1, dw, dh, text, align)
    draw_text_cfu(dx+1, dy-1, dw, dh, text, align)
    draw_text_cfu(dx-1, dy+1, dw, dh, text, align)
    draw_text_cfu(dx+1, dy+1, dw, dh, text, align)
    self.font.color = original_colour
    draw_text_cfu(dx, dy, dw, dh, text, align)
    self.font.shadow = true
  end
  end # YEM::UPGRADE::OUTLINE
  
end # Bitmap

#===============================================================================
# Game_Battler
#===============================================================================

class Game_Battler
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :pseudo_ani_id
  attr_accessor :state_turns
  
  #--------------------------------------------------------------------------
  # overwrite method: maxmp
  #--------------------------------------------------------------------------
  def maxmp
    return [[base_maxmp + @maxmp_plus, 0].max, maxmp_limit].min
  end
  
  #--------------------------------------------------------------------------
  # new method: maxmp_limit
  #--------------------------------------------------------------------------
  def maxmp_limit
    return 9999
  end
  
  #--------------------------------------------------------------------------
  # alias method: clear_sprite_effects
  #--------------------------------------------------------------------------
  alias clear_sprite_effects_cfu clear_sprite_effects unless $@
  def clear_sprite_effects
    clear_sprite_effects_cfu
    @pseudo_ani_id = 0
  end
  
  #--------------------------------------------------------------------------
  # alias method: remove_states_auto
  #--------------------------------------------------------------------------
  alias remove_states_auto_cfu remove_states_auto unless $@
  def remove_states_auto
    return if self.dead?
    remove_states_auto_cfu
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: state_resist?
  #--------------------------------------------------------------------------
  def state_resist?(state_id)
    return false if state_id == 1
    return false if state_probability(state_id) > YEM::FIXES::MIN_STATE_RESIST
    return true
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: apply_variance
  #--------------------------------------------------------------------------
  def apply_variance(damage, variance)
    amp = [damage.abs * variance / 100, 0].max
    if damage > 0
      damage += rand(amp+1) + rand(amp+1)
      damage -= amp
    elsif damage < 0
      damage -= rand(amp+1) + rand(amp+1)
      damage += amp
    end
    return damage
  end
  
end # Game_Battler

#==============================================================================
# Game_Interpreter
#==============================================================================

class Game_Interpreter
  
  #--------------------------------------------------------------------------
  # overwrite method: command_122
  #--------------------------------------------------------------------------
  def command_122
    value = 0
    case @params[3]  # Operand
    when 0  # Constant
      value = @params[4]
    when 1  # Variable
      value = $game_variables[@params[4]]
    when 2  # Random
      value = @params[4] + rand(@params[5] - @params[4] + 1)
    when 3  # Item
      value = $game_party.item_number($data_items[@params[4]])
    when 4 # Actor
      actor = $game_actors[@params[4]]
      if actor != nil
        case @params[5]
        when 0  # Level
          value = actor.level
        when 1  # Experience
          value = actor.exp
        when 2  # HP
          value = actor.hp
        when 3  # MP
          value = actor.mp
        when 4  # Maximum HP
          value = actor.maxhp
        when 5  # Maximum MP
          value = actor.maxmp
        when 6  # Attack
          value = actor.atk
        when 7  # Defense
          value = actor.def
        when 8  # Spirit
          value = actor.spi
        when 9  # Agility
          value = actor.agi
        end
      end
    when 5  # Enemy
      enemy = $game_troop.members[@params[4]]
      if enemy != nil
        case @params[5]
        when 0  # HP
          value = enemy.hp
        when 1  # MP
          value = enemy.mp
        when 2  # Maximum HP
          value = enemy.maxhp
        when 3  # Maximum MP
          value = enemy.maxmp
        when 4  # Attack
          value = enemy.atk
        when 5  # Defense
          value = enemy.def
        when 6  # Spirit
          value = enemy.spi
        when 7  # Agility
          value = enemy.agi
        end
      end
    when 6  # Character
      character = get_character(@params[4])
      if character != nil
        case @params[5]
        when 0  # x-coordinate
          value = character.x
        when 1  # y-coordinate
          value = character.y
        when 2  # direction
          value = character.direction
        when 3  # screen x-coordinate
          value = character.screen_x
        when 4  # screen y-coordinate
          value = character.screen_y
        end
      end
    when 7  # Other
      case @params[4]
      when 0  # map ID
        value = $game_map.map_id
      when 1  # number of party members
        value = $game_party.members.size
      when 2  # gold
        value = $game_party.gold
      when 3  # steps
        value = $game_party.steps
      when 4  # play time
        value = Graphics.frame_count / Graphics.frame_rate
      when 5  # timer
        value = $game_system.timer / Graphics.frame_rate
      when 6  # save count
        value = $game_system.save_count
      end
    end
    for i in @params[0] .. @params[1]   # Batch control
      case @params[2]  # Operation
      when 0  # Set
        $game_variables[i] = value
      when 1  # Add
        $game_variables[i] += value
      when 2  # Sub
        $game_variables[i] -= value
      when 3  # Mul
        $game_variables[i] *= value
      when 4  # Div
        $game_variables[i] /= value if value != 0
      when 5  # Mod
        $game_variables[i] %= value if value != 0
      end
      if $game_variables[i] > 99999999    # Maximum limit check
        $game_variables[i] = 99999999
      end
      if $game_variables[i] < -99999999   # Minimum limit check
        $game_variables[i] = -99999999
      end
    end
    $game_map.need_refresh = true
    return true
  end
  
end # Game_Interpreter

#==============================================================================
# Sprite_Base
#==============================================================================

class Sprite_Base < Sprite
  
  #--------------------------------------------------------------------------
  # constants
  #--------------------------------------------------------------------------
  RATE = YEM::FIXES::ANIMATION_RATE
  
  #--------------------------------------------------------------------------
  # overwrite method: update
  #--------------------------------------------------------------------------
  def update
    super
    update_animation if @animation != nil
    @@animations.clear
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: start_animation
  #--------------------------------------------------------------------------
  def start_animation(animation, mirror = false)
    dispose_animation
    @animation = animation
    return if @animation == nil
    @animation_mirror = mirror
    @animation_duration = @animation.frame_max * RATE + 1
    load_animation_bitmap
    @animation_sprites = []
    if @animation.position != 3 or not @@animations.include?(animation)
      if @use_sprite
        for i in 0..15
          sprite = ::Sprite.new(self.viewport)
          sprite.visible = false
          @animation_sprites.push(sprite)
        end
        @@animations.push(animation) unless @@animations.include?(animation)
      end
    end
    if @animation.position == 3
      if viewport == nil
        @animation_ox = Graphics.width / 2
        @animation_oy = Graphics.height / 2
      else
        @animation_ox = viewport.rect.width / 2
        @animation_oy = viewport.rect.height / 2
      end
    else
      @animation_ox = x - ox + width / 2
      @animation_oy = y - oy + height / 2
      if @animation.position == 0
        @animation_oy -= height / 2
      elsif @animation.position == 2
        @animation_oy += height / 2
      end
    end
  end
  
  #--------------------------------------------------------------------------
  # new method: start_pseudo_ani
  #--------------------------------------------------------------------------
  def start_pseudo_ani(animation, mirror = false)
    dispose_animation
    @animation = animation
    return if @animation == nil
    @animation_mirror = mirror
    @animation_duration = @animation.frame_max * RATE + 1
    @animation_sprites = []
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: update_animation
  #--------------------------------------------------------------------------
  def update_animation
    @animation_duration -= 1
    return unless @animation_duration % RATE == 0
    if @animation_duration > 0
      frame_index = @animation.frame_max
      frame_index -= (@animation_duration+RATE-1)/RATE
      animation_set_sprites(@animation.frames[frame_index])
      for timing in @animation.timings
        next unless timing.frame == frame_index
        animation_process_timing(timing)
      end
      return
    end
    dispose_animation
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: animation_process_timing
  #--------------------------------------------------------------------------
  def animation_process_timing(timing)
    timing.se.play
    case timing.flash_scope
    when 1
      self.flash(timing.flash_color, timing.flash_duration * RATE)
    when 2
      if viewport != nil
        viewport.flash(timing.flash_color, timing.flash_duration * RATE)
      end
    when 3
      self.flash(nil, timing.flash_duration * RATE)
    end
  end
  
end # Sprite_Base

#==============================================================================
# Sprite_Battler
#==============================================================================

class Sprite_Battler < Sprite_Base
  
  #--------------------------------------------------------------------------
  # alias method: setup_new_effect
  #--------------------------------------------------------------------------
  alias setup_new_effect_cfu setup_new_effect unless $@
  def setup_new_effect
    setup_new_effect_cfu
    if @battler.pseudo_ani_id != 0 and @battler.pseudo_ani_id != nil
      animation = $data_animations[@battler.pseudo_ani_id]
      start_pseudo_ani(animation)
      @battler.pseudo_ani_id = 0
    end
  end
  
end # Sprite_Battler

#===============================================================================
# Scene_Status
#===============================================================================

class Scene_Status < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_status_cfu start unless $@
  def start
    start_scene_status_cfu
    $game_party.last_actor_index = @actor_index
  end
  
end # Scene_Skill

#===============================================================================
# Scene_Skill
#===============================================================================

class Scene_Skill < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_skill_cfu start unless $@
  def start
    start_scene_skill_cfu
    $game_party.last_actor_index = @actor_index
  end
  
  #--------------------------------------------------------------------------
  # alias method: update_skill_selection
  #--------------------------------------------------------------------------
  alias update_skill_selection_cfu update_skill_selection unless $@
  def update_skill_selection
    if (Input.trigger?(Input::L) or Input.trigger?(Input::R)) and
    @actor.skills.size > YEM::FIXES::SKILL_LIST_SIZE
      return
    end
    update_skill_selection_cfu
  end
  
end # Scene_Skill

#===============================================================================
# Scene_Equip
#===============================================================================

class Scene_Equip < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :actor
  
  #--------------------------------------------------------------------------
  # alias method: start
  #--------------------------------------------------------------------------
  alias start_scene_equip_cfu start unless $@
  def start
    start_scene_equip_cfu
    $game_party.last_actor_index = @actor_index
  end
  
end # Scene_Equip

#===============================================================================
# Scene_Battle
#===============================================================================

class Scene_Battle < Scene_Base
  
  #--------------------------------------------------------------------------
  # public instance variables
  #--------------------------------------------------------------------------
  attr_accessor :active_battler
  
  #--------------------------------------------------------------------------
  # alias method: terminate
  #--------------------------------------------------------------------------
  alias terminate_cfu terminate unless $@
  def terminate
    terminate_cfu
    if $disposable_battle_windows != nil
      for window in $disposable_battle_windows
        window.dispose unless window.disposed?
      end
      $disposable_battle_windows = []
    end
  end

  #--------------------------------------------------------------------------
  # alias method: start_main
  #--------------------------------------------------------------------------
  alias start_main_cfu start_main unless $@
  def start_main
    @performed_actors = []
    start_main_cfu
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: set_next_active_battler
  #--------------------------------------------------------------------------
  def set_next_active_battler
    @performed_actors = [] if @performed_actors == nil
    loop do
      if $game_troop.forcing_battler != nil
        @active_battler = $game_troop.forcing_battler
        @action_battlers.delete(@active_battler)
        $game_troop.forcing_battler = nil
      else
        make_action_orders
        @action_battlers -= @performed_actors
        @active_battler = @action_battlers.shift
      end
      @performed_actors.push(@active_battler) unless @active_battler == nil
      return if @active_battler == nil
      return if @active_battler.index != nil
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: wait_for_animation
  #--------------------------------------------------------------------------
  def wait_for_animation
    update_basic
    update_basic while @spriteset.animation?
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: display_normal_animation
  #--------------------------------------------------------------------------
  def display_normal_animation(targets, animation_id, mirror = false)
    animation = $data_animations[animation_id]
    if animation != nil
      to_screen = (animation.position == 3)
      ani_check = false
      for target in targets.uniq
        if ani_check
          target.pseudo_ani_id = animation_id
        else
          target.animation_id = animation_id
          target.animation_mirror = mirror
        end
        ani_check = true if to_screen
        wait(20, true) unless to_screen
      end
      wait(20, true) if to_screen
    end
  end
  
end # Scene_Battle

#===============================================================================
# Window_Base
#===============================================================================

class Window_Base < Window
  
  #--------------------------------------------------------------------------
  # alias method: initialize
  #--------------------------------------------------------------------------
  alias initialize_window_base initialize unless $@
  def initialize(x, y, width, height)
    initialize_window_base(x, y, width, height)
    self.contents.font.color = normal_color
    if $game_temp.in_battle
      $disposable_battle_windows = [] if $disposable_battle_windows == nil
      $disposable_battle_windows.push(self)
    end
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: dispose
  #--------------------------------------------------------------------------
  def dispose
    if $game_temp.in_battle
      $disposable_battle_windows = [] if $disposable_battle_windows == nil
      $disposable_battle_windows.delete(self)
    end
    if self.disposed?
      if $TEST or $BTEST
        p "Failure to dispose Nil window."
        p self
      end
    else
      self.contents.dispose
    end
    super
  end
  
  #--------------------------------------------------------------------------
  # alias method: create_contents
  #--------------------------------------------------------------------------
  alias create_contents_base_cfu create_contents unless $@
  def create_contents
    create_contents_base_cfu
    self.contents.font.color = normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite methods: *_colors
  #--------------------------------------------------------------------------
  def normal_color; return text_color(YEM::UPGRADE::COLOURS[:normal]); end
  def system_color; return text_color(YEM::UPGRADE::COLOURS[:system]); end
  def crisis_color; return text_color(YEM::UPGRADE::COLOURS[:crisis]); end
  def lowmp_color; return text_color(YEM::UPGRADE::COLOURS[:lowmp]); end
  def knockout_color; return text_color(YEM::UPGRADE::COLOURS[:knockout]); end
  def gauge_back_color; return text_color(YEM::UPGRADE::COLOURS[:gaugeback]); end
  def exhaust_color; return text_color(YEM::UPGRADE::COLOURS[:exhaust]); end
  def hp_back_color; return text_color(YEM::UPGRADE::COLOURS[:hp_back]); end
  def hp_gauge_color1; return text_color(YEM::UPGRADE::COLOURS[:hp_gauge1]); end
  def hp_gauge_color2; return text_color(YEM::UPGRADE::COLOURS[:hp_gauge2]); end
  def mp_back_color; return text_color(YEM::UPGRADE::COLOURS[:mp_back]); end
  def mp_gauge_color1; return text_color(YEM::UPGRADE::COLOURS[:mp_gauge1]); end
  def mp_gauge_color2; return text_color(YEM::UPGRADE::COLOURS[:mp_gauge2]); end
  def power_up_color; return text_color(YEM::UPGRADE::COLOURS[:power_up]); end
  def power_down_color; return text_color(YEM::UPGRADE::COLOURS[:power_dn]); end
    
  #--------------------------------------------------------------------------
  # overwrite method: hp_color
  #--------------------------------------------------------------------------
  def hp_color(actor)
    return knockout_color if actor.hp == 0
    return crisis_color if actor.hp < (actor.maxhp*YEM::UPGRADE::CRISIS_HP/100)
    return normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: mp_color
  #--------------------------------------------------------------------------
  def mp_color(actor)
    return lowmp_color if actor.mp < (actor.maxmp*YEM::UPGRADE::CRISIS_MP/100)
    return normal_color
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_hp_gauge
  #--------------------------------------------------------------------------
  def draw_actor_hp_gauge(actor, x, y, width = 120)
    actor.hp = [actor.hp, actor.maxhp].min
    gc0 = hp_back_color
    gc1 = hp_gauge_color1
    gc2 = hp_gauge_color2
    gh = YEM::UPGRADE::GAUGE_HEIGHT
    gh += 2 if YEM::UPGRADE::OUTLINE
    gy = y + WLH - 8 - (gh - 6)
    self.contents.fill_rect(x, gy, width, gh, gc0)
    gy += 1 if YEM::UPGRADE::OUTLINE
    gh -= 2 if YEM::UPGRADE::OUTLINE
    width -= 2 if YEM::UPGRADE::OUTLINE
    maxhp = [[actor.maxhp, actor.base_maxhp, 1].max, actor.maxhp_limit].min
    gbw = width * actor.hp / maxhp
    x += 1 if YEM::UPGRADE::OUTLINE
    self.contents.gradient_fill_rect(x, gy, gbw, gh, gc1, gc2)
    return unless maxhp > actor.maxhp
    dw = width * (actor.base_maxhp - actor.maxhp) / actor.base_maxhp
    dx = x + width - dw
    self.contents.fill_rect(dx, gy, dw, gh, exhaust_color)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_mp_gauge
  #--------------------------------------------------------------------------
  def draw_actor_mp_gauge(actor, x, y, width = 120, height = nil)
    actor.mp = [actor.mp, actor.maxmp].min
    gc0 = mp_back_color
    gc1 = mp_gauge_color1
    gc2 = mp_gauge_color2
    gh = YEM::UPGRADE::GAUGE_HEIGHT
    gh += 2 if YEM::UPGRADE::OUTLINE
    gy = y + WLH - 8 - (gh - 6)
    self.contents.fill_rect(x, gy, width, gh, gc0)
    gy += 1 if YEM::UPGRADE::OUTLINE
    gh -= 2 if YEM::UPGRADE::OUTLINE
    width -= 2 if YEM::UPGRADE::OUTLINE
    maxmp = [[actor.maxmp, actor.base_maxmp, 1].max, actor.maxmp_limit].min
    gbw = width * actor.mp / maxmp
    x += 1 if YEM::UPGRADE::OUTLINE
    self.contents.gradient_fill_rect(x, gy, gbw, gh, gc1, gc2)
    return unless maxmp > actor.maxmp
    dw = width * (actor.base_maxmp - actor.maxmp) / [actor.base_maxmp, 1].max
    dx = x + width - dw
    self.contents.fill_rect(dx, gy, dw, gh, exhaust_color)
  end
  
  #--------------------------------------------------------------------------
  # new method: draw_actor_rage_gauge
  #--------------------------------------------------------------------------
  def draw_actor_rage_gauge(actor, x, y, width = 120, height = nil)
    gc0 = gauge_back_color
    gc1 = text_color(YEM::BATTLE_ENGINE::RAGE[:rage_gauge1])
    gc2 = text_color(YEM::BATTLE_ENGINE::RAGE[:rage_gauge2])
    gh = YEM::UPGRADE::GAUGE_HEIGHT
    gh += 2 if YEM::UPGRADE::OUTLINE
    gy = y + WLH - 8 - (gh - 6)
    self.contents.fill_rect(x, gy, width, gh, gc0)
    gy += 1 if YEM::UPGRADE::OUTLINE
    gh -= 2 if YEM::UPGRADE::OUTLINE
    width -= 2 if YEM::UPGRADE::OUTLINE
    gw = [[width * actor.rage / actor.max_rage, width].min, 0].max
    x += 1 if YEM::UPGRADE::OUTLINE
    self.contents.gradient_fill_rect(x, gy, gw, gh, gc1, gc2)
  end
  
  #--------------------------------------------------------------------------
  # overwrite method: draw_actor_state
  #--------------------------------------------------------------------------
  def draw_actor_state(actor, x, y, width = 96)
    count = 0
    for state in actor.states
      next if state.icon_index == 0
      next if state.hide_state
      draw_icon(state.icon_index, x + 24 * count, y)
      draw_state_turns(x + 24 * count, y, state, actor)
      count += 1
      break if (24 * count > width - 24)
    end
    self.contents.font.color = normal_color
    self.contents.font.bold = Font.default_bold
    self.contents.font.size = Font.default_size
  end
  
  #--------------------------------------------------------------------------
  # new method: draw_state_turns
  #--------------------------------------------------------------------------
  def draw_state_turns(x, y, state, actor)
    return unless YEM::UPGRADE::DRAW_STATE_TURNS
    return if state == nil
    return unless actor.state_turns.include?(state.id)
    dy = y - (YEM::UPGRADE::STATE_TURN_F_SIZE - 10)
    duration = actor.state_turns[state.id] 
    if state.auto_release_prob > 0 and duration >= 0
      self.contents.font.color = text_color(state.turn_colour)
      self.contents.font.size = YEM::UPGRADE::STATE_TURN_F_SIZE
      self.contents.font.bold = YEM::UPGRADE::STATE_TURN_BOLD
      self.contents.draw_text(x, dy, 24, WLH, duration, 2)
    end
  end
  
end # Window_Base

#===============================================================================
# Window_Selectable
#===============================================================================

class Window_Selectable < Window_Base

  #--------------------------------------------------------------------------
  # overwrite method: create_contents
  #--------------------------------------------------------------------------
  def create_contents
    self.contents.dispose
    maxbitmap = 8192
    dw = [width - 32, maxbitmap].min
    dh = [[height - 32, row_max * WLH].max, maxbitmap].min
    bitmap = Bitmap.new(dw, dh)
    self.contents = bitmap
    self.contents.font.color = normal_color
  end
  
end # Window_Selectable

#===============================================================================
# Window_Help
#===============================================================================

class Window_Help < Window_Base
  
  #--------------------------------------------------------------------------
  # alias method: set_text
  #--------------------------------------------------------------------------
  alias set_text_cfu set_text unless $@
  def set_text(text, align = 0)
    text = text.clone
    text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    text.gsub!(/\\N\[0\]/i)        { current_actor }
    text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    set_text_cfu(text, align)
  end
  
  #--------------------------------------------------------------------------
  # new method: current_actor
  #--------------------------------------------------------------------------
  def current_actor
    if $scene.is_a?(Scene_Skill) or $scene.is_a?(Scene_Equip)
      return $scene.actor.name
    elsif $scene.is_a?(Scene_Battle) and $scene.active_battler != nil
      return $scene.active_battler.name
    else
      return YEM::UPGRADE::HELP_WINDOW_0
    end
  end
  
end # Window_Help

#==============================================================================
# Window_Item
#==============================================================================

class Window_Item < Window_Selectable

  #--------------------------------------------------------------------------
  # overwrite method: include
  #--------------------------------------------------------------------------
  def include?(item)
    return false if item == nil
    return false if $game_temp.in_battle and !$game_party.item_can_use?(item)
    return true
  end
  
end # Window_Item

#===============================================================================
# Window_Message
#===============================================================================

class Window_Message < Window_Selectable
  
  #--------------------------------------------------------------------------
  # alias method: convert_special_characters
  #--------------------------------------------------------------------------
  alias convert_special_characters_cfu convert_special_characters unless $@
  def convert_special_characters
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\N\[0\]/i)        { $game_party.members[0].name }
    @text.gsub!(/\\F\[0\]/i)        { leader_face_art }
    convert_special_characters_cfu
  end
  
  #--------------------------------------------------------------------------
  # new method: leader_face_art
  #--------------------------------------------------------------------------
  def leader_face_art
    $game_message.face_name  = $game_party.members[0].face_name
    $game_message.face_index = $game_party.members[0].face_index
    return ""
  end
  
end # Window_Message

#===============================================================================
# 
# END OF FILE
# 
#===============================================================================