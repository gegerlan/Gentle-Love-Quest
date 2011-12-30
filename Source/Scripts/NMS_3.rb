#===============================================================
# + [VX] [ NMS - Neo Message System 3.0 Beta ] +
#--------------------------------------------------------------
# >> by Woratana [woratana@hotmail.com]
# >> Thaiware RPG Maker Community
# >> Special Thanks: Mako, Yatzumo, Straycat, Erzengel, RPG,
# Dubalex, Modern Algebra, Equilibrium Keeper
#--------------------------------------------------------------
# Released on: 07/06/2008 (D-M-Y)
#--------------------------------------------------------------
# Include: NEO-FACE SYSTEM ADVANCE (Version 3.0) by Woratana
#===============================================================
# Note:
# - This script started when VX English is not coming out yet,
# so some of comments here are still be Japanese :)
# - This script is included newest version of Neo-Face System,
# so you have to remove old Neo-Face System if you have it.

=begin
=============================================
+ NMS 3 Beta + [07/06/2008]
- Add 'Text Remove List'
- Change window size & position temporarily
- You can now call script:
$game_message.create_nms_data
to reset NMS data or create NMS data for old save file
- Fixed bug for write actor's class name
- Fixed bug for out-of-screen name box
- Add NAMEBOX_Y_PLUS_TOP to fix out-of-screen name box when show message on Top
- Set name box's opacity for different types of message background
- Auto fix if message window is out of screen
- You can draw new face while message is running, and also set new face size
=============================================
=============================================
+ NMS 2.3 + [11/03/2008 - 06/04/2008]
- Remove Color for [WRITE TEXT] features
- 'Quick Text' feature
- Animated Face
- Play SE/ME
- Typing Sound
- Scroll Text Vertically and Horizontally
- Auto-cut text (Not work perfectly)
- Hex Color (Special Thanks: RPG & Erzengel)
- Pop Message (Work in Progress)
- Add the script code in comment of some settings,
so user can change it in game by call script.
=============================================
=============================================
+ NMS 2.1 + [11/03/2008]: Fixed Name Box Bug
=============================================
=====================================
     + NMS 2.0 FEATURES LIST +
=====================================
Use these features in message box
----------------------------------
>> NMS MESSAGE FEATURES
----------------------------------
--------------------------
>> [SPECIAL CALL] PART
--------------------------
\ce[Common Event ID] << Run Common Event immediately

\ani[Animation ID] << Show Animation on 'This Event'
\bal[Balloon ID] << Show Ballon on 'This Event'

* Note: This Event = Event that show this message

--------------------------
>> [MESSAGE WINDOW] PART
--------------------------
* temporary properties will be using only one time
\wx[x]        << Set temporary X to x
\wy[y]        << Set temporary Y to y
\ww[width]    << Set temporary Width to width
\wh[height]   << Set temporary Height to height

----------------------------------------
>> +[ POP TEXT ]+
----------------------------------------
Pop text is the message box that will show over character
and has size equal to message size

You can call pop text by put this in message
\p[character]

* character: Character you want to show message box over~
0 for Player
-1 for This Event
1 or more for that event ID

----------------------------------------
>> +[ QUICK TEXT ]+ a.k.a. Shortcut
----------------------------------------
Add & Call your very long text (or) text that you use many times by shortcut.
You can put special syntax in it, e.g. 'Welcome to \c[10]Syria Village\c[0]

$nms.qt[Quick Text ID] = 'Text you want' << Add Quick Text

\qt[Quick Text ID] << Call Quick Text from message box

--------------------------
>> [DRAW IMAGE] PART
--------------------------
\dw[weapon ID] << Draw Weapon Icon + Weapon Name
\da[armor ID]  << Draw Armor Icon + Armor Name
\di[item ID]   << Draw Item Icon + Item Name
\ds[skill ID]  << Draw Skill Icon + Skill Name

\ic[icon ID]   << Draw Icon

\dp[image_name] << Draw Image from folder 'System'

--------------------------
>> [WRITE TEXT] PART
--------------------------
\map                         << Write Map Name

\nc[actor ID]                << Write Class of Actor
\np[1 to 4 (order in party)] << Write Name of actor in that order
\nm[monster ID]              << Write Monster Name
\nt[troop ID]                << Write Troop Name

\nw[weapon ID]               << Write Weapon Name
\na[armor ID]                << Write Armor Name
\ns[skill ID]                << Write Skill Name
\ni[item ID]                 << Write Item Name
\price[item ID]              << Write Item Price

--------------------------
>> [TEXT EFFECT] PART
--------------------------
\fn[Font Name] (or) << Change Font Name
\fs[Font Size] << Change Font Size
\delay[Delay]  << Change text Delay per letter (in frame, 60 frames = about 1 sec)

\ref           << Reset Font Name
\res           << Reset Font Size
\red           << Reset text Delay

\b             << Turn on/off BOLD text
\i             << Turn on/off ITALIC text
\sh            << Turn on/off SHADOW text
\lbl           << Turn on/off LETTER-BY-LETTER Mode (default is ON)

--------------------------
>> [NAME BOX & FACE] PART
--------------------------
\nb[Name]  << Show Name Box in current message window

\rnb[Name] (or) $nms._name = 'Name' << Repeat Name Box:
Name Box with this name will show again and again in next messages
unless there is \nb[Name] in that message, or you've stop this option by type \rnb[]

\sd[side] (or) $nms.side = side << Change Face Side:
(0: Left Side Normal Face | -1: Right Side Normal Face)
(1: Left Side Neo Face | 2: Right Side Neo Face)

$nms.color = [Red,Green,Blue] << Change Name Text Color:
Put RGB Color in, e.g. [255,100,200]

\fa[face_file_name, face_index] (or) \fa[face_file_name, face_index, new_side]
<< Draw new face while message is running~
face_file_name: Face image's name
face_index:     Index of the face in image (0 - 7)
new_side:       Face side you want to change to

--------------------------
>> [SOUND] PART
--------------------------
\se[filename]   << Play SE
\me[filename]   << Play ME
\bgm[filename]  << Play BGM

\typ            << Turn on/off typing sound

--------------------------
>> [Misc.] PART
--------------------------
\cb           << Turn on/off cancel skip text feature (Player can/can't press [Enter] to skip text)
\nl           << Start new line
\sc[x]        << Create blank space x pixel
\w[x]         << Wait x frames
\c[#XXXXXX]   << Use Hex Color for text

----------------------------------
>> VX DEFAULT MESSAGE FEATURES
----------------------------------
\v[variable ID] << Write value from variable
\n[actor ID]    << Write actor's name
\c[color ID]    << Change text color (Color ID is from Down-right corner in Windowskin)
\g              << Show gold window
\.              << Wait 15 frames (about 1/4 sec)
\|              << Wait 60 frames (about 1 sec)
\!              << Wait for player to press button to continue message
\>              << Skip letter-by-letter in current line
\<              << Stop 'skip letter-by-letter' in current line
\^              << Close message box immediately
\\              << Write '\'

=end
class Window_Base
  
  #---------------------------------
  # [START] SETUP SCRIPT PART
  #-------------------------------
  #---------------------------------
  # ? MESSAGE SYSTEM
  #-------------------------------
  NMS_FONT_NAME = Font.default_name # Default Font Name
  NMS_FONT_SIZE = 20 # Default Font Size
  
  # COLOR_ID is from Windowskin image in down-right corder
  NMS_ITEM_NAME_COLOR_ID = 5 
  NMS_WEAPON_NAME_COLOR_ID = 10
  NMS_ARMOR_NAME_COLOR_ID = 4
  NMS_SKILL_NAME_COLOR_ID = 2
  
  NMS_DELAY_PER_LETTER = 0 # Delay between letter when showing text letter-by-letter
  # Delay is in frame, 60 frames = 1 second
  # $nms.text_delay = (number)
  
  TEXT_X_PLUS = 0 # Move Text Horizontally
  CHOICE_INPUT_X_PLUS = 0
  # Move Choices Text and Input Number Text Horizontally
  
  # [NEW SETTING] #
  NMS_MSGWIN_X = 0 # Default Message Window X
  # $nms.msg_x = (number)
  
  NMS_MSGWIN_WIDTH = 544 # Default Message Window Width
  # $nms.msg_w = (number)
  NMS_MSGWIN_MIN_HEIGHT = 128 # Default & Minimum Message Window Height
  # $nms.msg_h_user = (number)
  
  NMS_MAX_LINE = 4 # Max Message Lines to display per page
  # $nms.max_line = (number)
  NMS_GET_NEXT_LINE = false # Get messages from next message command, if box is not full
  # $nms.next_msg = true/false
  
  NMS_MSG_BACK = "MessageBack" # Message Back Image File Name (For 'Dim Background' Message)
  # (Must be in folder 'System')
  # $nms.mback = 'Image Name'
  NMS_MSG_BACK_OPACITY = 255 # message Back's Opacity
  # $nms.mback_opac = (0 - 255)
  
  NMS_TEXT_SCROLL = false # Use Vertical Text Scroll?
  # $nms.txt_scrl = true/false
  
  NMS_TEXT_AUTO_CUT = false # Text will automatically start new line if that line is full
  # (Some bug, it may cut in the middle of word..)
  # $nms.txt_cut = true/false
  
  NMS_TEXT_AUTO_SCROLL_HORIZONTAL = false # Text will automatically scroll to the left if line is full
  # This will not work if NMS_TEXT_AUTO_CUT is true
  # $nms.txt_scrl_hori = true/false
  NMS_TEXT_AUTO_SCROLL_HORIZONTAL_DELAY = 1 # Scroll Delay (in frame)
  # $nms.txt_scrl_hori_delay = (number)
  
  NMS_USER_NEW_LINE = false # Text will goes in new line ONLY when type \nl
  # (Good for Text Auto Cut)
  # $nms.txt_unl = true/false
  
  NMS_REMOVE_LIST = [] # List of text that you want to remove from message
  # for example, NMS_REMOVE_LIST = ['test', '[MS]']
  # will remove text 'test' and '[MS]' before show message
  # Note that this is NOT case sensitive
  
  #---------------------------------
  # ? FACE SYSTEM
  #-------------------------------
  #------------------------------------------------
  # ** BOTH FACE SYSTEMS SETUP
  #----------------------------------------------
  DEFAULT_FACE_SIDE = 0 # Default Face Side when game start~
  # (0: Left Side Normal Face | -1: Right Side Normal Face)
  # (1: Left Side Neo Face | 2: Right Side Neo Face)
  # $nms.side = (side no.)
  
  FACE_X_PLUS = 0 # Move Face Horizontally (Left: -, Right: +)
  FACE_Y_PLUS = 0 # Move Face Vertically (Up: -, Down: +)
  
  MOVE_TEXT = true # (true/false)
  # Move text to right side of face, when showing face in left side.
  
  #-------------------------------------
  # **SHOW FACE EFFECT
  # * For both Face Systems *
  #----------------------------------
  FADE_EFFECT = true # Turn on/off fade effect (true/false)
  # $nms.face_fade = true/false
  FADE_SPEED = 20 # Speed up face's fade effect by increase this number
  FADE_ONLY_FIRST = true # Use Fade Effect only in first message window?
  
  MOVE_EFFECT = true # Turn on/off "move in" effect (true/false)
  # $nms.face_move = true/false
  MOVE_SPEED = 10 # Speed up face's "move in" effect by increase this number
  MOVE_ONLY_FIRST = true # Use Move Effect only in first message window?
  
  FADE_MOVE_WHEN_USE_NEW_FACE = true
  # Use Fade and Move effect when change Face graphic
  # (In case using FADE_ONLY_FIRST and MOVE_ONLY_FIRST)
  
  #-------------------------------
  # ** NEO FACE SYSTEM
  #----------------------------
  EightFaces_File = false
  # Use 8 Faces per file (or) 1 Face per file (true/false)
  
  #-------------------------------
  # ** ANIMATED FACE SYSTEM
  #----------------------------
  ANIMATE_FACE_DELAY = 6 # Face animate every _ frame
  # $nms.animf_delay = (number)
  
  ANIMATE_FACE_CONTINUE = false # Face continue to animate after text stop writing?
  # $nms.animf_cont = (true/false)
  
  #------------------------------------
  # ? NAME BOX SYSTEM
  #----------------------------------
  NAMEBOX_SKIN = 'Window' # Windowskin of Name Box (In folder 'Graphics/System')
  NAMEBOX_OPACITY = 255 # Name Box Opacity when using 'Normal Background' message
  # (Lowest 0 - 255 Highest)
  NAMEBOX_OPACITY_DIM_BG = 0 # Name Box Opacity when using 'Dim Background'
  NAMEBOX_OPACITY_NO_BG = 0 # Name Box Opacity when using 'Transparent' Background
  NAMEBOX_BACK_OPACITY = 180 # Name Box Background Opacity
  
  NAMEBOX_X_PLUS_NOR = 100 # Additional Name Box X [Horizontal] for Normal Face Name Box
  NAMEBOX_X_PLUS_NEO = 160 # Additional Name Box X for Neo Face Name Box
  NAMEBOX_Y_PLUS = 0 # Move Name Box & Text Vertically
  NAMEBOX_Y_PLUS_TOP = 140
  # Move Name Box & Text Vertically if message box is on Top
  
  NAMEBOX_TEXT_FONT = Font.default_name # Name Text Font's Name
  NAMEBOX_TEXT_SIZE = Font.default_size # Name Text Font's Size
  NAMEBOX_TEXT_HEIGHT_PLUS = 2 # Increase Name Text Height (For Big Size Text)

  NAMEBOX_TEXT_BOLD = false # Make Text in Name Box Bold
  NAMEBOX_TEXT_OUTLINE = false # Make Black Outline around Text (Good with Opacity = 0)
  NAMEBOX_TEXT_DEFAULT_COLOR = [255,255,255]#[255,255,255] # [Red,Green,Blue]: Name Text Color (RGB) 
  # You can easily find color code for RGB (Red Green Blue) color in Google :)
  # You are allow to change color in game by call script:
  # $nms.color = [Red,Green,Blue]
  
  NAMEBOX_TEXT_AFTER_NAME = ":" # Add Text after Name, leave "" to disable.
  
  NAMEBOX_BOX_WIDTH_PLUS = 6 # Increase Name Box Width
  NAMEBOX_BOX_HEIGHT_PLUS = 7 # Increase Name Box Height
  
  MOVE_NAMEBOX = true
  # (true/false) Move Text Box to Right Side if showing Face in Right side.

  #---------------------------------
  # ? TEXT TYPING SOUND SYSTEM
  #-------------------------------
  TYPING_SOUND = true # Use Typing Sound?
  # $nms.typ_se = true/false
  TYPING_SOUND_FILE = 'Open1'
  # Sound File Name for Typing Sound (Must be in Folder 'Audio/SE')
  # $nms.typ_file = 'filename'
  TYPING_SOUND_VOLUME = 40 # Typing Sound's Volume
  # $nms.typ_vol = 0 - 100
  TYPING_SOUND_SKIP = 4
  # How many frames you want to skip before play typing sound again?
  # $nms.typ_skip = (no. of frames)
  #---------------------------------
  # [END] SETUP SCRIPT PART
  #-------------------------------
end
  $worale = {} if $worale == nil
  $worale["NMS"] = true
  
class Window_Message < Window_Selectable
  #--------------------------------------------------------------------------
  # ? ALIAS
  #--------------------------------------------------------------------------
    alias wor_nms_winmsg_ini initialize
    def initialize
      wor_nms_winmsg_ini
      $nms = $game_message
      contents.font.name = $nms.nms_fontname
      contents.font.size = $nms.nms_fontsize
      @face = Sprite.new
      @face.z = self.z + 5
      @nametxt = Sprite.new
      @nametxt.z = self.z + 15
      @namebox = nil
      @ori_x = 0
      @name_text = nil
      @showtime = 0 # To check if this is first time it shows message (For face)
      @face_data = Array.new(3)
      @face_data_old = Array.new(3)
      
      #NMS 2++
      self.width = $nms.msg_w
      self.height = $nms.msg_h
      update_window_size(true)
      self.x = $nms.msg_x
      
      @typse_count = 0
      @delay_text = 0
      @no_press_input = false
      @biggest_text_height = 0
      @all_text_width = 0
      @animf_dl = 0 # Animation Face Delay
      @animf = false # Using Animation Face?
      @animf_ind = 0 # Animation Face Index
      @pop = nil # Pop ID
    end
  #--------------------------------------------------------------------------
  # ? ??
  #--------------------------------------------------------------------------
  def dispose
    super
    dispose_gold_window
    dispose_number_input_window
    dispose_back_sprite
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def update
    super
  if self.visible == true
    update_back_sprite
    update_gold_window
    update_number_input_window
    update_show_fast
    update_window_size
    update_animate_face if @animf
    
    @typse_count -= 1 if @typse_count > 0
    
    if @name_text != nil
      draw_name(@name_text,self.x,self.y)
    end
    if @face.bitmap != nil
      # UPDATE FADE IN EFFECT
      if @face.opacity < 255
        @face.opacity += FADE_SPEED
      end
      # UPDATE MOVE IN EFFECT
      if $nms.face_move and @ori_x != @face.x
        if (@ori_x > @face.x and @face.x + MOVE_SPEED < @ori_x) or (@ori_x < @face.x and @face.x - MOVE_SPEED > @ori_x)
          @face.x += MOVE_SPEED if @ori_x > @face.x
          @face.x -= MOVE_SPEED if @ori_x < @face.x
        else
          @face.x = @ori_x
        end
      end
    end
  end
    unless @opening or @closing
      if @wait_count > 0
        @wait_count -= 1
      elsif self.pause
        input_pause
      elsif self.active
        input_choice
      elsif @number_input_window.visible
        input_number
      elsif @text != nil
        if @delay_text > 0
          @delay_text -= 1
        else
          update_message
        end
      elsif continue?
        @showtime += 1
        start_message
        open
        $game_message.visible = true
      else
        close
        @showtime = 0
        if @face.bitmap != nil
         @face.bitmap.dispose
        end
        clear_namebox if @namebox != nil
        $game_message.visible = @closing
      end
    end
  end
  #--------------------------------------------------------------------------
  # ? NEW
  #--------------------------------------------------------------------------
  def update_window_size(direct = false, create_bitmap = true)
    if (self.width != $nms.msg_w or self.height != $nms.msg_h) or direct
      self.width = $nms.msg_w if $nms.msg_w > 32
      self.height = $nms.msg_h if $nms.msg_h > 32
      create_contents if create_bitmap
    end
  end
  #--------------------------------------------------------------------------
  # ? ???????????
  #--------------------------------------------------------------------------
  def create_gold_window
    @gold_window = Window_Gold.new(384, 0)
    @gold_window.openness = 0
  end
  #--------------------------------------------------------------------------
  # ? ????????????
  #--------------------------------------------------------------------------
  def create_number_input_window
    @number_input_window = Window_NumberInput.new
    @number_input_window.visible = false
  end
  #--------------------------------------------------------------------------
  # ? ??????????
  #--------------------------------------------------------------------------
  def create_back_sprite
    @back_sprite = Sprite.new
    @back_sprite.bitmap = @old_mback = Cache.system($game_message.mback)
    @back_sprite.opacity = @old_mback_opac = $game_message.mback_opac
    @back_sprite.visible = (@background == 1)
    @back_sprite.z = 190
  end
  #--------------------------------------------------------------------------
  # ? ???????????
  #--------------------------------------------------------------------------
  def dispose_gold_window
    @gold_window.dispose
  end
  #--------------------------------------------------------------------------
  # ? ????????????
  #--------------------------------------------------------------------------
  def dispose_number_input_window
    @number_input_window.dispose
  end
  #--------------------------------------------------------------------------
  # ? ??????????
  #--------------------------------------------------------------------------
  def dispose_back_sprite
    @back_sprite.dispose
  end
  #--------------------------------------------------------------------------
  # ? ???????????
  #--------------------------------------------------------------------------
  def update_gold_window
    @gold_window.update
  end
  #--------------------------------------------------------------------------
  # ? ????????????
  #--------------------------------------------------------------------------
  def update_number_input_window
    @number_input_window.update
  end
  #--------------------------------------------------------------------------
  # ? ??????????
  #--------------------------------------------------------------------------
  def update_back_sprite
    @back_sprite.visible = (@background == 1)
    @back_sprite.y = y - 16
    @back_sprite.opacity = $nms.mback_opac > openness ? openness : $nms.mback_opac
    @back_sprite.update
  end
  #--------------------------------------------------------------------------
  # ? ?????????
  #--------------------------------------------------------------------------
  def update_show_fast
    if self.pause or self.openness < 255
      @show_fast = false
    elsif Input.trigger?(Input::C) and @wait_count < 2 and !@no_press_input
      @show_fast = true
    elsif not Input.press?(Input::C)
      @show_fast = false
    end
    if @show_fast and @wait_count > 0
      @wait_count -= 1
    end
  end
  #--------------------------------------------------------------------------
  # ? ????????????????????
  #--------------------------------------------------------------------------
  def continue?
    return true if $game_message.num_input_variable_id > 0
    return false if $game_message.texts.empty?
    if self.openness > 0 and not $game_temp.in_battle
      return false if @background != $game_message.background
      return false if @position != $game_message.position
    end
    return true
  end
  #--------------------------------------------------------------------------
  # ? EDITED: NMS 2.2+
  #--------------------------------------------------------------------------
  def start_message
    @all_text_width = 0
    @pop = nil
    
    @text = ""
    @text_line = $game_message.texts.size < $game_message.max_line ? $game_message.texts.size + 1 : MAX_LINE + 1
    for i in 0...$game_message.texts.size
      # Change "    " to "" (Spacing for choice)
      @text += "" if i >= $game_message.choice_start
      @text += $game_message.texts[i].clone + "\x00"
    end
     
    @item_max = $game_message.choice_max
    convert_special_characters
    reset_window
    update_window_size
    new_page
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def new_page
    @animf = false
    contents.clear
    
    if @face.bitmap != nil
    @face.bitmap.dispose
    end
    if $game_message.face_name.empty?
    @contents_x = TEXT_X_PLUS
    else
      nms_draw_new_face
      # CHECK FOR MOVE EFFECT
      @ori_x = @face.x
      if $nms.face_move and ((MOVE_ONLY_FIRST and @showtime <= 1) or (MOVE_ONLY_FIRST == false))
        if $game_message.side == 0 or $game_message.side == 1
          @face.x = 0 - @face.width
        else
          @face.x = Graphics.width
        end
      end
      @contents_x = get_x_face
    end
    @main_contents_x = @contents_x
    @contents_y = 0
    @line_count = 0
    @typse_count = 0
    @show_fast = false
    @line_show_fast = false
    @pause_skip = false
    contents.font.color = text_color(0)
    @contents_x += CHOICE_INPUT_X_PLUS if $game_message.choice_max > 00
    
    if @old_mback != Cache.system($nms.mback) or @old_mback_opac != $nms.mback_opac
      dispose_back_sprite; create_back_sprite
    end
    
    @no_press_input = false
    self.oy = 0
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def new_line
    biggest = @biggest_text_height > WLH ? @biggest_text_height : WLH
    @contents_y += biggest
    if $nms.txt_scrl and @contents_y >= contents.height and @text != ""
      rect = Rect.new(0, biggest, contents.width, contents.height - biggest)
      cont_s = Bitmap.new(contents.width,contents.height)
      cont_s.blt(0, 0, contents, rect)
      rect_s = Rect.new(0,0,contents.width,contents.height)
      contents.clear_rect(0, 0, contents.width, contents.height)
      contents.blt(0, 0, cont_s, rect_s)
      @contents_y = rect.height
      cont_s.dispose
      @show_fast = false
      @no_press_input = true
    end
    @contents_x = @main_contents_x
    @contents_x += CHOICE_INPUT_X_PLUS if $game_message.choice_max > 0
    @biggest_text_height = WLH
    @line_count += 1
    @line_show_fast = false
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def convert_special_characters
    clear_namebox if @namebox != nil
    
    # Woratana's :: Quick Text
    @text.gsub!(/\\QT\[([0-9]+)\]/i) { $nms.qt[$1.to_i] }
    
    #--------------------------
    # DEFAULT FEATURES
    #-----------------------
    @text.gsub!(/\\V\[([0-9]+)\]/i) { $game_variables[$1.to_i] }
    @text.gsub!(/\\N\[([0-9]+)\]/i) { $game_actors[$1.to_i].name }
    @text.gsub!(/\\C\[(.*?)\]/i) { "\x01{#{$1}}" }
    @text.gsub!(/\\G/i)              { "\x02" }
    @text.gsub!(/\\\./)             { "\x03" }
    @text.gsub!(/\\\|/)             { "\x04" }
    @text.gsub!(/\\!/)              { "\x05" }
    @text.gsub!(/\\>/)              { "\x06" }
    @text.gsub!(/\\</)              { "\x07" }
    @text.gsub!(/\\\^/)             { "\x08" }
    @text.gsub!(/\\\\/)             { "\\" }
    
    #--------------------------
    # * GLQ FEATURES!!
    #-----------------------
    # Draws face of character in party (0 = player)
    @text.gsub!(/\\PARTY\[([0-9]+)\]/i) do 
      actor = $game_party.members[$1.to_i]
      actor_name   = actor.name
      actor_mood   = actor.mood
      actor_clothes= actor.clothing
      $game_message.face_name = "#{actor_name} - #{actor_clothes} - #{actor_mood}" # Eva - Normal - Smiling
      ""
    end
    # Draws face of character defined as an actor (1 = Eva)
    @text.gsub!(/\\ACTOR\[([0-9]+)\]/i) do 
      actor = $game_actors[$1.to_i]
      actor_name   = actor.name
      actor_mood   = actor.mood
      actor_clothes= actor.clothing
      $game_message.face_name = "#{actor_name} - #{actor_clothes} - #{actor_mood}" # Eva - Normal - Smiling
      ""
    end
    
    #--------------------------
    # * NMS FEATURES!!
    #-----------------------
    # Woratana's :: Draw Weapon Name + Icon
    @text.gsub!(/\\DW\[([0-9]+)\]/i) { "\x83[#{$data_weapons[$1.to_i].icon_index}]\x01{#{NMS_WEAPON_NAME_COLOR_ID}}\\nw[#{$1.to_i}]\x01{#{$nms.last_color}}"}
    # Woratana's :: Draw Item Name + Icon
    @text.gsub!(/\\DI\[([0-9]+)\]/i) { "\x83[#{$data_items[$1.to_i].icon_index}]\x01{#{NMS_ITEM_NAME_COLOR_ID}}\\ni[#{$1.to_i}]\x01{#{$nms.last_color}}" }
    # Woratana's :: Draw Armor Name + Icon
    @text.gsub!(/\\DA\[([0-9]+)\]/i) { "\x83[#{$data_armors[$1.to_i].icon_index}]\x01{#{NMS_ARMOR_NAME_COLOR_ID}}\\na[#{$1.to_i}]\x01{#{$nms.last_color}}"}
    # Woratana's :: Draw Skill Name + Icon
    @text.gsub!(/\\DS\[([0-9]+)\]/i) { "\x83[#{$data_skills[$1.to_i].icon_index}]\x01{#{NMS_ITEM_NAME_COLOR_ID}}\\ns[#{$1.to_i}]\x01{#{$nms.last_color}}"}

    # Woratana's :: Call Animation
    @text.gsub!(/\\ANI\[([0-9]+)\]/i) { "\x80[#{$1}]" }
    # Woratana's :: Call Balloon
    @text.gsub!(/\\BAL\[([0-9]+)\]/i) { "\x81[#{$1}]" }
    # Woratana's :: Call Common Event
    @text.gsub!(/\\CE\[([0-9]+)\]/i) { "\x82[#{$1}]" }
    # Woratana's :: Draw Icon
    @text.gsub!(/\\IC\[([0-9]+)\]/i) { "\x83[#{$1}]" }

    # Woratana's :: Map Name
    @text.gsub!(/\\MAP/i) { nms_get_map_name }
    # Woratana's :: Actor Class Name
    @text.gsub!(/\\NC\[([0-9]+)\]/i) { $data_classes[$game_actors[$1.to_i].class_id].name }
    # Woratana's :: Party Actor Name
    @text.gsub!(/\\NP\[([0-9]+)\]/i) { $game_party.members[($1.to_i - 1)].name }
    # Woratana's :: Monster Name
    @text.gsub!(/\\NM\[([0-9]+)\]/i) { $data_enemies[$1.to_i].name }
    # Woratana's :: Troop Name
    @text.gsub!(/\\NT\[([0-9]+)\]/i) { $data_troops[$1.to_i].name }
    # Woratana's :: Item Name
    @text.gsub!(/\\NI\[([0-9]+)\]/i) { $data_items[$1.to_i].name }
    # Woratana's :: Weapon Name
    @text.gsub!(/\\NW\[([0-9]+)\]/i) { $data_weapons[$1.to_i].name }
    # Woratana's :: Armor Name
    @text.gsub!(/\\NA\[([0-9]+)\]/i) { $data_armors[$1.to_i].name }
    # Woratana's :: Skill Name
    @text.gsub!(/\\NS\[([0-9]+)\]/i) { $data_skills[$1.to_i].name }
    # Woratana's :: Item Price
    @text.gsub!(/\\PRICE\[([0-9]+)\]/i) { $data_items[$1.to_i].price.to_s }
    
    # Woratana's :: Font Name Change
    @text.gsub!(/\\FN\[(.*?)\]/i) { "\x84[#{$1}]" }
    # Woratana's :: Font Size Change
    @text.gsub!(/\\FS\[(.*?)\]/i) { "\x85[#{$1}]" }
    # Woratana's :: Reset Font Name
    @text.gsub!(/\\REF/i) { "\x86" }
    # Woratana's :: Reset Font Size
    @text.gsub!(/\\RES/i) { "\x87" }
    # Woratana's :: BOLD Text
    @text.gsub!(/\\B/i) { "\x88" }
    # Woratana's :: ITALIC Text
    @text.gsub!(/\\I/i) { "\x89" }
    # Woratana's :: Text DELAY
    @text.gsub!(/\\DELAY\[([0-9]+)\]/i) { "\x90[#{$1}]"}
    # Woratana's :: Reset Text Delay
    @text.gsub!(/\\RED/i) { "\x91" }
    # Woratana's :: Turn On/Off Letter by Letter
    @text.gsub!(/\\LBL/i) { "\x92" }
   
     # Woratana's NeoFace System
     @text.scan(/\\SD\[([-,0-9]+)\]/i)
     if $1.to_s != ""
       $game_message.side = $1.to_i
       @text.sub!(/\\SD\[([-,0-9]+)\]/i) {}
     end
    
     # Woratana's :: Name Box
     @text.scan(/\\NB\[(.*?)\]/i)
     if $1.to_s != ""
       n_text = $1.to_s.gsub(/\x01\{(.*?)\}/i) {} # Clear If there's Color
       @name_text = n_text
       @text.sub!(/\\NB\[(.*?)\]/i) {}
     end
   
     # Woratana's :: Repeat Name Box
     @text.gsub!(/\\RNB\[(.*?)\]/i) do
       $game_message._name = $1.to_s
       a = ""
     end
     
     # NMS 2++
     # Woratana's :: SHADOW Text
     @text.gsub!(/\\SH/i) { "\x93" }
     # Woratana's :: Cancel Skip Text Button
     @text.gsub!(/\\CB/i) { "\x94" }
     # Woratana's :: Wait X Frame
     @text.gsub!(/\\W\[([0-9]+)\]/i) { "\x95[#{$1}]" }
     # Woratana's :: Add Space X Pixel
     @text.gsub!(/\\SC\[([0-9]+)\]/i) { "\x96[#{$1}]" }
     
     # Woratana's :: Play SE
     @text.gsub!(/\\SE\[(.*?)\]/i) { "\x97[#{$1}]" }
     # Woratana's :: Play ME
     @text.gsub!(/\\ME\[(.*?)\]/i) { "\x98[#{$1}]" }
     # Woratana's :: Play BGM
     @text.gsub!(/\\BGM\[(.*?)\]/i) { "\x99[#{$1}]" }
     
     # Woratana's :: Start New Line
     @text.gsub!(/\\NL/i) { "\x09" }
     # Woratana's :: Turn ON/OFF Typing Sound
     @text.gsub!(/\\TYP/i) { "\x10" }
     # Woratana's :: Draw Picture
     @text.gsub!(/\\DP\[(.*?)\]/i) { "\x11[#{$1}]" }
     
     # Woratana's :: Draw Face
     @text.gsub!(/\\FA\{(.*?)\}/i) { "\x12{#{$1}}" }
     
     # Woratana's :: Temporary Width
     @text.scan(/\\WW\[([-,0-9]+)\]/i)
     if $1.to_s != ''
       $nms.msg_temp_w = $1.to_i
       @text.sub!(/\\WW\[([-,0-9]+)\]/i) {}
     end
     # Woratana's :: Temporary Height
     @text.scan(/\\WH\[([-,0-9]+)\]/i)
     if $1.to_s != ''
       $nms.msg_temp_h = $1.to_i
       @text.sub!(/\\WH\[([-,0-9]+)\]/i) {}
     end
     # Woratana's :: Temporary X
     @text.scan(/\\WX\[([-,0-9]+)\]/i)
     if $1.to_s != ''
       $nms.msg_temp_x = $1.to_i
       @text.sub!(/\\WX\[([-,0-9]+)\]/i) {}
     end
     # Woratana's :: Temporary Y
     @text.scan(/\\WY\[([-,0-9]+)\]/i)
     if $1.to_s != ''
       $nms.msg_temp_y = $1.to_i
       @text.sub!(/\\WY\[([-,0-9]+)\]/i) {}
     end

    # Woratana's :: Remove text list
     NMS_REMOVE_LIST.each {|i| @text.gsub!(/#{i}/i) {} }
     
     # Woratana's :: Pop Text
     @text.scan(/\\P\[(.*?)\]/i)
     if $1.to_s != ""
      @pop = $1.to_i
      contents.font.name = $nms.nms_fontname if contents.font.name != $nms.nms_fontname
      contents.font.size = $nms.nms_fontsize if contents.font.size != $nms.nms_fontsize
      a = @text.split(/\x00/)
      for i in 0..(a.size - 1)
        text_width = contents.text_size(a[i]).width
        @all_text_width = text_width if @all_text_width < text_width
      end
       nms_draw_new_face
       if @face.bitmap != nil
        if get_x_face == 0 and MOVE_TEXT
          @all_text_width += (@face.width + TEXT_X_PLUS)
        else
          @all_text_width += get_x_face
        end
        @face.bitmap.dispose
        @face.bitmap = nil
      end
      @text.sub!(/\\P\[(.*?)\]/i) {}
      end
  
     @name_text = $game_message._name if @name_text == nil and $game_message._name != ""
   end
  #--------------------------------------------------------------------------
  # ? EDIT: NMS 2.2++
  #--------------------------------------------------------------------------
  def reset_window
    @background = $game_message.background
    @position = $game_message.position
    if @background == 0
      self.opacity = 255
    else
      self.opacity = 0
    end
    # Calculate Window X/Y and Size depends on Pop or normal message
    if @pop != nil
      $nms.msg_h = [((@text_line * WLH) + 8), $nms.msg_h_user].min
      $nms.msg_w = @all_text_width + 32
      
      case @pop
      when 0 # Player
        set_window_xy($game_player)
      when -1 # This Event
        set_window_xy($game_map.events[$game_message.event_id])
      else # Event ID
        set_window_xy($game_map.events[@pop])
      end
    else
      $nms.msg_h = ((((@text_line * WLH) + 8) > $nms.msg_h_user) and ($nms.txt_scrl == false)) ? ((@text_line * WLH) + 8) : $nms.msg_h_user
      $nms.msg_w = NMS_MSGWIN_WIDTH
      self.x = $nms.msg_x
      case @position
      when 0  # Down
        self.y = 0
        @gold_window.y = 360
      when 1  # Middle
        self.y = ((Graphics.height - $nms.msg_h) / 2)
        @gold_window.y = 0
      when 2  # Up
        self.y = Graphics.height - $nms.msg_h
        @gold_window.y = 0
      end
    end
    # Temporary Size & Position
    if !$nms.msg_temp_w.nil?
      $nms.msg_w = $nms.msg_temp_w
      $nms.msg_temp_w = nil
    end
    if !$nms.msg_temp_h.nil?
      $nms.msg_h = $nms.msg_temp_h
      $nms.msg_temp_h = nil
    end
    if !$nms.msg_temp_x.nil?
      self.x = $nms.msg_temp_x
      $nms.msg_temp_x = nil
    end
    if !$nms.msg_temp_y.nil?
      self.y = $nms.msg_temp_y
      $nms.msg_temp_y = nil
    end
    # Fix Window Position if it's out of screen
    self.x = 0 if self.x < 0
    self.x = Graphics.width - $nms.msg_w if (self.x + $nms.msg_w) > Graphics.width
    self.y = 0 if self.y < 0
    self.y = Graphics.height - $nms.msg_h if (self.y + $nms.msg_h) > Graphics.height
  end
  #--------------------------------------------------------------------------
  # ? SET Window XY for Pop Message
  #--------------------------------------------------------------------------
  def set_window_xy(chara)
    char_x = chara.screen_x
    char_y = chara.screen_y
    self.x = char_x - ($nms.msg_w / 2)
    self.y = ((char_y - 32 - $nms.msg_h) >= 0) ? (char_y - 32 - $nms.msg_h) : (char_y + 32)
  end
  #--------------------------------------------------------------------------
  # ? ????????
  #--------------------------------------------------------------------------
  def terminate_message
    self.active = false
    self.pause = false
    self.index = -1
    @gold_window.close
    @number_input_window.active = false
    @number_input_window.visible = false
    $game_message.main_proc.call if $game_message.main_proc != nil
    $game_message.clear
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def update_message
    loop do
      c = @text.slice!(/./m)
      case c
      when nil
        finish_message
        break
      when "\x00"
        new_line if !$nms.txt_unl
        if @line_count >= $game_message.max_line
          unless @text.empty?
            self.pause = true
            break
          end
        end
      when "\x80"
        @text.sub!(/\[([0-9]+)\]/, "")
        $game_map.events[$game_message.event_id].animation_id = $1.to_i
      when "\x81"
        @text.sub!(/\[([0-9]+)\]/, "")
        $game_map.events[$game_message.event_id].balloon_id = $1.to_i
      when "\x82"
        @text.sub!(/\[([0-9]+)\]/, "")
        a = $game_map.interpreter.params[0]
        $game_map.interpreter.params[0] = $1.to_i
        $game_map.interpreter.command_117
        $game_map.interpreter.params[0] = a
      when "\x83"
        @text.sub!(/\[([0-9]+)\]/, "")
        bitmap = Cache.system("Iconset")
        icon_index = $1.to_i
        # Check for Auto Cut
        new_line if $nms.txt_cut and (@contents_x + 24 > contents.width)
        # Draw ICON
        draw_icon(icon_index, @contents_x, @contents_y, true)
        @contents_x += 24
      when "\x84"
        @text.sub!(/\[(.*?)\]/, "")
        $nms.nms_fontname = $1.to_s
        next
      when "\x85"
        @text.sub!(/\[([0-9]+)\]/, "")
        $nms.nms_fontsize = $1.to_i; next
      when "\x86"
        $nms.nms_fontname = NMS_FONT_NAME; next
      when "\x87"
        $nms.nms_fontsize = NMS_FONT_SIZE; next
      when "\x88"
        contents.font.bold = contents.font.bold == true ? false : true
        next
      when "\x89"
        contents.font.italic = contents.font.italic == true ? false : true
        next
      when "\x90"
        @text.sub!(/\[([0-9]+)\]/, "")
        $nms.text_delay = $1.to_i; next
      when "\x91"
        $nms.text_delay = NMS_DELAY_PER_LETTER; next
      when "\x92"
        $nms.lbl = $nms.lbl == true ? false : true; next
      when "\x93"
        contents.font.shadow = contents.font.shadow == true ? false : true
        next
      when "\x94"
        @no_press_input = @no_press_input == true ? false : true
        next
      when "\x95"
        @text.sub!(/\[([0-9]+)\]/, "")
        @wait_count = $1.to_i
        break
      when "\x96"
        @text.sub!(/\[([0-9]+)\]/, "")
        @contents_x += $1.to_i
        next
      when "\x97"
        @text.sub!(/\[(.*?)\]/, "")
        RPG::SE.new($1).play
      when "\x98"
        @text.sub!(/\[(.*?)\]/, "")
        RPG::ME.new($1).play
      when "\x99"
        @text.sub!(/\[(.*?)\]/, "")
        RPG::BGM.new($1).play
      when "\x09"
        new_line
      when "\x10"
        $nms.typ_se = !$nms.typ_se
      when "\x11"
        @text.sub!(/\[(.*?)\]/, "")
        bitmap = Cache.system($1.to_s)
        rect = Rect.new(0,0,0,0)
        rect.width = bitmap.width
        rect.height = bitmap.height
        # Check for Auto Cut & Scroll
        if (@contents_x + bitmap.width > contents.width)
          if $nms.txt_cut; new_line
          elsif $nms.txt_scrl_hori; nms_scroll_hori(bitmap.width)
          end
        end
        # Draw Image
        self.contents.blt(@contents_x, @contents_y, bitmap, rect)
        @contents_x += bitmap.width
        @biggest_text_height = bitmap.height if bitmap.height > @biggest_text_height
        bitmap.dispose
      when "\x12"
        @text.sub!(/\{(.*?)\}/, "")
        a = $1.to_s.split(',')
        $nms.face_name = a[0]
        $nms.face_index = a[1].to_i
        $nms.side = a[2].to_i unless a[2].nil?
        nms_draw_new_face
        @ori_x = @face.x
      when "\x01"
        @text.sub!(/\{(.*?)\}/, "")
        color_code = $1.to_s
        if color_code.include?('#')
          color_code.sub!(/([0123456789ABCDEF]+)/, "")
          contents.font.color = get_hex($1)
        else
          $nms.last_color = color_code.to_i
          contents.font.color = text_color($nms.last_color)
        end
        next
      when "\x02"
        @gold_window.refresh
        @gold_window.open
      when "\x03"
        @wait_count = 15
        break
      when "\x04"
        @wait_count = 60
        break
      when "\x05"
        self.pause = true
        break
      when "\x06"
        @line_show_fast = true
      when "\x07"
        @line_show_fast = false
      when "\x08"
        @pause_skip = true
      else
        contents.font.name = $nms.nms_fontname if contents.font.name != $nms.nms_fontname
        contents.font.size = $nms.nms_fontsize if contents.font.size != $nms.nms_fontsize
        c_width = contents.text_size(c).width
        
        # Check for Text Cut & Scroll Horizontal
        if (@contents_x + c_width > contents.width)
          if $nms.txt_cut; new_line
          elsif $nms.txt_scrl_hori
            nms_scroll_hori(c_width)
            @wait_count = $nms.txt_scrl_hori_delay
            @text = c + @text
            return
          end
        end
        nms_line_height = contents.text_size(c).height
        contents.draw_text(@contents_x, @contents_y, 40, nms_line_height, c)
        @contents_x += c_width
        # Change Biggest Text Height
        @biggest_text_height = nms_line_height if nms_line_height > @biggest_text_height
        
        # Play Typing Sound
        if $nms.typ_se and @typse_count <= 0
          RPG::SE.new($nms.typ_file, $nms.typ_vol).play
          @typse_count += $nms.typ_skip
        end
        #Show Fast & Text Delay
        @show_fast = true if $nms.lbl == false

        @delay_text += $nms.text_delay
      end
      break unless @show_fast or @line_show_fast
    end
  end
  #--------------------------------------------------------------------------
  # ? ??????????
  #--------------------------------------------------------------------------
  def finish_message
    if $game_message.choice_max > 0
      start_choice
    elsif $game_message.num_input_variable_id > 0
      start_number_input
    elsif @pause_skip
      terminate_message
    else
      self.pause = true
    end
    @wait_count = 10
    @text = nil
  end
  #--------------------------------------------------------------------------
  # ? ??????
  #--------------------------------------------------------------------------
  def start_choice
    self.active = true
    self.index = 0
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def start_number_input
    digits_max = $game_message.num_input_digits_max
    number = $game_variables[$game_message.num_input_variable_id]
    @number_input_window.digits_max = digits_max
    @number_input_window.number = number
    if $game_message.face_name.empty? or MOVE_TEXT == false
      @number_input_window.x = x - 23
    else
      case $game_message.side
      when 0
        @number_input_window.x = (x + 112) - 23
      when 1
        @number_input_window.x = (x + text_x) - 23
      when 2
        @number_input_window.x = x - 23
      when -1
        @number_input_window.x = x - 23
      end
    end
    @number_input_window.x += CHOICE_INPUT_X_PLUS
    @number_input_window.y = y + @contents_y
    @number_input_window.active = true
    @number_input_window.visible = true
    @number_input_window.update
  end
  #--------------------------------------------------------------------------
  # ? EDITED
  #--------------------------------------------------------------------------
  def update_cursor
    if @index >= 0
      if $game_message.face_name.empty?
      x = TEXT_X_PLUS
      else
      x = get_x_face
      end
      y = ($game_message.choice_start + @index) * WLH
      # CHANGE WIDTH OF CURSOR FOR CHOICE SELECT
      if $game_message.face_name.empty? or MOVE_TEXT == false
        facesize = x
      else
        facesize = get_x_face
        facesize += @face.width if $game_message.side == 2
        facesize += @face.width + 16 if $game_message.side == -1
      end
      self.cursor_rect.set(x, y, contents.width - facesize, WLH)
    else
      self.cursor_rect.empty
    end
  end

  #--------------------------------------------------------------------------
  # ? ?????????
  #--------------------------------------------------------------------------
  def input_pause
    if Input.trigger?(Input::B) or Input.trigger?(Input::C)
      self.pause = false
      if @text != nil and not @text.empty?
        new_page if @line_count >= $game_message.max_line
      else
        terminate_message
      end
    end
  end
  #--------------------------------------------------------------------------
  # ? ????????
  #--------------------------------------------------------------------------
  def input_choice
    if Input.trigger?(Input::B)
      if $game_message.choice_cancel_type > 0
        Sound.play_cancel
        $game_message.choice_proc.call($game_message.choice_cancel_type - 1)
        terminate_message
      end
    elsif Input.trigger?(Input::C)
      Sound.play_decision
      $game_message.choice_proc.call(self.index)
      terminate_message
    end
  end
  #--------------------------------------------------------------------------
  # ? ???????
  #--------------------------------------------------------------------------
  def input_number
    if Input.trigger?(Input::C)
      Sound.play_decision
      $game_variables[$game_message.num_input_variable_id] =
        @number_input_window.number
      $game_map.need_refresh = true
      terminate_message
    end
  end
end

#==============================================================================
# NMS +[ADD ON]+ WINDOW_MESSAGE_CLASS
#------------------------------------------------------------------------------
#==============================================================================

class Window_Message < Window_Selectable
  
# Return X for Text
def get_x_face
  if MOVE_TEXT == true
    case $game_message.side
    when 0
      return 112 + TEXT_X_PLUS
    when 1
      return text_x
    when 2
      return TEXT_X_PLUS
    else
      return TEXT_X_PLUS
    end
  else
    return TEXT_X_PLUS
  end
end

  def text_x
    return @face.width + TEXT_X_PLUS
  end
  
  # Clear Name Box & Name Text
  def clear_namebox
    @nametxt.bitmap.dispose
    @namebox.dispose
    @namebox = nil
    @name_text = nil
  end
  
  def nms_get_map_name
    mapdata = load_data("Data/MapInfos.rvdata")
    map_id = $game_map.map_id
    return mapdata[map_id].name
  end
  
  #--------------------------------------
  # DRAW FACE [Both Systems] METHOD
  #------------------------------------
  def draw_face2(face_name, x, y, index = 0, animf = false, animf_index = 0, animf_max = 1, nofade = false)
  if animf
    # Use Animated Face
    bitmap = Cache.face(face_name)
    rect = Rect.new(0,0,0,0)
    rect.width = (bitmap.width / animf_max)
    rect.height = bitmap.height
    rect.x = animf_index * rect.width
    rect.y = 0
    @face.bitmap = Bitmap.new(rect.width,rect.height)
    @face.bitmap.blt(0,0,bitmap,rect)
    bitmap.dispose
  elsif $game_message.side == 0 or $game_message.side == -1 or EightFaces_File
    # USE 8 FACES PER FILE
    bitmap = Cache.face(face_name)
    rect = Rect.new(0,0,0,0)
    rect.width = (bitmap.width / 4)
    rect.height = (bitmap.height / 2)
    rect.x = index % 4 * rect.width
    rect.y = index / 4 * rect.height
    @face.bitmap = Bitmap.new(rect.width,rect.height)
    @face.bitmap.blt(0,0,bitmap,rect)
    bitmap.dispose
  else
    # USE 1 FACES PER FILE
    @face.bitmap = Cache.face(face_name)
  end
  # SET X/Y OF FACE DEPENDS ON FACE SIDE
  if $game_message.side == 1
    @face.mirror = false
    @face.x = x + 6
    @face.y = y - 6 + height - @face.height
  elsif $game_message.side == 2
    @face.mirror = true
    @face.x = x + ((self.width - 6) - @face.width)
    @face.y = y - 6 + height - @face.height
  elsif $game_message.side == 0
    @face.mirror = false
    @face.x = x + 16
    @face.y = y - 16 + height - @face.height
  elsif $game_message.side == -1
    @face.mirror = true
    @face.x = x + self.contents.width - @face.width + 16
    @face.y = y - 16 + height - @face.height
  end
    @face.x += FACE_X_PLUS
    @face.y += FACE_Y_PLUS
    @face_data = [face_name, index, $game_message.side]
    if @face_data != @face_data_old and FADE_MOVE_WHEN_USE_NEW_FACE; @showtime = 1; @face_data_old = @face_data; end
    @face.opacity = 0 if !nofade and ($nms.face_fade == true and ((FADE_ONLY_FIRST and @showtime <= 1) or (FADE_ONLY_FIRST == false)))
  end
  #--------------------------------------
  # DRAW NAME BOX METHOD
  #-----------------------------------
  def draw_name(name,x,y)
    name = name + NAMEBOX_TEXT_AFTER_NAME
    a = Bitmap.new(33,33)
    a.font.name = NAMEBOX_TEXT_FONT
    a.font.size = NAMEBOX_TEXT_SIZE
    rect = a.text_size(name)
    a.dispose
    @nametxt.bitmap = Bitmap.new(16 + rect.width, rect.height + NAMEBOX_TEXT_HEIGHT_PLUS)
    @nametxt.x = x + 8
    if $game_message.side == 1 or $game_message.side == 2
      @nametxt.x += NAMEBOX_X_PLUS_NEO
    else
      @nametxt.x += NAMEBOX_X_PLUS_NOR
    end
    @nametxt.y = y - 20 + ($game_message.position == 0 ? NAMEBOX_Y_PLUS_TOP : NAMEBOX_Y_PLUS)
    namebox_x_plus = ($game_message.side == 1 or $game_message.side == 2) ? NAMEBOX_X_PLUS_NEO : NAMEBOX_X_PLUS_NOR
    @nametxt.x = ((self.x + $nms.msg_w) - namebox_x_plus - @nametxt.width) if MOVE_NAMEBOX and ($game_message.side == 2 or $game_message.side == -1)
    @namebox = Window.new
    @namebox.windowskin = Cache.system(NAMEBOX_SKIN)
    @namebox.z = self.z + 10
    @namebox.opacity = case @background
    when 0; NAMEBOX_OPACITY
    when 1; NAMEBOX_OPACITY_DIM_BG
    when 2; NAMEBOX_OPACITY_NO_BG
    end
    @namebox.back_opacity = NAMEBOX_BACK_OPACITY
    @namebox.openness = 255
    @namebox.x = @nametxt.x - NAMEBOX_BOX_WIDTH_PLUS
    @namebox.y = @nametxt.y - NAMEBOX_BOX_HEIGHT_PLUS
    @namebox.width = @nametxt.bitmap.width + (NAMEBOX_BOX_WIDTH_PLUS * 2)
    @namebox.height = @nametxt.bitmap.height + (NAMEBOX_BOX_HEIGHT_PLUS * 2)
    # Fixed position bug
    @namebox.x = 0 if @namebox.x < 0
    @namebox.x = (Graphics.width - @namebox.width) if (@namebox.x + @namebox.width) > Graphics.width 
    @nametxt.bitmap.font.name = NAMEBOX_TEXT_FONT
    @nametxt.bitmap.font.size = NAMEBOX_TEXT_SIZE
    @nametxt.bitmap.font.bold = NAMEBOX_TEXT_BOLD
    if NAMEBOX_TEXT_OUTLINE == true
      # MAKE TEXT OUTLINE
      old_shadow = @nametxt.bitmap.font.shadow
      @nametxt.bitmap.font.color = Color.new(0,0,0)
      @nametxt.bitmap.draw_text(0,2,@nametxt.bitmap.width,@nametxt.bitmap.height,name,1)
      @nametxt.bitmap.draw_text(0,0,@nametxt.bitmap.width,@nametxt.bitmap.height,name,1)
      @nametxt.bitmap.draw_text(2,0,@nametxt.bitmap.width,@nametxt.bitmap.height,name,1)
      @nametxt.bitmap.draw_text(2,2,@nametxt.bitmap.width,@nametxt.bitmap.height,name,1)
      @nametxt.bitmap.font.shadow = old_shadow
    end
    @nametxt.bitmap.font.color = Color.new($game_message.color[0],$game_message.color[1],$game_message.color[2])
    @nametxt.bitmap.draw_text(1,1,@nametxt.bitmap.width,@nametxt.bitmap.height,name,1)
    @name_text = nil
  end
  
  #--------------------------------------
  # DRAW NEW FACE
  #-----------------------------------
  def nms_draw_new_face
    # Setup Face Name / Index
    name = $game_message.face_name
    index = $game_message.face_index
    animf_test = name.sub(/\[([0-9]+)\]/, "")
    # Animated?
    @animf = $1.to_i > 0 ? true : false
    @animf_maxind = $1.to_i
    @animf_ind = 0
    @animf_dl = $nms.animf_delay
    # CALL DRAW FACE METHOD
    draw_face2(name, self.x, self.y, index, @animf, @animf_ind, @animf_maxind)
  end
  #--------------------------------------
  # UPDATE ANIMATION FACE
  #-----------------------------------
  def update_animate_face
    if (!self.pause or $nms.animf_cont)
      @animf_dl -= 1
      if @animf_dl <= 0
        @animf_ind = (@animf_ind + 1) % @animf_maxind
        @animf_dl = $nms.animf_delay
        draw_face2($game_message.face_name, self.x, self.y, index, @animf, @animf_ind, @animf_maxind, true)
      end
    elsif @animf_ind != 0
      @animf_ind = 0
      draw_face2($game_message.face_name, self.x, self.y, index, @animf, @animf_ind, @animf_maxind, true)
    end
  end
  #--------------------------------------
  # SCROLL TEXT HORIZONTAL
  #-----------------------------------
  def nms_scroll_hori(scr_width)
    biggest = @biggest_text_height > WLH ? @biggest_text_height : WLH
    rect = Rect.new(0, @contents_y, contents.width, biggest)
    bitmap = Bitmap.new(rect.width, rect.height)
    bitmap.blt(0, 0, contents, rect)
    contents.clear_rect(rect)
    rect = Rect.new(0, 0, rect.width, rect.height)
    contents.blt(0 - scr_width, @contents_y, bitmap, rect)
    contents.clear_rect(0, 0, @face.width, @face.height) if @face.bitmap != nil
    bitmap.dispose
    @contents_x = @contents_x - scr_width
  end
  
  #--------------------------------------
  # GET HEX COLOR by RPG & ERZENGEL
  #------------------------------------
  def get_hex(n)
    red = 0
    green = 0
    blue = 0
    if n.size != 6
      print("Hex triplets must be six characters long!\nNormal color will be used.")
      return normal_color
    end
    for i in 1..6
      sliced = n.slice!(/./m)
      value = hexconvert(sliced)
      case i
      when 1; red += value * 16
      when 2; red += value
      when 3; green += value * 16
      when 4; green += value
      when 5; blue += value * 16
      when 6; blue += value
      end
    end
    return Color.new(red, green, blue)
  end
  def hexconvert(n)
    case n
    when "0"; return 0
    when "1"; return 1
    when "2"; return 2
    when "3"; return 3
    when "4"; return 4
    when "5"; return 5
    when "6"; return 6
    when "7"; return 7
    when "8"; return 8
    when "9"; return 9
    when "A"; return 10
    when "B"; return 11
    when "C"; return 12
    when "D"; return 13
    when "E"; return 14
    when "F";return 15
    else; return -1
    end
  end
end # CLASS END

#==============================================================================
# NMS +[ADD ON]+ OTHER CLASS
#------------------------------------------------------------------------------
#==============================================================================

# STORE variables here~*
class Game_Message
  attr_accessor :nms_fontname, :nms_fontsize, :event_id, :side, :color, :_name,
:last_color, :text_delay, :lbl, :msg_w, :msg_h, :msg_x, :max_line, :nms_face_name, 
:nms_face_index, :next_msg, :typ_se, :typ_file, :typ_skip, :typ_vol, :mback, :mback_opac,
:qt, :txt_scrl, :msg_h_user, :animf_delay, :animf_cont, :txt_cut, :txt_unl, :txt_scrl_hori,
:txt_scrl_hori_delay, :face_fade, :face_move, :msg_temp_y, :msg_temp_x, :msg_temp_h,
:msg_temp_w

  
  alias wor_nms_old_ini initialize
  def initialize
    create_nms_data
    wor_nms_old_ini
  end
  
  def create_nms_data
    # NFS
    @side = Window_Base::DEFAULT_FACE_SIDE
    @_name = ""
    @color = Window_Base::NAMEBOX_TEXT_DEFAULT_COLOR
    # NMS
    @last_color = 0
    @nms_fontname = Window_Base::NMS_FONT_NAME
    @nms_fontsize = Window_Base::NMS_FONT_SIZE
    @event_id = 0
    @text_delay = Window_Base::NMS_DELAY_PER_LETTER
    @lbl = true
    @msg_w = Window_Base::NMS_MSGWIN_WIDTH
    @msg_h = @msg_h_user = Window_Base::NMS_MSGWIN_MIN_HEIGHT
    @msg_x = Window_Base::NMS_MSGWIN_X
    @max_line = Window_Base::NMS_MAX_LINE
    @nms_face_name = ""
    @nms_face_index = 1
    @next_msg = false
    @typ_se = Window_Base::TYPING_SOUND
    @typ_file = Window_Base::TYPING_SOUND_FILE
    @typ_skip = Window_Base::TYPING_SOUND_SKIP
    @typ_vol = Window_Base::TYPING_SOUND_VOLUME
    @mback = Window_Base::NMS_MSG_BACK
    @mback_opac = Window_Base::NMS_MSG_BACK_OPACITY
    @qt = Array.new
    @txt_scrl = Window_Base::NMS_TEXT_SCROLL
    @animf_delay = Window_Base::ANIMATE_FACE_DELAY
    @animf_cont = Window_Base::ANIMATE_FACE_CONTINUE
    @txt_cut = Window_Base::NMS_TEXT_AUTO_CUT
    @txt_scrl_hori = Window_Base::NMS_TEXT_AUTO_SCROLL_HORIZONTAL
    @txt_scrl_hori_delay = Window_Base::NMS_TEXT_AUTO_SCROLL_HORIZONTAL_DELAY
    @txt_unl = Window_Base::NMS_USER_NEW_LINE
    @face_fade = Window_Base::FADE_EFFECT
    @face_move = Window_Base::MOVE_EFFECT
    @msg_temp_x = nil
    @msg_temp_y = nil
    @msg_temp_h = nil
    @msg_temp_w = nil
  end
end

class Game_Map
  attr_accessor :interpreter
end

class Game_Interpreter
  attr_accessor :params
end

class Game_Interpreter
  def command_101
    unless $game_message.busy
      $game_message.event_id = @event_id
      $game_message.face_name = @params[0]
      $game_message.face_index = @params[1]
      $game_message.background = @params[2]
      $game_message.position = @params[3]
      next_msg = true
    loop do
      if @list[@index].code == 101 and $game_message.max_line > $game_message.texts.size and next_msg
        @index += 1
      else
        break
      end
      next_msg = false
      while @list[@index].code == 401 and $game_message.max_line > $game_message.texts.size
        next_msg = $game_message.next_msg
        $game_message.texts.push(@list[@index].parameters[0])
        @index += 1
      end
    end
      if @list[@index].code == 102
        setup_choices(@list[@index].parameters)
      elsif @list[@index].code == 103
        setup_num_input(@list[@index].parameters)
      end
      set_message_waiting
    end
    return false
  end
  
  def setup_choices(params)
    if $game_message.texts.size <= $game_message.max_line - params[0].size
      $game_message.choice_start = $game_message.texts.size
      $game_message.choice_max = params[0].size
      for s in params[0]
        $game_message.texts.push(s)
      end
      $game_message.choice_cancel_type = params[1]
      $game_message.choice_proc = Proc.new { |n| @branch[@indent] = n }
      @index += 1
    end
  end
end
