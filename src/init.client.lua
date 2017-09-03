--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

-- Client is 100% loaded games
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if NetworkIsSessionStarted() then

      TriggerServerEvent('ft_core:onClientReady')
      TriggerEvent('ft_core:onClientReady')
      break

    end

  end
end)
