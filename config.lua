Settings = {}
Settings.DebugLocation = true --Used for setting certain location for easy teleport
Settings.OpenWithKey = true --Use F5 to open menu

--[[
    TELEPORT MENU LOCALE
    You can change notification messages based on your language
]]--

Locale = {
    ['teleported']  = 'You have teleported to ~b~',
    ['teleported_last']  = 'You have teleported to ~r~Last Location',
    ['teleported_last_empty']  = 'You didn\'t visit any location with this menu.',
    ['teleported_debug']  = 'You have added ~y~Debug Location ~s~coordinates.',
    ['no_waypoint']  = 'You do not have a waypoint set!',
    
}

--[[
    TELEPORT MENU COORDINATES
    Below you have lines of code that you need to change based on your use
    LABEL - label of location that you can find in menu
    OTHER lines are the actual coordinates
]]--

Locations = {
    { label = 'Police station', x = 425.1, y = -979.5, z = 30.7  },
    { label = 'Airport Los Santos', x = -1037.51, y = -2963.24, z = 13.95 },
    { label = 'Airport Sandy Shores', x = 1718.47, y = 3254.40, z = 41.14},
    { label = 'Mount Chiliad', x = 501.76, y = 5604.28, z = 797.91},
    { label = 'Vinewood Sign', x = 663.41, y = 1217.21, z = 322.94},
    { label = 'Benny\'s', x = -205.73, y = -1303.71, z = 31.24 },
    { label = 'Los Santos Customs', x = -360.91, y = -129.46, z = 38.70 },
    { label = 'Top of Maze Bank',  x = -75.20, y = -818.95, z = 326.18 }
}


if Settings.OpenWithKey then
    RegisterCommand('tpmenu', function()
        TriggerServerEvent('tpmenu:TriggerMenu')
    end, false)

    RegisterKeyMapping('tpmenu', 'Teleport Menu', 'keyboard', 'f5')
end