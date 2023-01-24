require("constants")

UI = {}

UI.width = 200

UI.paint_ui = function(self)
  -- Paints the UI section on the right
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle("fill", love.graphics.getWidth() - self.width, 0, self.width, love.graphics.getHeight())

  self:paint_fps()
  self:paint_mode()
end

UI.paint_mode = function(self)
  -- TODO: account for spacing on the very right
  local modes = {"Move", "Point", "Line", "Path"}
  local x_starting_position = love.graphics.getWidth() - UI.width

  for index, mode in ipairs(modes) do
    -- Setting the color of each mode
    if Mode:is(index) then
      love.graphics.setColor(0.75, 0.75, 0.75)
    else
      love.graphics.setColor(0, 0, 0)
    end

    local x_position = x_starting_position + (Graph.padding / 2) + ((index - 1) * (self.width / 4))
    -- love.graphics.points(x_position, Graph.padding)

    -- Painting a rectangle around each mode
    love.graphics.rectangle(
      "fill",
      x_position,
      Graph.padding,
      (self.width / 4) - Graph.padding,
      Font:getHeight(),
      Font:getHeight() / 2,
      Font:getHeight() / 2
    )

    -- Painting the text
    if Mode:is(index) then love.graphics.setColor(0, 0, 0)
    else love.graphics.setColor(0.75, 0.75, 0.75) end
    love.graphics.print(
      mode,
      x_position + (self.width / 8) - (Font:getWidth(mode) / 2) - (Graph.padding / 2),
      Graph.padding
    )

    -- Checks, if the mouse is within a mode UI element
    if
      not Mode:is(index) -- Skipping all further logic checks if we are hovering on the currenlty active mode
      and Utils:is_point_in_pill(
        love.mouse.getX(),
        love.mouse.getY(),
        x_position,
        Graph.padding,
        (self.width / 4) - (2 * Graph.padding), -- This is technically wrong but somehow works
        Font:getHeight()
      )
    then
      love.graphics.setColor(0.75, 0.75, 0.75)
      love.graphics.rectangle(
        "line",
        x_position - 2,
        Graph.padding - 2,
        (self.width / 4) - 1,
        Font:getHeight() + 4,
        Font:getHeight() / 2,
        Font:getHeight() / 2
      )

      -- User clicks on hovered mode UI element
      if love.mouse.isDown(1) then
        Mode:set(index)
      end
    end
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
