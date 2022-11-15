local points = {
  points = {},

  add = function(self, x, y)
    local smallest_id = 1

    -- Searches for the smallest missing id
    for id in ipairs(self.points) do
      if id == smallest_id + 1 then
        smallest_id = id
      else
        break
      end
    end

    self.points[smallest_id + 1] = {
      x = x,
      y = y,
      text = love.graphics.newText(love.graphics.getFont(), tostring(smallest_id))
    }
  end,

  remove = function(self, id_param)
    for id in ipairs(self.points) do
      if id == id_param then
        table.remove(self.points, id)
      end
    end

    -- TODO: remove all lines associated with this point
  end,

  draw = function(self)
    -- Draws all points to the screen
    for _, point in pairs(self.points) do
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
  end,
}

return points
