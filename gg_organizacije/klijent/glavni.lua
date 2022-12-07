ESX = exports['es_extended']:getSharedObject()



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


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)





Citizen.CreateThread(function()
  for k, v in pairs(Config.Mafije)do 
    if ESX.PlayerData.job and ESX.PlayerData.job.name == k then 
      if Config.Blip == true then   
        blip = AddBlipForCoord(v.kordinate)
        SetBlipSprite(blip, 357)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 1.0)
        SetBlipColour(blip, 83)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Prevod["blip"]["message"])
        EndTextCommandSetBlipName(blip)
      end
    end
  end
end)