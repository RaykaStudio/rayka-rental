local Framework = nil
local ESX = nil

CreateThread(function()
    local fwSetting = Config.Framework
    if fwSetting == "auto" then
        if GetResourceState('es_extended') == 'started' then Framework = 'esx'
        elseif GetResourceState('qb-core') == 'started' then Framework = 'qb'
        elseif GetResourceState('qbox-core') == 'started' then Framework = 'qbox'
        else Framework = 'standalone' end
    else Framework = fwSetting end

    if Framework == 'esx' then ESX = exports['es_extended']:getSharedObject() end
end)

RegisterNetEvent("rayka-rentals:server:processRent", function(model, price, rentalId)
    local src = source
    local hasMoney = false

    if Framework == 'esx' then
        local xPlayer = ESX.GetPlayerFromId(src)
        if xPlayer then
            if xPlayer.getMoney() >= price then
                xPlayer.removeMoney(price)
                hasMoney = true
            elseif xPlayer.getAccount('bank').money >= price then
                xPlayer.removeAccountMoney('bank', price)
                hasMoney = true
            end
        end
    elseif Framework == 'qb' or Framework == 'qbox' then
        local Player = exports['qb-core']:GetCoreObject().Functions.GetPlayer(src)
        if Player then
            local cashBalance = Player.Functions.GetMoney('cash')
            local bankBalance = Player.Functions.GetMoney('bank')

            if cashBalance >= price then
                if Player.Functions.RemoveMoney('cash', price) then
                    hasMoney = true
                end
            elseif bankBalance >= price then
                if Player.Functions.RemoveMoney('bank', price) then
                    hasMoney = true
                end
            end
        end
    elseif Framework == 'standalone' then
        hasMoney = true
    end

    if hasMoney then
        TriggerClientEvent("rayka-rentals:client:spawnVehicle", src, model, rentalId)
    else
        if Config.Notification == "ox_lib" and GetResourceState('ox_lib') == 'started' then
            TriggerClientEvent('ox_lib:notify', src, { title = 'RENTAL', description = "You don't have enough money!", type = 'error' })
        elseif Framework == 'qb' or Framework == 'qbox' then
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough money!", "error")
        elseif Framework == 'esx' then
            TriggerClientEvent('esx:showNotification', src, "You don't have enough money!")
        end
    end
end)