--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

-- Event is emited after resource is loded
AddEventHandler('onServerResourceStart', function(resource)
    if resource == "ft_core" then

        -- Convar
        Settings.debug = GetConvar("ft_debug", tostring(Settings.debug)) == "true" and true or false

        -- Send event
        TriggerEvent('ft_core:onResourceReady')

    end
end)
