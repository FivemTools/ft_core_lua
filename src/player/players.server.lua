--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

Players = {}
PlayerDrop = {}

--
-- Function
--

-- Check if is in the list player
function PlayerExist(source)

  if type(Players[source]) == "nil" then
    return false
  else
    return true
  end

end

-- Add Player in player list
function AddPlayer(source, player)
  Players[source] = player
end

-- Remove Player in player list
function RemovePlayer(source)
  Players[source] = nil
end

-- Get all player
function GetPlayers()
  return Players
end

-- Get player by serverId (source)
function GetPlayerFromServerId(serverId)
  return Players[serverId]
end

--
function AddPlayerDrop(callback)
  PlayerDrop.insert(callback)
end

--
-- Event
--

-- Event is emited after client is 100% loaded games
RegisterServerEvent("ft_core:onClientReady")
AddEventHandler('ft_core:onClientReady', function()

  local source = source
  local steamId = getSteamId(source)
  local player = {}

  -- Add player in player table
  if not PlayerExist(serverId) then

    player = GetPlayerFromSteamId(steamId)
    if type(player) == "nil" then
      CreatePlayer(steamId) -- Create player in db
      player = GetPlayerFromSteamId(steamId) -- Select player in db
    end
    player.source = source
    AddPlayer(source, player)

  else
    player = Players[source]
  end

  if Settings.debug then
    print("-----=====[ DEBUG ]=====-----")
    print("[player] data in database")
    tprint(player)
    print(player:GetCash())
    print(player:AddCash(50000))
    print(player:GetCash())
    print("-----------------------------")
  end

  -- Send to client
  TriggerClientEvent("ft_core:initPlayer", source, player)

  -- Send playerReadyToJoin event
  TriggerClientEvent("ft_core:playerReadyToJoin", source)
  TriggerEvent("ft_core:playerReadyToJoin", source)

end)

-- Event before player leave
AddEventHandler('playerDropped', function()

  local source = source
  local player = GetPlayerFromServerId(source)

  -- Execute after player dropped
  for _, callback in pairs(PlayerDrop) do
    callback(player)
  end

  -- Remove in player list
  if PlayerExist(source) then
    RemovePlayer(source)
  end

end)
