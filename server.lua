ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('tpmenu', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent("tpmenu:open")
end, true, {help = 'Teleport menu', validate = false})

RegisterServerEvent('tpmenu:TriggerMenu')
AddEventHandler('tpmenu:TriggerMenu', function()
	local xPlayer = ESX.GetPlayerFromId(source)
    if DoesHavePermision(xPlayer) then
		TriggerClientEvent("tpmenu:open", source)
	else
		TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Error: ^1You are not allowed to use this command.')
	end
end)

function DoesHavePermision(xPlayer)
	local group = xPlayer.getGroup()
    if group == 'superadmin' or group == 'admin' or group == 'moderator' then
        return true
    end
	return false
end