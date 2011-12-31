=begin
# Added dice rolls for doing checks against attributes
=end
class Game_Actor
  # Do a dice roll and see if the actor passes the check
  # check(difficulty, attributeName[, modifier[, modifier[, ..])
  #   difficulty: How likely the check is to pass (recommended 0-100 value)
  #               0 implies always, while 100 makes it very unlikely
  #   attributeName: The name of the actor's attributes to check
  #                  e.g. fertility. The value is converted to int for the
  #                  check
  #   modifier: positive or negative values that impacts the likelyhood that
  #             the check is passed by the actor. This could be context specific
  #             things like dialog choices.
  #
  # Example
  #   if actor.check(80, fertility)
  #     p "Congratulation #{actor.name} is pregnant!"
  #   end
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
  # See if any member of the party passes a check.
  #
  # checkParty(difficulty, attribute[, modifier[, modifier[, ...]]])
  def checkParty(difficulty, attributeName, *modifiers)
    success = false
    $game_party.members.each do |member|
      success = member.check(difficulty, attributeName, *modifiers)
      break if success
    end
    return success
  end
  
  # See if the current leader of the party passes a check.
  #
  # checkPlayer(difficulty, attribute[, modifier[, modifier[, ...]]])
  def checkPlayer(difficulty, attributeName, *modifiers)
    return $game_party.members[0].check(difficulty, attributeName, *modifiers)
  end
  # check(difficulty, attribute[, modifier[, modifier[, ...]]]) - alias for checkParty
  alias check checkParty
  
  # check actor (as defined in database) by using object (Game_Actor), 
  # database position (integer) or name (string)
  #
  # checkActor(actorIdentifier, difficulty, attribute[, modifier[, modifier[, ...]]])
  def checkActor(actorIdentifier, difficulty, attributeName, *modifiers)
    actors = $game_actors.to_a.slice(1..-1)
    actor = getActor(actorIdentifier, actors)
    if actor != nil
      return actor.check(difficulty, attributeName, *modifiers)
    end
    return false
  end
  
  # Check current party member by using object (Game_Actor), party position (integer) or name (string)
  # checkMember(memberIdentifier, difficulty, attribute[, modifier[, modifier[, ...]]])
  def checkMember(actorIdentifier, difficulty, attributeName, *modifiers)
    actor = getActor(actorIdentifier, $game_party.members)
    if actor != nil
      return actor.check(difficulty, attributeName, *modifiers)
    end
    return false
  end
  
  private
  # Simplifies getting the actor when passed an integer, a string or an object.
  # Context provides the source where to search for the actor, usually 
  # $game_players or $game_party.members
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