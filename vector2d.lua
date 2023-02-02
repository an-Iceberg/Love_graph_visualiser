function Vector2d(x, y)
  x = x or 0
  y = y or 0

  local vector2d = {}

  vector2d.x = x
  vector2d.y = y

  vector2d.magnitude = function(self)
    return math.sqrt(self.x^2 + self.y^2)
  end

  vector2d.magnitude2 = function(self)
    return (self.x^2 + self.y^2)
  end

  vector2d.normalised = function(self)
    local r = 1 / self:mag()
    return Vector2d(self.x * r, self.y * r)
  end

  vector2d.perpendicular = function(self)
    return Vector2d(-self.y, self.x)
  end

  vector2d.floor = function(self)
    return Vector2d(math.floor(self.x), math.floor(self.y))
  end

  vector2d.ceil = function(self)
    return Vector2d(math.ceil(self.x), math.ceil(self.y))
  end

  vector2d.max = function(self, other_vector)
    return Vector2d(math.max(self.x, other_vector.x), math.max(self.y, other_vector.y))
  end

  vector2d.min = function(self, other_vector)
    return Vector2d(math.min(self.x, other_vector.x), math.min(self.y, other_vector.y))
  end

  vector2d.cart = function(self)
    -- TODO: implement
  end

  vector2d.polar = function(self)
    -- TODO: implement
  end

  vector2d.dot_product = function(self, other_vector)
    return (self.x * other_vector.x) + (self.y + other_vector.y)
  end

  vector2d.cross_product = function(self, other_vector)
    return (self.x * other_vector.y) - (self.y + other_vector.x)
  end

  vector2d.to_string = function(self, indicators)
    if indicators then
      return string.format("(x:%d, y:%d)", self.x, self.y)
    else
      return string.format("(%d, %d)", self.x, self.y)
    end
  end

  vector2d.print = function(self, indicators)
    if indicators then
      print(string.format("(x:%d, y:%d)", self.x, self.y))
    else
      print(string.format("(%d, %d)", self.x, self.y))
    end
  end

  local vector_metatable = {
    __add = function(a, b)
      return Vector2d(a.x + b.x, a.y + b.y)
    end,

    __sub = function(a, b)
      return Vector2d(a.x - b.x, a.y - b.y)
    end,

    __mul = function(a, b)
      return Vector2d(a.x * b.x, a.y * b.y)
    end,

    __div = function(a, b)
      return Vector2d(a.x / b.x, a.y / b.y)
    end,

    __unm = function(a)
      return Vector2d(-a.x, -a.y)
    end,

    __eq = function(a, b)
      return a.x == b.x and a.y == b.y
    end
  }

  setmetatable(vector2d, vector_metatable)

  return vector2d
end
