--[[ TELEPORT MENU BY ADRA ]]--
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
end)

local elements = {}
local lastlocation = nil
table.insert(elements, { label = 'Last location' })

--[[
    TELEPORT MENU COORDINATES
    Below you have lines of code that you need to change based on your use
    LABEL - label of location that you can find in menu
    OTHER lines are the actual coordinates
]]--

table.insert(elements, { label = 'Police station', x = 425.1, y = -979.5, z = 30.7  })
table.insert(elements, { label = 'Airport Los Santos', x = -1037.51, y = -2963.24, z = 13.95 })
table.insert(elements, { label = 'Airport Sandy Shores', x = 1718.47, y = 3254.40, z = 41.14})
table.insert(elements, { label = 'Mount Chiliad', x = 501.76, y = 5604.28, z = 797.91})
table.insert(elements, { label = 'Vinewood Sign', x = 663.41, y = 1217.21, z = 322.94})
table.insert(elements, { label = 'Benny\'s', x = -205.73, y = -1303.71, z = 31.24 })
table.insert(elements, { label = 'Los Santos Customs', x = -360.91, y = -129.46, z = 38.70 })
table.insert(elements, { label = 'Top of Maze Bank',  x = -75.20, y = -818.95, z = 326.18 })

--[[
    TELEPORT MENU LOCALE
    You can change notification messages based on your language
]]--

local Locale = {
    ['teleported']  = 'You have teleported to ~b~',
    ['teleported_last']  = 'You have teleported to ~r~Last Location',
    ['teleported_last_empty']  = 'You didn\'t visit any location with this menu.',
}

RegisterNetEvent('tpmenu:open')
AddEventHandler('tpmenu:open', function()
    ESX.UI.Menu.CloseAll()					--Close everything ESX.Menu related	
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu',
        {
            title    = 'Teleport menu',
            align    = 'bottom-right',
            elements = elements
        },
        function(data, menu)						--on data selection
            if data.current.label == "Last location" then
                if lastlocation ~= nil then  
                    ESX.Game.Teleport(PlayerPedId(), lastlocation) 
                    ESX.ShowNotification(Locale['teleported_last'])
                else 
                    ESX.ShowNotification(Locale['teleported_last_empty'])
                end
            else
                lastlocation = GetEntityCoords(GetPlayerPed(-1))
                local coords = { x = data.current.x,  y = data.current.y, z = data.current.z}
                ESX.Game.Teleport(PlayerPedId(), coords)
                ESX.ShowNotification(Locale['teleported'] .. data.current.label)
            end
            menu.close()							--close menu after selection
          end,
          function(data, menu)
            menu.close()
          end
        )
    
end)
