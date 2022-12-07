ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('gg:vezivanje')
AddEventHandler('gg:vezivanje', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

    if xJob and Config.Mafije[xJob.name] then
        if drugijebeniigrac then 
            if udaljenost < 8.0 then
                if src ~= target then
                    return TriggerClientEvent('gg:vezivanjecl', target)
                end
            end
        end
    end
     DropPlayer(src, 'Cao citeru') 
end)

RegisterNetEvent('gg:vuci')
AddEventHandler('gg:vuci', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))

    if xJob and Config.Mafije[xJob.name] then
        if drugijebeniigrac then 
            if udaljenost < 8.0 then
                if src ~= target then
                    return TriggerClientEvent('gg:vuci', target, src)
                end
            end
        end
    end
     DropPlayer(src, 'Cao citeru') 
end)

RegisterNetEvent('gg:staviUVozilo')
AddEventHandler('gg:staviUVozilo', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))
    local vozilonajblize = GetNajblizeVozilo(GetEntityCoords(GetPlayerPed(src)))
    local vozilozakljucan = GetVehicleDoorLockStatus(vozilonajblize)

    if vozilozakljucan ~= 2 then
        if xJob and Config.Mafije[xJob.name] then
            if drugijebeniigrac then 
                if udaljenost < 8.0 then
                    if src ~= target then
                        return TriggerClientEvent('gg:staviUVozilo', target)
                    end
                end
            end
        end
         DropPlayer(src, 'Cao citeru') 
    else
        TriggerClientEvent('esx:showNotification', src, (Config.Prevod['zakljucano']['message']))
    end
end)

RegisterNetEvent('gg:staviVanVozila')
AddEventHandler('gg:staviVanVozila', function(target)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local xJob = xPlayer.job
    local drugijebeniigrac = ESX.GetPlayerFromId(target)
    local udaljenost = #(GetEntityCoords(GetPlayerPed(src)) - GetEntityCoords(GetPlayerPed(target)))
    local vozilonajblize = GetNajblizeVozilo(GetEntityCoords(GetPlayerPed(src)))
    local vozilozakljucan = GetVehicleDoorLockStatus(vozilonajblize)
    local vozilo = GetVehiclePedIsIn(GetPlayerPed(target), false)
    if vozilo then
        if vozilozakljucan ~= 2 then
            if xJob and Config.Mafije[xJob.name] then
                if drugijebeniigrac then 
                    if udaljenost < 8.0 then
                        if src ~= target then
                            TaskLeaveVehicle(GetPlayerPed(target), vozilo, 64)
                            return
                        end
                    end
                end
            end

        DropPlayer(src, 'Cao citeru')
    else
        TriggerClientEvent('esx:showNotification', src, (Config.Prevod['zakljucano']['message']))
    end
    else
        TriggerClientEvent('esx:showNotification', src, (Config.Prevod['nijeuvozilu']["message"]))
    end
end)