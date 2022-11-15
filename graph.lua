local graph = {
  points = {},
  lines = {},
  path = {},

  add_point = function(self, x, y)
    local missing_id = 1

    -- Finding a missing index or just using the largest one
    for id in pairs(self.points) do
      if id == missing_id then
        missing_id = id + 1
      else
        break
      end
    end

    self.points[missing_id] = {
      x = x,
      y = y,
    }
  end,

  remove_point = function(self, id)
    -- Removing any lines associated with the point
    for key, line in pairs(self.lines) do
      if line.from == id or line.to == id then
        self.lines[key] = nil
      end
    end

    self.points[id] = nil
  end,

  draw_points = function(self)
    for id, point in pairs(self.points) do
      -- Draws the point
      love.graphics.setColor(1, 0.5, 0)
      love.graphics.circle("fill", point.x, point.y, Radius)

      -- Draws the point id
      love.graphics.setColor(0, 0, 0)
      -- Centering the text using the width and height of the text itself
      love.graphics.print(
        id,
        point.x - (love.graphics.getFont():getWidth(id) / 2),
        point.y - (love.graphics.getFont():getHeight() / 2)
      )
    end
  end,

  add_line = function(self, from, to, length)
    -- TODO: do not allow duplicate lines
    table.insert(self.lines, {
      from = from,
      to = to,
      length = length--love.graphics.newText(love.graphics.getFont(), length),
    })
  end,

  remove_line = function(self, from, to)
    for index, line in ipairs(self.lines) do
      -- Finding the line we want to remove
      if line.from == from and line.to == to then
        table.remove(self.lines, index)
      end
    end
  end,

  draw_lines = function(self)
    for index, line in pairs(self.lines) do
      -- Only drawing the lines and ignoring the methods in the table
      if type(index) == "number" then
        -- Drawing the line
        love.graphics.setColor(0, 0.5, 0.5)
        love.graphics.line(
          self.points[line.from].x,
          self.points[line.from].y,
          self.points[line.to].x,
          self.points[line.to].y
        )

        -- Considering adding a rectangle to the background to make text more readable
        love.graphics.setColor(1, 1, 1)
        -- Centering the text using the width and height of the text itself
        love.graphics.print(
          line.length,
          (self.points[line.to].x + self.points[line.from].x) / 2 - (love.graphics.getFont():getWidth(line.length) / 2),
          (self.points[line.to].y + self.points[line.from].y) / 2 - (love.graphics.getFont():getHeight() / 2)
        )

        -- TODO: draw little triange indicating direction
      end
    end
  end,

  draw_graph = function(self)
    self:draw_lines()
    self:draw_points()
  end,
}

return graph
