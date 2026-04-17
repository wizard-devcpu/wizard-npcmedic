local QBCore = exports['qb-core']:GetCoreObject()
local medicActive = false
local currentMedic = nil

local function CleanupMedic()
    if currentMedic then
        DeleteEntity(currentMedic)
        currentMedic = nil
    end
    medicActive = false
end

RegisterNetEvent('wizard-npcmedic:client:startMedic', function()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local spawnCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, Config.SpawnDistance, 0.0)
    
    medicActive = true
    
    RequestModel(Config.MedicPed)
    while not HasModelLoaded(Config.MedicPed) do Wait(10) end
    
    currentMedic = CreatePed(4, Config.MedicPed, spawnCoords.x, spawnCoords.y, spawnCoords.z, 0.0, true, false)
    SetEntityInvincible(currentMedic, true)
    SetBlockingOfNonTemporaryEvents(currentMedic, true)
    
    TaskGoToEntity(currentMedic, playerPed, -1, 1.0, 1.0, 1073741824, 0)
    
    CreateThread(function()
        while medicActive do
            local medicCoords = GetEntityCoords(currentMedic)
            local dist = #(medicCoords - GetEntityCoords(playerPed))
            
            if dist < 2.0 then
                ClearPedTasks(currentMedic)
                TaskTurnPedToFaceEntity(currentMedic, playerPed, 1000)
                Wait(1000)
                
                RequestAnimDict(Config.ReviveAnimDict)
                while not HasAnimDictLoaded(Config.ReviveAnimDict) do Wait(10) end
                
                TaskPlayAnim(currentMedic, Config.ReviveAnimDict, Config.ReviveAnimName, 8.0, 8.0, Config.ReviveTime, 1, 0, false, false, false)
                
                QBCore.Functions.Progressbar("revive_doc", "Medic is treating you...", Config.ReviveTime, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() 
                    TriggerEvent('hospital:client:Revive')
                    CleanupMedic()
                end)
                break
            end
            Wait(500)
        end
    end)
end)

RegisterCommand('medic', function()
    local PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] then
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = "open",
            cost = Config.MedicCost
        })
    else
        QBCore.Functions.Notify("You are not incapacitated", "error")
    end
end)

RegisterNUICallback('callMedic', function(data, cb)
    if not medicActive then
        TriggerServerEvent('wizard-npcmedic:server:requestMedic')
    else
        QBCore.Functions.Notify("A medic is already on the way", "error")
    end
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('restartScript', function(data, cb)
    CleanupMedic()
    QBCore.Functions.Notify("Medic system reset", "success")
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)