fx_version 'adamant'
game 'gta5'

author 'MarcelSimple'
description 'Simple Moneywash'
version '1.0.1'

server_scripts {
    'Einstellungen/Simple_Security.lua',
	'Server/Simple_Server.lua'
}

shared_scripts {
    'Einstellungen/Simple_Einstellungen.lua',
}

client_scripts {
	'Client/Simple_Client.lua'
}

ui_page "UI/SimpleScripts.html"
files {
    'UI/*.*',
    'UI/**/*.*',
    'UI/**/**/*.*'
}