require("constants")

Mode = {}

Mode.mode = MOVE

Mode.is = function(self, mode)
  if self.mode == mode then
    return true
  end

  return false
end

Mode.set = function(self, mode)
  self.mode = mode
end
