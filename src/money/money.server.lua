--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

-- Create money
function createMoney(name)

  local nameUpper = name.gsub(name, "^%l", name.upper)

  -- Get cash
  AddPlayerMethod("Get" .. nameUpper, function(self)
    return self[name] + 0.0
  end)

  -- Set cash
  AddPlayerMethod("Set" .. nameUpper, function(self, mount)
    self:Set(name, mount)
  end)

  -- Add cash
  AddPlayerMethod("Add" .. nameUpper, function(self, mount)
    local money = self[name] + mount
    self["Set" .. nameUpper](self, money)
  end)

  -- Remove cash
  AddPlayerMethod("Remove" .. nameUpper, function(self, mount)
    local money = self[name] - mount
    self["Set" .. nameUpper](self, money)
  end)

  -- Give cash
  AddPlayerMethod("Give" .. nameUpper, function(self, player, mount)
    self["Remove" .. nameUpper](self, mount)
    player["Add" .. nameUpper](self, mount)
  end)

end
