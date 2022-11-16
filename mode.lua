MOVE = 0
POINT = 1
LINE = 2
PATH = 3

Mode = {
  mode = 0,

  is = function(self, mode)
    if self.mode == mode then
      return true
    end

    return false
  end,

  increment = function(self)
    if self.mode < PATH then
      self.mode = self.mode + 1
    end
  end,

  decrement = function(self)
    if self.mode > MOVE then
      self.mode = self.mode - 1
    end
  end
}
