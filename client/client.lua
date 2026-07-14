local Framework, NotificationSystem = nil, nil
local activeNPCs = {}
local activeBlips = {}
local isUIOpen = false

CreateThread(function()
    if Config.Framework == "auto" then
        if GetResourceState('es_extended') == 'started' then Framework = 'esx'
        elseif GetResourceState('qb-core') == 'started' then Framework = 'qb'
        elseif GetResourceState('qbox-core') == 'started' then Framework = 'qbox'
        else Framework = 'standalone' end
    else Framework = Config.Framework end

    NotificationSystem = Config.Notification
    
    SetupNPCs()
    SetupBlips()
    SetupInteraction()
end)

function ShowNotification(text, type)
    if NotificationSystem == "ox_lib" and GetResourceState('ox_lib') == 'started' then
        exports.ox_lib:notify({ title = 'RENTAL', description = text, type = type })
    elseif NotificationSystem == "qb" or Framework == 'qb' or Framework == 'qbox' then
        TriggerEvent('QBCore:Notify', text, type)
    elseif NotificationSystem == "esx" or Framework == 'esx' then
        TriggerEvent('esx:showNotification', text)
    else
        BeginTextCommandPrint("STRING") AddTextComponentString(text) EndTextCommandPrint(3000, 1)
    end
end

function SetupNPCs()
    for _, rental in ipairs(Config.Rentals) do
        local modelHash = GetHashKey(rental.npcModel)
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do Wait(10) end
        
        local npc = CreatePed(4, modelHash, rental.npcCoords.x, rental.npcCoords.y, rental.npcCoords.z - 1.0, rental.npcCoords.w, false, true)
        SetEntityAsMissionEntity(npc, true, true)
        SetBlockingOfNonTemporaryEvents(npc, true)
        FreezeEntityPosition(npc, true)
        SetEntityInvincible(npc, true)
        activeNPCs[rental.id] = npc
    end
end

function SetupBlips()
    for _, rental in ipairs(Config.Rentals) do
        if rental.blip and rental.blip.enable then
            local blip = AddBlipForCoord(rental.npcCoords.x, rental.npcCoords.y, rental.npcCoords.z)
            SetBlipSprite(blip, rental.blip.sprite or 225)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, rental.blip.scale or 0.8)
            SetBlipColour(blip, rental.blip.color or 3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(rental.name)
            EndTextCommandSetBlipName(blip)
            activeBlips[rental.id] = blip
        end
    end
end

function OpenRentalMenu(rentalId, rentalName, categories, enableCategories)
    isUIOpen = true
    SendNUIMessage({ action = "update3DHint", visible = false }) 
    SetNuiFocus(true, true)

    local formattedCategories = json.decode(json.encode(categories))
    for _, category in ipairs(formattedCategories) do
        if category.vehicles then
            for _, vehicle in ipairs(category.vehicles) do
                if vehicle.image then
                    vehicle.image = string.format("https://cfx-nui-%s/%s", GetCurrentResourceName(), vehicle.image)
                end
            end
        end
    end

    SendNUIMessage({
        action = "open",
        rentalId = rentalId,
        rentalName = rentalName,
        enableCategories = enableCategories,
        categories = formattedCategories
    })
end

function SetupInteraction()
    if Config.InteractionType == "ox_target" and GetResourceState('ox_target') == 'started' then
        for _, rental in ipairs(Config.Rentals) do
            local npc = activeNPCs[rental.id]
            if npc then
                exports.ox_target:addLocalEntity(npc, {
                    {
                        name = 'open_rental_' .. rental.id,
                        icon = 'fa-solid fa-key',
                        label = 'Open Rental Menu',
                        onSelect = function()
                            OpenRentalMenu(rental.id, rental.name, rental.categories, rental.enableCategories)
                        end
                    }
                })
            end
        end

    elseif Config.InteractionType == "qb-target" and GetResourceState('qb-target') == 'started' then
        for _, rental in ipairs(Config.Rentals) do
            local npc = activeNPCs[rental.id]
            if npc then
                exports['qb-target']:AddTargetEntity(npc, {
                    options = {
                        {
                            type = "client",
                            icon = 'fas fa-key',
                            label = 'Open Rental Menu',
                            action = function()
                                OpenRentalMenu(rental.id, rental.name, rental.categories, rental.enableCategories)
                            end
                        }
                    },
                    distance = 2.0
                })
            end
        end

    elseif Config.InteractionType == "interact" then
        CreateThread(function()
            while true do
                local sleep = 1000
                if not isUIOpen and Config.InteractionType == "interact" then
                    local playerPed = PlayerPedId()
                    local playerCoords = GetEntityCoords(playerPed)
                    local foundActiveNPC = false

                    for _, rental in ipairs(Config.Rentals) do
                        local npc = activeNPCs[rental.id]
                        if npc and DoesEntityExist(npc) then
                            local npcCoords = GetEntityCoords(npc)
                            local distance = #(playerCoords - npcCoords)

                            if distance <= 5.0 then
                                sleep = 0
                                foundActiveNPC = true
                                
                                local boneCoords = GetPedPedBoneCoords if not boneCoords then boneCoords = GetPedBoneCoords(npc, 24818, 0.0, 0.0, 0.0) end
                                local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(boneCoords.x, boneCoords.y, boneCoords.z + 0.05)
                                
                                if onScreen and HasEntityClearLosToEntity(playerPed, npc, 17) then
                                    local visibleKey = distance <= 5.0
                                    local visibleText = distance <= 3.0

                                    SendNUIMessage({
                                        action = "update3DHint",
                                        visible = true,
                                        x = screenX,
                                        y = screenY,
                                        showKey = visibleKey,
                                        showText = visibleText
                                    })
                                else
                                    SendNUIMessage({ action = "update3DHint", visible = false })
                                end

                                if distance <= 2.0 and IsControlJustPressed(0, 38) then
                                    OpenRentalMenu(rental.id, rental.name, rental.categories, rental.enableCategories)
                                end
                                break
                            end
                        end
                    end
                    if not foundActiveNPC then SendNUIMessage({ action = "update3DHint", visible = false }) end
                else
                    SendNUIMessage({ action = "update3DHint", visible = false })
                    Wait(500)
                end
                Wait(sleep)
            end
        end)
    end
end

local function SetVehicleFuel(vehicle, amount)
    local fuelSystem = Config.FuelSystem or "none"

    if fuelSystem == "ox_fuel" then
        Entity(vehicle).state.fuel = amount
        SetVehicleFuelLevel(vehicle, amount)
    elseif fuelSystem ~= "none" and GetResourceState(fuelSystem) == 'started' then
        exports[fuelSystem]:SetFuel(vehicle, amount)
    else
        SetVehicleFuelLevel(vehicle, amount)
        Entity(vehicle).state.fuel = amount
    end
end

RegisterNUICallback("rentVehicle", function(data, cb)
    TriggerServerEvent("rayka-rentals:server:processRent", data.model, data.price, data.rentalId)
    cb("ok")
end)

RegisterNetEvent("rayka-rentals:client:spawnVehicle", function(model, rentalId)
    local rentalData = nil
    for _, r in ipairs(Config.Rentals) do 
        if r.id == rentalId then 
            rentalData = r 
            break 
        end 
    end
    if not rentalData then return end

    local spawnPos = nil
    if type(rentalData.spawnCoords) == "table" and #rentalData.spawnCoords > 0 then
        local randomIndex = math.random(1, #rentalData.spawnCoords)
        spawnPos = rentalData.spawnCoords[randomIndex]
    else
        spawnPos = rentalData.spawnCoords
    end

    if not spawnPos then 
        ShowNotification("Spawn coordinates not found!", "error")
        return 
    end

    local hash = GetHashKey(model)
    RequestModel(hash) 
    while not HasModelLoaded(hash) do Wait(10) end

    local vehicle = CreateVehicle(hash, spawnPos.x, spawnPos.y, spawnPos.z, spawnPos.w, true, false)
    
    SetVehicleDirtLevel(vehicle, 0.0)
    SetVehicleFixed(vehicle)
    SetVehicleDeformationFixed(vehicle)
    SetVehicleEngineHealth(vehicle, 1000.0)
    SetVehicleBodyHealth(vehicle, 1000.0)
    SetVehiclePetrolTankHealth(vehicle, 1000.0)

    SetVehicleFuel(vehicle, 100.0)

    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetModelAsNoLongerNeeded(hash)

    if Config.GiveKeys and (Framework == 'qb' or Framework == 'qbox') then
        local plate = GetVehicleNumberPlateText(vehicle)
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end

    ShowNotification("Vehicle rented successfully!", "success")
end)

RegisterNUICallback("close", function(data, cb) isUIOpen = false; SetNuiFocus(false, false); cb("ok") end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    for _, npc in pairs(activeNPCs) do if DoesEntityExist(npc) then DeleteEntity(npc) end end
    for _, blip in pairs(activeBlips) do if DoesBlipExist(blip) then RemoveBlip(blip) end end
end)