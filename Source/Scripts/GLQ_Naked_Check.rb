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