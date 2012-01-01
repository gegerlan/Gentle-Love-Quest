class Game_Actor < Game_Battler
  
  attr_accessor   :stats
  attr_accessor   :custom_attr
  
  attr_accessor   :mood
  attr_accessor   :attribute_history
  
  alias glq_initialize initialize
  
  def initialize(actor_id)
    glq_initialize(actor_id)
 
    @attribute_history = {}
    
    @mood = "neutral"

    @stats = {
      "masturbation" => 0,
      "exhibition"   => 0,
      "fuck"         => 0,
      "women"        => 0,
      "oral"         => 0,
      "anal"         => 0,
      "bondage"      => 0,
      "whore"        => 0,
      "rape"         => 0,
      "animal"       => 0,
      "monster"      => 0,
      "demon"        => 0,
      "hypno"        => 0,
      "pokemon"      => 0,
      "givenMilk"    => 0
    }

    @custom_attr = {
      "intelligence" => 0,
      "alignment"    => 0,
      "horny"        => 0,
      "pervert"      => 0,
      "fertility"    => 10,
      "breastSize"   => 2,
      "cow"          => 0,
      "mare"         => 0,
      "fullBreast"   => 100,
    }
  end
  
  def clothing
    case armor3_id
    when 0
      "Nude"
    when 1
      "Normal"
    when 4
      "Cow"
    when 5
      "Cow"
    else
      "Normal"
    end
  end
  
  def breastSize(index)
    sizes = ["A", "B", "C", "D", "DD", "DDD", "E", "F","G","H","HH","HHH","Insane"]
    return sizes[index]
  end
  
  # Provides the number of matched context
  #   attribute: name of the attribute
  #   context: the context to match for the attribute
  #   block: further selection criteria as a block
  #
  # Example
  #    get_context_occurance("sexAppeal", [1,2,3]) # Get the number of changes to sexAppeal from map 1's event 2's page 3
  #    get_context_occurance("fertility", [3,2,1], { |item| item[:value] > 0 }) # Get the number of changes to fertility from map 3's event 2's page 1 that were positive.
  def get_context_occurance(attribute, context, &block)
    history = @attribute_history[attribute] ||= []
    context_instances = history.select { |instance| instance[:context] == context }
    if context_instances != nil
      context_instances = context_instances.select {|item| block.call(item)} if block != nil
      context_instances.length
    else
      0
    end
  end
  # Update the value of a historic attribute change
  #   attribute = attribute name
  #   time = the game frame when it happened
  #   context = the context where the change happened
  #   value = the value to change to
  def update_history(attribute, time, context, value)
    history = @attribute_history[attribute] ||= []
    i = history.find { |item| item[:time] == time && item[:context] == context }
    i[:value] = value
  end

  # Remove a historic attribute change
  #   attribute = name of the attribute
  #   context = the change at a given context to remove
  #   time = the change at the given time to remove
  # Context and/or time needs to be provided. But both is not a must.
  #
  # Example
  #   remove_history("sexAppeal", [1,2,3]) # remove historic change to sexAppeal for Map 1's Event 2's Page 3
  #   remove_history("fertility", nil, 130) # remove historic change to fertility that happened during frame 130 (~2 secounds into the game)
  #   remove_history("pervert", [3,2,1], 1200) # remove historic change to pervert that happened for Map 3's Event 2's Page 1, during frame 1200 (~2 minutes into the game)
  def remove_history(attribute, context = nil, time = nil)
    if context != nil || time != nil
      history = @attribute_history[attribute] ||= []
      history.remove! do |item|
        doRemove = false
        if context != nil
          doRemove = item[:context] == context
        end
        if time != nil && (context == nil || doRemove)
          doRemove = item[:time] == time
        end
        doRemove
      end
    end
  end
  # Log a change to an attribute
  #   attribute = name of the attribute
  #   context = where the change happened
  #   value = the change (delta)
  def add_history(attribute, context, value)
    time = Graphics.frame_count
    item = {:time => time, :context => context, :value => value}
    
    history = @attribute_history[attribute] ||= []
    history << item
  end
  
  # Raise one of the attributes for the actor.
  #   attribute: attribute name to raise
  #   delta: the improvement to the attribute
  #   max: the highest value the raise can increase towards (i.e. attribute can't be raised beyond this value)
  #   context: the context uniquely identifying the change
  def raise(attribute, delta, max, context = nil)
    current_value = self.send attribute
    if max < current_value 
      # Skip if the current value is less than the min value provided
      current_value
    else
      if context != nil
        # If we have a context, we want to see how often this change has been
        # called and make appropriate changes to our delta value, by halfing
        # the change with the number of times the update has been called.
        delta = delta / (get_context_occurance(attribute, context) {|item| delta > 0 ? item[:value] > 0 : item[:value] < 0 } + 1)
        delta = delta.floor
      end
      if current_value + delta.abs > max
        delta = max - current_value
      end
      if delta == 0
        current_value # ignore if there's no change
      else
        update_attribute(attribute, delta.abs, context)
      end
    end
  end
  # Lower one of the attributes for the actor.
  #   attribute: attribute name to raise
  #   delta: the decrease of the attribute
  #   min: the smallest value the lower can decrease towards (i.e. attribute can't be lowered beyond this value)
  #   context: the context uniquely identifying the change
  def lower(attribute, delta, min, context = nil)
    current_value = self.send attribute
    if min > current_value 
      # Skip if the current value is less than the min value provided
      current_value
    else
      if context != nil
        # If we have a context, we want to see how often this change has been
        # called and make appropriate changes to our delta value, by halfing
        # the change with the number of times the update has been called.
        delta = delta / (get_context_occurance(attribute, context) {|item| delta > 0 ? item[:value] > 0 : item[:value] < 0 } + 1)
        delta = delta.floor
      end
      if current_value - delta.abs < min
        delta = min - current_value
      end
      if delta == 0
        current_value # ignore if there's no change
      else
        update_attribute(attribute, -delta.abs, context)
      end
    end
  end
  
  def update_attribute(attribute, delta, context)
    if delta == 0 
      # If there is no change, just return the attribute value
      self.send attribute
    else
      add_history(attribute, context, delta)
      # Makes a call setting the attribute
      # e.g. sexAppeal=10
      self.send("#{attribute}=", self.send(attribute) + delta)
    end
  end
  
  # Makes @stats and @custom_attr accessible as normal attributes of Game_Actor
  # i.e. calling $game_party.members[0].pervert will given you the perversion 
  # value of the party leader
  def method_missing(sym, *args, &block)
    [@stats, @custom_attr].each do |haystack|
      key = sym.to_s
      if key =~ /=$/
        key.gsub!(/=$/, "")
        return haystack[key] = args.inject {|s,x| s ? s+x : x} if haystack.has_key?(key)
      else
        return haystack[key] if haystack.has_key?(key)
      end
    end
    super(sym, *args, &block)
  end
end

class Game_Interpreter
  # Improve the attribute of the player, with a max possible value to alter towards.
  #   attribute: name of attribute to raise
  #   amount:  how much to change the attribute
  #   max: to top value the change may increase to
  #   extra_context: extra context for the identifying the change
  def raise(attribute, amount, max, extra_context = nil)
    context = [$game_map.map_id, @event_id, @page_id]
    context << extra_context if extra_context != nil
    $game_party.members[0].raise(attribute, amount, max, context)
  end
  # Decrease the attribute of the player, with a min possible value to alter towards.
  #   attribute: name of attribute to lower
  #   amount:  how much to change the attribute
  #   min: to min value the change may increase to
  #   extra_context: extra context for the identifying the change
  def lower(attribute, amount, min, extra_context = nil)
    context = [$game_map.map_id, @event_id, @page_id]
    context << extra_context if extra_context != nil
    $game_party.members[0].lower(attribute, amount, min, context)
  end
end