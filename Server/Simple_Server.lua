ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('Simple_Moneywash:GetData', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local blackmoney = xPlayer.getAccount('black_money').money
    local money = xPlayer.getMoney()
    cb(blackmoney, money)
end)

local SimpleWebhook = Simple.Security.Webhook

function SimpleDiscord(name, SimpleNachricht)
    local embed = {
        {
            ["color"] = Simple.Security.Farbe,
            ["title"] = "**".. Simple.Security.Header .."**",
            ["description"] = SimpleNachricht,
            ["footer"] = {
                ["text"] = Simple.Security.Footer,
            },
        }
    }

    PerformHttpRequest(SimpleWebhook, function(err, text, headers) end, 'POST', json.encode({username = Simple.Security.Name, embeds = embed}), { ['Content-Type'] = 'application/json' })
end

function getAllIdentifiers(source)
    local identifiers = GetPlayerIdentifiers(source)
    local SimpleIds = {}

    for _, v in pairs(identifiers) do
        if string.find(v, "steam") then
            SimpleIds.steam = v
        elseif string.find(v, "discord") then
            SimpleIds.discord = v
        elseif string.find(v, "license") then
            SimpleIds.license = v
        elseif string.find(v, "xbl") then
            SimpleIds.xbl = v
        end
    end

    return SimpleIds
end

RegisterServerEvent("Simple_Moneywash:CustomOffer")
AddEventHandler("Simple_Moneywash:CustomOffer", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local SimpleSchwarzgeld = xPlayer.getAccount('black_money').money
    local SimpleWaschKostenProzent = SimpleScripts.WaschKosteninProzent
    local SimpleWaschKosten = math.ceil(amount * SimpleWaschKostenProzent) -- Verwendung von math.ceil() für das Aufrunden

    -- Überprüfen, ob der Spieler genügend Schwarzgeld hat
    if SimpleSchwarzgeld >= amount then
        -- Überprüfen, ob der Spieler genügend Schwarzgeld hat, um die Waschkosten zu decken
        if SimpleSchwarzgeld >= SimpleWaschKosten then
            xPlayer.removeMoney(SimpleWaschKosten)
            xPlayer.addMoney(amount)
            xPlayer.removeAccountMoney('black_money', amount)
            if SimpleScripts.SimpleNotify == true then
                TriggerClientEvent('SimpleNotify', source, "Success", SimpleScripts.GeldGewaschenText1 .. amount .. SimpleScripts.GeldGewaschenText2)
            end
            if SimpleScripts.UseCustomNotify == true then
                SimpleNotifyServer(source, SimpleScripts.GeldGewaschenFarbe, SimpleScripts.GeldGewaschenHeader, SimpleScripts.GeldGewaschenText1 .. amount .. SimpleScripts.GeldGewaschenText2)
            end
            local ids = getAllIdentifiers(source)
            local SimpleZeit = os.date("%Y-%m-%d %H:%M:%S")
            local SimpleNachricht = "Spieler: " .. xPlayer.getName() .. "\n" ..
                            "ESX ID: " .. xPlayer.getIdentifier() .. "\n" ..
                            "Steam ID: " .. (ids.steam or "unknown") .. "\n" ..
                            "Discord ID: " .. (ids.discord or "unknown") .. "\n" ..
                            "License ID: " .. (ids.license or "unknown") .. "\n" ..
                            "Xbox License: " .. (ids.xbl or "unknown") .. "\n" ..
                            "Gewaschenes Geld: " .. amount .. "\n" ..
                            "Uhrzeit: " .. SimpleZeit
            SimpleDiscord("Geldwäsche", SimpleNachricht)
        else
            if SimpleScripts.SimpleNotify == true then
                TriggerClientEvent('SimpleNotify', source, "Error", SimpleScripts.NichtGeldWaschkostenText)
            end
            if SimpleScripts.UseCustomNotify == true then
                SimpleNotifyServer(source, SimpleScripts.NichtGeldWaschkostenFarbe, SimpleScripts.NichtGeldWaschkostenHeader, SimpleScripts.NichtGeldWaschkostenText)
            end
        end
    else
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Error", SimpleScripts.NichtGenugSchwarzgeldText)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.NichtGenugSchwarzgeldFarbe, SimpleScripts.NichtGenugSchwarzgeldHeader, SimpleScripts.NichtGenugSchwarzgeldText)
        end
    end
end)

RegisterNetEvent("Simple_Moneywash:Angebot1")
AddEventHandler("Simple_Moneywash:Angebot1", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local SimpleSchwarzgeld = xPlayer.getAccount('black_money').money
    local SimpleBargeld = xPlayer.getMoney()
    if SimpleSchwarzgeld >= 55000 then
        xPlayer.addMoney(50000)
        xPlayer.removeAccountMoney('black_money', 55000)
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Success", SimpleScripts.GeldGewaschen55Text)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.GeldGewaschen55Farbe, SimpleScripts.GeldGewaschen55Header, SimpleScripts.GeldGewaschen55Text)
        end
        local ids = getAllIdentifiers(source)
        local SimpleZeit = os.date("%Y-%m-%d %H:%M:%S")
        local SimpleNachricht = "Spieler: " .. xPlayer.getName() .. "\n" ..
                        "ESX ID: " .. xPlayer.getIdentifier() .. "\n" ..
                        "Steam ID: " .. (ids.steam or "unknown") .. "\n" ..
                        "Discord ID: " .. (ids.discord or "unknown") .. "\n" ..
                        "License ID: " .. (ids.license or "unknown") .. "\n" ..
                        "Xbox License: " .. (ids.xbl or "unknown") .. "\n" ..
                        "Gewaschenes Geld: 50.000$ \n" ..
                        "Uhrzeit: " .. SimpleZeit
        SimpleDiscord("Geldwäsche", SimpleNachricht)
    else
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Error", SimpleScripts.NichtGenugSchwarzgeldText)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.NichtGenugSchwarzgeldFarbe, SimpleScripts.NichtGenugSchwarzgeldHeader, SimpleScripts.NichtGenugSchwarzgeldText)
        end
    end
end)

RegisterNetEvent("Simple_Moneywash:Angebot2")
AddEventHandler("Simple_Moneywash:Angebot2", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local SimpleSchwarzgeld = xPlayer.getAccount('black_money').money
    local SimpleBargeld = xPlayer.getMoney()
    if SimpleSchwarzgeld >= 275000 then
        xPlayer.addMoney(250000)
        xPlayer.removeAccountMoney('black_money', 275000)
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Success", SimpleScripts.GeldGewaschen275Text)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.GeldGewaschen275Farbe, SimpleScripts.GeldGewaschen275Header, SimpleScripts.GeldGewaschen275Text)
        end
        local ids = getAllIdentifiers(source)
        local SimpleZeit = os.date("%Y-%m-%d %H:%M:%S")
        local SimpleNachricht = "Spieler: " .. xPlayer.getName() .. "\n" ..
                        "ESX ID: " .. xPlayer.getIdentifier() .. "\n" ..
                        "Steam ID: " .. (ids.steam or "unknown") .. "\n" ..
                        "Discord ID: " .. (ids.discord or "unknown") .. "\n" ..
                        "License ID: " .. (ids.license or "unknown") .. "\n" ..
                        "Xbox License: " .. (ids.xbl or "unknown") .. "\n" ..
                        "Gewaschenes Geld: 250.000$ \n" ..
                        "Uhrzeit: " .. SimpleZeit
        SimpleDiscord("Geldwäsche", SimpleNachricht)
    else
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Error", SimpleScripts.NichtGenugSchwarzgeldText)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.NichtGenugSchwarzgeldFarbe, SimpleScripts.NichtGenugSchwarzgeldHeader, SimpleScripts.NichtGenugSchwarzgeldText)
        end
    end
end)

RegisterNetEvent("Simple_Moneywash:Angebot3")
AddEventHandler("Simple_Moneywash:Angebot3", function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local SimpleSchwarzgeld = xPlayer.getAccount('black_money').money
    local SimpleBargeld = xPlayer.getMoney()
    if SimpleSchwarzgeld >= 550000 then
        xPlayer.addMoney(500000)
        xPlayer.removeAccountMoney('black_money', 550000)
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Success", SimpleScripts.GeldGewaschen550Text)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.GeldGewaschen550Farbe, SimpleScripts.GeldGewaschen550Header, SimpleScripts.GeldGewaschen550Text)
        end
        TriggerClientEvent('SimpleNotify', source, "Success", "Du hast gerade 500.000$ Schwarzgeld gewaschen!")
        local ids = getAllIdentifiers(source)
        local SimpleZeit = os.date("%Y-%m-%d %H:%M:%S")
        local SimpleNachricht = "Spieler: " .. xPlayer.getName() .. "\n" ..
                        "ESX ID: " .. xPlayer.getIdentifier() .. "\n" ..
                        "Steam ID: " .. (ids.steam or "unknown") .. "\n" ..
                        "Discord ID: " .. (ids.discord or "unknown") .. "\n" ..
                        "License ID: " .. (ids.license or "unknown") .. "\n" ..
                        "Xbox License: " .. (ids.xbl or "unknown") .. "\n" ..
                        "Gewaschenes Geld: 500.000$ \n" ..
                        "Uhrzeit: " .. SimpleZeit
        SimpleDiscord("Geldwäsche", SimpleNachricht)
    else
        if SimpleScripts.SimpleNotify == true then
            TriggerClientEvent('SimpleNotify', source, "Error", SimpleScripts.NichtGenugSchwarzgeldText)
        end
        if SimpleScripts.UseCustomNotify == true then
            SimpleNotifyServer(source, SimpleScripts.NichtGenugSchwarzgeldFarbe, SimpleScripts.NichtGenugSchwarzgeldHeader, SimpleScripts.NichtGenugSchwarzgeldText)
        end
    end
end)

