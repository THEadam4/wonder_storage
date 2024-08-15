CreateThread(function()
    for k, v in pairs(Config.Stashes) do
        exports.ox_target:addSphereZone({
            coords = vec3(v.coords.x, v.coords.y, v.coords.z),
            radius = 2,
            debug = false,
            drawSprite = true,
            options = {
                {
                    icon = "fa-solid fa-warehouse",
                    label = v.label,
                    distance = 2.0,
                    onSelect = function()
                        local input = lib.inputDialog(_U("pin_input_title"), {
                            {type = 'input', label = _U("pin_input_label"), icon = 'vault', required = true, password = true, max = 4, min = 4}
                        })
                        if not input then
                            return
                        end 
                        if tonumber(input[1]) == nil then
                            ShowNotify(_U("notify_wrong_pin"), "error")
                        else
                            local pin = lib.callback.await("wonder_storage:checkpin", false, k)
                            if pin == tonumber(input[1]) then
                                ShowNotify(_U("notify_pin_success"), "success")
                                TriggerServerEvent("wonder_storage:registerStash", k, v.label, v.slots, v.weight)
                                Citizen.Wait(50)
                                exports.ox_inventory:openInventory("stash", k)
                            else
                                ShowNotify(_U("notify_wrong_pin"), "error")
                            end
                        end
                    end
                },
                {
                    icon = "fa-solid fa-user-lock",
                    label = v.labelChange,
                    distance = 2.0,
                    onSelect = function()
                        local input = lib.inputDialog(_U("new_pin_input_title"), {
                            {type = 'input', label = _U("new_pin_input_label"), icon = 'vault', required = true, password = true, max = 4, min = 4}
                        })
                        if not input then
                            return
                        end 
                        if tonumber(input[1]) == nil then
                            ShowNotify(_U("notify_new_pin_error"), "error")
                        else
                            ShowNotify(_U("notify_new_pin_success")..input[1], "info")
                            TriggerServerEvent("wonder_storage:SetPinCode", input[1], k)
                        end
                    end,
                    canInteract = function()
                        local identifier = lib.callback.await("wonder_storage:checkowner", false)
                        if identifier == v.owner then
                            return true
                        else
                            return
                        end
                    end
                }
            }
        })
    end
end)