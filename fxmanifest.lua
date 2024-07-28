fx_version 'cerulean'
games { 'gta5' }
author 'Kristof-_-, Goshawk1337'
lua54("yes")
description 'SRRP jobcenter written by Goshawk1337 Kristof-_-'

-----------------------------------------------------------
--EZEKHEZ NE NYULJ!

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'client/*'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*'
}

files {
    'html/src/**/*',
    'html/src/script.js'
}

ui_page 'html/src/index.html'

escrow_ignore {
    'config.lua'
}
