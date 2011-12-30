=begin
#
# This script will look for facesets with the word '- placeholder -' in them, 
# andreplace them with a relevant image.
#
=end
module Cache
  # armor_id => body name (part of filename)
  # The first value defined will be used for undefined armors
  BODY_NAME = {
    4 => "Cow",
    1 => "Normal",  
    0 => "Nude"
  }
  class << self
    alias glq_face face
  end
  def self.face(filename)
    if filename =~ /- placeholder -/i
      options = filename.split("-").map { |s| s.strip }
      actor_name = options[0]
      actor_state = options[2]
      # Retrieve the actor so we can get the armor
      actor = $game_actors.to_a.slice(1..-1).find do |actor| 
        actor.name.casecmp(actor_name) == 0
      end
      if actor != nil
        # Use the first option if the name of the current armor isn't defined
        actor_body = BODY_NAME[actor.armor3_id] || BODY_NAME.values[0]
        filename = "#{actor_name} - #{actor_body} - #{actor_state}"
      end
    end
    # Call the original face function to draw the face
    glq_face(filename)
  end
end