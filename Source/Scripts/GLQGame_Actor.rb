class Game_Actor < Game_Battler
  
  attr_accessor   :stats
  attr_accessor   :custom_attr
  
  attr_accessor   :mood
  attr_accessor   :clothing
  
  alias glq_initialize initialize
  
  def initialize(actor_id)
    glq_initialize(actor_id)
 
    @mood = "neutral"
    @clothing = "normal"
    
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
  
  def breastSize(index)
    sizes = ["A", "B", "C", "D", "DD", "DDD", "E", "F","G","H","HH","HHH","Insane"]
    return sizes[index]
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
