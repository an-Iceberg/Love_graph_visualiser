Graph = {}

Graph.points = {}
Graph.lines = {}
Graph.path = {}
Graph.padding = 5
Graph.hovered_point_id = 0

-- Adds a point to the graph at the mouse position
Graph.add_point = function(self, x, y)
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
end

-- Adds a line from the specified point to the other specified point
Graph.add_line = function(self, from, to, length)
  -- TODO: do not allow duplicate lines
  table.insert(self.lines, {
    from = from,
    to = to,
    length = length--love.graphics.newText(Font, length),
  })
end

-- Removes a specified point from the graph and all lines associated with it
Graph.remove_point = function(self, id)
  -- Removing any lines associated with the point
  for key, line in pairs(self.lines) do
    if line.from == id or line.to == id then
      self.lines[key] = nil
    end
  end

  self.points[id] = nil
end

-- Removes a specified line
Graph.remove_line = function(self, from, to)
  for index, line in ipairs(self.lines) do
    -- Finding the line we want to remove
    if line.from == from and line.to == to then
      table.remove(self.lines, index)
    end
  end
end

-- Draws all points with their id in the center
Graph.paint_points = function(self)
  -- If no point is hovered upon then this value will stay 0
  self.hovered_point_id = 0

  for id, point in pairs(self.points) do
    -- Draws the point
    love.graphics.setColor(1, 0.5, 0)
    love.graphics.circle("fill", point.x, point.y, Radius)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", point.x, point.y, Radius + 1)

    -- Draws the point id
    love.graphics.setColor(0, 0, 0)
    -- Centering the text using the width and height of the text itself
    love.graphics.print(
      id,
      point.x - (Font:getWidth(id) / 2),
      point.y - (Font:getHeight() / 2)
    )

    -- Makes sure to only hover over one point
    if Utils:is_point_in_circle(love.mouse.getX(), love.mouse.getY(), point.x, point.y, Radius) then
      self.hovered_point_id = id
    end
  end
end

-- Draws all lines and their lengths centered between the two points
Graph.paint_lines = function(self)
  for _, line in pairs(self.lines) do
    -- TODO: don't draw the lines from the center of the circle, shift them to the edge of the circle
    -- Drawing the line
    love.graphics.setColor(0, 1, 1)
    love.graphics.line(
      self.points[line.from].x,
      self.points[line.from].y,
      self.points[line.to].x,
      self.points[line.to].y
    )

    -- TODO: the line length should be drawn on top of the points
    -- Drawing a rectangle around the line length to make it better readable
    love.graphics.setColor(0, 1, 1)
    love.graphics.rectangle(
      "fill",
      (self.points[line.to].x + self.points[line.from].x) / 2 - (Font:getWidth(line.length) / 2) - self.padding,
      (self.points[line.to].y + self.points[line.from].y) / 2 - (Font:getHeight() / 2) + 0.5,
      Font:getWidth(line.length) + (self.padding * 2),
      Font:getHeight(),
      Font:getHeight() / 2,
      Font:getHeight() / 2
    )

    -- Considering adding a rectangle to the background to make text more readable
    love.graphics.setColor(0, 0, 0)
    -- Centering the text using the width and height of the text itself
    love.graphics.print(
      line.length,
      (self.points[line.to].x + self.points[line.from].x) / 2 - (Font:getWidth(line.length) / 2),
      (self.points[line.to].y + self.points[line.from].y) / 2 - (Font:getHeight() / 2)
    )

    -- TODO: draw little triange indicating direction
  end
end

-- Draws the entire graph and paints a highlight around the hovered point
Graph.paint_graph = function(self)
  self:paint_lines()
  self:paint_points()

  -- Draws a highlight around the hovered point
  if self.hovered_point_id ~= 0 then
      love.graphics.setColor(1, 0, 1)
      love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, Radius + 5)

      love.graphics.setColor(0, 0, 0)
      love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, Radius + 4)
      love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, Radius + 6)
  end
end
