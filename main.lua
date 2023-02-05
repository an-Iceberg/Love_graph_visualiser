math.randomseed(os.time())

require("graph")
require("mode")
require("utils")
require("ui")
require("constants")
-- require("vector2d")

Font = love.graphics.getFont()

-- TODO: consider restructuring using signals that are generated here
-- TODO: move all code into "/src"

-- Init
function love.load()
  Graph:add_point(100, 100) -- 1
  Graph:add_point(200, 200) -- 2
  Graph:add_point(300, 150) -- 3
  Graph:add_point(1000, 700) -- 4
  Graph:add_point(500, 500) -- 5

  Graph:add_line(2, 4, 90)
  Graph:add_line(1, 2, 40)
  Graph:add_line(2, 3, 200)
  Graph:add_line(3, 5, 69)

  Graph:remove_point(4)

  Mode:set(MOVE)
end

-- Mouse input
function love.mousepressed(x, y, button)
  -- Move a point around
  if
    Mode:is(MOVE) and
    button == LEFT_MOUSE and
    Graph.hovered_point_id ~= 0 and
    Utils:is_point_in_rectangle(x, y, RADIUS, RADIUS, love.graphics.getWidth() - (2 * RADIUS + UI.width), love.graphics.getHeight() - (2 * RADIUS))
  then
    SELECTED_POINT = Graph.hovered_point_id
  end

  -- Create a new point with left click
  if
    Mode:is(POINT) and
    button == LEFT_MOUSE and
    Utils:is_point_in_rectangle(x, y, RADIUS, RADIUS, love.graphics.getWidth() - (2 * RADIUS + UI.width), love.graphics.getHeight() - (2 * RADIUS))
  then
    Graph:add_point(x, y)
  end

  -- Remove a point with right click
  if
    Mode:is(POINT) and
    button == RIGHT_MOUSE and
    Graph.hovered_point_id ~= 0
  then
    Graph:remove_point(Graph.hovered_point_id)
  end

  -- Selecting a point in LINE mode
  if
    Mode:is(LINE) and
    button == LEFT_MOUSE
  then
    -- Adding a line
    if SELECTED_POINT == 0 then
      SELECTED_POINT = Graph.hovered_point_id
    else
      if Graph.hovered_point_id ~= 0 then
        Graph:add_line(SELECTED_POINT, Graph.hovered_point_id, Graph.line_length)
      end

      SELECTED_POINT = 0
    end
  end

  -- Deleting a line
  if
    Mode:is(LINE) and
    button == RIGHT_MOUSE
  then
    if Graph.hovered_point_id ~=0 then
      Graph:remove_line(SELECTED_POINT, Graph.hovered_point_id)
    end

    SELECTED_POINT = 0
  end

  -- Selecting the slider UI element
  if
    Mode:is(LINE) and
    Utils:is_point_in_circle(x, y, UI.button_x_position, UI.button_y_position, UI.button_size)
  then
    UI.slider_button_is_pressed = true
  end

  -- TODO: Selecting the start point

  -- TODO: Selecting the end point
end

function love.mousemoved(x, y, delta_x, delta_y)
  -- Moving a point around in MOVE mode and also making sure that the point doesn't move outside the window space
  if
    Mode:is(MOVE) and
    love.mouse.isDown(LEFT_MOUSE) and
    SELECTED_POINT ~= 0 and
    x > RADIUS and
    y > RADIUS and
    x < (love.graphics.getWidth() - (UI.width + RADIUS)) and
    y < love.graphics.getHeight() - RADIUS
  then
    Graph.points[SELECTED_POINT].x = x
    Graph.points[SELECTED_POINT].y = y
  end
end

function love.mousereleased(x, y, button)
  -- Releasing the left mouse button also releases the selected point
  if
    Mode:is(MOVE) and
    button == LEFT_MOUSE
  then
    SELECTED_POINT = 0
  end

  if Mode:is(LINE) then
    UI.slider_button_is_pressed = false
  end
end

function love.wheelmoved(x, y)
end

-- Keybaord input
function love.keypressed(key, scancode, is_repeat)
  if key == "delete" or key == "backspace" then
    Graph:clear()
  end
end

--[[
function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end
]]

-- Update game state
function love.update(delta_time)
end

-- Paint game to screen
function love.draw()
  -- local mouse_x, mouse_y = love.mouse.getPosition()

  Graph:paint_graph()

  UI:paint_ui()
end

-- Quit
function love.quit()
end
