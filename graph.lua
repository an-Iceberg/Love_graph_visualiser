require("constants")
require("vector2d")

Graph = {}

Graph.points = {}
Graph.lines = {}
Graph.path = {}
Graph.padding = 5 -- What does this do?
Graph.hovered_point_id = 0
Graph.line_length = 1

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

  self.points[missing_id] = Vector2d(x, y)
end

-- Adds a line from the specified point to the other specified point
Graph.add_line = function(self, from, to, length)
  -- TODO: allow bidirectional edges
  table.insert(self.lines, {
    from = from, -- Point id
    to = to, -- Point id
    length = length --love.graphics.newText(Font, length),
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

  -- Removing the point itself
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

Graph.clear = function(self)
  self.lines = {}
  self.points = {}
end

-- Paints all points with their id in the center
Graph.paint_points = function(self)
  -- If no point is hovered upon then this value will stay 0
  self.hovered_point_id = 0

  for id, point in pairs(self.points) do
    -- Paints the point

    -- Paints the selected point yellow, orange otherwise
    if SELECTED_POINT == id then
      love.graphics.setColor(1, 1, 0)
    else
      love.graphics.setColor(1, 0.5, 0)
    end

    love.graphics.circle("fill", point.x, point.y, RADIUS)
    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", point.x, point.y, RADIUS + 1)

    -- Paints the point id
    love.graphics.setColor(0, 0, 0)
    -- Centering the text using the width and height of the text itself
    love.graphics.print(
      id,
      point.x - (Font:getWidth(id) / 2),
      point.y - (Font:getHeight() / 2)
    )

    -- Makes sure to only hover over one point
    if Utils:is_point_in_circle(love.mouse.getX(), love.mouse.getY(), point.x, point.y, RADIUS) then
      self.hovered_point_id = id
    end
  end
end

-- Paints all lines and their lengths centered between the two points
Graph.paint_lines = function(self)
  for _, line in pairs(self.lines) do

    local direction = Vector2d(
      self.points[line.from].x - self.points[line.to].x,
      self.points[line.from].y - self.points[line.to].y
    )
    local arrow_head_location = Vector2d(
      self.points[line.to].x + (direction.x * ((RADIUS + 2) / direction:magnitude())),
      self.points[line.to].y + (direction.y * ((RADIUS + 2) / direction:magnitude()))
    )
    local helper_point = Vector2d(
      self.points[line.to].x + (direction.x * ((RADIUS + 15) / direction:magnitude())),
      self.points[line.to].y + (direction.y * ((RADIUS + 15) / direction:magnitude()))
    )
    local angle = 0.436 -- In radians
    local arrow_head_length = 20

    -- Calculating the tip of the triangle that touches the node (position + (direction * (radius / length)))
    -- TODO: don't paint the lines from the center of the circle, shift them to the edge of the circle
    -- TODO: create vector2d objects
    -- Painting the line
    love.graphics.setColor(0, 1, 1)
    love.graphics.line(
      self.points[line.from].x + (direction.x * (-RADIUS / direction:magnitude())),
      self.points[line.from].y + (direction.y * (-RADIUS / direction:magnitude())),
      arrow_head_location.x,
      arrow_head_location.y
    )

    --[[
    x1/y1 are the start of the line, x2/y2 are the end of the line where the head of the arrow should be
    L1 is the length from x1/y1 to x2/y2
    L2 is the length of the arrow head
    a is the angle

    Formula:
    x3 = x2 + L2/L1 * [(x1 - x2) * cos(a) + (y1 - y2) * sin(a)]
    y3 = y2 + L2/L1 * [(y1 - y2) * cos(a) - (x1 - x2) * sin(a)]
    x4 = x2 + L2/L1 * [(x1 - x2) * cos(a) - (y1 - y2) * sin(a)]
    y4 = y2 + L2/L1 * [(y1 - y2) * cos(a) + (x1 - x2) * sin(a)]

    Source: https://math.stackexchange.com/questions/1314006/drawing-an-arrow
    ]]
    love.graphics.polygon(
      "fill",
      arrow_head_location.x,
      arrow_head_location.y,
      arrow_head_location.x + (arrow_head_length / direction:magnitude())*(((self.points[line.from].x - self.points[line.to].x) * math.cos(angle)) + ((self.points[line.from].y - self.points[line.to].y) * math.sin(angle))),
      arrow_head_location.y + (arrow_head_length / direction:magnitude())*(((self.points[line.from].y - self.points[line.to].y) * math.cos(angle)) - ((self.points[line.from].x - self.points[line.to].x) * math.sin(angle))),
      helper_point.x,
      helper_point.y,
      arrow_head_location.x + (arrow_head_length / direction:magnitude())*(((self.points[line.from].x - self.points[line.to].x) * math.cos(angle)) - ((self.points[line.from].y - self.points[line.to].y) * math.sin(angle))),
      arrow_head_location.y + (arrow_head_length / direction:magnitude())*(((self.points[line.from].y - self.points[line.to].y) * math.cos(angle)) + ((self.points[line.from].x - self.points[line.to].x) * math.sin(angle)))
    )

    local length_position = Vector2d(
      (1/3)*self.points[line.from].x + (2/3)*self.points[line.to].x,
      (1/3)*self.points[line.from].y + (2/3)*self.points[line.to].y
    )

    -- Painting the line length 1/3 from the arrow head
    -- TODO: the line length should be painted on top of the points
    -- Painting a rectangle around the line length to make it better readable
    love.graphics.setColor(0, 1, 1)
    love.graphics.rectangle(
      "fill",
      length_position.x - (Font:getWidth(line.length) / 2) - self.padding,
      length_position.y - (Font:getHeight() / 2) + 0.5,
      Font:getWidth(line.length) + (self.padding * 2),
      Font:getHeight(),
      Font:getHeight() / 2,
      Font:getHeight() / 2
    )

    -- Painting the line length
    love.graphics.setColor(0, 0, 0)
    -- Centering the text using the width and height of the text itself
    love.graphics.print(
      line.length,
      length_position.x - (Font:getWidth(line.length) / 2),
      length_position.y - (Font:getHeight() / 2)
    )
  end
end

-- Paints the entire graph and paints a highlight around the hovered point
Graph.paint_graph = function(self)
  self:paint_lines()
  self:paint_points()

  -- Paints a highlight around the hovered point
  if self.hovered_point_id ~= 0 then
    love.graphics.setColor(1, 0, 1)
    love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, RADIUS + 5)

    love.graphics.setColor(0, 0, 0)
    love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, RADIUS + 4)
    love.graphics.circle("line", self.points[self.hovered_point_id].x, self.points[self.hovered_point_id].y, RADIUS + 6)
  end
end
