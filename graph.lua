Graph = {
  points = {},
  lines = {},
  path = {},
  padding = 5,

  -- Adds a point to the graph at the mouse position
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

  -- Removes a specified point from the graph and all lines associated with it
  remove_point = function(self, id)
    -- Removing any lines associated with the point
    for key, line in pairs(self.lines) do
      if line.from == id or line.to == id then
        self.lines[key] = nil
      end
    end

    self.points[id] = nil
  end,

  -- Draws all points with their id in the center and a purple ring around them if they're hovered over
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

      if Utils.is_point_in_circle(love.mouse.getX(), love.mouse.getY(), point.x, point.y, Radius) then
        love.graphics.setColor(1, 0, 1)
        love.graphics.circle("line", point.x, point.y, Radius + 5)

        love.graphics.setColor(0, 0, 0)
        love.graphics.circle("line", point.x, point.y, Radius + 4)
        love.graphics.circle("line", point.x, point.y, Radius + 6)
      end
    end
  end,

  -- Adds a line from the specified point to the other specified point
  add_line = function(self, from, to, length)
    -- TODO: do not allow duplicate lines
    table.insert(self.lines, {
      from = from,
      to = to,
      length = length--love.graphics.newText(love.graphics.getFont(), length),
    })
  end,

  -- Removes a specified line
  remove_line = function(self, from, to)
    for index, line in ipairs(self.lines) do
      -- Finding the line we want to remove
      if line.from == from and line.to == to then
        table.remove(self.lines, index)
      end
    end
  end,

  -- Draws all lines and their lengths centered between the two points
  draw_lines = function(self)
    for index, line in pairs(self.lines) do
      -- Only drawing the lines and ignoring the methods in the table
      if type(index) == "number" then
        -- Drawing the line
        love.graphics.setColor(0, 1, 1)
        love.graphics.line(
          self.points[line.from].x,
          self.points[line.from].y,
          self.points[line.to].x,
          self.points[line.to].y
        )

        -- Drawing a rectangle around the line length to make it better readable
        love.graphics.setColor(0, 1, 1)
        love.graphics.rectangle(
          "fill",
          (self.points[line.to].x + self.points[line.from].x) / 2 - (love.graphics.getFont():getWidth(line.length) / 2) - self.padding,
          (self.points[line.to].y + self.points[line.from].y) / 2 - (love.graphics.getFont():getHeight() / 2) + 0.5,
          love.graphics.getFont():getWidth(line.length) + (self.padding * 2),
          love.graphics.getFont():getHeight(),
          love.graphics.getFont():getHeight() / 2,
          love.graphics.getFont():getHeight() / 2
        )

        -- Considering adding a rectangle to the background to make text more readable
        love.graphics.setColor(0, 0, 0)
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

  -- Draws the entire graph
  draw_graph = function(self)
    self:draw_lines()
    self:draw_points()
  end,
}