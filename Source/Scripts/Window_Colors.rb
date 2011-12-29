class Window_Colors < Window_Base
  
  def initialize
    super(0, 0, 544, 416)

    refresh
  end
  
  def refresh
    self.contents.clear
    for i in 0..20
      self.contents.font.color = text_color(i)
      self.contents.draw_text(0,0+20*i,100,20, "Color " + i.to_s(),1)
    end
  end
  
  
end


