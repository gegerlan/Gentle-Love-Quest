class Window_Status < Window_Base

  LW = 90
  VW = 40
  IW = 130

  attr_accessor   :page
  attr_accessor   :totalpages
  
  
  def initialize(actor)
    super(0, 0, 544, 416)
    @actor = actor
    @page = 1
    @totalpages = 3
    refresh
  end
  
  def refresh
    self.contents.clear

    headerColor = 14
    
    case @page
      when 1

        line = 0
        
        #Name
        self.contents.draw_text(0, line, 200, WLH, @actor.name.to_s() + " (" + @actor.class.name.to_s() +")", 0)

        #Custom parameters
        line += WLH
        line += WLH
        self.contents.font.color = text_color(headerColor)
        self.contents.draw_text(IW*0   , line, LW, WLH, "Attributes" , 0)
        self.contents.font.color = normal_color

        line += WLH
        self.contents.draw_text(0 , line, LW, WLH, "Intelligence:" , 0)
        self.contents.draw_text(LW, line, VW, WLH, @actor.custom_attr["intelligence"], 0)

        self.contents.draw_text(IW   , line, LW, WLH, "Alignment:", 0)
        self.contents.draw_text(IW+LW, line, VW, WLH, @actor.custom_attr["alignment"], 0)
         
        #Sex parameters
        line += WLH
        line += WLH
        self.contents.font.color = text_color(headerColor)
        self.contents.draw_text(IW*0   , line, LW, WLH, "Sex" , 0)
        self.contents.font.color = normal_color

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Horny:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.custom_attr["horny"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Pervert:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.custom_attr["pervert"], 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Fertility:" , 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.custom_attr["fertility"], 0)
        self.contents.draw_text(IW*3   , line, LW, WLH, "Breast Size:", 0)
        self.contents.draw_text(IW*3+LW, line, VW, WLH, @actor.breastSize(@actor.custom_attr["breastSize"]), 0)

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Cow:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.custom_attr["cow"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Breast milk:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.custom_attr["fullBreast"].to_s() + "%", 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Mare:", 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.custom_attr["mare"], 0)

        #Statistics
        line += WLH
        line += WLH
        self.contents.font.color = text_color(headerColor)
        self.contents.draw_text(IW*0   , line, LW, WLH, "Statistics" , 0)
        self.contents.font.color = normal_color

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Masturbation:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.stats["masturbation"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Fuck:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.stats["fuck"], 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Women:" , 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.stats["women"], 0)
        self.contents.draw_text(IW*3   , line, LW, WLH, "Oral:", 0)
        self.contents.draw_text(IW*3+LW, line, VW, WLH, @actor.stats["oral"], 0)

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Anal:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.stats["anal"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Bondage:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.stats["bondage"], 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Whore:" , 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.stats["whore"], 0)
        self.contents.draw_text(IW*3   , line, LW, WLH, "Rape:", 0)
        self.contents.draw_text(IW*3+LW, line, VW, WLH, @actor.stats["rape"], 0)

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Animal:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.stats["animal"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Monster:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.stats["monster"], 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Demon:" , 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.stats["demon"], 0)
        self.contents.draw_text(IW*3   , line, LW, WLH, "Hypno:", 0)
        self.contents.draw_text(IW*3+LW, line, VW, WLH, @actor.stats["hypno"], 0)

        line += WLH
        self.contents.draw_text(IW*0   , line, LW, WLH, "Pokemon:" , 0)
        self.contents.draw_text(IW*0+LW, line, VW, WLH, @actor.stats["pokemon"], 0)
        self.contents.draw_text(IW*1   , line, LW, WLH, "Milk Given:", 0)
        self.contents.draw_text(IW*1+LW, line, VW, WLH, @actor.stats["givenMilk"], 0)
        self.contents.draw_text(IW*2   , line, LW, WLH, "Exhibitions:", 0)
        self.contents.draw_text(IW*2+LW, line, VW, WLH, @actor.stats["exhibition"], 0)
      when 2
        line = 0

        #Name
        self.contents.draw_text(0, line, 100, WLH, @actor.name.to_s() + " (" + @actor.class.name.to_s() +")", 0)

        line += WLH
        line += WLH
        self.contents.draw_text(0, line, 100, WLH, "Page 2", 0)
      when 3
        line = 0
        #Name
        self.contents.draw_text(0, line, 100, WLH, @actor.name.to_s() + " (" + @actor.class.name.to_s() +")", 0)

        line += WLH
        line += WLH
        self.contents.draw_text(0, line, 100, WLH, "Page 3", 0)
    end
 
  end

  def nextpage
    @page += 1
    if (@page > @totalpages)
      @page = 1
    end
    refresh
  end
  
end