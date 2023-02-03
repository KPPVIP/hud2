![LJ HUD](https://user-images.githubusercontent.com/91661118/143670558-cbd7b923-1fbe-4ac1-86f5-72c518937b85.png)

# 🎅🎄🎁 lj-hud used with QBCore Framework 🍪🦌🤶
![ultrawide-support](https://user-images.githubusercontent.com/91661118/144727215-6d2cd8a1-04a4-4667-b350-5571b40efd92.png)

Join my Discord laboratory for updates, support, and special early testing!
<br>
https://discord.gg/loljoshie (without-vanity url: https://discord.gg/HH6uTcBfew)

Improved off of the newest QBCore hud. Written in Vue.js
<br>
Runs at ~ 0.01 to 0.03 ms if you have more optimization suggestions feel free to reach out

In collaboration with [OnlyCats](https://github.com/onlycats) who handled the majority of the javascript, helped make lj-menu, expanding UltraWide support along with various other miscellaneous tasks

⚠️ **If you are looking to use this hud with older versions of QBCore you can find that version [HERE](https://github.com/uShifty/lj-hud)** ⚠️

# Dependencies
* [lj-menu](https://github.com/loljoshie/lj-menu) **there are no more configurations. It's all handled through lj-menu 🙌**

![lj-menu](https://user-images.githubusercontent.com/91661118/144958755-678e6659-fd0b-4d93-8fed-300f94d21ed7.PNG)
* [qbcore framework](https://github.com/qbcore-framework) 
* [interact-sound](https://github.com/qbcore-framework/interact-sound) (if you want sound effects)
* [pma-voice](https://github.com/AvarianKnight/pma-voice) 
* [qb-radio](https://github.com/qbcore-framework/qb-radio) 
* [LegacyFuel](https://github.com/qbcore-framework/LegacyFuel)

# Recommended 
* [lj-compass](https://github.com/loljoshie/lj-compass) **this is specific version is made for lj-menu compatibility, if you want the standalone version** [lj-compass-old](https://github.com/loljoshie/lj-compass-old)

![lj-compass](https://user-images.githubusercontent.com/91661118/138012961-163ec6b3-7885-4df6-84a5-efd84aeac696.png)

# Installation
* **IMPORTANT: Recommended that have the default safezone size set found in Settings/Display/"Restore Defaults"**
* **IMPORTANT: If you're using [lj-fuel](https://github.com/loljoshie/lj-fuel) you NEED to change LegacyFuel exports**

## qb-smallresources
* find **"qb-smallresources/client/seatbelt.lua"**
* find **"seatbelt:client:UseHarness" event** then add snippet below under **"harnessData = ItemData"**
```lua 
TriggerEvent('hud:client:UpdateHarness', harnessHp)
```

# Key Features
* lj-menu now handles all configuration in game
* More resolutions supported (2560 x 1440 | 1920 x 1440 | 1920 x 1200 | 1280 x 720)
* ULTRAWIDE SUPPORT! (3440 x 1440)
* Toggle engine on and off
* Harness mode (harness radial shows when you have the harness item and checks for uses left which updates on the radial)
* Armed mode (weapons specifically whitelisted to not show armed mode)
* Switch between square and circle map with in-game /circle or square
* Cinematic mode (fully hides hud)
* Nitro when actived icon turns light red
* When dead heath radial turns red
* Dev mode radial when permission to do so (if you want dev mode working must follow instructions below)
* Headset icon appears when connected to radio channel
* Voice proximity and radio proximity highlighted
* Radial icons realign
* Seat belt equipped icon indicator
* Oxygen and Stamina radial indicator
* Engine health orange and red icon indicator
* Fuel low alert
* Fuel gauge color changes
* Parachute equipped radial indicator
* Cruise control radial dependent on vehicle speed
#

# Previews
### config / dynamic settings handled through lj-menu
![lj-menu close](https://user-images.githubusercontent.com/91661118/144960465-3a0162d8-f5f6-4f91-95de-a9931c92c10f.PNG)
### dead health
![dead](https://user-images.githubusercontent.com/91661118/143668617-3f41913f-506e-4c40-bc97-99c0e02eaec6.png)
### engine health
![engine](https://user-images.githubusercontent.com/91661118/143668642-22269059-8220-4b78-8f24-3c3661b7e82f.png)
### altitude
![altitude](https://user-images.githubusercontent.com/91661118/143668687-89ae10b6-9acc-4d68-845d-97db67d3d6de.png)
### parachute
![parachute](https://user-images.githubusercontent.com/91661118/143668699-a9d50ee4-1168-401b-bf92-8ba80a696e6e.png)
### armed
![armed](https://user-images.githubusercontent.com/91661118/143668646-baac9848-56e5-436b-922a-b35e50ed335f.png)
### cinematic
![cinematic](https://user-images.githubusercontent.com/91661118/143668651-74e90ac0-11ad-447a-b27c-1542dd10edfd.png)
### cruise
![cruise](https://user-images.githubusercontent.com/91661118/143668654-1b843009-c791-4482-807d-352b75707d42.png)
### harness
![harness](https://user-images.githubusercontent.com/91661118/143668664-bd03289a-286f-4165-9447-25b16b5b0c8e.png)
### cash
![cash](https://user-images.githubusercontent.com/91661118/143668667-a8e2e856-94be-45c4-9751-39e71315b303.png)
### bank
![bank](https://user-images.githubusercontent.com/91661118/143668668-fed140e6-9043-4daa-8aba-36feac3f9b78.png)
### nitro
![nitro](https://user-images.githubusercontent.com/91661118/143668672-8a164eb0-aca5-4e00-a99f-56c64e4d5069.png)
### stamina
![stamina](https://user-images.githubusercontent.com/91661118/143668678-3327c0bf-7e3b-4fe5-b6e5-da6e4054a47a.png)
### oxygen
![oxygen](https://user-images.githubusercontent.com/91661118/143668693-d623822b-fc78-499a-baa3-a86e29504044.png)
### radio
![radio](https://user-images.githubusercontent.com/91661118/143668707-eb4bb5e7-5900-4dd8-b500-5fc745a7c146.png)
### all radials
![all radials](https://user-images.githubusercontent.com/91661118/143668930-e9475c53-284c-4054-ad9c-88aa98f76768.png)

# Change Logs

### 1.7
* Added support for 4k resolution 3840 x 2160
* Added support for UltraWide resolution 2560 x 1080
* Added UltraWide minimap anchor (Took inspiration from googleoblivion)
* Fixed minimap load on login

### 1.6
* Changed radials smaller on default
* Added speedometer fps lj-menu
* Added minimap outside vehicle lj-menu
* Added support for UltraWide resolution 2560 x 1080
* Addedd UltraWide minimap anchor
* 

### 1.5
* More minor CSS changes
* Massive performance enhancements
* Added smoother transitions
* Added lj-menu compatibility
* Removed all configuration
* Cleaned CSS
* Cleaned HTML
* Fixed circle map alignment for 1920 x 1080

### 1.2
* Added more resolutions supported (2560 x 1440 | 1920 x 1440 | 1920 x 1200 | 1280 x 720)
* Added UltraWide support
* Added responsive CSS file
* Reworked car gauges with a new method
* Fixed parachute value
* Fixed cruise control not capturing speed value
* Cleaned CSS
* Cleaned HTML
* Added more optimization

### 1.1
* Revised radials added more spacing
* Separated icons from radials
* CSS changes on money and colors
* CSS changes on stress and parachute
* Added dynamic armor
* Fixed map not displaying while idle in vehicle
* Added border option found in config.lua
* Added more optimization

### 1.0
* Initial release

# Credits
* GhzGarage for original qb-hud [original version](https://github.com/qbcore-framework/qb-hud)
* [MonkeyWhisper](https://github.com/MonkeyWhisper) for testing UltraWide support with his community ❤️

# Issues and Suggestions
Please use the GitHub issues system to report issues or make suggestions, when making suggestion, please keep [Suggestion] in the title to make it clear that it is a suggestion.
