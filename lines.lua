local points = require("points")

local lines = {
  lines = {},

  add = function(self, from, to, length)
    -- TODO: do not allow duplicate lines
    table.insert(self.lines, {
      from = from,
      to = to,
      length = love.graphics.newText(love.graphics.getFont(), length),
    })
  end,

  remove = function(self, from, to)
    for index, line in ipairs(self.lines) do
      -- Finding the line we want to remove
      if line.from == from and line.to == to then
        table.remove(self, index)
      end
    end
  end,

  draw = function(self)
    for index, line in pairs(self.lines) do
      -- Only drawing the lines and ignoring the methods in the table
      if type(index) == "number" then
        -- Drawing the line
        love.graphics.setColor(0, 0.5, 0.5)
        love.graphics.line(
          points.points[line.from].x,
          points.points[line.from].y,
          points.points[line.to].x,
          points.points[line.to].y
        )

        -- Considering adding a rectangle to the background to make text more readable
        love.graphics.setColor(1, 1, 1)
        -- Centering the text using the width and height of the text itself
        love.graphics.draw(
          line.length,
          (points.points[line.to].x + points.points[line.from].x) / 2 - (line.length:getWidth() / 2),
          (points.points[line.to].y + points.points[line.from].y) / 2 - (line.length:getHeight() / 2)
        )

        -- TODO: draw little triange indicating direction
      end
    end
  end
}

return lines
