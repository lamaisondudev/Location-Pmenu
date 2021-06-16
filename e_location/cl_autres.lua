
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	Citizen.Wait(0)
    end  
end)

----------------------------- Location ------------------------------------

local location = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {255, 255, 255}, Title = "Location auto/moto" },
    Data = { currentMenu = "Liste des véhicules :", "Test"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)
         
            if btn.name == "Twizy" then   
                TriggerServerEvent('buyauto')
                spawncar("twizy")
                ESX.ShowAdvancedNotification("Location", "Votre ~b~véhicule ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Va a l'arrière boutique !", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "tu retrouvera ton véhicule", "", "CHAR_CARSITE", 1)
            elseif btn.name == "Scooter" then
                TriggerServerEvent('buyscoot')
                spawncar("faggio")
                ESX.ShowAdvancedNotification("Location", "Votre ~b~moto ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Va a l'arrière boutique !", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "tu retrouvera ton véhicule", "", "CHAR_CARSITE", 1)
            elseif btn.name == "BMX" then 
                TriggerServerEvent('buybmx')
                spawncar("bmx")
                ESX.ShowAdvancedNotification("Location", "Votre ~b~vélo ~w~à été livré avec ~g~succés ~w~!", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Bonne route !", "", "CHAR_CARSITE", 1)
                ESX.ShowAdvancedNotification("Location", "Va a l'arrière boutique !", "", "CHAR_CARSITE", 1) 
                ESX.ShowAdvancedNotification("Location", "tu retrouvera ton véhicule", "", "CHAR_CARSITE", 1)  
            elseif btn.name == "~r~Poser la tablette" then   
                CloseMenu(true)
            end 
    end,
},
    Menu = {
        ["Liste des véhicules :"] = {
            b = {
                {name = "Twizy", ask = '~g~150$', askX = true},
                {name = "Scooter", ask = '~g~150$', askX = true},
                {name = "BMX", ask = '~g~25$', askX = true},
                {name = "~r~Poser la tablette", ask = '', askX = true},
            }
        }
    }
} 

function spawncar(car)
    local car = GetHashKey(car)
    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)   
    end


    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, -1044.11, -2673.80, 13.97, 321.85, true, false)
    SetEntityAsNoLongerNeeded(vehicle) 
    SetVehicleNumberPlateText(vehicle, "LOCATION")
end 

local loc = { 
    {x = -1042.14, y = -2677.04, z = 13.83}
}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(loc) do
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, loc[k].x, loc[k].y, loc[k].z)
            if dist <= 1.5 then
                DrawMarker(23, -1042.14, -2677.04, 12.97, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.2, 1.2, 1.2, 0, 0, 255, 255, 0, 0, 2, 1, nil, nil, 0)
                ESX.ShowHelpNotification("Appuyez sur ~g~E~s~ pour voir les véhicules")
                if IsControlJustPressed(1,38) then 			
                    CreateMenu(location)
         end end end end end)

-- Blips

local blips = {
    {title="~b~Location", colour=3, id=315, x = -1040.69, y = -2668.59, z = 13.98}
}

Citizen.CreateThread(function()

    for _, info in pairs(blips) do
        info.blip = AddBlipForCoord(info.x, info.y, info.z)
        SetBlipSprite(info.blip, info.id)
        SetBlipDisplay(info.blip, 4)
        SetBlipScale(info.blip, 0.9)
        SetBlipColour(info.blip, info.colour)
        SetBlipAsShortRange(info.blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(info.title)
        EndTextCommandSetBlipName(info.blip)
    end
end)
