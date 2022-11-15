local utils =
{
  clamp = function (min, max, number)
    if number > max then return max end
    if number < min then return min end
    return number
  end
}

return utils
