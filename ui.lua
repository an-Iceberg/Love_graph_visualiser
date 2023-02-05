require("constants")

UI = {}

UI.width = 200
UI.advice_distance = 18
UI.button_size = 15
UI.button_x_position = love.graphics.getWidth() - UI.width + (2 * Graph.padding)
UI.button_y_position = 56 - (UI.button_size / 2) + 2.5
UI.min_button_x = love.graphics.getWidth() - UI.width + Graph.padding
UI.max_button_x = love.graphics.getWidth() - (Graph.padding + UI.button_size)
UI.slider_button_is_pressed = false

UI.paint_ui = function(self)
  -- Paints the UI section on the right
  love.graphics.setColor(0.2, 0.2, 0.2)
  love.graphics.rectangle("fill", love.graphics.getWidth() - self.width, 0, self.width, love.graphics.getHeight())

  self:paint_fps()
  self:paint_mode()
  self:paint_advice()
  if Mode:is(LINE) then
    self:paint_line_length()
  end
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

    -- Painting a rectangle around each mode
    love.graphics.rectangle(
      "fill",
      x_position,
      Graph.padding,
      (self.width / 4) - Graph.padding,
      Font:getHeight() + Graph.padding,
      Font:getHeight() / 2,
      Font:getHeight() / 2
    )

    -- Painting the text
    if Mode:is(index) then love.graphics.setColor(0, 0, 0)
    else love.graphics.setColor(0.75, 0.75, 0.75) end
    love.graphics.print(
      mode,
      x_position + (self.width / 8) - (Font:getWidth(mode) / 2) - (Graph.padding / 2),
      Graph.padding * 1.5
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
        Font:getHeight() + Graph.padding
      )
    then
      love.graphics.setColor(0.75, 0.75, 0.75)
      love.graphics.rectangle(
        "line",
        x_position - 2,
        Graph.padding - 2,
        (self.width / 4) - 1,
        Font:getHeight() + 4 + Graph.padding,
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
  local y = self.advice_distance + (Graph.padding * 2)
  love.graphics.setColor(1, 1, 1)
  local message = "Delete/Backspace: clear graph\n"

  if Mode:is(MOVE) then
    love.graphics.print(message.."Left click: move a point around", x, y)
  elseif Mode:is(POINT) then
    love.graphics.print(message.."Left click: create a new point\nRight click: delete a point", x, y)
  elseif Mode:is(LINE) then
    if SELECTED_POINT == 0 then
      -- No point has been selected yet
      love.graphics.print(message.."Left click: select a point", x, y + 40)
    else
      love.graphics.print(message.."Left click: create a new line\nRight click: delete a line", x, y + 50)
    end
  elseif Mode:is(PATH) then
    -- TODO: add button to calculate path
    love.graphics.print(message.."Left click: mark starting point\nRight click: mark ending point\n", x, y)
  end
end

UI.paint_line_length = function(self)
  -- Text
  love.graphics.setColor(1, 1, 1)
  love.graphics.print("Line length: "..tostring(Graph.line_length), love.graphics.getWidth() - self.width + Graph.padding, 28)

  -- Slider
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", love.graphics.getWidth() - self.width + Graph.padding, 56, self.width - (Graph.padding * 2), 5, 3, 3)

  -- Slider button
  love.graphics.setColor(0.5, 0.5, 0.5)
  love.graphics.rectangle("fill", self.button_x_position, self.button_y_position, self.button_size, self.button_size, self.button_size, self.button_size)

  -- While the mouse is within the slider button and pressed, move the slider button
  if self.slider_button_is_pressed and love.mouse.isDown(LEFT_MOUSE) then
    self.button_x_position = Utils:clamp(self.min_button_x, self.max_button_x, love.mouse.getX() - (self.button_size / 2))
    Graph.line_length = Utils:x_position_to_line_length(self.button_x_position)
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
