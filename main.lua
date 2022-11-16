math.randomseed(os.time())

require("graph")
require("mode")
require("utils/utils")

Selected_point = 0
Radius = 15

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
end

-- Mouse input
function love.mousepressed(x, y, button)
  if Mode:is(POINT) and button == 1 then
    Graph:add_point(x, y)
  end
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

  Graph:draw_graph()
end

-- Quit
function love.quit()
end
