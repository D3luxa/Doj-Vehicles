ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

--========================================================= CheckTunes
Citizen.CreateThread(function()
    local peds = {
        `s_m_y_xmech_02`,
    }
    
	exports['qtarget']:AddTargetModel(peds, {
		options = {
			{
				event = "doj-vehs:checkVehicleMods",
				icon = "fas fa-car",
				label = "Check tuning",
			},
		},
		job = {"all"},
		distance = 10.0
	}) 
end)

local ImportShop= {
	{934.401, -966.435, 38.753 ,218.689, "s_m_y_xmech_02"},
	{130.925, -3029.502, 6.041 ,252.643, "s_m_y_xmech_02"},
}
CreateThread(function()
	for _,v in pairs(ImportShop) do
		RequestModel(GetHashKey(v[5]))
	  	while not HasModelLoaded(GetHashKey(v[5])) do
			Wait(1)
	  	end
	  	RequestAnimDict("amb@world_human_smoking@male@male_a@base")
	  	while not HasAnimDictLoaded("amb@world_human_smoking@male@male_a@base") do
			Wait(1)
	  	end
	  	ped =  CreatePed(0, v[5],v[1],v[2],v[3], false, false)
	  	SetEntityHeading(ped, v[4])
	  	FreezeEntityPosition(ped, true)
	  	SetEntityInvincible(ped, true)
	  	SetBlockingOfNonTemporaryEvents(ped, true)
	  	TaskPlayAnim(ped,"amb@world_human_smoking@male@male_a@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
	end
end)

RegisterNetEvent('doj-vehs:checkVehicleMods', function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsIn(ped, false)
	local time = 5000
	if IsPedInAnyVehicle(ped, false) then
		exports['progressBars']:startUI(time, 'Checking for Vehicle Mods...')
		SetVehicleEngineOn(veh, false, false, true)
		checkVehicleMods()
		SetVehicleEngineOn(veh, true, false, false)
	else
		exports['mythic_notify']:DoHudText('error', 'Cant help you without a vehicle!')
	end
end)

function checkVehicleMods()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	local vehProps = ESX.Game.GetVehicleProperties(vehicle)
	local model = GetEntityModel(vehicle)
	local modelName = GetDisplayNameFromVehicleModel(model)
	local modCount = GetNumVehicleMods(vehicle, modType)
	vehProps.modEngine = vehProps.modEngine + 1
	vehProps.modBrakes = vehProps.modBrakes + 1
	vehProps.modSuspension = vehProps.modSuspension + 1
	vehProps.modTransmission = vehProps.modTransmission + 1
	vehProps.windowTint = vehProps.windowTint + 1

	--local neon = {}
	--local r, g, b = GetVehicleNeonLightsColour(vehicle)
	--if r == 222 and g == 222 and b == 255 then -- White
	--	neon = 'White'
	--elseif r == 2 and g == 21 and b ==  255 then -- Blue
	--	neon = 'Blue'
	--elseif r == 3 and g == 83 and b == 255 then -- Electric blue
	--	neon = 'Electric blue'
	--elseif r == 0 and g == 255 and b == 140 then -- Mint green
	--	neon = 'Mint green'
	--elseif r == 94 and g == 255 and b == 1 then -- Lime green
	--	neon = 'Lime green'
	--elseif r == 255 and g == 255 and b == 0 then -- Yellow
	--	neon = 'Yellow'
	--elseif r == 255 and g == 150 and b == 0 then -- Golden shower
	--	neon = 'Golden shower'
	--elseif r == 255 and g == 62 and b == 0 then -- Orange
	--	neon = 'Orange'
	--elseif r == 255 and g == 1 and b == 1 then -- Red
	--	neon = 'Red'
	--elseif r == 255 and g == 50 and b == 100 then -- Pony pink
	--	neon = 'Pony pink'
	--elseif r == 255 and g == 5 and b == 190 then -- Hot pink
	--	neon = 'Hot pink'
	--elseif r == 35 and g == 1 and b == 255 then -- Purple
	--	neon = 'Purple'
	--elseif r == 15 and g == 3 and b == 255 then -- Blacklight
	--	neon = 'Blacklight'
	--end

	if Config.checkTunesMessage == "chat" then
		TriggerEvent('chat:addMessage', { 
			template = '<div class="chat-message-advert"><strong>Sport Race | Diagnostics</strong><br>Model: {0}<br>Tint: {1}<br>Brakes: {2}<br>Engine: {3}<br>Suspension: {4}<br>Transmission: {5}<br>Turbo: {6}<br>Headlights: {7}</div>',
			args = {
				modelName,
				tostring(vehProps.windowTint).. '/6',
				tostring(vehProps.modBrakes).. '/' .. GetNumVehicleMods(vehicle, 12),
				tostring(vehProps.modEngine).. '/' .. GetNumVehicleMods(vehicle,11),
				tostring(vehProps.modSuspension).. '/' .. GetNumVehicleMods(vehicle,15),
				tostring(vehProps.modTransmission).. '/' .. GetNumVehicleMods(vehicle,13),
				tostring(vehProps.modTurbo),
				tostring(vehProps.modXenon),
				--tostring(neon)
			} 
		})
		print(r,g,b)
		exports['mythic_notify']:DoHudText('success', 'Vehicle Mod List Recieved')
	end
end

--RegisterCommand('checkneon', function()
--	local ped = PlayerPedId()
--	local vehicle = GetVehiclePedIsIn(ped)
--	local neon = GetVehicleNeonLightsColour(vehicle)
--	print(neon)
--end)
