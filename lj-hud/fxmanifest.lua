fx_version 'cerulean'
game 'gta5'

description 'lj-hud'
version '1.7'
author 'github.com/loljoshie'

client_script 'config.lua'
client_script 'client.lua'
server_script 'server.lua'
lua54 'yes'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/styles.css',
	'html/responsive.css',
	'html/app.js',
}

exports {
	'setVoiceMode',
	'playernowTalking'
}