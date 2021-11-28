
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('doj-vehs:coiloverMenu', function() 
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
        exports['mythic_notify']:DoHudText('error', 'Cannot Install while inside vehicle')
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
            ESX.TriggerServerCallback('doj-vehs:hasItem', function(item)
                if item then
                    coiloverMenu()
                else
                    exports['mythic_notify']:DoHudText('error', 'You dont have a wrench')
                end
            end, item) 
		end
	else
        exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)

RegisterNetEvent('doj-vehs:applyCoilovers', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
    SetVehicleModKit(vehicle, 0)
    coiloverMenu()
	if args == 1 then 
        SetVehicleMod(vehicle, 15, 4, false)
    elseif args == 2 then 
        SetVehicleMod(vehicle, 15, 0, false)
    elseif args == 3 then 
        SetVehicleMod(vehicle, 15, 1, false)
    elseif args == 4 then 
        SetVehicleMod(vehicle, 15, 2, false)
    elseif args == 5 then
        SetVehicleMod(vehicle, 15, 3, false)
    else
        TriggerEvent('zf_context:closeMenu')
        CurrentVehicleData = ESX.Game.GetVehicleProperties(vehicle)
        TriggerServerEvent('updateVehicle', CurrentVehicleData)
    end
end)

function coiloverMenu()
    local coiloverParts = {        
        {
            id = 1,
            header = 'Coilover menu',
            txt = ''
        },
        {
            id = 2,
            header = 'Stock',
            txt = 'Stock suspension',
            params = {
                event = 'doj-vehs:applyCoilovers',
                isServer = false,
                args = 1
            }
        },
        {
            id = 3,
            header = 'Level 1',
            txt = 'Level 1 suspension',
            params = {
                event = 'doj-vehs:applyCoilovers',
                isServer = false,
                args = 2
            }
        },
        {
            id = 4,
            header = 'Level 2',
            txt = 'Level 2 suspension',
            params = {
                event = 'doj-vehs:applyCoilovers',
                isServer = false,
                args = 3
            }
        },
        {
            id = 5,
            header = 'Level 3',
            txt = 'Level 3 suspension',
            params = {
                event = 'doj-vehs:applyCoilovers',
                isServer = false,
                args = 4
            }
        },
        {
            id = 6,
            header = 'Level 4',
            txt = 'Level 4 suspension',
            params = {
                event = 'doj-vehs:applyCoilovers',
                isServer = false,
                args = 5
            }
        }
    }

    exports['zf_context']:openMenu(coiloverParts)
end
