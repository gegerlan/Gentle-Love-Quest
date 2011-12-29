class Scene_Base
  
  def someoneNaked
    ret = false
    if $game_actors[1].armor3_id == 0 || 
      $game_actors[2].armor3_id == 0 || 
      $game_actors[3].armor3_id == 0 || 
      $game_actors[4].armor3_id == 0
      ret = true
    end
    
    return ret
  end
  
  def increaseExhibitions(amount)
    if $game_actors[1].armor3_id == 0
      $game_actors[1].stats["exhibition"] += amount
    end
    if $game_actors[2].armor3_id == 0
      $game_actors[2].stats["exhibition"] += amount
    end
    if $game_actors[3].armor3_id == 0
      $game_actors[3].stats["exhibition"] += amount
    end
    if $game_actors[4].armor3_id == 0
      $game_actors[4].stats["exhibition"] += amount
    end
  end
  
  
end
