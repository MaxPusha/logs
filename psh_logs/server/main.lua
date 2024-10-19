function SendLogToDiscord(webhook, title, message, color)
    if webhook == '' then return end
    local embed = {
        {
            ["author"] = {
                ["name"] = 'Pusha Roleplay',
                ["icon_url"] = Pusha.Author
            },
            ["title"] = title,
            ["description"] = message,
            ["color"] = color,
            ["footer"] = {
                ["text"] = 'Pusha ©2024',
                ["icon_url"] = Pusha.Footer
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Pusha Logs", embeds = embed}), { ['Content-Type'] = 'application/json' })
end

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    SendLogToDiscord(Pusha.Webhooks.Connecting, "Connecting Log", "**" .. playerName .. "** verbindet sich mit dem Server.", 16776960)
end)

AddEventHandler('playerDropped', function(reason)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    SendLogToDiscord(Pusha.Webhooks.Disconnecting, "Disconnecting Log", "**" .. playerName .. "** hat den Server verlassen. Grund: " .. reason, 16776960)
end)

AddEventHandler('baseevents:onPlayerKilled', function(killerId, data)
    local victimName = GetPlayerName(source)
    local killerName = GetPlayerName(killerId)
    local weapon = data.weaponhash
    SendLogToDiscord(Pusha.Webhooks.Kill, "Kill Log", "**" .. killerName .. "** hat **" .. victimName .. "** mit Waffe " .. weapon .. " getötet.", 16776960)
end)

AddEventHandler('baseevents:onPlayerShot', function(shooterId, data)
    local shooterName = GetPlayerName(shooterId)
    local weapon = data.weaponhash
    SendLogToDiscord(Pusha.Webhooks.Shoot, "Shoot Log", "**" .. shooterName .. "** hat mit der Waffe " .. weapon .. " geschossen.", 16776960)
end)

RegisterCommand("adminaction", function(source, args, rawCommand)
    local playerId = source
    local playerName = GetPlayerName(playerId)
    local action = table.concat(args, " ")
    SendLogToDiscord(Pusha.Webhooks.Admin, "Admin Log", "**" .. playerName .. "** führte folgende Admin-Aktion durch: " .. action, 16776960)
end, true)

AddEventHandler('chatMessage', function(playerId, playerName, message)
    SendLogToDiscord(Pusha.Webhooks.Command, "Command Log", "**" .. playerName .. "** hat folgenden Befehl verwendet: " .. message, 16776960)
end)