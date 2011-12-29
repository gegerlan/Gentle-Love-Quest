class Game_Actor
  def check(difficulty, attributeName, *modifiers)
    attributeValue = send attributeName
    attributeValue = attributeValue.to_i
    
    modifiers << -rand(difficulty + 1) # difficulty modifier
    for modifier in modifiers
      attributeValue += modifier
    end
      
    outcome = attributeValue > 0
    return outcome
  end
end

class Game_Interpreter
  def checkParty(difficulty, attributeName, *modifiers)
    success = false
    $game_party.members.each do |member|
      success = member.check(difficulty, attributeName, *modifiers)
      break if success
    end
    return success
  end
  def checkPlayer(difficulty, attributeName, *modifiers)
    return $game_party.members[0].check(difficulty, attributeName, *modifiers)
  end
  alias check checkParty
  def checkActor(actorIdentifier, difficulty, attributeName, *modifiers)
    actors = $game_actors.to_a.slice(1..-1)
    actor = getActor(actorIdentifier, actors)
    if actor != nil
      return actor.check(difficulty, attributeName, *modifiers)
    end
    return false
  end
  def checkMember(actorIdentifier, difficulty, attributeName, *modifiers)
    actor = getActor(actorIdentifier, $game_paty.members)
    if actor != nil
      return actor.check(difficulty, attributeName, *modifiers)
    end
    return false
  end
  private
  def getActor(actorIdentifier, context)
    if actorIdentifier.is_a?(Game_Actor)
      return actorIdentifier
    elsif actorIdentifier.is_a?(Integer)
      return context[actorIdentifier]
    elsif actorIdentifier.is_a?(String)
      return context.find{|actor| actor.name == actorIdentifier}
    else
      return nil
    end
  end
end