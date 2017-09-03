--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

--
-- Class
--

Player = {}
Player.__index = Player

-- Get player atributs
function Player:Get(...)

  local arg = {...}

  if #arg == 1 and type(arg[1]) == "table" then

    local table = {}
    for _, name in pairs(arg[1]) do
      table[name] = self[name]
    end
    return table

  elseif #arg == 1 then

    local name = arg[1]
    return self[name]

  end

end

-- Set player atributs
function Player:Set(...)

  local arg = {...}

  if #arg == 1 and type(arg[1]) == "table" then

    local save = {}
    for _, data in ipairs(arg[1]) do

      local name = data[1]
      local value = data[2]
      self[name] = value
      save[name] = value

    end

    self:Save(save)

  elseif #arg == 2 then

    local save = {}
    local name = arg[1]
    local value = arg[2]
    self[name] = value
    save[name] = value

    self:Save(save)

  end

end

function Player:Save(data)

  data = data or self

  local str_query = ""
  local count = 0

  for column, value in pairs(data) do
    if column ~= "id" and column ~= "steamId" and column ~= "createdAt" then

      if count ~= 0 then
        str_query = str_query .. ", "
      end

      str_query = str_query .. tostring(column) .. " = " .. tostring(value)
      count = count + 1
    end
  end

  MySQL.Sync.execute("UPDATE players SET " .. str_query .. " WHERE steamId = @steamId", { ['@steamId'] = self.steamId } )

end

function Player:Kick(reason)
  DropPlayer(self.source, reason)
end

--
-- Functions
--

-- Create player in database
function CreatePlayer(steamId)
  local date = os.date("%Y-%m-%d %X")
  local result = MySQL.Sync.execute("INSERT INTO players (`steamId`, `createdAt`) VALUES (@steamId, @date)", { ['@steamId'] = steamId, ['@date'] = date } )
  return result
end

-- Get player by id
function GetPlayerFromId(id)

  local player = nil
  local data = MySQL.Sync.fetchAll("SELECT * FROM players WHERE id = @id", { ['@id'] = id } )

  if data[1] ~= nil then
    player = setmetatable(data[1], Player)
  end

  return player

end

-- Get player by steamId
function GetPlayerFromSteamId(steamId)

  local player = nil
  local data = MySQL.Sync.fetchAll("SELECT * FROM players WHERE steamId = @steamId", { ['@steamId'] = steamId } )

  if data[1] ~= nil then
    player = setmetatable(data[1], Player)
  end

  return player
end

-- Add method to player class
function AddPlayerMethod(name, method)
  Player[name] = method
end
