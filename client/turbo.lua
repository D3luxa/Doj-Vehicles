
ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--========================================================== Turbo
RegisterNetEvent('doj-vehs:applyTurbo', function()
	local playerPed	= PlayerPedId()
    local coords	= GetEntityCoords(playerPed)
    if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:DoHudText('error', 'Cannot Install while inside vehicle')
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
			SetVehicleEngineOn(vehicle, false, false,true)
			SetVehicleDoorOpen(vehicle, 4, false, false)
			local finished = exports["np-taskbarskill"]:taskBar(1700,math.random(7,14))
			if finished ~= 100 then
				exports['mythic_notify']:DoHudText('error', 'Turbo installation failed!')
				ClearPedTasks(playerPed)
			else
				--QBCore.Functions.Notify("Success! Installing Turbo", "success", 3500)
				exports['mythic_notify']:DoHudText('success', 'Success! Installing Turbo')
				FreezeEntityPosition(playerPed, true)
				time = math.random(7000,10000)
				--TriggerEvent('pogressBar:drawBar', time, 'Installing Turbo')
				exports['progressBars']:startUI(time, 'Installing Turbo')
				SetVehicleModKit(vehicle, 0)
				ToggleVehicleMod(vehicle, 18, true)
				SetVehicleEngineOn(vehicle, true, true)
				SetVehicleDoorShut(vehicle, 4, false)
				ClearPedTasks(playerPed)
				FreezeEntityPosition(playerPed, false)
				SetVehicleEngineOn(vehicle, false, false,false)
				CurrentVehicleData = ESX.Game.GetVehicleProperties(vehicle)
				TriggerServerEvent('updateVehicle', CurrentVehicleData)
				TriggerServerEvent('doj-vehs:removeTurbo')
			end
		end
	else
		exports['mythic_notify']:DoHudText('error', 'There is no vehicle nearby')
	end
end)

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do 
      Wait(0) 
    end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end