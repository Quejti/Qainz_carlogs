-- Webhook URL (paste your Discord webhook link)
local webhookURL = "https://discord.com/api/webhooks/1304546366323822643/S_nJnCjIF7da7vsy2NPywBLebOQhrJSMpn7bEdrZ-BP20byPLGVgBoOSoFgfdEOm-Ky4"

local function sendToDiscord(playerName, playerId, vehicleName)
    local time = os.date("%Y-%m-%d %H:%M:%S")
    local embed = {
        {
            ["title"] = "QUEJTI_LOGS",
            ["color"] = 16711680, -- color (RED)
            ["fields"] = {
                {["name"] = "Player Nickname", ["value"] = playerName, ["inline"] = true},
                {["name"] = "Player ID", ["value"] = tostring(playerId), ["inline"] = true},
                {["name"] = "Vehicle", ["value"] = vehicleName, ["inline"] = true},
                {["name"] = "Date & Time", ["value"] = time, ["inline"] = false},
            },
            ["footer"] = {
                ["text"] = "WHAT VEHICLE THE PLAYER HAS SPAWNED",
            },
        }
    }

    PerformHttpRequest(webhookURL, function(err, text, headers)
        if err ~= 200 then
            print("[ERROR] Webhook returned an error code: " .. tostring(err))
        else
            print("[INFO] Log posted on Discord.")
        end
    end, "POST", json.encode({username = "QUEJTI_LOGS", embeds = embed}), {["Content-Type"] = "application/json"})
end

RegisterServerEvent("custom:vehicleSpawned")
AddEventHandler("custom:vehicleSpawned", function(vehicleName)
    local src = source
    local playerName = GetPlayerName(src)
    local playerId = src

    sendToDiscord(playerName, playerId, vehicleName)

    print(string.format("[QUEJTI_LOGS]: Player: %s (ID: %d) spawned vehicle: %s", playerName, playerId, vehicleName))
end)

