ESX = exports['es_extended']:getSharedObject()
local getajresourcename = GetCurrentResourceName()




if getajresourcename ~= "gg_organizacije" then
	print("                                             #")
	print("                                             ###")
	print("###### ###### ###### ###### ######  ##############")
	print("#      #    # #    # #    # #    #  ################    Promeni '" .. getajresourcename .. "' u 'gg_organizacije'")
	print("###    ###### ###### #    # ######  ##################  ili neces koristiti skriptu kidaro!")
	print("#      # ##   # ##   #    # # ##    ################    gg_organizacije by Vulegg#5757 !!!")
	print("###### #   ## #   ## ###### #   ##  ##############")
	print("                                             ###")
	print("                                             #")
	StopResource(getajresourcename)
	Wait(5000)
	os.exit(69)
	kresuj = true
	Citizen.CreateThread(function()
		while kresuj do
	    end
	end)
end