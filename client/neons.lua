ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('doj-vehs:neonMenu', function() 
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
            ESX.TriggerServerCallback('doj-vehs:hasItemDiod', function(item)
                if item then
                    neonMenu()
                else
                    exports['mythic_notify']:DoHudText('error', 'You dont have led lamps')
                end
            end, item) 
		end
	else
        exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)

RegisterCommand('applyneon', function()
    TriggerEvent('doj-vehs:neonMenu')
end)

RegisterNetEvent('doj-vehs:applyNeons', function(args) 
    local args = tonumber(args)
    local playerPed	= PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
    SetVehicleModKit(vehicle, 0)
    SetVehicleEngineOn(vehicle, true, true)
    neonMenu()
	if args == 1 then 
        SetVehicleNeonLightsColour(vehicle, 222, 222, 255)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 2 then 
        SetVehicleNeonLightsColour(vehicle, 2, 21, 255)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 3 then 
        SetVehicleNeonLightsColour(vehicle, 3, 83, 255)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 4 then 
        SetVehicleNeonLightsColour(vehicle, 0, 255, 140)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)
        
    elseif args == 5 then
        SetVehicleNeonLightsColour(vehicle, 94, 255, 1)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 6 then
        SetVehicleNeonLightsColour(vehicle, 255, 255, 0)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 7 then
        SetVehicleNeonLightsColour(vehicle, 255, 150, 0)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 8 then
        SetVehicleNeonLightsColour(vehicle, 255, 62, 0)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 9 then
        SetVehicleNeonLightsColour(vehicle, 255, 1, 1)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 10 then
        SetVehicleNeonLightsColour(vehicle, 255, 50, 100)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 11 then
        SetVehicleNeonLightsColour(vehicle, 255, 5, 190)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 12 then
        SetVehicleNeonLightsColour(vehicle, 35, 1, 255)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    elseif args == 13 then
        SetVehicleNeonLightsColour(vehicle, 15, 3, 255)

        SetVehicleNeonLightEnabled(vehicle, 0, true)
        SetVehicleNeonLightEnabled(vehicle, 1, true)
        SetVehicleNeonLightEnabled(vehicle, 2, true)
        SetVehicleNeonLightEnabled(vehicle, 3, true)

    else
        CurrentVehicleData = ESX.Game.GetVehicleProperties(vehicle)
        TriggerServerEvent('updateVehicle', CurrentVehicleData)
    end
end)

function neonMenu()
    local neonColors = {        
        {
            id = 1,
            header = 'Neon menu',
            txt = ''
        },
        {
            id = 2,
            header = 'White',
            txt = 'White neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 1
            }
        },
        {
            id = 3,
            header = 'Blue',
            txt = 'Blue neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 2
            }
        },
        {
            id = 4,
            header = 'Electric blue',
            txt = 'Electric blue neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 3
            }
        },
        {
            id = 5,
            header = 'Mint green',
            txt = 'Mint green neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 4
            }
        },
        {
            id = 6,
            header = 'Lime green',
            txt = 'Lime green neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 5
            }
        },
        {
            id = 7,
            header = 'Yellow',
            txt = 'Yelow neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 6
            }
        },
        {
            id = 8,
            header = 'Golden shower',
            txt = 'Golden shower neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 7
            }
        },
        {
            id = 9,
            header = 'Orange',
            txt = 'Orange neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 8
            }
        },
        {
            id = 10,
            header = 'Red',
            txt = 'Red neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 9
            }
        },
        {
            id = 11,
            header = 'Pony pink',
            txt = 'Pony pink neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 10
            }
        },
        {
            id = 12,
            header = 'Hot pink',
            txt = 'Hot pink neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 11
            }
        },
        {
            id = 13,
            header = 'Purple',
            txt = 'Purple neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 12
            }
        },
        {
            id = 14,
            header = 'Blacklight',
            txt = 'Blacklight neon',
            params = {
                event = 'doj-vehs:applyNeons',
                isServer = false,
                args = 13
            }
        }
    }

    exports['zf_context']:openMenu(neonColors)
end
