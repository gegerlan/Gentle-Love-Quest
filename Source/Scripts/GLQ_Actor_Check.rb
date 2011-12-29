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