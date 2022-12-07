ESX = exports['es_extended']:getSharedObject()
local  isHandcuffed = false, false, false
local  dragStatus = {}, {}, {}, nil
local PlayerData = nil
dragStatus.isDragged = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job

end)
local function canOpenTarget(ped)
	return IsPedFatallyInjured(ped)
	or IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3)
	or IsPedCuffed(ped)
	or IsEntityPlayingAnim(ped, 'mp_arresting', 'idle', 3)
	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_base', 3)
	or IsEntityPlayingAnim(ped, 'missminuteman_1ig_2', 'handsup_enter', 3)
	or IsEntityPlayingAnim(ped, 'random@mugging3', 'handsup_standing_base', 3)
end
CreateThread(function()
    for k, _ in pairs(Config.Mafije) do     
        if ESX.PlayerData.job and ESX.PlayerData.job.name == k then  
            exports['qtarget']:Player({
                options = {
                    {
                        event = "ox_inventory:pretrazivanje",
                        icon = "fa-solid fa-male",
                        label = "Pretrazi",
                        job = k,
                        canInteract = function(entity, coords, distance)
                            
                            if canOpenTarget(entity) then
                                
                                return true
                            end
                            
                        end
                        
                    },

                    {
                        event = "gg:handcuff",
                        label = "Vezi/odvezi",
                        icon = "fa-solid fa-male",
                        job = k,
                    },
                    {
                        event = "gg:drag",
                        label = "Vuci",
                        icon = "fa-solid fa-male",
                        job = k,
                    },
                    {
                        event = "gg:put_in_vehicle",
                        label = "Stavi u vozilo",
                        icon = "fa-solid fa-male",
                        job = k,
                    },
                    {
                        event = "gg:out_the_vehicle",
                        label = "Izvadi iz vozila",
                        icon = "fa-solid fa-male",
                        job = k,
                    },
                },
                distance = 2
            })
        end
    end
end)

function pretrazi()
	ExecuteCommand("steal")
end

RegisterNetEvent('gg:odvezivanje')
 AddEventHandler('gg:odvezivanje', function()
    if isHandcuffed then
        isHandcuffed = false
        local playerPed = PlayerPedId()
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)
        FreezeEntityPosition(playerPed, false)
        DisplayRadar(true)
    end
end)


RegisterNetEvent('gg:handcuff')
AddEventHandler('gg:handcuff', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gg:vezivanje', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(Config.Prevod["nemaigraca"]["message"])
	end
end)

RegisterNetEvent('gg:drag')
AddEventHandler('gg:drag', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gg:vuci', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(Config.Prevod["nemaigraca"]["message"])
	end
end)

RegisterNetEvent('gg:vuci')
AddEventHandler('gg:vuci', function(copId)
    if not isHandcuffed then return end
    dragStatus.isDragged = not dragStatus.isDragged
    dragStatus.CopId = copId
end)

RegisterNetEvent('gg:put_in_vehicle')
AddEventHandler('gg:put_in_vehicle', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gg:staviUVozilo', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(Config.Prevod["nemaigraca"]["message"])
	end
end)

RegisterNetEvent('gg:staviUVozilo')
AddEventHandler('gg:staviUVozilo', function()
    if isHandcuffed then
        local igrac = PlayerPedId()
        local vozilo, udaljenost = ESX.Game.GetClosestVehicle()

        if vozilo and udaljenost < 5 then
            local max, slobodno = GetVehicleMaxNumberOfPassengers(vozilo)

            for i = max - 1, 0, -1 do
                if IsVehicleSeatFree(vozilo, i) then
                    slobodno = i
                    break
                end
            end

            if slobodno then
                TaskWarpPedIntoVehicle(igrac, vozilo, slobodno)
                dragStatus.isDragged = false
            end
        end
    end
end)

RegisterNetEvent('gg:out_the_vehicle')
AddEventHandler('gg:out_the_vehicle', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gg:staviVanVozila', GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification(Config.Prevod["nemaigraca"]["message"])
	end
end)

RegisterNetEvent('gg:vezivanjecl')
 AddEventHandler('gg:vezivanjecl', function()
    isHandcuffed = not isHandcuffed
    local playerPed = PlayerPedId()
    if isHandcuffed then
        RequestAnimDict('mp_arresting')
        while not HasAnimDictLoaded('mp_arresting') do Wait(0) end
        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        SetEnableHandcuffs(playerPed, true)
        DisablePlayerFiring(playerPed, true)
        SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true) 
        SetPedCanPlayGestureAnims(playerPed, false)
      --  FreezeEntityPosition(playerPed, true)
        DisplayRadar(false)
    else
        ClearPedSecondaryTask(playerPed)
        SetEnableHandcuffs(playerPed, false)
        DisablePlayerFiring(playerPed, false)
        SetPedCanPlayGestureAnims(playerPed, true)
        FreezeEntityPosition(playerPed, false)
        DisplayRadar(true)
    end
end)