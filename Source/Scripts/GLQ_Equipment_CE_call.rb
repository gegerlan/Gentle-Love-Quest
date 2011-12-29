=begin
# Makes the game call a CE when the actor's equipment changes
# Requies CLQ Scene Interpreter
=end
class Game_Actor < Game_Battler
  alias pre_atq_actor_id_setup setup
  def setup(actor_id)
    pre_atq_actor_id_setup(actor_id)
    @actor_id = actor_id
  end
  
  EQUIPMENT_CHANGE_CE = 1
  alias pre_atq_chg_eqp change_equip
  def change_equip(equip_type, item, test = false)
    pre_atq_chg_eqp(equip_type, item, test)
    unless test
      interpreter = Game_Interpreter.new(0, true)
      interpreter.setup($data_common_events[EQUIPMENT_CHANGE_CE].list, @actor_id)
      $scene.interpreter_queue << interpreter
    end
  end
end