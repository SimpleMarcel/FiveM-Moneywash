fx_version 'adamant'
game 'gta5'

author 'MarcelSimple'
description 'Simple Moneywash'
version '1.0.0'

server_scripts {
    'Einstellungen/Simple_Security.lua',
    'Einstellungen/SimplePanel.lua',
	'Server/Simple_Server.lua'
}

shared_scripts {
    'Einstellungen/Simple_Einstellungen.lua',
}

client_scripts {
	'Client/Simple_Client.lua'
}

escrow_ignore {
    'Einstellungen/Simple_Einstellungen.lua',  
    'Einstellungen/Simple_Security.lua',
    'Einstellungen/SimplePanel.lua'
}

lua54 'yes'

ui_page "UI/SimpleScripts.html"
files {
    'UI/*.*',
    'UI/**/*.*',
    'UI/**/**/*.*'
}