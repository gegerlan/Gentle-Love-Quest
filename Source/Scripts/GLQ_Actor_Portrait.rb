class Game_Actor < Game_Battler
  def portrait_name
    "#{name} - #{clothing} - #{mood}" # Eva - Normal - Smiling
  end
end