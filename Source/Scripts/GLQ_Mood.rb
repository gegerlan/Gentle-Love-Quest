=begin
# Makes it possible to set the mood for actors
# by using short script command in an event.
=end
class Game_Interpreter
  # Set the mood new_mood for one or more actors by their position 
  # in the database.
  # e.g. 
  # setMood("Neutral", 1)
  #   Set the mood to Neutral for the actor at position 1 in the database
  # setMood("Smiling", 2, 3)
  #   Set the mood to Smiling for the actors at position 2 and 3 in the database
  def setMood(new_mood, *actor_indices)
    actor_indices.each do |actor_index|
      $game_actors[actor_index].mood = new_mood if $game_actors[actor_index] != nil
    end
  end
  # Set the mood new_mood for one or more members of the player's 
  # party by their position in the team.
  # e.g.
  # setPartyMood("Neutral", 0)
  #   Set the mood to Neutral for the first party member (the player)
  # setPartyMood("Smiling", 1, 2)
  #   Set the mood to Smiling for the second and third members of the party.
  def setPartyMood(new_mood, *member_indices)
    member_indices.each do |member_index|
      setMood(new_mood, $game_party.members[member_index].id) if $game_party.members[member_index] != nil
    end
  end
  # Set the mood for the player (the leader of the current party)
  # Short for calling setPartyMood with position 0 (set the mood for the first party member).
  def setPlayerMood(new_mood)
    setPartyMood(new_mood, 0)
  end
end
