ESX = exports['es_extended']:getSharedObject()
local ox_inventory = exports.ox_inventory

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
        
    end
     while ESX.GetPlayerData() == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()


end)
Objects = {}
AddEventHandler("onResourceStop", function(res)
  if GetCurrentResourceName() == res then


    for i = 1, #Objects do
      DeleteObject(Objects[i])
    end


  end
end)



RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
	
	for k, v in pairs(Config.Mafije) do  
	  RequestModel(GetHashKey(`prop_ld_int_safe_01`))
	  while not HasModelLoaded(`prop_ld_int_safe_01`) do Wait(100) print("cekam model", model) end
		
    PostaviSef = CreateObject(`prop_ld_int_safe_01`, v.sef, false, true)
    SetEntityHeading(PostaviSef, v.sefheading)
    FreezeEntityPosition(PostaviSef, true) 
    SetEntityInvincible(PostaviSef, true)
    PlaceObjectOnGroundProperly(PostaviSef)
    table.insert(Objects, PostaviSef)
    SetModelAsNoLongerNeeded(`prop_ld_int_safe_01`)
    exports.qtarget:AddBoxZone(k, v.sef, 0.85, 0.75, {
        name=k,
        heading= v.sefheading,
        debugPoly=Config.Debug,
        minZ=v.kordinate.z -1,
        maxZ=v.kordinate.z +2,
        }, {
            options = {
                {
                    action = function()
                        otvorisef()
                    end,
                    label = "Pristupite sefu",
                    job = k,
                },
            },
            distance = 3.5
    })
  end 
end)


function otvorisef()
    
       
    for k, v in pairs(Config.Mafije) do     
        if ESX.PlayerData.job and ESX.PlayerData.job.name == k then  
            TriggerEvent('ox_inventory:openInventory', 'stash',  k )
        end
    end  
end
