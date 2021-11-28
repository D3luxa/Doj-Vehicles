
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--========================================================== Headlights
RegisterNetEvent('doj-vehs:applyXenons', function()
	local playerPed		= PlayerPedId()
    local coords		= GetEntityCoords(playerPed)

    if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoHudText('error', "Cannot Install while inside vehicle")
        ClearPedTasks(playerPed)
        return
    end
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
		local vehicle = nil
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
		end
		if DoesEntityExist(vehicle) then
			playAnim("mini@repair", "fixing_a_ped", 35000)
			CreateThread(function()
                local finished = exports["np-taskbarskill"]:taskBar(1700,math.random(7,14))
                if finished ~= 100 then
					exports['mythic_notify']:DoHudText('error', 'Xenon Headlight installation failed!')
					ClearPedTasks(playerPed) 
				else
					exports['mythic_notify']:DoHudText('success', 'Success! Installing Xenon Headlights')
					FreezeEntityPosition(playerPed, true)
					time = math.random(3000,7000)
					exports['progressBars']:startUI(time, 'Installing Xenon Headlights')
					SetVehicleModKit(vehicle, 0)
					ToggleVehicleMod(vehicle, 22, true)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					CurrentVehicleData = ESX.Game.GetVehicleProperties(vehicle)
					TriggerServerEvent('updateVehicle', CurrentVehicleData)
					TriggerServerEvent('doj-vehs:removeXenon')
                end
			end)
		end
	else
		exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)