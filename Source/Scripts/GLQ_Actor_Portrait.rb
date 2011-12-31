class Game_Actor < Game_Battler
  def portrait_name
    "#{name} - #{clothing} - #{mood}" # Eva - Normal - Smiling
  end
  # Returns the name of the file used as the face for the actor.
  def face_name
    "#{name} - #{clothing}"
  end
  # Returns what part of the face image that should be used for the actor.
  def face_index
    case mood
    when /Neutral/i
      0
    when /Empty eyes/i
      1
    #when ???
    # 2
    when /Ahegao/i
      3
    else
      0
    end
  end
end