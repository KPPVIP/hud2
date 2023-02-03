RegisterNetEvent('ld-loadscreen:ShutdownLoadingScreen')
AddEventHandler('ld-loadscreen:ShutdownLoadingScreen', function()
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
end)

