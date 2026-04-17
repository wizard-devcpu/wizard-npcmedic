local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('wizard-npcmedic:server:requestMedic', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cost = Config.MedicCost

    if Player.Functions.GetMoney('cash') >= cost then
        Player.Functions.RemoveMoney('cash', cost)
        TriggerClientEvent('wizard-npcmedic:client:startMedic', src)
    elseif Player.Functions.GetMoney('bank') >= cost then
        Player.Functions.RemoveMoney('bank', cost)
        TriggerClientEvent('wizard-npcmedic:client:startMedic', src)
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough money", "error")
    end
end)