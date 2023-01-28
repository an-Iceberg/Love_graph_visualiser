require("constants")

UI = {}

UI.width = 200

UI.advice_distance = 18

UI.paint_ui = function(self)
  -- Paints the UI section on the right
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle("fill", love.graphics.getWidth() - self.width, 0, self.width, love.graphics.getHeight())

  self:paint_fps()
  self:paint_mode()
  self:paint_advice()
end

UI.paint_mode = function(self)
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

UI.paint_advice = function(self)
  local x = love.graphics.getWidth() - (UI.width - Graph.padding)
  love.graphics.setColor(1, 1, 1)
  local message = "Delete/Backspace: clear graph\n"

  if Mode.mode == MOVE then
    love.graphics.print(
      message.."Left click: move a point around",
      x,
      self.advice_distance + Graph.padding
    )
  elseif Mode.mode == POINT then
    love.graphics.print(
      message.."Left click: create a new point\nRight click: delete a point",
      x,
      self.advice_distance + Graph.padding
    )
  elseif Mode.mode == LINE then
    -- TODO: adjust height because a slider for the line length is also going to be painted somewhere in the UI
    if SELECTED_POINT == 0 then
      -- No point has been selected yet
      love.graphics.print(
        message.."Left click: select a point",
        x,
        self.advice_distance + Graph.padding
      )
    else
      love.graphics.print(
        message.."Left click: create a new line\nRight click: delete a line",
        x,
        self.advice_distance + Graph.padding
      )
    end
  elseif Mode.mode == PATH then
    love.graphics.print(
      message.."Left click: mark starting point\nRight click: mark ending point\n",
      x,
      self.advice_distance + Graph.padding
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
