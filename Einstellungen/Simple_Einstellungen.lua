SimpleScripts = {}

SimpleScripts.MindestSchwarzgeldMenge = 100

SimpleScripts.WaschKosteninProzent = 0.1

--STANDART NOTFIY von SIMPLESCRIPTS.eu | Dafür muss SimpleNotify Installiert sein!
SimpleScripts.SimpleNotify = true

--CUSTOM NOTIFY
SimpleScripts.UseCustomNotify = false

SimpleScripts.AnzeigeHeader = "Information"
SimpleScripts.AnzeigeText = "Drücke [ E ] um auf die Geldwäscherei zuzugreifen."
SimpleScripts.AnzeigeFarbe = "WHITE"
SimpleScripts.GeldGewaschenHeader = "Information"
SimpleScripts.GeldGewaschenText1 = "Du hast gerade "
SimpleScripts.GeldGewaschenText2 =" Schwarzgeld gewaschen!"
SimpleScripts.GeldGewaschenFarbe = "GREEN"
SimpleScripts.NichtMinSchwarzgeldHeader = "Information"
SimpleScripts.NichtMinSchwarzgeldText = "Du hast nicht genug Schwarzgeld!"
SimpleScripts.NichtMinSchwarzgeldFarbe = "RED"
SimpleScripts.NichtGeldWaschkostenHeader = "Information"
SimpleScripts.NichtGeldWaschkostenText = "Du hast nicht genug Schwarzgeld, um die Waschkosten zu decken!"
SimpleScripts.NichtGeldWaschkostenFarbe = "RED"
SimpleScripts.NichtGenugSchwarzgeldHeader = "Information"
SimpleScripts.NichtGenugSchwarzgeldText = "Du hast nicht genug Schwarzgeld, um die Geldwäsche durchzuführen!"
SimpleScripts.NichtGenugSchwarzgeldFarbe = "WHITE"
SimpleScripts.GeldGewaschen55Header = "Information"
SimpleScripts.GeldGewaschen55Text = "Du hast gerade 50.000$ Schwarzgeld gewaschen!"
SimpleScripts.GeldGewaschen55Farbe = "GREEN"
SimpleScripts.GeldGewaschen275Header = "Information"
SimpleScripts.GeldGewaschen275Text = "Du hast gerade 250.000$ Schwarzgeld gewaschen!"
SimpleScripts.GeldGewaschen275Farbe = "GREEN"
SimpleScripts.GeldGewaschen550Header = "Information"
SimpleScripts.GeldGewaschen550Text = "Du hast gerade 550.000$ Schwarzgeld gewaschen!"
SimpleScripts.GeldGewaschen550Farbe = "GREEN"
 
function SimpleNotify(color, title, msg)
    TriggerEvent('notifications', color, title, msg) -- Dein Notify Client Trigger, falls du eine eigene Nutzt.
end

function SimpleNotifyServer(source, color, title, msg)
    TriggerClientEvent('notifications', source, color, title, msg) -- Dein Notify Server Trigger, falls du eine eigene Nutzt.
end

SimpleScripts.NPC = {
    ["NpcModel"] = "s_m_y_dealer_01", 
    ["Scenario"] = "WORLD_HUMAN_SMOKING",
    ["Position"] = {
        ["x"] = 1074.0588378906,
        ["y"] = -2450.7536621094,
        ["z"] = 29.122821807861,
        ["h"] = 118.07751464844
    },
}