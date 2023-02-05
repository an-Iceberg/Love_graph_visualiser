require("constants")

Utils = {}

-- Clamps a number between min and max
Utils.clamp = function (self, min, max, number)
  if number > max then return max end
  if number < min then return min end
  return number
end

-- Returns true if the point is in or on the circle
Utils.is_point_in_circle = function(self, point_x, point_y, circle_x, circle_y, circle_radius)
  return math.abs(((circle_x - point_x)^2 + (circle_y - point_y)^2)) <= circle_radius^2
end

-- Returns true if the point is in or on the rectangle
Utils.is_point_in_rectangle = function(self, point_x, point_y, rectangle_top_left_x, rectangle_top_left_y, rectangle_width, rectangle_height)
  if
    point_x < rectangle_top_left_x or
    point_y < rectangle_top_left_y or
    point_x > (rectangle_top_left_x + rectangle_width) or
    point_y > (rectangle_top_left_y + rectangle_height)
  then
    return false
  end

  return true
end

-- Returns true if the point is inside the pill that is formed around the rectangle
Utils.is_point_in_pill = function(self, point_x, point_y, rectangle_top_left_x, rectangle_top_left_y, rectangle_width, rectangle_height)
  return
  (
    -- Checking if the point is in the rectangle
    self:is_point_in_rectangle(point_x, point_y, rectangle_top_left_x, rectangle_top_left_y, rectangle_width, rectangle_height) or
    -- Checking if the point is in the left circle
    self:is_point_in_circle(point_x, point_y, rectangle_top_left_x, rectangle_height / 2, rectangle_height / 2) or
    -- Checking if the point is in the right circle
    self:is_point_in_circle(point_x, point_y, rectangle_top_left_x + rectangle_width, rectangle_height / 2, rectangle_height / 2)
  )
end

Utils.x_position_to_line_length = function(self, x_position)
  return math.floor(((99/175) * x_position) - (3064/5))
end
