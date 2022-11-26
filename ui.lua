UI = {}

UI.width = 200

-- TODO: handle UI element hover
UI.paint_ui = function(self)
  -- Paints the UI section on the right
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle("fill", love.graphics.getWidth() - self.width, 0, self.width, love.graphics.getHeight())

  self:paint_fps()
  self:paint_mode()

  -- TODO: paint mode and handle mode selection
end

UI.paint_mode = function(self)
  -- TODO: better spacing
  local modes = {"Move", "Point", "Line", "Path"}
  local x_starting_position = love.graphics.getWidth() - UI.width

  for index, mode in ipairs(modes) do
    index = index - 1
    -- Setting the color of each mode
    if Mode.mode == index then
      love.graphics.setColor(1, 1, 1)
    else
      love.graphics.setColor(0, 0, 0)
    end

    local x_position = x_starting_position + Graph.padding + (index * (self.width / 4))

    -- Painting a rectangle around each mode
    love.graphics.rectangle(
      "fill",
      x_position,
      Graph.padding,
      Font:getWidth(mode) + (2 * Graph.padding),
      Font:getHeight(),
      Font:getHeight() / 2,
      Font:getHeight() / 2
    )

    -- Painting the text
    if Mode.mode == index then
      love.graphics.setColor(0, 0, 0)
    else
      love.graphics.setColor(1, 1, 1)
    end
    love.graphics.print(
      mode,
      x_position + Graph.padding,
      Graph.padding
    )
  end
end

UI.paint_fps = function(self)
  -- Paints the FPS in the lower left corner of the UI section
  love.graphics.setColor(1, 1, 1)
  love.graphics.print(
    "FPS:"..love.timer.getFPS(),
    love.graphics.getWidth() - self.width + Graph.padding,
    love.graphics.getHeight() - (Font:getHeight() + Graph.padding)
  )
end
