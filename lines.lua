local lines = {}

local points = require("points")

lines.add = function(from, to, length)
  -- TODO: do not allow duplicate lines
  table.insert(lines, {
    from = from,
    to = to,
    length = love.graphics.newText(love.graphics.getFont(), length),
  })
end

lines.remove = function(from, to)
  for index, line in ipairs(lines) do
    -- Finding the line we want to remove
    if line.from == from and line.to == to then
      table.remove(lines, index)
    end
  end
end

lines.draw = function()
  for index, line in pairs(lines) do
    -- Only drawing the lines and ignoring the methods in the table
    if type(index) == "number" then
      -- Drawing the line
      love.graphics.setColor(0, 0.5, 0.5)
      love.graphics.line(
        points[line.from].x,
        points[line.from].y,
        points[line.to].x,
        points[line.to].y
      )

      -- Considering adding a rectangle to the background to make text more readable
      love.graphics.setColor(1, 1, 1)
      -- Centering the text using the width and height of the text itself
      love.graphics.draw(
        line.length,
        (points[line.to].x + points[line.from].x) / 2 - (line.length:getWidth() / 2),
        (points[line.to].y + points[line.from].y) / 2 - (line.length:getHeight() / 2)
      )

      -- TODO: draw little triange indicating direction
      --[[
      love.graphics.setColor(0, 0.5, 0.5)
      love.graphics.polygon(
        "fill",
        points[line.to].x,
        points[line.to].y,

      )
      ]]
    end
  end
end

return lines
