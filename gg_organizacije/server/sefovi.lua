ESX = exports['es_extended']:getSharedObject()
local GetCurrentResourceName = GetCurrentResourceName()
local ox_inventory = exports.ox_inventory

AddEventHandler('onServerResourceStart', function(resourceName)
	if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName then
		for k, v in pairs(Config.Mafije) do
			ox_inventory:RegisterStash(k, 'Organizacija sef', v.slotovi, v.tezina, false, k)
		end
	end
end)