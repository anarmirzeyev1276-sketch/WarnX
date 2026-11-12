-- WarnX Hub | Ultimate CMD Suite with Player Target System & Live Search
-- Creator: rbxWarnX

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Clean previous instances
if PlayerGui:FindFirstChild("WarnX_UltimateCMD") then
    PlayerGui.WarnX_UltimateCMD:Destroy()
end
if PlayerGui:FindFirstChild("WarnX_CmdsGui") then
    PlayerGui.WarnX_CmdsGui:Destroy()
end

-- ==========================================
-- GUI INTERFACE (White & Purple & Yellow Theme)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WarnX_UltimateCMD"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 580, 0, 50)
MainFrame.Position = UDim2.new(0.5, -290, 0.85, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(245, 247, 250)
MainFrame.BorderColor3 = Color3.fromRGB(138, 43, 226) -- Bright Purple
MainFrame.BorderSizePixel = 2
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- Top Accent Line (Gold Yellow Detail)
local AccentLine = Instance.new("Frame")
AccentLine.Size = UDim2.new(1, 0, 0, 3)
AccentLine.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Yellow
AccentLine.BorderSizePixel = 0
AccentLine.Parent = MainFrame

local PromptLabel = Instance.new("TextLabel")
PromptLabel.Size = UDim2.new(0, 35, 1, 0)
PromptLabel.Position = UDim2.new(0, 5, 0, 0)
PromptLabel.BackgroundTransparency = 1
PromptLabel.Text = ">"
PromptLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
PromptLabel.TextSize = 18
PromptLabel.Font = Enum.Font.Code
PromptLabel.Parent = MainFrame

local CmdTextBox = Instance.new("TextBox")
CmdTextBox.Size = UDim2.new(1, -130, 1, 0)
CmdTextBox.Position = UDim2.new(0, 40, 0, 0)
CmdTextBox.BackgroundTransparency = 1
CmdTextBox.Text = ""
CmdTextBox.PlaceholderText = "Type command (e.g., speed anar 200, tp player, cmds)..."
CmdTextBox.TextColor3 = Color3.fromRGB(30, 30, 30)
CmdTextBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
CmdTextBox.TextSize = 13
CmdTextBox.Font = Enum.Font.Code
CmdTextBox.TextXAlignment = Enum.TextXAlignment.Left
CmdTextBox.Parent = MainFrame

local RunBtn = Instance.new("TextButton")
RunBtn.Size = UDim2.new(0, 75, 0, 34)
RunBtn.Position = UDim2.new(1, -80, 0.5, -17)
RunBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
RunBtn.Text = "EXECUTE"
RunBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RunBtn.TextSize = 11
RunBtn.Font = Enum.Font.GothamBold
RunBtn.Parent = MainFrame

local RunCorner = Instance.new("UICorner")
RunCorner.CornerRadius = UDim.new(0, 6)
RunCorner.Parent = RunBtn

local CreatorTag = Instance.new("TextLabel")
CreatorTag.Size = UDim2.new(1, 0, 0, 16)
CreatorTag.Position = UDim2.new(0, 0, 1, 3)
CreatorTag.BackgroundTransparency = 1
CreatorTag.Text = "WarnX Ultimate Suite | Target System Active | By rbxWarnX"
CreatorTag.TextColor3 = Color3.fromRGB(200, 170, 0)
CreatorTag.TextSize = 10
CreatorTag.Font = Enum.Font.GothamBold
CreatorTag.Parent = MainFrame

-- ==========================================
-- FULL DRAGGABLE SYSTEM
-- ==========================================
local dragging, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(MainFrame, TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos}):Play()
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ==========================================
-- PLAYER FINDER UTILITY (Target System)
-- ==========================================
local function FindPlayer(nameQuery)
    if not nameQuery then return nil end
    nameQuery = string.lower(nameQuery)
    if nameQuery == "me" or nameQuery == "myself" then
        return LocalPlayer
    end
    for _, player in ipairs(Players:GetPlayers()) do
        local playerName = string.lower(player.Name)
        local playerDisplay = string.lower(player.DisplayName)
        if string.sub(playerName, 1, #nameQuery) == nameQuery or string.sub(playerDisplay, 1, #nameQuery) == nameQuery then
            return player
        end
    end
    return nil
end

-- ==========================================
-- COMMANDS LIST FOR LIVE SEARCH
-- ==========================================
local AllCommands = {
    "speed [name] [val]", "jumppower [name] [val]", "gravity [val]", "hipheight [val]", "health [name] [val]", "defspeed", "defjp", "defgrav", "sit",
    "fly [val]", "unfly", "nofalldamage", "bhop", "float", "unfloat", "infinitejump", "spin [val]", "unspin", "walkonwater",
    "noclip", "clip", "invisible", "visible", "btools", "day", "night", "bright", "dark", "fogoff", "maxzoom", "minzoom", "unlockcam",
    "heal [name]", "god [name]", "ungod [name]", "kill [name]", "goto [name]", "bring [name]", "rejoin", "respawn", "clear", "fps", "ping",
    "copyname", "copyid", "esp", "partcount", "cleargui", "close", "time", "date", "placeid", "gameid", "version", "unload", "volume [0-100]",
    "maxplayers", "playerlist", "sitdown", "jump", "cmds"
}

-- ==========================================
-- OPEN CMDS SEARCH UI WINDOW
-- ==========================================
local function OpenCmdsMenu()
    if PlayerGui:FindFirstChild("WarnX_CmdsGui") then
        PlayerGui.WarnX_CmdsGui:Destroy()
    end

    local CmdsGui = Instance.new("ScreenGui")
    CmdsGui.Name = "WarnX_CmdsGui"
    CmdsGui.Parent = PlayerGui
    CmdsGui.ResetOnSpawn = false

    local Window = Instance.new("Frame")
    Window.Size = UDim2.new(0, 420, 0, 400)
    Window.Position = UDim2.new(0.5, -210, 0.5, -200)
    Window.BackgroundColor3 = Color3.fromRGB(245, 247, 250)
    Window.BorderColor3 = Color3.fromRGB(138, 43, 226)
    Window.BorderSizePixel = 2
    Window.Parent = CmdsGui

    local WinCorner = Instance.new("UICorner")
    WinCorner.CornerRadius = UDim.new(0, 10)
    WinCorner.Parent = Window

    local WinHeader = Instance.new("Frame")
    WinHeader.Size = UDim2.new(1, 0, 0, 35)
    WinHeader.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    WinHeader.BorderSizePixel = 0
    WinHeader.Parent = Window

    local WinHeaderCorner = Instance.new("UICorner")
    WinHeaderCorner.CornerRadius = UDim.new(0, 10)
    WinHeaderCorner.Parent = WinHeader

    local WinTitle = Instance.new("TextLabel")
    WinTitle.Size = UDim2.new(1, -40, 1, 0)
    WinTitle.Position = UDim2.new(0, 12, 0, 0)
    WinTitle.BackgroundTransparency = 1
    WinTitle.Text = "WarnX Command List & Target System"
    WinTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    WinTitle.TextSize = 13
    WinTitle.Font = Enum.Font.GothamBold
    WinTitle.TextXAlignment = Enum.TextXAlignment.Left
    WinTitle.Parent = WinHeader

    local CloseListBtn = Instance.new("TextButton")
    CloseListBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseListBtn.Position = UDim2.new(1, -32, 0, 2)
    CloseListBtn.BackgroundColor3 = Color3.fromRGB(220, 20, 60)
    CloseListBtn.Text = "X"
    CloseListBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseListBtn.TextSize = 12
    CloseListBtn.Font = Enum.Font.GothamBold
    CloseListBtn.Parent = WinHeader

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseListBtn

    CloseListBtn.MouseButton1Click:Connect(function()
        CmdsGui:Destroy()
    end)

    local SearchBox = Instance.new("TextBox")
    SearchBox.Size = UDim2.new(1, -20, 0, 35)
    SearchBox.Position = UDim2.new(0, 10, 0, 45)
    SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.BorderColor3 = Color3.fromRGB(200, 210, 225)
    SearchBox.Text = ""
    SearchBox.PlaceholderText = "Search commands (e.g., speed, tp, kill)..."
    SearchBox.TextColor3 = Color3.fromRGB(30, 30, 30)
    SearchBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
    SearchBox.TextSize = 12
    SearchBox.Font = Enum.Font.Code
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.Parent = Window

    local SearchCorner = Instance.new("UICorner")
    SearchCorner.CornerRadius = UDim.new(0, 6)
    SearchCorner.Parent = SearchBox

    local CmdScroll = Instance.new("ScrollingFrame")
    CmdScroll.Size = UDim2.new(1, -20, 1, -95)
    CmdScroll.Position = UDim2.new(0, 10, 0, 85)
    CmdScroll.BackgroundTransparency = 1
    CmdScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    CmdScroll.ScrollBarThickness = 6
    CmdScroll.Parent = Window

    local CmdListLayout = Instance.new("UIListLayout")
    CmdListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    CmdListLayout.Padding = UDim.new(0, 5)
    CmdListLayout.Parent = CmdScroll

    local function RenderCmdList(filter)
        for _, v in ipairs(CmdScroll:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end

        local count = 0
        for _, cmdName in ipairs(AllCommands) do
            if filter == "" or string.find(string.lower(cmdName), string.lower(filter)) then
                count = count + 1
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.BackgroundColor3 = Color3.fromRGB(235, 240, 248)
                btn.Text = "  > " .. cmdName
                btn.TextColor3 = Color3.fromRGB(40, 40, 50)
                btn.TextSize = 12
                btn.Font = Enum.Font.Code
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = CmdScroll

                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0, 4)
                c.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    CmdTextBox.Text = string.split(cmdName, " ")[1]
                    CmdsGui:Destroy()
                end)
            end
        end
        CmdScroll.CanvasSize = UDim2.new(0, 0, 0, count * 33)
    end

    RenderCmdList("")

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        RenderCmdList(SearchBox.Text)
    end)
end

-- ==========================================
-- COMMAND ENGINE WITH TARGET SUPPORT
-- ==========================================
local FlyConn = nil
local NoclipConn = nil
local EspEnabled = false
local EspHighlights = {}

local function ExecuteCommand()
    local text = CmdTextBox.Text
    if text == "" then return end
    CmdTextBox.Text = ""

    local lowerText = string.lower(text)
    
    if lowerText == "cmds" or lowerText == "help" then
        OpenCmdsMenu()
        return
    end

    local args = {}
    for word in string.gmatch(lowerText, "%S+") do
        table.insert(args, word)
    end

    local cmd = args[1] or ""
    local arg1 = args[2]
    local arg2 = args[3]

    task.spawn(function()
        pcall(function()
            local char = LocalPlayer.Character
            local humanoid = char and char:FindFirstChild("Humanoid")
            local rootPart = char and char:FindFirstChild("HumanoidRootPart")

            -- Target-based speed or self speed
            if cmd == "speed" or cmd == "ws" then
                local targetPlayer = FindPlayer(arg1)
                local val = tonumber(arg2) or tonumber(arg1) or 100
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.WalkSpeed = val
                elseif humanoid then
                    humanoid.WalkSpeed = val
                end

            elseif cmd == "jumppower" or cmd == "jp" then
                local targetPlayer = FindPlayer(arg1)
                local val = tonumber(arg2) or tonumber(arg1) or 100
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.JumpPower = val
                elseif humanoid then
                    humanoid.JumpPower = val
                end

            elseif cmd == "gravity" or cmd == "grav" then
                workspace.Gravity = tonumber(arg1) or 196.2

            elseif cmd == "hipheight" or cmd == "hh" then
                if humanoid then humanoid.HipHeight = tonumber(arg1) or 0 end

            elseif cmd == "health" or cmd == "hp" then
                local targetPlayer = FindPlayer(arg1)
                local val = tonumber(arg2) or 100
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.Health = val
                elseif humanoid then
                    humanoid.Health = val
                end

            elseif cmd == "defspeed" then
                if humanoid then humanoid.WalkSpeed = 16 end
            elseif cmd == "defjp" then
                if humanoid then humanoid.JumpPower = 50 end
            elseif cmd == "defgrav" then
                workspace.Gravity = 196.2
            elseif cmd == "sit" then
                if humanoid then humanoid.Sit = true end

            elseif cmd == "fly" then
                local val = tonumber(arg1) or 50
                if rootPart and not rootPart:FindFirstChild("WarnX_Fly") then
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "WarnX_Fly"
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Parent = rootPart
                    FlyConn = RunService.RenderStepped:Connect(function()
                        if rootPart and rootPart:FindFirstChild("WarnX_Fly") then
                            local cam = workspace.CurrentCamera
                            bv.Velocity = cam.CFrame.LookVector * (val * 2)
                        end
                    end)
                end
            elseif cmd == "unfly" then
                if rootPart and rootPart:FindFirstChild("WarnX_Fly") then rootPart.WarnX_Fly:Destroy() end
                if FlyConn then FlyConn:Disconnect() end

            elseif cmd == "nofalldamage" or cmd == "nfd" then
                if humanoid then humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false) end
            elseif cmd == "bhop" then
                spawn(function()
                    while task.wait(0.1) do
                        if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                        end
                    end
                end)
            elseif cmd == "float" then
                if rootPart and not rootPart:FindFirstChild("WarnX_Float") then
                    local bp = Instance.new("BodyPosition")
                    bp.Name = "WarnX_Float"
                    bp.Position = rootPart.Position - Vector3.new(0, 3, 0)
                    bp.MaxForce = Vector3.new(0, math.huge, 0)
                    bp.Parent = rootPart
                end
            elseif cmd == "unfloat" then
                if rootPart and rootPart:FindFirstChild("WarnX_Float") then rootPart.WarnX_Float:Destroy() end

            elseif cmd == "infinitejump" or cmd == "ijump" then
                _G.InfJump = not _G.InfJump
                UserInputService.JumpRequest:Connect(function()
                    if _G.InfJump and humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end)

            elseif cmd == "spin" then
                local val = tonumber(arg1) or 100
                if rootPart and not rootPart:FindFirstChild("WarnX_Spin") then
                    local bg = Instance.new("BodyAngularVelocity")
                    bg.Name = "WarnX_Spin"
                    bg.AngularVelocity = Vector3.new(0, val, 0)
                    bg.MaxTorque = Vector3.new(0, math.huge, 0)
                    bg.Parent = rootPart
                end
            elseif cmd == "unspin" then
                if rootPart and rootPart:FindFirstChild("WarnX_Spin") then rootPart.WarnX_Spin:Destroy() end

            elseif cmd == "noclip" then
                if not NoclipConn then
                    NoclipConn = RunService.Stepped:Connect(function()
                        if LocalPlayer.Character then
                            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                                if part:IsA("BasePart") then part.CanCollide = false end
                            end
                        end
                    end)
                end
            elseif cmd == "clip" then
                if NoclipConn then NoclipConn:Disconnect() NoclipConn = nil end

            elseif cmd == "invisible" or cmd == "inv" then
                if char then
                    for _, p in ipairs(char:GetDescendants()) do
                        if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = 1 end
                    end
                end
            elseif cmd == "visible" or cmd == "vis" then
                if char then
                    for _, p in ipairs(char:GetDescendants()) do
                        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then p.Transparency = 0 end
                    end
                end

            elseif cmd == "btools" then
                for _, typeName in ipairs({"Hammer", "Clone", "Grab"}) do
                    local t = Instance.new("HopperBin")
                    t.BinType = Enum.BinType[typeName]
                    t.Parent = LocalPlayer.Backpack
                end

            -- Teleport & Target Commands
            elseif cmd == "goto" or cmd == "tp" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and rootPart then
                    rootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end

            elseif cmd == "bring" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and rootPart then
                    targetPlayer.Character.HumanoidRootPart.CFrame = rootPart.CFrame + Vector3.new(0, 3, 0)
                end

            elseif cmd == "heal" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.Health = targetPlayer.Character.Humanoid.MaxHealth
                elseif humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end

            elseif cmd == "god" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.MaxHealth = math.huge
                    targetPlayer.Character.Humanoid.Health = math.huge
                elseif humanoid then
                    humanoid.MaxHealth = math.huge
                    humanoid.Health = math.huge
                end

            elseif cmd == "ungod" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.MaxHealth = 100
                    targetPlayer.Character.Humanoid.Health = 100
                elseif humanoid then
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end

            elseif cmd == "kill" then
                local targetPlayer = FindPlayer(arg1)
                if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                    targetPlayer.Character.Humanoid.Health = 0
                elseif humanoid then
                    humanoid.Health = 0
                end

            elseif cmd == "day" then Lighting.TimeOfDay = "14:00:00"
            elseif cmd == "night" then Lighting.TimeOfDay = "00:00:00"
            elseif cmd == "bright" then Lighting.Brightness = 5 Lighting.GlobalShadows = false
            elseif cmd == "dark" then Lighting.Brightness = 0 Lighting.GlobalShadows = true
            elseif cmd == "fogoff" then Lighting.FogEnd = 999999
            elseif cmd == "maxzoom" then LocalPlayer.CameraMaxZoomDistance = 10000
            elseif cmd == "minzoom" then LocalPlayer.CameraMinZoomDistance = 0.5
            elseif cmd == "unlockcam" then LocalPlayer.CameraMode = Enum.CameraMode.Classic

            elseif cmd == "rejoin" or cmd == "rj" then
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            elseif cmd == "respawn" or cmd == "res" then
                if humanoid then humanoid.Health = 0 end
            elseif cmd == "clear" or cmd == "cls" then
                CmdTextBox.Text = ""
            elseif cmd == "fps" then
                local s = Instance.new("ScreenGui") s.Name = "FPS_GUI" s.Parent = PlayerGui
                local l = Instance.new("TextLabel") l.Size = UDim2.new(0, 100, 0, 30) l.Position = UDim2.new(0, 10, 0, 10) l.Parent = s
                RunService.RenderStepped:Connect(function(dt) l.Text = "FPS: " .. math.floor(1/dt) end)
            elseif cmd == "ping" then
                print("Network Ping: " .. math.floor(LocalPlayer:GetNetworkPing() * 1000) .. " ms")
            elseif cmd == "copyname" then setclipboard(LocalPlayer.Name)
            elseif cmd == "copyid" then setclipboard(tostring(LocalPlayer.UserId))

            elseif cmd == "esp" then
                EspEnabled = not EspEnabled
                if EspEnabled then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and not EspHighlights[p] then
                            local hl = Instance.new("Highlight")
                            hl.FillColor = Color3.fromRGB(138, 43, 226)
                            hl.OutlineColor = Color3.fromRGB(255, 215, 0)
                            hl.Parent = p.Character
                            EspHighlights[p] = hl
                        end
                    end
                else
                    for _, hl in pairs(EspHighlights) do if hl then hl:Destroy() end end
                    EspHighlights = {}
                end
            elseif cmd == "partcount" then print("Total Parts: " .. #workspace:GetDescendants())
            elseif cmd == "cleargui" then
                for _, g in ipairs(PlayerGui:GetChildren()) do
                    if g ~= ScreenGui and g:IsA("ScreenGui") then g:Destroy() end
                end
            elseif cmd == "close" or cmd == "exit" then ScreenGui:Destroy()
            elseif cmd == "time" then print(os.date("%X"))
            elseif cmd == "date" then print(os.date("%x"))
            elseif cmd == "placeid" then print("PlaceID: " .. game.PlaceId)
            elseif cmd == "gameid" then print("GameID: " .. game.GameId)
            elseif cmd == "version" then print("Roblox Version: " .. version())
            elseif cmd == "unload" then ScreenGui:Destroy()
            elseif cmd == "volume" then UserSettings():GetService("UserGameSettings").MasterVolume = (tonumber(arg1) or 100) / 100
            elseif cmd == "maxplayers" then print("Max Players: " .. game.MaxPlayers)
            elseif cmd == "playerlist" then for _, p in ipairs(Players:GetPlayers()) do print(p.Name) end
            elseif cmd == "sitdown" then if humanoid then humanoid.Sit = true end
            elseif cmd == "jump" then if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
            else
                local customFn = loadstring(text)
                if customFn then customFn() end
            end
        end)
    end)
end

RunBtn.MouseButton1Click:Connect(ExecuteCommand)
CmdTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        ExecuteCommand()
    end
end)

print("WarnX Ultimate Suite with Target System loaded successfully by rbxWarnX!")
