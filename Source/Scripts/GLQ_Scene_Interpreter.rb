# Adds the ability to run a Game_Interpreter during any scene
class Scene_Base
  attr_accessor :interpreter_queue
  
  alias atq_pre_interp_start start
  def start
    atq_pre_interp_start
    @interpreter_queue = []
  end
  alias atq_pre_interp_upd update
  def update
    atq_pre_interp_upd
    @queue_item = @interpreter_queue.shift if @queue_item == nil
    unless @queue_item == nil
      if @queue_item.is_a?(Game_Interpreter)
        @queue_item.update
        if not @queue_item.running?
          @queue_item = nil
        end
      else
        @queue_item = nil
      end
    end
  end
end