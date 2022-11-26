math.randomseed(os.time())

require("graph")
require("mode")
require("utils")
require("ui")

Selected_point = 0
Radius = 13
Font = love.graphics.getFont()

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
  Graph:add_line(3, 5, 3985)

  Graph:remove_point(4)

  Mode:increment()

  Mode:set(POINT)
end

-- Mouse input
function love.mousepressed(x, y, button)
  -- Move a point around
  if
    Mode:is(MOVE) and
    button == 1 and
    Utils.is_point_in_rectangle( x, y, Radius, Radius, love.graphics.getWidth() - (2 * Radius + UI.width), love.graphics.getHeight() - (2 * Radius)) and
    Graph.hovered_point_id ~= 0
  then
    Selected_point = Graph.hovered_point_id
  end

  -- Create a new point with left click
  if
    Mode:is(POINT) and
    button == 1 and
    Utils.is_point_in_rectangle( x, y, Radius, Radius, love.graphics.getWidth() - (2 * Radius + UI.width), love.graphics.getHeight() - (2 * Radius))
  then
    Graph:add_point(x, y)
  end

  -- Remove a point with right click
  if Mode:is(POINT) and button == 2 and Graph.hovered_point_id ~= 0 then
    Graph:remove_point(Graph.hovered_point_id)
  end
end

function love.mousemoved(x, y, delta_x, delta_y)
  --[[
  -- Left mouse button
  if love.mouse.isDown(1) and Selected_point ~= 0 then
    Graph:points[Selected_point].x = delta_x
    Graph:points[Selected_point].y = delta_y
  end
  ]]
end

function love.mousereleased(x, y, button)
  -- Releasing the left mouse button also releases the selected point
  if Mode:is(MOVE) and button == 1 and Selected_point ~= 0 then
    Selected_point = 0
  end
end

function love.wheelmoved(x, y)
end

-- Keybaord input
function love.keypressed(key, scancode, is_repeat)
end

--[[
function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end
]]

-- Update game state
function love.update(delta_time)
end

-- Draw game to screen
function love.draw()
  -- local mouse_x, mouse_y = love.mouse.getPosition()

  Graph:paint_graph()

  UI:paint_ui()
end

-- Quit
function love.quit()
end
