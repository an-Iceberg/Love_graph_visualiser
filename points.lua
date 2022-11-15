local points = {}

-- Adds a point to the table with the index and text of "index"
points.add = function(index, x, y)
  points[index] = {
    x = x,
    y = y,
    text = love.graphics.newText(love.graphics.getFont(), index)
  }
end

-- Removes the point with index "index"
points.remove = function(index)
  points[index] = nil
end

points.draw = function()
  -- Draws all points to the screen
  for index, point in pairs(points) do
    -- Not trying to draw anything when the index is a method name
    if type(index) == "number" then
      -- Draws the point
      love.graphics.setColor(1, 0.5, 0)
      love.graphics.circle("fill", point.x, point.y, Radius)

      -- Draws the point id
      love.graphics.setColor(0, 0, 0)
      -- Centering the text using the width and height of the text itself
      love.graphics.draw(
        point.text,
        point.x - (point.text:getWidth() / 2),
        point.y - (point.text:getHeight() / 2)
      )
    end
  end
end

return points
