class Game_Interpreter
  def setMood(new_mood, *actor_indices)
    actor_indices.each do |actor_index|
      $game_actors[actor_index].mood = new_mood if $game_actors[actor_index] != nil
    end
  end
  def setPartyMood(new_mood, *member_indices)
    member_indices.each do |member_index|
      setMood(new_mood, $game_party.members[member_index].id) if $game_party.members[member_index] != nil
    end
  end
  def setPlayerMood(new_mood)
    setPartyMood(new_mood, 0)
  end
end