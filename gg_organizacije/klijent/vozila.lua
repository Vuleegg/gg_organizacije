ESX = exports['es_extended']:getSharedObject()





RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
	ESX.ShowNotification(Config.Prevod["ulaznaporuka"]["message"])
end)


CreateThread(function()
    for k, v in pairs(Config.Mafije) do
 RequestModel(GetHashKey('a_m_y_business_03'))
while not HasModelLoaded(GetHashKey('a_m_y_business_03')) do
Wait(1)
end
PostaviPeda = CreatePed(4, 'a_m_y_business_03', v.kordinate , v.heading, false, true)
TaskStartScenarioInPlace(PostaviPeda, 'WORLD_HUMAN_SMOKING', 0, false)
FreezeEntityPosition(PostaviPeda, true) 
SetEntityInvincible(PostaviPeda, true)
SetBlockingOfNonTemporaryEvents(PostaviPeda, true)
exports.qtarget:AddBoxZone(k, v.kordinate, 0.85, 0.75, {
	name=k,
	heading=50.0,
	debugPoly=Config.Debug,
	minZ=v.kordinate.z -1,
	maxZ=v.kordinate.z +1,
	}, {
		options = {
			{
				event = "vaskezzyy:test",
				label = "Otvorite garazu",
				job = k,
			},
			{
				action = function()
                    vrativozilo()
                end,
				label = "Parkirajte vozilo",
				job = k,
                canInteract = function()
                    return IsPedInAnyVehicle(PlayerPedId(), false)
                  end,
			},
		},
		distance = 3.5
})
  end
end)

function vrativozilo()
    local vrativozilo = GetLastDrivenVehicle(PlayerPedId())
    DeleteVehicle(vrativozilo)
    ESX.ShowNotification(Config.Prevod["parkiranje"]["message"])
end


RegisterNetEvent('vaskezzyy:test', function()

    local table = {}

    for model, label in pairs(Config.Mafije[PlayerData.job.name]["MeniVozila"]) do
        table[#table + 1] = {
            title = label,
			event = "stvorivozlil123",
			args= model
        }

		lib.registerContext({
			id = 'example_menu1',
			title = 'Auta:',
			options = table
		})
		lib.showContext('example_menu1')
    end
end)


RegisterNetEvent('stvorivozlil123', function(model)

	

	local ModelHash = model 
	if not IsModelInCdimage(ModelHash) then return end
		RequestModel(ModelHash) 
	while not HasModelLoaded(ModelHash) do 
		Citizen.Wait(10)
	end
	local MyPed = PlayerPedId()
	local Vehicle = CreateVehicle(ModelHash, Config.Mafije[PlayerData.job.name]["spawnvozila"][1], 0, true, false)
	if Config.Mafije[PlayerData.job.name]['Boja'] then -- Boja vozila, imate u config.lua!
		local props = {
			color1 = Config.Mafije[PlayerData.job.name]['Boja'],
			color2 = Config.Mafije[PlayerData.job.name]['Boja'],
		}
		ESX.Game.SetVehicleProperties(veh, props)
	end
	TaskWarpPedIntoVehicle(MyPed,Vehicle,-1)

end)