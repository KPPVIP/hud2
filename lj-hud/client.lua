local ESX = nil
local isLoggedIn = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(30)-- Saniye Bekletme
  end
end)

-- lj-hud
local config = Config
local speedMultiplier = config.UseMPH and 2.23694 or 3.6
local seatbeltOn = false
local cruiseOn = false
local showAltitude = false
local showSeatbelt = false
local nos = 0
local stress = 0
local hunger = 100
local thirst = 100
local cashAmount = 0
local bankAmount = 0
local nitroActive = 0
local harness = 0
local hp = 100
local armed = 0
local parachute = -1
local oxygen = 100
local engine = 0
local dev = false
local playerDead = false

-- lj-menu 
local checklistSounds = true
local openMenuSounds = true
local resetHudSounds = true
local showOutMap = false
local showMapNotif = true
local showFuelAlert = true
local showCinematicNotif = true
local dynamicHealth = true
local dynamicArmor = true
local dynamicHunger = true
local dynamicThirst = true
local dynamicStress = true
local dynamicOxygen = true
local dynamicEngine = true
local dynamicNitro = true
local changeFPS = true
DisplayRadar(false)
local map = "circle"
local hideMap = false
local showMapBorders = true
-- lj-menu Callbacks & Events

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    isLoggedIn = true
end)

AddEventHandler('onResourceStart', function (resourceName)
    if(GetCurrentResourceName() == resourceName) then
        isLoggedIn = true
    end
end)

-- reset hud
RegisterNUICallback('restartHud', function()
    Wait(50)
    TriggerEvent("hud:client:playResetHudSounds")
    if IsPedInAnyVehicle(PlayerPedId()) then
        Wait(2600)
        SendNUIMessage({ action = 'car', show = false })
        SendNUIMessage({ action = 'car', show = true })
    end
    Wait(2600)
    SendNUIMessage({ action = 'hudtick', show = false })
    SendNUIMessage({ action = 'hudtick', show = true })
    Wait(2600)
    --TriggerEvent('QBCore:Notify', "Hud has been reset!", "success")

end) 

RegisterCommand('resethud', function()
    Wait(50)
    if IsPedInAnyVehicle(PlayerPedId()) then
        Wait(2600)
        SendNUIMessage({ action = 'car', show = false })
        SendNUIMessage({ action = 'car', show = true })
    end
    Wait(2600)
    SendNUIMessage({ action = 'hudtick', show = false })
    SendNUIMessage({ action = 'hudtick', show = true })
    Wait(2600)
    --TriggerEvent('QBCore:Notify', "Hud has been reset!", "success")
end)

-- notifications
RegisterNUICallback('openMenuSounds', function()
    Wait(50)
    TriggerEvent("hud:client:openMenuSounds")
end) 

RegisterNetEvent("hud:client:openMenuSounds", function()
    Wait(50)
    openMenuSounds = not openMenuSounds
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNetEvent("hud:client:playOpenMenuSounds", function()
    Wait(50)
    if openMenuSounds == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "houses_door_open", 0.5)
    end
end)

RegisterNUICallback('resetHudSounds', function()
    Wait(50)
    TriggerEvent("hud:client:resetHudSounds")
end) 

RegisterNetEvent("hud:client:resetHudSounds", function()
    Wait(50)
    resetHudSounds = not resetHudSounds
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNetEvent("hud:client:playResetHudSounds", function()
    Wait(50)
    if resetHudSounds == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "airwrench", 0.1)
    end
end)

RegisterNUICallback('checklistSounds', function()
    Wait(50)
    TriggerEvent("hud:client:checklistSounds")
end) 

RegisterNetEvent("hud:client:checklistSounds", function()
    Wait(50)
    checklistSounds = not checklistSounds
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNetEvent("hud:client:playHudChecklistSound", function()
    Wait(50)
    if checklistSounds == true then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "lock", 0.5)
    end
end)

RegisterNUICallback('showOutMap', function()
    Wait(50)
    TriggerEvent("hud:client:showOutMap")
end) 

RegisterNetEvent("hud:client:showOutMap", function()
    Wait(50)
    showOutMap = not showOutMap
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('showMapNotif', function()
    Wait(50)
    TriggerEvent("hud:client:showMapNotif")
end) 

RegisterNetEvent("hud:client:showMapNotif", function()
    Wait(50)
    showMapNotif = not showMapNotif
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('showFuelAlert', function()
    Wait(50)
    TriggerEvent("hud:client:showFuelAlert")
end) 

RegisterNetEvent("hud:client:showFuelAlert", function()
    Wait(50)
    showFuelAlert = not showFuelAlert
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('showCinematicNotif', function()
    Wait(50)
    TriggerEvent("hud:client:showCinematicNotif")
end) 

RegisterNetEvent("hud:client:showCinematicNotif", function()
    Wait(50)
    showCinematicNotif = not showCinematicNotif
    TriggerEvent("hud:client:playHudChecklistSound")
end)

-- status
RegisterNUICallback('dynamicHealth', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleHealth")
end) 

RegisterNetEvent("hud:client:ToggleHealth", function()
    Wait(50)
    dynamicHealth = not dynamicHealth
    TriggerEvent("hud:client:playHudChecklistSound")
end)
  
RegisterNetEvent("hud:client:ToggleArmor", function()
    Wait(50)
    dynamicArmor = not dynamicArmor
end)

RegisterNUICallback('dynamicArmor', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleArmor")
   TriggerEvent("hud:client:playHudChecklistSound")
end) 
  
RegisterNetEvent("hud:client:ToggleHunger", function()
    Wait(50)
    dynamicHunger = not dynamicHunger
end)

RegisterNUICallback('dynamicHunger', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleHunger")
    TriggerEvent("hud:client:playHudChecklistSound")
end) 

RegisterNetEvent("hud:client:ToggleThirst", function()
    Wait(50)
    dynamicThirst = not dynamicThirst
end)

RegisterNUICallback('dynamicThirst', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleThirst")
    TriggerEvent("hud:client:playHudChecklistSound")
end) 

RegisterNetEvent("hud:client:ToggleStress", function()
    Wait(50)
    dynamicStress = not dynamicStress
end)

RegisterNUICallback('dynamicStress', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleStress")
    TriggerEvent("hud:client:playHudChecklistSound")
end) 

RegisterNUICallback('dynamicOxygen', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleOxygen")
    TriggerEvent("hud:client:playHudChecklistSound")
end)   

RegisterNetEvent("hud:client:ToggleOxygen", function()
    Wait(50)
    dynamicOxygen = not dynamicOxygen
end)

-- vehicle
RegisterNUICallback('changeFPS', function()
    Wait(50)
    TriggerEvent("hud:client:changeFPS")
    TriggerEvent("hud:client:playHudChecklistSound")
end)   

RegisterNetEvent("hud:client:changeFPS", function()
    Wait(50)
    changeFPS = not changeFPS
end)

RegisterNUICallback('HideMap', function()
    Wait(50)
    TriggerEvent("hud:client:HideMap")
end) 

RegisterNetEvent("hud:client:LoadMap", function()
    Wait(50)
    -- Credit to Dalrae for the solve.
    local defaultAspectRatio = 1920/1080 -- Don't change this.
    local resolutionX, resolutionY = GetActiveScreenResolution()
    local aspectRatio = resolutionX/resolutionY
    local minimapOffset = 0
    if aspectRatio > defaultAspectRatio then
        minimapOffset = ((defaultAspectRatio-aspectRatio)/3.6)-0.008
    end

    if map == "square" then 
        RequestStreamedTextureDict("squaremap", false)
        if not HasStreamedTextureDictLoaded("squaremap") then
            Wait(50)
        end
        if showMapNotif == true then
            --TriggerEvent('QBCore:Notify', 'Square map loading...')
        end
            SetMinimapClipType(0)
            AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "squaremap", "radarmasksm")
            AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "squaremap", "radarmasksm")
            -- 0.0 = nav symbol and icons left 
            -- 0.1638 = nav symbol and icons stretched
            -- 0.216 = nav symbol and icons raised up
            SetMinimapComponentPosition("minimap", "L", "B", 0.0+minimapOffset, -0.047, 0.1638, 0.183)
    
            -- icons within map
            SetMinimapComponentPosition("minimap_mask", "L", "B", 0.2+minimapOffset, 0.0, 0.065, 0.20)
    
            -- -0.01 = map pulled left
            -- 0.025 = map raised up
            -- 0.262 = map stretched
            -- 0.315 = map shorten
            SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.01+minimapOffset, 0.025, 0.262, 0.300)
            SetBlipAlpha(GetNorthRadarBlip(), 0)
            SetRadarBigmapEnabled(true, false)
            SetMinimapClipType(0)
            Wait(50)
            SetRadarBigmapEnabled(false, false)
        if showMapBorders == true then
            showCircleB = false
            showSquareB = true
        end
        Wait(1200)
        if showMapNotif == true then
            --TriggerEvent('QBCore:Notify', 'Square map loaded!')
        end
        elseif map == "circle" then 
            RequestStreamedTextureDict("circlemap", false)
            if not HasStreamedTextureDictLoaded("circlemap") then
                Wait(50)
            end
            if showMapNotif == true then
                --TriggerEvent('QBCore:Notify', 'Circle map loading...')
            end
                SetMinimapClipType(1)
                AddReplaceTexture("platform:/textures/graphics", "radarmasksm", "circlemap", "radarmasksm")
                AddReplaceTexture("platform:/textures/graphics", "radarmask1g", "circlemap", "radarmasksm")
                -- -0.0100 = nav symbol and icons left 
                -- 0.180 = nav symbol and icons stretched
                -- 0.258 = nav symbol and icons raised up
                SetMinimapComponentPosition("minimap", "L", "B", -0.0100+minimapOffset, -0.030, 0.180, 0.258)
    
                -- icons within map
                SetMinimapComponentPosition("minimap_mask", "L", "B", 0.200+minimapOffset, 0.0, 0.065, 0.20)
    
                -- -0.00 = map pulled left
                -- 0.015 = map raised up
                -- 0.252 = map stretched
                -- 0.338 = map shorten
                SetMinimapComponentPosition('minimap_blur', 'L', 'B', -0.00+minimapOffset, 0.015, 0.252, 0.338)
                SetBlipAlpha(GetNorthRadarBlip(), 0)
                SetMinimapClipType(1)
                SetRadarBigmapEnabled(true, false)
                Wait(50)
                SetRadarBigmapEnabled(false, false)
                if showMapBorders == true then
                    showSquareB = false
                    showCircleB = true
                end
                Wait(1200)
            if showMapNotif == true then
                --TriggerEvent('QBCore:Notify', 'Circle map loaded!')
            end
        end
end)

RegisterNetEvent("hud:client:HideMap", function()
    Wait(50)
    hideMap = not hideMap
    if hideMap == true then
        DisplayRadar(false)
    else 
        DisplayRadar(true)
    end
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('ToggleMapShape', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleMapShape")
end) 

RegisterNetEvent("hud:client:ToggleMapShape", function()
    Wait(50)
    if hideMap == false then
    if map == "circle" then 
        map = "square"
    else 
        map = "circle"
    end
    TriggerEvent("hud:client:LoadMap")   
    end 
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('ToggleMapBorders', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleMapBorders")
end) 

RegisterNetEvent("hud:client:ToggleMapBorders", function()
    Wait(50)
    showMapBorders = not showMapBorders
    if showMapBorders == false then
        showSquareB = false
        showCircleB = false
    elseif showMapBorders == true then 
        if map == "square" then
            showSquareB = true
        else 
            showCircleB = true
        end
    end
        TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('dynamicEngine', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleEngine")
end) 

RegisterNetEvent("hud:client:ToggleEngine", function()
    Wait(50)
    dynamicEngine = not dynamicEngine
    TriggerEvent("hud:client:playHudChecklistSound")
end)
 
RegisterNUICallback('dynamicNitro', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleNitro")
end) 

RegisterNetEvent("hud:client:ToggleNitro", function()
    Wait(50)
    dynamicNitro = not dynamicNitro
    TriggerEvent("hud:client:playHudChecklistSound")
end)

RegisterNUICallback('cinematicMode', function()
    Wait(50)
    TriggerEvent("hud:client:ToggleCinematic")
end) 

RegisterNetEvent("hud:client:ToggleCinematic", function()
    Wait(50)
    cinematic = not cinematic
    if CinematicModeOn == true then
        CinematicShow(false)
        CinematicModeOn = false
        if showCinematicNotif == true then
       -- TriggerEvent('QBCore:Notify', 'Cinematic mode off!', 'error')
        end
        DisplayRadar(1)
    elseif CinematicModeOn == false then
        CinematicShow(true)
        CinematicModeOn = true
        if showCinematicNotif == true then
      --  TriggerEvent('QBCore:Notify', 'Cinematic mode on!')
        end
    end
    TriggerEvent("hud:client:playHudChecklistSound")

end)


RegisterNetEvent("hud:client:EngineHealth", function(newEngine)
    engine = newEngine
end)

RegisterNetEvent('hud:client:ToggleAirHud', function()
    showAltitude = not showAltitude
end)

RegisterNetEvent('hud:client:UpdateNeeds', function(newHunger, newThirst) -- Triggered in qb-core
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress) -- Add this event with adding stress elsewhere
    stress = newStress
end)

RegisterNetEvent('hud:client:ToggleShowSeatbelt', function()
    showSeatbelt = not showSeatbelt
end)

RegisterNetEvent('seatbelt:client:ToggleSeatbelt', function() -- Triggered in smallresources
    seatbeltOn = not seatbeltOn
end)

RegisterNetEvent('seatbelt:client:ToggleCruise', function() -- Triggered in smallresources
    cruiseOn = not cruiseOn
end)

RegisterNetEvent('hud:client:UpdateNitrous', function(hasNitro, nitroLevel, bool)
    nos = nitroLevel
    nitroActive = bool
end)

RegisterNetEvent('hud:client:UpdateHarness', function(harnessHp)
    hp = harnessHp
end)

-- RegisterNetEvent("qb-admin:client:ToggleDevmode", function()
--     dev = not dev
-- end)

RegisterCommand('+engine', function()
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
        if (GetIsVehicleEngineRunning(vehicle)) then
            --QBCore.Functions.Notify('Engine halted!', "error")
        else
            --QBCore.Functions.Notify('Engine started!')
        end
        SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
    end
end)

RegisterKeyMapping('+engine', 'Toggle Engine', 'keyboard', 'G')


local function IsWhitelistedWeaponArmed(weapon)
    if weapon ~= nil then
        for _, v in pairs(config.WhitelistedWeaponArmed) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

local prevPlayerStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updatePlayerHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevPlayerStats[k] ~= v then
            shouldUpdate = true
            break
        end
    end
    prevPlayerStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'hudtick',
            show = data[1],
            dynamicHealth = data[2],
            dynamicArmor = data[3],
            dynamicHunger = data[4],
            dynamicThirst = data[5],
            dynamicStress = data[6],
            dynamicOxygen = data[7],
            dynamicEngine = data[8],
            dynamicNitro = data[9],
            health = data[10],
            playerDead = data[11],
            armor = data[12],
            thirst = data[13],
            hunger = data[14],
            stress = data[15],
            voice = data[16],
            radio = data[17],
            talking = data[18],
            armed = data[19],
            oxygen = data[20],
            parachute = data[21],
            nos = data[22],
            cruise = data[23],
            nitroActive = data[24],
            harness = data[25],
            hp = data[26],
            speed = data[27],
            engine = data[28],
            cinematic = data[29],
            dev = data[30],
        })
    end
end

local prevVehicleStats = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }

local function updateVehicleHud(data)
    local shouldUpdate = false
    for k, v in pairs(data) do
        if prevVehicleStats[k] ~= v then shouldUpdate = true break end
    end
    prevVehicleStats = data
    if shouldUpdate then
        SendNUIMessage({
            action = 'car',
            show = data[1],
            isPaused = data[2],
            seatbelt = data[3],
            speed = data[4],
            fuel = data[5],
            altitude = data[6],
            showAltitude = data[7],
            showSeatbelt = data[8],
            showSquareB = data[9],
            showCircleB = data[10],
        })
    end
end

local lastFuelUpdate = 0
local lastFuelCheck = {}

local function getFuelLevel(vehicle)
    local updateTick = GetGameTimer()
    if (updateTick - lastFuelUpdate) > 2000 then
        lastFuelUpdate = updateTick
        lastFuelCheck = math.floor(GetVehicleFuelLevel(vehicle))
    end
    return lastFuelCheck
end

-- HUD Update loop
local voicenew = 1

function setVoiceMode(voicerange)
    if voicerange == 0 then
        voicenew = 1
    elseif voicerange == 1 then
        voicenew = 3 
    elseif voicerange == 2 then
        voicenew = 5
    end
end

local playertalking = false

function playernowTalking(yesno)
    playertalking = yesno
end

CreateThread(function()
    local wasInVehicle = false;
    local mapLoaded = false
    while true do
        if changeFPS == true then
            Wait(1000)
        elseif changeFPS == false then
            Wait(50)
        end
        if isLoggedIn then
            local show = true  
            local player = PlayerPedId()
            local weapon = GetSelectedPedWeapon(player)
            -- player hud
            if not mapLoaded then
                TriggerEvent("hud:client:LoadMap") 
                mapLoaded=true
            end
            if not IsWhitelistedWeaponArmed(weapon) then
                if weapon ~= `WEAPON_UNARMED` then
                    armed = true
                else
                    armed = false
                end
            end
            if IsPedDeadOrDying(player) then
                playerDead=true
        
            else
                playerDead=false
            end    
            parachute = GetPedParachuteState(PlayerPedId())
            -- stamina
            if not IsEntityInWater(PlayerPedId()) then
                oxygen = 100 - GetPlayerSprintStaminaRemaining(PlayerId())  
            end
            -- oxygen
            if IsEntityInWater(PlayerPedId()) then
                oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10
            end
            -- player hud
            local talking = playertalking
            voice = voicenew
            if IsPauseMenuActive() then
                show = false
            end
            if not ( IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle) ) then
            updatePlayerHud({
                show, 
                dynamicHealth,
                dynamicArmor,
                dynamicHunger,
                dynamicThirst,
                dynamicStress,
                dynamicOxygen,
                dynamicEngine,
                dynamicNitro,
                GetEntityHealth(player) - 100,
                playerDead,
                GetPedArmour(player),
                thirst,
                hunger,
                stress,
                voice,
                LocalPlayer.state['radioChannel'],
                talking,
                armed,
                oxygen,
                GetPedParachuteState(player),
                -1,
                cruiseOn,
                nitroActive,
                harness,
                hp,
                math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                -1,
                cinematic,
                dev,
            }) 
            end
            -- vehcle hud
            local vehicle = GetVehiclePedIsIn(player)
            if IsPedInAnyHeli(player) or IsPedInAnyPlane(player) then
                showAltitude = true
                showSeatbelt = false
            end
            if IsPedInAnyVehicle(player) and not IsThisModelABicycle(vehicle) then
                if not wasInVehicle then
                    DisplayRadar(true)
                end
                wasInVehicle = true
                ESX.TriggerServerCallback('hud:server:HasHarness', function(hasItem)
                    if hasItem then
                        harness = true
                    else
                        harness = false
                    end
                end, "harness")
                updatePlayerHud({
                    show, 
                    dynamicHealth,
                    dynamicArmor,
                    dynamicHunger,
                    dynamicThirst,
                    dynamicStress,
                    dynamicOxygen,
                    dynamicEngine,
                    dynamicNitro,
                    GetEntityHealth(player) - 100,
                    playerDead,
                    GetPedArmour(player),
                    thirst,
                    hunger,
                    stress,
                    voice,
                    LocalPlayer.state['radioChannel'],
                    talking,
                    armed,
                    oxygen,
                    GetPedParachuteState(player),
                    nos,
                    cruiseOn,
                    nitroActive,
                    harness,
                    hp,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    (GetVehicleEngineHealth(vehicle) /10),
                    cinematic,
                    dev,
                })
                updateVehicleHud({
                    show,
                    IsPauseMenuActive(),
                    seatbeltOn,
                    math.ceil(GetEntitySpeed(vehicle) * speedMultiplier),
                    getFuelLevel(vehicle),
                    math.ceil((GetEntityCoords(player).z *.5)),
                    showAltitude,
                    showSeatbelt,
                    showSquareB,
                    showCircleB,
                })
                showAltitude = false
                showSeatbelt = true
            else
                if wasInVehicle then
                    wasInVehicle = false
                    SendNUIMessage({
                        action = 'car',
                        show = false,
                        seatbelt = false,
                        cruise = false,
                    })
                    seatbeltOn = false
                    cruiseOn = false
                    harness = false
                end
                if showOutMap == false then
                    DisplayRadar(false)
                else
                    DisplayRadar(true)
                end
            end
        else
            SendNUIMessage({
                action = 'hudtick',
                show = false
            })
        end
    end
end)

-- low fuel
CreateThread(function()
    while true do
        if isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                if GetVehicleFuelLevel(vehicle) <= 20 then -- At 20% Fuel Left
                    if showFuelAlert == true then
                        TriggerServerEvent("InteractSound_SV:PlayOnSource", "pager", 0.10)
                        --TriggerEvent('QBCore:Notify', "Low Fuel!", "error")
                        Wait(60000) -- repeats every 1 min until empty
                    end
                end
            end
        end
        Wait(10000)
    end
end)

-- Money HUD

RegisterNetEvent('hud:client:ShowAccounts')
AddEventHandler('hud:client:ShowAccounts', function(type, amount)
    if type == 'cash' then
        SendNUIMessage({
            action = 'show',
            type = 'cash',
            cash = amount
        })
    else
        SendNUIMessage({
            action = 'show',
            type = 'bank',
            bank = amount
        })
    end
end)

RegisterNetEvent('hud:client:OnMoneyChange')
AddEventHandler('hud:client:OnMoneyChange', function(type, amount, isMinus)
    QBCore.Functions.GetPlayerData(function(PlayerData)
        cashAmount = PlayerData.money['cash']
        bankAmount = PlayerData.money['bank']
    end)
    SendNUIMessage({
        action = 'update',
        cash = cashAmount,
        bank = bankAmount,
        amount = amount,
        minus = isMinus,
        type = type
    })
end)

-- Stress Gain

CreateThread(function() -- Speeding
    while true do
        if isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local speed = GetEntitySpeed(GetVehiclePedIsIn(ped, false)) * speedMultiplier
                local stressSpeed = seatbeltOn and config.MinimumSpeed or config.MinimumSpeedUnbuckled
                if speed >= stressSpeed then
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                end
            end
        end
        Wait(10000)
    end
end)

local function IsWhitelistedWeaponStress(weapon)
    if weapon ~= nil then
        for _, v in pairs(config.WhitelistedWeaponStress) do
            if weapon == GetHashKey(v) then
                return true
            end
        end
    end
    return false
end

CreateThread(function() -- Shooting
    while true do
        if isLoggedIn then
            local ped = PlayerPedId()
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= `WEAPON_UNARMED` then
                if IsPedShooting(ped) and not IsWhitelistedWeaponStress(weapon) then
                    if math.random() < config.StressChance then
                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                    end
                end
            else
                Wait(1000)
            end
        end
        Wait(8)
    end
end)

-- Stress Screen Effects

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        if stress >= 100 then
            local ShakeIntensity = GetShakeIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = (FallRepeat * 1750)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 3000, 500)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Wait(1000)
            for i=1, FallRepeat, 1 do
                Wait(750)
                DoScreenFadeOut(200)
                Wait(1000)
                DoScreenFadeIn(200)
                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
                SetFlash(0, 0, 200, 750, 200)
            end
        elseif stress >= config.MinimumStress then
            local ShakeIntensity = GetShakeIntensity(stress)
            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', ShakeIntensity)
            SetFlash(0, 0, 500, 2500, 500)
        end
        Wait(GetEffectInterval(stress))
    end
end)

function GetShakeIntensity(stresslevel)
    local retval = 0.05
    for k, v in pairs(config.Intensity['shake']) do
        if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.intensity
            break
        end
    end
    return retval
end

function GetEffectInterval(stresslevel)
    local retval = 60000
    for k, v in pairs(config.EffectInterval) do
        if stresslevel >= v.min and stresslevel <= v.max then
            retval = v.timeout
            break
        end
    end
    return retval
end

-- minimap update
Citizen.CreateThread(function()
    while true do
        Wait(500)
        local player = PlayerPedId()
        SetRadarZoom(1000)
        SetRadarBigmapEnabled(false, false)
    end
end)

-- cinematic mode
CinematicHeight = 0.2
CinematicModeOn = false
w = 0
function CinematicShow(bool)
    SetRadarBigmapEnabled(true, false)
    Wait(0)
    SetRadarBigmapEnabled(false, false)
    if bool then
        for i = CinematicHeight, 0, -1.0 do
            Wait(10)
            w = i
        end 
    else
        for i = 0, CinematicHeight, 1.0 do 
            Wait(10)
            w = i
        end
    end
end
Citizen.CreateThread(function()
    minimap = RequestScaleformMovie("minimap")
    if not HasScaleformMovieLoaded(minimap) then
        RequestScaleformMovie(minimap)
        while not HasScaleformMovieLoaded(minimap) do 
            Wait(1)
        end
    end
    while true do
        Citizen.Wait(0)
        if w > 0 then
            BlackBars()
            DisplayRadar(0)
            SendNUIMessage({
                action = 'hudtick',
                show = false,
            })
            SendNUIMessage({
                action = 'car',
                show = false,
            })
        end
    end
end)
function BlackBars()
    DrawRect(0.0, 0.0, 2.0, w, 0, 0, 0, 255)
    DrawRect(0.0, 1.0, 2.0, w, 0, 0, 0, 255)
end
