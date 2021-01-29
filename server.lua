ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('tpmenu', 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent("tpmenu:open")
end, true, {help = 'Teleport menu', validate = false})
