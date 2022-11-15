math.randomseed(os.time())

-- TODO: consider redoing this as a graph with two main tables: points and lines
local points = require("points")
--local lines = require("lines")
local path = {}
local selected_point
Radius = 15

-- Init
function love.load()
  points:add(200, 150)
  points:add(300, 300)
  points:add(700, 250)

  --[[
  lines:add(1, 2, 45)
  lines:add(2, 3, 306)
  lines:remove(1, 2)
  ]]
  -- points.remove(1)
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

  --lines:draw()
  points:draw()
end

-- Quit
function love.quit()
end
