--
-- @Project: FiveM Tools
-- @Author: Samuelds
-- @License: GNU General Public License v3.0
-- @Source: https://github.com/FivemTools/ft_core
--

dependencies {
  "mysql-async",
}

client_scripts {

  --
  -- Requirement
  --
  "src/settings.client.lua",


  --
  -- Player
  --
  "src/players/player.client.lua",

  --
  -- Money
  --
  "src/money/money.client.lua",

  --
  -- Init
  --
  "src/init.client.lua",

}

server_scripts {

  --
  -- Requirement
  --
  "@mysql-async/lib/MySQL.lua",
  "src/settings.server.lua",
  "src/utils.server.lua",

  --
  -- Player
  --
  "src/player/player.server.lua",
  "src/player/players.server.lua",

  --
  -- Money
  --
  "src/money/money.server.lua",

  --
  -- Init
  --
  "src/init.server.lua",

}

exports {

}

server_exports {
  "createMoney",
}
