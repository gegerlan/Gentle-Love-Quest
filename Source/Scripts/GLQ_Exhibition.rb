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