
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--========================================================== Turbo
RegisterNetEvent('doj-vehs:removeTurbo', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('turbo', 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Turbo has been installed'})

end)

ESX.RegisterUsableItem("turbo", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("doj-vehs:applyTurbo", source)
end)

--========================================================== Headlights
RegisterNetEvent('doj-vehs:removeXenon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('headlights', 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Xenon has been installed'})
end)

ESX.RegisterUsableItem("headlights", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent("doj-vehs:applyXenons", source)
end)

--========================================================== Tire Repair
ESX.RegisterUsableItem("tire", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('doj-vehs:replacePoppedTire', source)
end)

RegisterServerEvent('doj-vehs:removeTire', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('tire', 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Tire has been changed'})
end)

--========================================================== suspension
ESX.RegisterUsableItem("coilover_wrenches", function(source, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('doj-vehs:coiloverMenu', source)
end)

ESX.RegisterServerCallback('doj-vehs:hasItem', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('coilover_wrenches').count
    cb(item)
end)

ESX.RegisterServerCallback('doj-vehs:hasItemDiod', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem('diod').count
    cb(item)
end)

-- RegisterServerEvent('doj-vehs:removeCoilovers', function()
--     local Player = QBCore.Functions.GetPlayer(source)
--     Player.Functions.RemoveItem('coilovers', 1)
--     TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['coilovers'], "remove", 1)
--     TriggerClientEvent('QBCore:Notify', source, "suspension installed", 'success')
-- end)





