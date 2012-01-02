class Game_Player < Game_Character
  attr_accessor   :karma       # type of vehicle currenting being ridden
  alias glq_karma_initialize initialize
  def initialize
    glq_karma_initialize
    @karma = 0
  end
end
