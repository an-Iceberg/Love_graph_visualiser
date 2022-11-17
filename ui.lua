UI = {
  width = 150,

  paint_ui = function(self)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", love.graphics.getWidth() - self.width, 0, self.width, love.graphics.getHeight())
  end
}
