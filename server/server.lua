if Config.Framework == "ESX" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterNetEvent("wonder_storage:registerStash", function(stash, label, slots, weight)
    exports.ox_inventory:RegisterStash(stash, label, slots, weight)
end)

RegisterNetEvent("wonder_storage:SetPinCode", function(pin, stash)
    local playerName = GetPlayerName(source)
    MySQL.Async.fetchAll("SELECT pincode FROM wonder_storage WHERE stash = @stash", { ['@stash'] = stash }, 
    function(result)
        if result[1] == nil then
            MySQL.Async.execute('INSERT INTO wonder_storage (pincode, stash) VALUES (@pincode, @stash)', {['pincode'] = pin, ['stash'] = stash })
        else
            MySQL.Async.execute('UPDATE wonder_storage SET pincode = @pincode WHERE stash = @stash', {['pincode'] = pin, ['stash'] = stash })
        end
    end)
    SendLog("**"..playerName.."** si nastavil nový pin: **"..pin.."**")
end)

lib.callback.register("wonder_storage:checkpin", function(source, stash)
    local pin
    MySQL.Async.fetchAll("SELECT pincode FROM wonder_storage WHERE stash = @stash", { ['@stash'] = stash }, 
    function(result)
        pin = result[1].pincode
    end)
    Wait(50)
    return pin
end)

lib.callback.register("wonder_storage:checkowner", function(source)
    local identifier
    if Config.Framework == "ESX" then
        local xPlayer = ESX.GetPlayerFromId(source)
        identifier = xPlayer.identifier
    elseif Config.Framework == "QBCore" then
        identifier = QBCore.Functions.GetIdentifier(source)
    end
    return identifier
end)

function SendLog(message)
    if Sv_config.Webhook == "WEBHOOOK_HERE" then
        print("No webhook set")
        return
    else
        local embed = {
            {    
                title = "Wonder Storage",
                color = 16177664, 
                description = message,
                ["footer"] = {
                    ["text"] = "Wonder log - [ "..os.date('%H:%M:%S - %d. %m. %Y', os.time()).." ]",
                    ["icon_url"] = 'https://cdn.discordapp.com/attachments/667357933272825876/1273619922387472447/logo.png?ex=66bf467c&is=66bdf4fc&hm=510da7af5c0cf22a55ebb70df531f054589f01a772ecc48bc0352b7dd77b1df4&',
                },
            }
        }
        PerformHttpRequest(Sv_config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Wonder Storage', embeds = embed}), { ['Content-Type'] = 'application/json' })
    end
end
