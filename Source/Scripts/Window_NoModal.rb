class Window_NoModal < Window_Base

  def initialize(x,y,width,height)
    super(x,y,width,height)
    self.visible = false
    @count = 0
  end

  def show_message(message, count)
    @count = count
    self.contents.clear
    self.contents.draw_text(0,0,self.contents.width, WLH, message)
    self.visible = true
  end
  
  def update
    return unless self.visible
    @count -= 1
    self.visible = (@count > 0)
  end
  
end