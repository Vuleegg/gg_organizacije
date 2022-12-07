fx_version 'cerulean'
game 'gta5'
deskripcija 'Napokon da zavrsimo i to da me ne tagate kako i sta'
autor 'vulegg#5757'

lua54 'yes'
shared_script '@ox_lib/init.lua'

client_scripts {
    'klijent/*.lua',
	'config.lua'
}

server_scripts  {
    'server/*.lua',
	'config.lua'
}

dependencies {
	'es_extended',
	'esx_addonaccount',
	'esx_addoninventory',
	'esx_datastore',
	'esx_society',
	'PolyZone',
	'qtarget'
}
