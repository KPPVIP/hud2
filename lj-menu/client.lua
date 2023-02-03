local showMenu = false

RegisterCommand('hud', function()
    Wait(50)
    if not showMenu then
        TriggerEvent("hud:client:playOpenMenuSounds")
        SetNuiFocus(true, true)
        SendNUIMessage({ action = "open"}) 
        showMenu = true
end
end)

RegisterNUICallback('closeMenu', function()
    Wait(50)
    showMenu = false
    SetNuiFocus(false, false)
end) 

RegisterKeyMapping('hud', 'Open Menu', 'keyboard', Config.OpenKey)