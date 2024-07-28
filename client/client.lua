local peds = {}
local nametags = {}
local blips = {}
local id = 0
local core = Config.SetCore()


AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end

    npc(false)
end)



-- NUI Callbacks
RegisterNUICallback('exit', function(data, cb)
    SetNuiState(false)
    cb('ok')
end)

RegisterNUICallback('setJob', function(data, cb)
    TriggerServerEvent("fz:setJob", data.job, Config.JobsCenterPos[id].jobs[data.job].grade)
    SetNuiState(false)
    cb('ok')
end)
function SetNuiState(state)
    SetNuiFocus(state, state)

    SendNUIMessage({
        type = "show",
        enable = state
    })
end


CreateThread(function()
    npc(true)
end)

function npc(type)
    if type then
        for k, v in pairs(Config.JobsCenterPos) do
            lib.requestModel(v.model)
            local ped = CreatePed(1, v.model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.heading, false, false)
            peds[#peds + 1] = ped
            FreezeEntityPosition(peds[k], true)
            SetBlockingOfNonTemporaryEvents(peds[k], true)
            SetEntityInvincible(peds[k], true)
            TaskStartScenarioInPlace(peds[k], "WORLD_HUMAN_CLIPBOARD", -1, false)

        if Config.oxTarget then 
            local label = CreateMpGamerTag(peds[k], v.text, false, false, "", 0)
            SetMpGamerTagsVisibleDistance(v.drawRange)
            nametags[#nametags + 1] = label
            exports.ox_target:addLocalEntity(peds, {
                {
                    label = v.text,
                    name = "SellMenu",
                    icon = "fa-solid fa-fish-fins",
                    distance = 1.5,
                    onSelect = function()
                        SetNuiState(true)
                        SendNUIMessage({
                            type = "set",
                            list = v.jobs,
                            playerName = GetPlayerName(PlayerId())
                        })
                        id = k
                    end,
                },
            })
        else
            local label = CreateMpGamerTag(peds[k], "[E] - "..v.text, false, false, "", 0)
            SetMpGamerTagsVisibleDistance(v.drawRange)
            nametags[#nametags + 1] = label
            local point = lib.points.new({
                coords = GetEntityCoords(peds[k]),
                distance = 1,
            })
             
            function point:onEnter()
                Config.textUI("[E] - "..v.text, "show")
            end
             
            function point:onExit()
                Config.textUI("[E] - "..v.text, "hide")
            end
             
            function point:nearby()             
                if self.currentDistance < 1 and IsControlJustReleased(0, Config.openKey) then
                    SetNuiState(true)
                    SendNUIMessage({
                        type = "set",
                        list = v.jobs,
                        playerName = GetPlayerName(PlayerId())
                    })
                    Config.textUI("[E] - "..v.text, "hide")
                    id = k

                end
            end
        end
            local blip = AddBlipForCoord(v.coords.xyz)
            blips[#blips + 1] = blip
            SetBlipSprite(blips[k], v.blipSettings.type)
            SetBlipColour(blips[k], v.blipSettings.color)
            SetBlipDisplay(blips[k], 4)
            SetBlipAsShortRange(blips[k], true)
            SetBlipScale(blips[k], v.blipSettings.scale)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipSettings.name)
            EndTextCommandSetBlipName(blips[k])
        end
    else
        peds = {}
        for k, v in pairs(nametags) do
            print(k, v)
            RemoveMpGamerTag(v)
        end
    end
end


function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = (string.len(text)) / 370
    DrawRect(_x, _y + 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
end
