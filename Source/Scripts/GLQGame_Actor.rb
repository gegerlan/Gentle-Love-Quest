class Game_Actor < Game_Battler
  
  attr_accessor   :stats
  attr_accessor   :custom_attr
  
  attr_accessor   :mood
  
  alias glq_initialize initialize
  
  def initialize(actor_id)
    glq_initialize(actor_id)
 
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
  # Raise one of the attributes for the actor.
  #   attribute: attribute name to raise
  #   delta: the improvement to the attribute
  #   max: the highest value the raise can increase towards (i.e. attribute can't be raised beyond this value)
  def raise(attribute, delta, max)
    current_value = self.send attribute
    if max < current_value
      # Skip if the current value is greater than the max value provided
      current_value
    else
      target_value  = current_value + delta.abs
      if target_value > max
        # If the projected value is greater than max, set the new value to max
        target_value = max
      end
      # Makes a call setting the attribute
      # e.g. sexAppeal=10
      self.send("#{attribute}=", target_value)
    end
  end
  # Lower one of the attributes for the actor.
  #   attribute: attribute name to raise
  #   delta: the decrease of the attribute
  #   min: the smallest value the lower can decrease towards (i.e. attribute can't be lowered beyond this value)
  def lower(attribute, delta, min)
    current_value = self.send attribute
    if min > current_value 
      # Skip if the current value is less than the min value provided
      current_value
    else
      target_value  = current_value - delta.abs
      if target_value < min
        # If the projected value is less than min, set the new value to min
        target_value = min
      end
      # Makes a call setting the attribute
      # e.g. sexAppeal=10
      self.send("#{attribute}=", target_value)
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

class Game_Party < Game_Unit
  # returns the sum of the attribute for all party members
  def sum(attribute)
    return members.inject(0) { |sum, actor|
      sum += actor.send(attribute)
    }
  end
  # returns the highest value of the attribute that exists in the party
  def max(attribute)
    return members.max { |actor1, actor2|
      actor1.send(attribute) <=> actor2.send(attribute)
    }.send(attribute)
  end
  # returns the lowest value of the attribute that exists in the party
  def min(attribute)
    return members.min { |actor1, actor2|
      actor1.send(attribute) <=> actor2.send(attribute)
    }.send(attribute) 
  end
  # returns the average value of the attribute that exists in the party
  def avg(attribute)
    return sum(attribute) / @actors.length.to_f
  end
  # raise an attribute for all party members
  #   attribute: attribute name
  #   delta: the amount to change
  #   max: cut-off value, the maximum value the change can change towards
  def raise(attribute, delta, max)
    sum = 0
    members.each do |actor|
      sum += actor.raise(attribute, delta, max)
    end
    sum
  end
  # lower an attribute for all party members
  #   attribute: attribute name
  #   delta: the amount to change
  #   min: cut-off value, the minimum value the change can change towards
  def lower(attribute, delta, min)
    sum = 0
    members.each do |actor|
      sum += actor.lower(attribute, delta, min)
    end
    sum
  end
end