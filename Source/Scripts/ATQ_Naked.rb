
def debug_put(message)
  p message if $DEBUG
end

class Game_Actor
  def naked?
    return armor3_id == 0
  end
end
class Game_Actors
  def to_a
    return @data
  end
end
class Game_Interpreter
  ACTOR_CONTEXT = 0
  PARTY_CONTEXT = 1
  # Is the the member of the party naked (party leader if no id is provided)
  # You can pass a Game_Actor, index (0 = leader), or the name of the actor 
  # (case sensitive).
  # You can provide the context of which actors to search. ACTOR_CONTEXT = 0, 
  # searches through all the actors in the database. PARTY_CONTEXT = 1, searches
  # only through the members of the party.
  def isNaked?(member = 0, context = PARTY_CONTEXT)
    if member.is_a?(Game_Actor)
      actor = member
    else
      if context == PARTY_CONTEXT
        haystack = $game_party.members
      elsif context == ACTOR_CONTEXT
        game_actors = $game_actors.to_a
        if game_actors[1] != nil
          haystack = $game_actors.to_a.slice(1..-1)
        else
          debug_put "Missing actor definitions to check if actor is naked."
          return false
        end
      else
        debug_put "Unable to find the context #{context}, to evaluate if #{member} is naked."
        return false
      end
      if member.is_a?(Integer)
        actor = haystack[member]
      elsif member.is_a?(String)
        actor = haystack.find{|actor| actor.name == member}
      else
        debug_put "Unable to evaluate if #{member} is naked, format is not supported."
        return false
      end
    end
    if actor.is_a?(Game_Actor)
      return actor.naked?
    else
      return false
    end
  end
  
  # Is anyone in the party naked?
  def isAnyoneNaked?
    return $game_party.members.any?{ |actor| actor.naked? }
  end
end

class Game_Party < Game_Unit
  def increaseExhibitions(amount)
    @actors.each do |actor_id|
      actor = $game_actors[actor_id]
      if actor.naked?
        actor.stats["exhibition"] += amount
      end
    end
  end
end

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

# Makes the game call a CE when the actor's equipment changes
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