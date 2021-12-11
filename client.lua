ESX = nil
lastlocation = nil
debuglocation = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(50)
	end
end)

RegisterNetEvent('tpmenu:open')
AddEventHandler('tpmenu:open', function()
    ESX.UI.Menu.CloseAll() --Close everything ESX.Menu related	
    local elements = {}

    table.insert(elements, { label = 'Teleport To Waypoint', value= 'waypoint'})
    table.insert(elements, { label = 'Locations', value= 'loc'})

    if Settings.DebugLocation then 
        if debuglocation ~= nil then
            table.insert(elements, { label = 'Debug Location', value= 'debugloc'}) 
        end
        table.insert(elements, { label = 'Set Debug Location', value= 'setdebugloc'}) 
    end

    if lastlocation ~= nil 
        then table.insert(elements, { label = 'Last location', value= 'lastloc'}) 
    end

    table.insert(elements, { label = 'Print Coords', value= 'printcoords'})

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu',
    {
        title    = 'Teleport menu',
        align    = 'bottom-right',
        elements = elements
    },
    function(data, menu) --on data selection
        if data.current.value == "lastloc" then
            if lastlocation ~= nil then  
                ESX.Game.Teleport(PlayerPedId(), lastlocation) 
                ESX.ShowNotification(Locale['teleported_last'])
            else 
                ESX.ShowNotification(Locale['teleported_last_empty'])
            end
        elseif data.current.value == "setdebugloc" then
            debuglocation = GetEntityCoords(GetPlayerPed(-1))
            ESX.ShowNotification(Locale['teleported_debug'])
            menu.close()
        elseif data.current.value == "waypoint" then
            TeleportWaypoint()
        elseif data.current.value == "debugloc" then        
            lastlocation = GetEntityCoords(GetPlayerPed(-1))
            ESX.Game.Teleport(PlayerPedId(), debuglocation) 
            ESX.ShowNotification(Locale['teleported'] .. data.current.label)
        elseif data.current.value == "loc" then   
            OpenLocationsMenu()
        elseif data.current.value == "printcoords" then
            PrintCoords()
        end
    end,
    function(data, menu)
        menu.close()
    end)
end)


function OpenLocationsMenu()
    local elements = {}

    for k,v in ipairs(Locations) do
        table.insert(elements, { label = v.label, x = v.x, y = v.y, z = v.z })
    end
    
    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'tpmenu_locations',
    {
        title    = 'Teleport locations',
        align    = 'bottom-right',
        elements = elements
    },
    function(data, menu) --on data selection
        lastlocation = GetEntityCoords(GetPlayerPed(-1))
        local coords = { x = data.current.x,  y = data.current.y, z = data.current.z}
        ESX.Game.Teleport(PlayerPedId(), coords)
        ESX.ShowNotification(Locale['teleported'] .. data.current.label)
    end,
    function(data, menu)
        menu.close()
    end)
end

function TeleportWaypoint()
	local playerPed = GetPlayerPed(-1)
	local blip = GetFirstBlipInfoId(8)

	if DoesBlipExist(blip) then
		local waypointCoords = GetBlipInfoIdCoord(blip)
		for height = 1, 1000 do
			SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
			local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

			if foundGround then
				SetPedCoordsKeepVehicle(PlayerPedId(), waypointCoords["x"], waypointCoords["y"], height + 0.0)
				break
			end
			Citizen.Wait(5)
		end
        ESX.ShowNotification(Locale['teleported'] .. 'Waypoint')
	else
        ESX.ShowNotification(Locale['no_waypoint'])
	end
end

function PrintCoords()
    local playerPed = PlayerPedId()

	local pos      = GetEntityCoords(playerPed)
	local heading  = GetEntityHeading(playerPed)
	local finalPos = {}

	-- round to 2 decimals
	finalPos.x = string.format("%.2f", pos.x)
	finalPos.y = string.format("%.2f", pos.y)
	finalPos.z = string.format("%.2f", pos.z)
	finalPos.h = string.format("%.2f", heading)

	local formattedText = "x = " .. finalPos.x .. ", y = " .. finalPos.y .. ", z = " .. finalPos.z .. ', h = ' .. finalPos.h
	TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, formattedText)
	print(formattedText)
end