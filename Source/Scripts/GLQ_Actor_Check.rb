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