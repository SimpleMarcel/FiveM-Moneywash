local PlayerData = {}
local currentMoney = 0
local currentblackMoney = 0
local currentWashCost = 0
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local isMenuOpen = false

local notifyShown = false 

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(4)
        local coords = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(coords, SimpleScripts.NPC["Position"]["x"], SimpleScripts.NPC["Position"]["y"], SimpleScripts.NPC["Position"]["z"], true)
        
        if distance <= 3 then
            if not notifyShown then
                if SimpleScripts.SimpleNotify == true then
                    TriggerEvent('SimpleNotify', "Success", SimpleScripts.AnzeigeText)
                    end
                    if SimpleScripts.UseCustomNotify == true then
                    SimpleNotifyServer(SimpleScripts.AnzeigeFarbe, SimpleScripts.AnzeigeHeader, SimpleScripts.AnzeigeText)
                end
                notifyShown = true 
            end
            
            if IsControlJustReleased(0, 38) then
            if isMenuOpen == false then
                if IsControlJustReleased(0, 38) then
                    ESX.TriggerServerCallback('Simple_Moneywash:GetData', function(blackmoney, money) 
                        currentblackMoney = blackmoney
                        currentMoney = money
                        currentWashCost = math.ceil(blackmoney * SimpleScripts.WaschKosteninProzent)
                        if SimpleScripts.MindestSchwarzgeldMenge and SimpleScripts.MindestSchwarzgeldMenge > 0 then
                            if currentblackMoney >= SimpleScripts.MindestSchwarzgeldMenge then
                                SetDisplay(true)
                                isMenuOpen = true
                            else
                                if SimpleScripts.SimpleNotify == true then
                                    TriggerEvent('SimpleNotify', "Error", SimpleScripts.NichtMinSchwarzgeldText)
                                    end
                                    if SimpleScripts.UseCustomNotify == true then
                                    SimpleNotifyServer(SimpleScripts.NichtMinSchwarzgeldFarbe, SimpleScripts.NichtMinSchwarzgeldHeader, SimpleScripts.NichtMinSchwarzgeldText)
                                end
                            end
                        else
                            SetDisplay(true)
                            isMenuOpen = true
                        end
                    end)
                    Citizen.Wait(500)
                end
            end
        end
        else
            notifyShown = false
        end
    end
end)

RegisterNUICallback("EXIT", function(data) 
    SetDisplay(false)
    isMenuOpen = false
end)

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
        currentblackMoney = currentblackMoney,
        currentMoney = currentMoney,
        currentWashCost = currentWashCost,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)
        DisableControlAction(0, 1, display)
        DisableControlAction(0, 2, display)
        DisableControlAction(0, 142, display)
        DisableControlAction(0, 18, display) 
        DisableControlAction(0, 322, display) 
        DisableControlAction(0, 106, display) 
    end
end)

_RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end

Citizen.CreateThread(function()
    local pedPosition = SimpleScripts.NPC["Position"]
    local NpcModel = GetHashKey(SimpleScripts.NPC["NpcModel"])

    RequestModel(NpcModel)
    while not HasModelLoaded(NpcModel) do
        Wait(1)
    end

    local npc = CreatePed(4, NpcModel, pedPosition["x"], pedPosition["y"], pedPosition["z"], pedPosition["h"], false, true)
    SetEntityAsMissionEntity(npc, true, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetEntityInvincible(npc, true)
    SetPedCanRagdoll(npc, false)
    TaskStartScenarioInPlace(npc, SimpleScripts.NPC["Scenario"], 0, true)
end)


RegisterNUICallback("GO", function(data) 
    SetDisplay(false) 
    isMenuOpen = false
    TriggerServerEvent("Simple_Moneywash:3636324")
end)

RegisterNUICallback("Angebot1", function(data) 
    SetDisplay(false) 
    isMenuOpen = false
    TriggerServerEvent("Simple_Moneywash:Angebot1")
end)

RegisterNUICallback("Angebot2", function(data) 
    SetDisplay(false) 
    isMenuOpen = false
    TriggerServerEvent("Simple_Moneywash:Angebot2")
end)

RegisterNUICallback("Angebot3", function(data) 
    SetDisplay(false) 
    isMenuOpen = false
    TriggerServerEvent("Simple_Moneywash:Angebot3")
end)

RegisterNUICallback("CustomOffer", function(data)
    local customAmount = data.amount
    SetDisplay(false)
    isMenuOpen = false
    TriggerServerEvent("Simple_Moneywash:CustomOffer", customAmount)
end)