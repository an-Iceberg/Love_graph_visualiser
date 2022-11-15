math.randomseed(os.time())

-- TODO: consider redoing this as a graph with two main tables: points and lines
local graph = require("graph")
-- local path = {}
local selected_point
Radius = 15

-- Init
function love.load()
  graph:add_point(100, 100) -- 1
  graph:add_point(200, 200) -- 2
  graph:add_point(300, 150) -- 3
  graph:add_point(1000, 700) -- 4
  graph:add_point(500, 500) -- 5

  graph:add_line(2, 4, 90)
  graph:add_line(1, 2, 40)
  graph:add_line(2, 3, 200)
  graph:add_line(3, 5, 3985)

  graph:remove_point(4)
end

-- Mouse input
function love.mousepressed(x, y, button)
end

function love.mousemoved(x, y, delta_x, delta_y)
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
  -- local mouseX, mouseY = love.mouse.getPosition()

  graph:draw_graph()
end

-- Quit
function love.quit()
end
