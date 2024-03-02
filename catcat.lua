-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()

repeat wait() until game:IsLoaded()
local Camera = workspace.CurrentCamera
local Workspace = game:GetService("Workspace")
local ReplStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local COREGUI = game:GetService("CoreGui")
local LP = game:GetService("Players").LocalPlayer
local HumanoidRootPart = LP.Character.HumanoidRootPart
local VirtualUser = game:GetService("VirtualUser")
local VIM = game:GetService("VirtualInputManager")

--Service
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunS = game:GetService("RunService")
local TPS = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

--Date
local day = os.date("%A")
local month = os.date("%B")
local days = os.date("%d")
local year = os.date("%Y")

local playerName = game.Players.LocalPlayer.Name -- Ganti dengan cara mendapatkan nama pemain yang sesuai
local executionTime = os.date("%X") -- Format waktu saat ini
local executionDate = os.date("%x") -- Format tanggal saat ini

local mouse = LP:GetMouse()
local MousePosition = function()
return Vector2.new(mouse.X,mouse.Y)
end

local request = (syn and syn.request) or (http and http.request) or http_request
local GC = getconnections or get_signal_cons

local job = require(game:GetService("ReplicatedStorage").Modules.Job)
local Network = require(game:GetService("ReplicatedStorage").Modules.Network)
local TweenModule = require(game:GetService("ReplicatedStorage").Modules.Tween)
local TotalEarning = 0;
local StopFarm = false;

local mapName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local OSTime = os.time();
local Time = os.date('!*t', OSTime);
local thumbnailUrl = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)


local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/download/1.1.0/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()



local Window = Fluent:CreateWindow({
    Title = "100% Lunar Hub | v1.0.9 Shessh",
    SubTitle = " ",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl 
})

function DestroyLogger()
    local coreGui = game:GetService("CoreGui")
    print("coreGui found:", coreGui ~= nil)
    local robloxGui = coreGui:FindFirstChild("RobloxGui")
    print("robloxGui found:", robloxGui ~= nil)
    if robloxGui then
        local modules = robloxGui:FindFirstChild("Modules")
        print("modules found:", modules ~= nil)
        if modules then
            local devConsole = modules:FindFirstChild("DevConsole")
            print("devConsole found:", devConsole ~= nil)
            if devConsole then
                local components = devConsole:FindFirstChild("Components")
                print("components found:", components ~= nil)
                if components then
                    local log = components:FindFirstChild("Log")
                    print("log found:", log ~= nil)
                    if log then
                        log.Parent:Destroy()
                    end
                end
            end
        end
    end
end

function sendNotification()
    local Fields = 
    {
        { name = "Roblox Username", value = LP.Name, inline = true },
        { name = "Executor Name", value = identifyexecutor(), inline = true },
        { name = "Map Name", value = mapName, inline = true }
    }

    local Embed = 
    {
        title = 'Script Executions',
        color = 3412416,
        fields = Fields,
        author = { name = "Kunar Vision 📸", url = 'https://discord.gg/FJRkFEQxZy', icon_url = '' },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ", OSTime), 
        footer = { text = 'Lunar Team made with 🤍', icon_url = '' }
    }

    local response = (syn and syn.request or http_request)({
        Url = 'https://discord.com/api/webhooks/1196044655456956578/qq1-zj2qmFuGSPJhX7jAEfsgB7A1-hBz2VOkP0IsiMXb_v0jbxgJ9ZSFUR89IsOhXvS0',
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({embeds = {Embed}})
    });
end

function TruckWebhook(Destination)

    local Fields = {
        {name = "Roblox Username", value = LP.Name, inline = false},
        {name = "Executor Name", value = identifyexecutor(), inline = false},
        {name = "Map Name", value = mapName, inline = false},
        {name = "Cash", value = LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text, inline = false},
        {name = "Earning Cash", value = LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text, inline = false},
        {name = "Teleport", value = string.format("%d / %d",teleportCount, _G.amountTeleport), inline = false},
        {name = "Destination", value = Destination, inline = false}
    }
    
    local Embed = {
        title = 'Trucking Webhook',
        color = 3024,
        fields = Fields,
        author = {name = "Lunar Webhook 📸", url = 'https://discord.gg/FJRkFEQxZy', icon_url = ''},
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ", OSTime), 
        footer = {text = string.format('Lunar Team made with 🤍 and %s', LP.Name), icon_url = ''}
    }

    local response = (syn and syn.request or http_request)({
        Url = _G.webhookLink,
        Method = 'POST',
        Headers = {['Content-Type'] = 'application/json'},
        Body = game:GetService('HttpService'):JSONEncode({embeds = {Embed}})
    })

end

local Tabs = {
    MainTab         = Window:AddTab({ Title = "Main", Icon = "home" }),
    WebhookTab      = Window:AddTab({ Title = "Webhook", Icon = "anchor" }),
    FarmLogTab      = Window:AddTab({ Title = "AutoFarming Log", Icon = "siren" }),
    VehicleTab      = Window:AddTab({ Title = "Vehicle", Icon = "car" }),
    Environment     = Window:AddTab({ Title = "Environment", Icon = "database" }),
    Settings        = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local Options = Fluent.Options

do
    local brightloop

    local function DayWeather()
        game:GetService("Lighting").ClockTime = 12
    end

    local function NightWeather()
        game:GetService("Lighting").ClockTime = 0
    end

    local function StartWeatherLoop(weatherFunction)
        if brightloop then
            brightloop:Disconnect() 
        end
        brightloop = game:GetService("RunService").RenderStepped:Connect(weatherFunction)
    end

    local weatherStatus = Tabs.Environment:AddDropdown("Dropdown", {
        Title = "Select Weather",
        Values = {"Day", "Night"},
        Multi = false,
        Default = "",
    })
    
    weatherStatus:OnChanged(function(Value)
        if Value == "Day" then
            StartWeatherLoop(DayWeather)
        elseif Value == "Night" then
            StartWeatherLoop(NightWeather)
        else
            if brightloop then
                brightloop:Disconnect() 
            end
        end
    end)

    local ShadowToggle = Tabs.Environment:AddToggle("shaow", {Title = "Shadow Options", Default = false})

    ShadowToggle:OnChanged(function(Value)
        game:GetService("Lighting").GlobalShadows = Value
    end)

    function destroyListedObjects()
        local objectsToDestroy = {
            "AmbientLightRevamp",
            "ChristmasEvent",
            "Map.TrafficLight",
            "Map.Tree",
            "Map.17",
            "Map.Chirstmas",
            "Map.Ramadhan",
            "Map.RoadLight"
        }
    
        for _, objectName in ipairs(objectsToDestroy) do
            local object
            if objectName:find("%.") then
                local parts = {}
                for part in objectName:gmatch("[^%.]+") do
                    table.insert(parts, part)
                end
    
                object = workspace
                for _, partName in ipairs(parts) do
                    object = object:FindFirstChild(partName)
                    if not object then break end
                end
            else
                object = workspace:FindFirstChild(objectName)
            end
    
            if object then
                object:Destroy()
            else
                warn(objectName .. " not found in workspace")
            end
        end
    end
    
    Tabs.Environment:AddButton({
        Title = "Boost FPS",
        Description = "the effect will continue until you relog",
        Callback = function()
            destroyListedObjects()
        end
    })

    _G.webhookLink = nil
    _G.webhookToggle = false

    local WebhookInput = Tabs.WebhookTab:AddInput("Input", {
        Title = "Truck Farm",
        Default =  " ",
        Placeholder = "Replace your webhook here",
        Finished = false, 
        Callback = function(Value)
            _G.webhookLink = Value
            print(_G.webhookLink)
        end
    })  

    local WebhookToggle = Tabs.WebhookTab:AddToggle("cik", {Title = "Truck Farm Webhook", Default = false})

    WebhookToggle:OnChanged(function(Value)
        if _G.webhookLink ~= nil then
            _G.webhookToggle = Value
        else
            Fluent:Notify({
                Title = "Lunar Hub",
                Content = "Please Select set a Webhook First",
                Duration = 5 -- Set to nil to make the notification not disappear
            })
        end
    end)

    -- [ FARM SECTION ]
    local FarmSection = Tabs.MainTab:AddSection("Farm Config")

    local truck_cooldown_teleport = 48
    local cd = 0;

    local AmountCooldown = FarmSection:AddInput("Input", {
        Title = "Coolown Teleport",
        Default =  48,
        Placeholder = "Recommended  48",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            truck_cooldown_teleport = Value
        end
    })   
    
    _G.amountTeleport = 9999999

    local amountTeleport = FarmSection:AddInput("Input", {
        Title = "Amount Teleport",
        Default =  999999,
        Placeholder = "replace in here",
        Numeric = true, -- Only allows numbers
        Finished = false, -- Only calls callback when you press enter
        Callback = function(Value)
            _G.amountTeleport = Value
        end
    }) 

    local CountdownTP = FarmSection:AddParagraph({
        Title = "Countdown Teleport",
        Content = "Teleport in "..tostring(cd)
    })

    getgenv().SelectedJob = nil;
    local JobDrop = FarmSection:AddDropdown("Dropdown", {
        Title = "Select Job",
        Values = {"Office Worker", "Janji Jiwa", "Truck Driver"},
        Multi = false,
        Default = getgenv().SelectedJob,
    })
    
    JobDrop:OnChanged(function(Value)
        getgenv().SelectedJob = Value
    end)

    local Toggle = FarmSection:AddToggle("StartFarm", {Title = "Auto Farm", Default = false })

    Toggle:OnChanged(function()
        if Options.StartFarm.Value == true then
            if getgenv().SelectedJob ~= nil then
                if StopFarm == true then
                    StopFarm = false
                end
                DoFarm(getgenv().SelectedJob)
            else
                Fluent:Notify({
                    Title = "Valleys hub",
                    Content = "Please Select a Job First",
                    Duration = 5 -- Set to nil to make the notification not disappear
                })
            end
        else
            if string.find(tostring(getgenv().SelectedJob), "Driver") then
                cd = 0;
            end 
            StopFarm = true
        end

    end)
    local StatsSection = Tabs.MainTab:AddSection("Stats")

    local ClientCash = StatsSection:AddParagraph({
        Title = "Your Cash",
        Content = LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text
    })

    local ClientEarnings =  StatsSection:AddParagraph({
        Title = "Earnings Cash",
        Content = LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text
    })

    local ClientTime =  StatsSection:AddParagraph({
        Title = "Farming Time",
        Content = "You're not start Auto Farming"
    })

    local ClientDes =  StatsSection:AddParagraph({
        Title = "Destination",
        Content = "You're not start Auto Farming"
    })

    -- [ SNIPER BOX ]
    local BoxSniper = Tabs.MainTab:AddSection("Box Sniper")

    BoxSniper:AddButton({
        Title = "Claim Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Claim"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    BoxSniper:AddButton({
        Title = "Gamepass Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Buy",
                [2] = "Gamepass Box"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    BoxSniper:AddButton({
        Title = "Limited Box",
        Description = "",
        Callback = function()
            local args = {
                [1] = "Buy",
                [2] = "Limited Box"
            }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Box:FireServer(unpack(args))
        end
    })

    local dealershipParent = workspace.Etc:FindFirstChild("Dealership")
    local dealershipNames = {}
    local dealershipPrompts = {}

    if dealershipParent then
        for _, child in ipairs(dealershipParent:GetChildren()) do
            table.insert(dealershipNames, child.Name)
            dealershipPrompts[child.Name] = child.Prompt
        end
    end

    local DealershipJakarta = Tabs.VehicleTab:AddDropdown("Dropdown", {
        Title = "Dealership",
        Values = dealershipNames,
        Multi = false,
        Default = "",
    })

    DealershipJakarta:OnChanged(function(Value)
        local promptToFire = dealershipPrompts[Value]
        if promptToFire then
            fireproximityprompt(promptToFire)
        end
    end)

    function CashFormat(cash)
        local v70 = 1
        local v73 = string.len(cash)
        local v74 = v73 - 1
        local v77 = math.floor((v74) / 3)
        local v78 = v77
        local v79 = 1
        for v70 = v70, v78, v79 do
            v73 = string.sub
            v77 = v73(cash, 1, (-3) * v70 - v70)
            v74 = string.sub
            cash = v77 .. "," .. v74(cash, (-3) * v70 - v70 + 1)
        end
        v79 = "RP. "
        v78 = v79 .. cash
        return v78
    
    end

    function DoFarm(job)
        if job == "Truck Driver" then
            Saya melihatgame:GetService("VirtualInputManager"):SendKeyEvent(false, "U", false, game)
            wait(0.8)
            local args = { "Truck" }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
            game.Workspace.Gravity = 10
            wait(2)
            game.Workspace.Gravity = 0

            local TweenService = game:GetService("TweenService")
            local HumanoidRootPart = LP.Character.HumanoidRootPart
            local targetCFrame = CFrame.new(-21799.8, 1042.65, -26797.7)
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
            local tweenProperties = {CFrame = targetCFrame}
            local tween = TweenService:Create(HumanoidRootPart, tweenInfo, tweenProperties)
            tween:Play()
            tween.Completed:Wait() 

            CheckStartJob() 
            wait(5)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            game.Workspace.Gravity = 10
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt)
            wait(2)
            local destination = GetWaypointName()
            wait(1)
            game.Workspace.Gravity = 100
            wait(1)
            SpawnTruck()
            wait(4)
            GetInsideOfCar()
            wait(3)
            RemoveTrailerFromTruck()
            wait()
            wait(0.5)
            TruckFarm(StopFarm)
            GetTimer()
        elseif job == "Office Worker" then
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer("Office")
            game.Workspace.Gravity = 10
            wait(2)
            game.Workspace.Gravity = 0
            TakeEarlyPoint(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            game.Workspace.Gravity = 10
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.Office.Starter.Prompt)
            wait(2)
            local destination = GetWaypointName()
            game.Workspace.Gravity = 100
            wait(1)
            repeat wait()
                DoQuestOffice()
            until StopFarm == true
        elseif job == "Janji Jiwa" then
            local args = { "JanjiJiwa" }
            game:GetService("ReplicatedStorage").NetworkContainer.RemoteEvents.Job:FireServer(unpack(args))
            game.Workspace.Gravity = 10
            wait(2)
            game.Workspace.Gravity = 0
            TakeEarlyPoint(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            game.Workspace.Gravity = 10
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            fireproximityprompt(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
            wait(2)
            local destination = GetWaypointName()
            game.Workspace.Gravity = 100
            DoJanjijiwaFarm()
        end

    end


    function GetTimer()
        local jobTime = tick()
        local startTime = os.date("%H:%M:%S")
        local startDate = os.date("%Y-%m-%d")
    
        while wait() do
            local elapsedTime = tick() - jobTime
            local timeText = ""
    
            if elapsedTime < 60 then
                timeText = string.format("%.1f seconds", elapsedTime)
            elseif elapsedTime < 3600 then
                timeText = string.format("%.1f minutes", elapsedTime / 60)
            else
                timeText = string.format("%.1f hours", elapsedTime / 3600)
            end
    
            local currentTime = os.date("%H:%M:%S")

            ClientTime:SetDesc("You've been farming for: " .. timeText)

            _G.TimeHook = timeText
        end
    end

    local function GetDistance(Endpoint)
        if typeof(Endpoint) == "Instance" then
            Endpoint = Vector3.new(Endpoint.Position.X, LP.Character:FindFirstChild("HumanoidRootPart").Position.Y, Endpoint.Position.Z)
        elseif typeof(Endpoint) == "CFrame" then
            Endpoint = Vector3.new(Endpoint.Position.X, LP.Character:FindFirstChild("HumanoidRootPart").Position.Y, Endpoint.Position.Z)
        end
        local Magnitude = (Endpoint - LP.Character:FindFirstChild("HumanoidRootPart").Position).Magnitude
        return Magnitude
    end

    function TakeEarlyPoint(starterPrompts)
        local waypointPosition = game:GetService("Workspace").Etc.Waypoint.Waypoint.Position
        local humanoidRootPart = LP.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(waypointPosition)
        wait(1.5)
        for i = 1, 6 do
            fireproximityprompt(starterPrompts)
        end
    end

    function SpawnJobCar(waypointPos, promts)
        local waypointPosition = waypointPos
        local playerName = LP.Name
        local carIdentifier = "sCar"
        LP.Character.HumanoidRootPart.CFrame = CFrame.new(waypointPosition)

        fireproximityprompt(promts)
        wait(1)
        fireproximityprompt(promts)
    end

    function SpawnTruck()
        local TweenService = game:GetService("TweenService")
        local HumanoidRootPart = LP.Character.HumanoidRootPart
        local waypointPosition = game.Workspace.Etc.Job.Truck.Spawner.Part.Position
    
        local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false, 0)
        
        local tweenProperties = {
            CFrame = CFrame.new(waypointPosition)
        }
    
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, tweenProperties)
        tween:Play()
        tween.Completed:Wait() 
    
        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
        wait(1)
        fireproximityprompt(game.Workspace.Etc.Job.Truck.Spawner.Part.Prompt)
    end

    function GetInsideOfCar()
        local playerName = LP.Name
        local carIdentifier = "sCar"
    
        print("Attempting to find car for player:", playerName)
    
        local DriveSeat = game:GetService("Workspace").Vehicles[playerName .. carIdentifier]:WaitForChild("DriveSeat", 9e9)
        print("DriveSeat found?:", DriveSeat) 
    
        local humanoidRootPart = LP.Character.HumanoidRootPart
        humanoidRootPart.CFrame = CFrame.new(DriveSeat.Position)
        wait(1.5) 
    
        local promptDriveSeat = DriveSeat.PromptDriveSeat
        fireproximityprompt(promptDriveSeat)
        wait(0.5)
    
        if LP.Character.Humanoid.SeatPart == nil or LP.Character.Humanoid.SeatPart.Name ~= "DriveSeat" then
            print("Player not seated correctly, trying again.")  
            fireproximityprompt(promptDriveSeat)
            wait(0.5)
        else
            print("Player seated successfully.")
        end
    end
    

    function RemoveTrailerFromTruck()
        local playerName = LP.Name
        local carIdentifier = "sCar"
        local playerCar = game.Workspace.Vehicles[playerName .. carIdentifier]
    
        print("Player Name:", playerName)  
        print("Player Car:", playerCar) 
    
        for _, descendant in pairs(playerCar:GetDescendants()) do
            if descendant.Name == "Trailer1" then 
                print("Trailer found - removing.") 
                descendant:Destroy()
            end
        end
    end
    

    function safelyTeleportCar(playerCar, cframe)
        if not playerCar or not cframe then 
            print("Debug: Either playerCar or cframe is missing.")
            return 
        end
        local serverStatsItem = game:GetService("Stats").Network.ServerStatsItem
        local dataPing = serverStatsItem and serverStatsItem["Data Ping"] or nil

        if not dataPing then 
            print("Debug: Unable to fetch server stats item ['Data Ping'].")
            return 
        end
        local playerPing = dataPing:GetValueString()
        local pingValue = tonumber(playerPing:match("%d+"))

        local waitTime = 0
        local delayMessage = ""
        if pingValue > 100 then
            waitTime = 8
            delayMessage = "Adding delay of 8 seconds due to high ping."
        elseif pingValue > 80 then
            waitTime = 5
            delayMessage = "Adding delay of 5 seconds due to moderate ping."
        elseif pingValue < 30 then
            waitTime = 3
            delayMessage = "Adding delay of 3 seconds due to low ping."
        end

        CountdownTP:SetDesc(delayMessage)
        print("Debug: "..delayMessage)

        local success, errorMessage = pcall(function()
            wait(waitTime) 
            playerCar:SetPrimaryPartCFrame(cframe)
            print("Debug: Set player car position to the specified cframe.")
            game.Workspace.Gravity = -5
            CountdownTP:SetTitle("Teleporting...")
            CountdownTP:SetDesc("Teleported successfully!")
            wait(1)
            game.Workspace.Gravity = 500
            print("Debug: Reset gravity.")
        end)
        if not success then
            warn("Error teleporting car: " .. errorMessage)
            print("Debug: Error message - " .. errorMessage)
        end
    end

    function TruckFarm(value)
        coroutine.wrap(function()
            local teleportCount = 0 
            while coroutine.yield() do
                if StopFarm or teleportCount >= _G.amountTeleport then print("Teleportation limit exceeded or Farm Stopped") return end 

                print("Starting TruckFarm...")

                local humanoid = LP.Character and LP.Character:FindFirstChild("Humanoid")
                if not humanoid or humanoid.SeatPart == nil or humanoid.SeatPart.Name ~= "DriveSeat" then
                    print("Failed to find humanoid or humanoid is not in DriveSeat. TruckFarm stopping.")
                    return
                end

                local Destic = GetWaypointName()

                ClientDes:SetDesc("Your next destination is ".. Destic)

                print("Starting countdown...")
                pcall(function() StartCountdown() end)

                local waypointGui = game.Workspace.Etc.Waypoint.Waypoint:FindFirstChild("BillboardGui")
                if not waypointGui then
                    print("Failed to find waypointGui. TruckFarm stopping.")
                    return
                end

                local Waypoint = waypointGui.TextLabel.Text
                local playerName = LP.Name
                local carIdentifier = "sCar"
                local playerCar = game:GetService("Workspace").Vehicles:FindFirstChild(playerName .. carIdentifier)

                local destinationCF
                if Waypoint == "PT.CDID Cargo Cirebon" then
                    destinationCF = CFrame.new(-21803.8867, 1046.98877, -27817.0586, 0, 0, -1, 0, 1, 0, 1, 0, 0)
                elseif Waypoint == "Rojod Semarang" then
                    destinationCF = CFrame.new(-50889.6602, 1017.86719, -86514.7969)
                elseif Waypoint == "Rest Area Km 27" then
                    destinationCF = CFrame.new(-25910.9395, 1059.604, -43896.2734, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                elseif Waypoint == "Silambat Palimanan" then
                    destinationCF = CFrame.new(-13001.5781, 1058.45532, -16360.2012, -0.866007447, 0, -0.500031412, 0, 1, 0, 0.500031412, 0, -0.866007447)
                else
                    destinationCF = CFrame.new(game:GetService("Workspace").Etc.Waypoint.Waypoint.Position)
                end
                print("Teleporting to "..Waypoint)
                pcall(function() safelyTeleportCar(playerCar, destinationCF, 7) end)

                if _G.webhookToggle == true then
                    TruckWebhook(Destic)
                end

                teleportCount = teleportCount + 1

                print("Waiting for 2.2 seconds...")
                coroutine.yield(2.2)
            end
        end)
    end

    function DoJanjijiwaFarm()
        task.spawn(function()
            while wait() and not StopFarm do
                pcall(function()
                    repeat
                        TakeEarlyPoint(game:GetService("Workspace").Etc.Job.JanjiJiwa.Starter.Prompt)
                        if LP.Backpack:FindFirstChild("Coffee") then
                            game:GetService("ReplicatedStorage"):WaitForChild("NetworkContainer"):WaitForChild("RemoteEvents"):WaitForChild("JanjiJiwa"):FireServer("Delivery")
                        end
                    until StopFarm == true
                end)
            end

        end)
    end

    function DoQuestOffice()
        for i = 0, 4 do
            if StopFarm then break end
            local quest = LP.PlayerGui.Job.Components.Container.Office.Frame.Question.Text
            local Submit = LP.PlayerGui.Job.Components.Container.Office.Frame.SubmitButton
            local splitQuest = string.split(quest, " ")
            local num1 = tonumber(splitQuest[1])
            local operator = splitQuest[2]
            local num2 = tonumber(splitQuest[3])
            local solved;
            if operator == "+" then
                solved = tostring((num1 + num2))
            elseif operator == "-" then
                solved = tostring(num1 - num2)
            end
            
            LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text = string.match(solved, "%d+")
            repeat wait(0.5) until LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text == string.match(solved, "%d+")
            if (LP.PlayerGui.Job.Components.Container.Office.Frame.TextBox.Text == string.match(solved, "%d+")) then
                VIM:SendMouseButtonEvent(Submit.AbsolutePosition.X+Submit.AbsoluteSize.X/2,Submit.AbsolutePosition.Y+50,0,true,Submit,1)
                VIM:SendMouseButtonEvent(Submit.AbsolutePosition.X+Submit.AbsoluteSize.X/2,Submit.AbsolutePosition.Y+50,0,false,Submit,1)	
            end
        end
    end


    function StartCountdown()
           for i = truck_cooldown_teleport, 1, -1 do
               if StopFarm then 
                   print("Countdown stopped due to StopFarm flag.") 
                   break 
               end
               
               local cd = i
               print("Current countdown value:", cd)

               CountdownTP:SetDesc("Teleport in "..tostring(cd))
               wait(1)
           end
       end   

    function CheckStartJob()
        local jobStarted = false
        while not jobStarted do
            wait()
            local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
            local waypointLabel = assert(waypoint.BillboardGui and waypoint.BillboardGui.TextLabel, "Waypoint label not found!")
            local labelText = waypointLabel.Text
            if labelText == "PT.Shad Cirebon" then
                LP.Character.HumanoidRootPart.CFrame = CFrame.new(-21799.8, 1042.65, -26797.7)
                local prompt = assert(game:GetService("Workspace").Etc.Job.Truck.Starter.Prompt, "Prompt not found!")
                for i = 1, 4 do
                    fireproximityprompt(prompt)
                end
                game.Workspace.Gravity = 10
            else
                jobStarted = true
            end
        end
    end


    function GetWaypointName()
        local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
        local waypointLabel = assert(waypoint:FindFirstChild("BillboardGui") and waypoint.BillboardGui:FindFirstChild("TextLabel"), "Waypoint label not found!")
        return waypointLabel.Text
    end

    function GetWaypointNameBefore()
        local waypoint = assert(game.Workspace.Etc.Waypoint.Waypoint, "Waypoint not found!")
        local waypointLabel = assert(waypoint:FindFirstChild("BillboardGui") and waypoint.BillboardGui:FindFirstChild("TextLabel"), "Waypoint label not found!")
        return waypointLabel.Text
    end

    function RefreshCash()
        ClientCash:SetDesc(LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel.Text)
        ClientEarnings:SetDesc(LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value.Text)
    end

    LP:FindFirstChild("PlayerGui").Main.Container.Hub.CashFrame.Frame.TextLabel:GetPropertyChangedSignal("Text"):Connect(RefreshCash)
    LP:FindFirstChild("PlayerGui").PhoneUI.HolderHP.Homescreen.ProfileScreen.MainFrame.EarningFrame.Value:GetPropertyChangedSignal("Text"):Connect(RefreshCash)

end

function TimeTrialJakarta()
    fireproximityprompt(workspace.Etc.Race.TimeTrial.Start.Prompt)

    local startTime = tick()
    repeat RunS.Heartbeat:Wait() until tick() - startTime >= 10

    local playerName = LP.Name
    local playerCar = game:GetService("Workspace").Vehicles[playerName .. "sCar"]

    if not playerCar then
        print("Kendaraan player tidak ditemukan!")
        return
    end

    repeat RunS.Heartbeat:Wait() until tick() - startTime >= 15
    
    local checkpointCFrames = {
        CFrame.new(-4922.92578, 41.3567047, 363.310974, 2.05039978e-05, -0.86604017, -0.499974549, 1.00000012, 2.05039978e-05, 5.49852848e-06, 5.49852848e-06, -0.499974549, 0.866040111),
        CFrame.new(-3684.76489, 42.3644257, -526.991089, 2.07424164e-05, -0.57355696, -0.819165647, 0.99999994, 2.07424164e-05, 1.07884407e-05, 1.07884407e-05, -0.819165647, 0.573557019),
        CFrame.new(-2025.33301, 46.4877014, -556.023926, -8.22544098e-06, 0.642762423, -0.766065776, 1.00000012, 7.9870224e-06, -3.75509262e-06, 3.75509262e-06, -0.766065776, -0.642762542),
        CFrame.new(-1175.63403, 66.2507553, -29.6842384, -5.96046448e-07, 0.0871878564, -0.996191859, 1, 5.96046448e-07, -5.66244125e-07, 5.66244125e-07, -0.996191859, -0.087187767),
        CFrame.new(-799.506531, 47.0191269, 1184.70581, -8.10623169e-06, -0.642762303, -0.766065598, 1, -8.10623169e-06, -3.78489494e-06, -3.78489494e-06, -0.766065598, 0.642762303),
        CFrame.new(-1528.93933, 44.2638969, 2426.12964, 6.10947609e-05, -0.857243359, -0.514911354, 0.99999994, 6.10947609e-05, 1.69277191e-05, 1.69277191e-05, -0.514911354, 0.857243419),
        CFrame.new(-3078.01807, 44.0052948, 5127.05176, 3.12328339e-05, -0.941413283, -0.33725512, 1, 3.12328339e-05, 5.42402267e-06, 5.42402267e-06, -0.33725512, 0.941413283),
        CFrame.new(-3217.22119, 46.7632523, 5518.37402, -2.31266022e-05, 0.620019555, 0.78458631, 1, 2.31266022e-05, 1.12056732e-05, -1.12056732e-05, 0.78458631, -0.620019674),
        CFrame.new(-3430.00879, 45.0853043, 5427.7749, -4.78029251e-05, 0.710414648, -0.703783453, 1.00000012, 4.76837158e-05, -1.96695328e-05, 1.96695328e-05, -0.703783453, -0.710414648),
        CFrame.new(-4060.83228, 46.4606247, 5065.17041, -8.58306885e-06, 0.0378802717, 0.9992823, 1, 8.58306885e-06, 8.22544098e-06, -8.22544098e-06, 0.9992823, -0.0378801823),
        CFrame.new(-4198.26904, 46.3244781, 5102.25586, 2.84910202e-05, -0.988597989, 0.150579125, 1, 2.84910202e-05, -2.16066837e-06, -2.16066837e-06, 0.150579125, 0.988597989),
        CFrame.new(-4165.93652, 46.7464714, 4843.74316, 1.54972076e-06, -0.422563195, 0.906333447, 1, 1.54972076e-06, -9.83476639e-07, -9.83476639e-07, 0.906333447, 0.422563195),
        CFrame.new(-4751.43848, 43.617115, 4931.35645, -6.43730164e-06, 0.173615277, 0.984813631, 1, 6.37769699e-06, 5.42402267e-06, -5.42402267e-06, 0.984813631, -0.173615336),
        CFrame.new(-5305.7793, 46.3041267, 4970.16943, 4.0948391e-05, 0.966288626, -0.257461786, 1.00000012, -4.12464142e-05, 5.37931919e-06, -5.37931919e-06, -0.257461786, -0.966288805),
        CFrame.new(-5081.28174, 45.4488754, 4867.95801, -1.66893005e-06, 0.198071688, 0.980187535, 1, 1.66893005e-06, 1.34110451e-06, -1.34110451e-06, 0.980187535, -0.198071718),
        CFrame.new(-4683.97754, 46.3174934, 4793.32666, -5.24520874e-06, 0.203165472, 0.979144454, 1, 5.1856041e-06, 4.2617321e-06, -4.2617321e-06, 0.979144454, -0.203165531),
        CFrame.new(-4192.91455, 45.5189095, 4713.36572, 2.10404396e-05, 0.957543075, 0.288290054, 0.99999994, -2.0980835e-05, -3.09944153e-06, 3.09944153e-06, 0.288290054, -0.957543135),
        CFrame.new(-4277.23633, 43.0489655, 4203.81738, -4.42266464e-05, -0.999355972, 0.0358850844, 1, -4.42266464e-05, 7.93486834e-07, 7.93486834e-07, 0.0358850844, 0.999355912),
        CFrame.new(-4404.104, 45.3556252, 3396.99365, 4.29153442e-05, -0.984804988, 0.173663557, 1, 4.29153442e-05, -3.75509262e-06, -3.75509262e-06, 0.173663557, 0.984805048),
        CFrame.new(-4739.25293, 41.2888908, 1538.89795, 4.29153442e-05, -0.984804988, 0.173663557, 1, 4.29153442e-05, -3.75509262e-06, -3.75509262e-06, 0.173663557, 0.984805048),
    }

    for i, checkpointCFrame in ipairs(checkpointCFrames) do
        playerCar:SetPrimaryPartCFrame(checkpointCFrame)
        RunS.Heartbeat:Wait()
    end
    
    repeat RunS.Heartbeat:Wait() until tick() - startTime >= 71

    local finalCheckpointCFrame = CFrame.new(-4839.61328, 44.5184326, 945.549805, 1.57356262e-05, -0.986318946, 0.164848655, 1.00000012, 1.57356262e-05, -1.31875277e-06, -1.31875277e-06, 0.164848655, 0.986318886)
    playerCar:SetPrimaryPartCFrame(finalCheckpointCFrame)
end

function AntiAFK()
    AFKVal = game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", false, game)
        wait()
        game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", false, game)
    end)
end

function FluentMisc()
    SaveManager:SetLibrary(Fluent)
    InterfaceManager:SetLibrary(Fluent)

    SaveManager:IgnoreThemeSettings()
    SaveManager:SetIgnoreIndexes({})

    InterfaceManager:SetFolder("FluentScriptHub")
    SaveManager:SetFolder("FluentScriptHub/specific-game")

    InterfaceManager:BuildInterfaceSection(Tabs.Settings)
    SaveManager:BuildConfigSection(Tabs.Settings)

    Window:SelectTab(1)

    SaveManager:LoadAutoloadConfig()
end

-- [ CALLBACK FUNCTION ] -- 
FluentMisc()
AntiAFK()
DestroyLogger()
sendNotification()

