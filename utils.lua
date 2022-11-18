Utils =
{
  -- Clamps a number between min and max
  clamp = function (min, max, number)
    if number > max then return max end
    if number < min then return min end
    return number
  end,

  -- Returns true if the point is in or on the circle
  is_point_in_circle = function(point_x, point_y, circle_x, circle_y, circle_radius)
    return math.abs(((circle_x - point_x)^2 + (circle_y - point_y)^2)) <= circle_radius^2
  end,

  -- Returns true if the point is in or on the rectangle
  is_point_in_rectangle = function(point_x, point_y, rectangle_top_left_x, rectangle_top_left_y, rectangle_width, rectangle_height)
    if
      point_x < rectangle_top_left_x or
      point_y < rectangle_top_left_y or
      point_x > (rectangle_top_left_x + rectangle_width) or
      point_y > (rectangle_top_left_y + rectangle_height)
    then
      return false
    end

    return true
  end,
}
