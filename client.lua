local lastVehicle = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        local playerPed = PlayerPedId()
        if IsPedInAnyVehicle(playerPed, true) then
            local currentVehicle = GetVehiclePedIsIn(playerPed, false)
            local driver = GetPedInVehicleSeat(currentVehicle, -1)
            
            if driver == playerPed and currentVehicle ~= lastVehicle then
                local vehicleModel = GetEntityModel(currentVehicle)
                local vehicleName = GetDisplayNameFromVehicleModel(vehicleModel)
                
                TriggerServerEvent("custom:vehicleSpawned", vehicleName)

                lastVehicle = currentVehicle
            end
        else
            
            lastVehicle = nil
        end
    end
end)
