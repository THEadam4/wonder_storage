Config = {}

Config.Framework = "ESX" -- ESX/QBCore

Config.Locale = 'en' -- en/cs

Config.Stashes = {
    ["stash1"] = { -- Needs to be unique, if you make 2 same, it will create 2 identical stashes
        coords = vec3(445.6496, -979.3688, 30.6328), -- Coords for target
        label = "Storage", -- Label for target and stash
        labelChange = "Change pin", -- Label for target
        slots = 20, -- Slots for stash
        weight = 50000, -- Slots for stash
        owner = "char1:b4d422909eb8579b9e7de292262a15c5096531b1", -- Char identifier for owner to access Change PIN target
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
