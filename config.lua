Config = {}

Config.Locale = 'en' -- en/cs

Config.Stashes = {
    ["stash1"] = { -- Needs to be unique, if you make 2 same, it will create 2 identic stashes
        coords = vec3(445.6496, -979.3688, 30.6328), -- Coords for target
        label = "Storage", -- Label for target and stash
        labelChange = "Change pin", -- Label for target
        slots = 20, -- Slots for stash
        weight = 50000, -- Slots for stash
        owner = "license:b4d422909eb8579b9e7de292262a15c5096531b1", -- Needs to by license for standalone. But if you want to configure it for your framework, change it in server.lua
    },
    -- Add more here
}

function ShowNotify(msg, type)
    lib.notify({
        title = 'Storage',
        description = msg,
        type = type
    })
end