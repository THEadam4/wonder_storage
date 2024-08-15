fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'THEadam4 & vondrs'
description 'Simple storage system'
version '1.0.0'

escrow_ignore {
    'config.lua',
    'sv_config.lua',
    'locales/*.lua',
    'import.sql',
}

client_scripts {
    'locales/*.lua',
    'client/*.lua',
}

server_script {
    'locale.lua',
    'locales/*.lua',
    'server/*.lua',
    '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
    'locale.lua',
    '@ox_lib/init.lua',
    'config.lua',
}