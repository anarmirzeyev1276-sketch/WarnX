-- [[ WarnX Hub - Ultimate Elite Server-Ready Script ]] --
-- [[ Supported Executors: Delta, Codex ]] --
-- [[ Upgraded with Bunny Hop, Auto-Aim & Plus Toggle by rbxWarnX ]] --

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Remove existing GUI safely
if CoreGui:FindFirstChild("WarnXHubGui") then
    CoreGui.WarnXHubGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WarnXHubGui"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Container (Modern & Professional Dark Theme with Tween support)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -230, 0.5, -170)
MainFrame.Size = UDim2.new(0, 460, 0, 340)
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(90, 50, 180) -- Professional Purple Accent
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 40)

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 10)
TopBarCorner.Parent = TopBar

-- Logo Image (Asset ID: 58597725)
local LogoImg = Instance.new("ImageLabel")
LogoImg.Parent = TopBar
LogoImg.BackgroundTransparency = 1
LogoImg.Position = UDim2.new(0, 8, 0, 6)
LogoImg.Size = UDim2.new(0, 28, 0, 28)
LogoImg.Image = "rbxassetid://58597725"

-- Title Label
local Title = Instance.new("TextLabel")
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 44, 0, 0)
Title.Size = UDim2.new(0, 250, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "WarnX Hub | Ultimate Elite"
Title.TextColor3 = Color3.fromRGB(245, 245, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Floating Kvadrat Toggle Button with "+" Symbol
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "WarnXToggleBtn"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -25)
ToggleButton.Size = UDim2.new(0, 48, 0, 48)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "+"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 24
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = ToggleButton

local ToggleStroke = Instance.new("UIStroke")
ToggleStroke.Color = Color3.fromRGB(90, 50, 180)
ToggleStroke.Thickness = 2
ToggleStroke.Parent = ToggleButton

-- Close Button (Minimize to "+" Button)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = TopBar
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
CloseBtn.BorderSizePixel = 0
CloseBtn.Position = UDim2.new(1, -34, 0, 8)
CloseBtn.Size = UDim2.new(0, 24, 0, 24)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 11

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseEnter:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(230, 50, 50)}):Play()
end)
CloseBtn.MouseLeave:Connect(function()
    TweenService:Create(CloseBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(180, 30, 30)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.2), {Size = UDim2.new(0,0,0,0)}):Play()
    task.wait(0.2)
    MainFrame.Visible = false
    MainFrame.Size = UDim2.new(0, 460, 0, 340)
    ToggleButton.Visible = true
end)

ToggleButton.MouseButton1Click:Connect(function()
    ToggleButton.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 460, 0, 340)
    }):Play()
end)

-- Sidebar
local Sidebar = Instance.new("ScrollingFrame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Position = UDim2.new(0, 0, 0, 40)
Sidebar.Size = UDim2.new(0, 130, 1, -40)
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 300)
Sidebar.ScrollBarThickness = 2

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Parent = Sidebar
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 135, 0, 46)
ContentArea.Size = UDim2.new(1, -145, 1, -52)

local Pages = {}

local function CreatePage(name)
    local PageFrame = Instance.new("ScrollingFrame")
    PageFrame.Name = name .. "Page"
    PageFrame.Parent = ContentArea
    PageFrame.BackgroundTransparency = 1
    PageFrame.Size = UDim2.new(1, 0, 1, 0)
    PageFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
    PageFrame.ScrollBarThickness = 3
    PageFrame.ScrollBarImageColor3 = Color3.fromRGB(90, 50, 180)
    PageFrame.Visible = false

    local Layout = Instance.new("UIListLayout")
    Layout.Parent = PageFrame
    Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Layout.Padding = UDim.new(0, 6)

    Pages[name] = PageFrame
    return PageFrame
end

local function CreateTab(name, isDefault)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Parent = Sidebar
    TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    TabBtn.BorderSizePixel = 0
    TabBtn.Size = UDim2.new(1, 0, 0, 36)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(160, 160, 180)
    TabBtn.TextSize = 12

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = TabBtn

    local page = CreatePage(name)

    if isDefault then
        page.Visible = true
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 90)
    end

    TabBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages) do p.Visible = false end
        for _, b in pairs(Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                TweenService:Create(b, TweenInfo.new(0.2), {
                    TextColor3 = Color3.fromRGB(160, 160, 180),
                    BackgroundColor3 = Color3.fromRGB(20, 20, 28)
                }):Play()
            end
        end
        page.Visible = true
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundColor3 = Color3.fromRGB(50, 30, 90)
        }):Play()
    end)
end

-- UI Component Creators with Tween Effects
local function AddButton(page, text, callback)
    local Btn = Instance.new("TextButton")
    Btn.Parent = page
    Btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Btn.Size = UDim2.new(1, -10, 0, 34)
    Btn.Font = Enum.Font.Gotham
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(230, 230, 240)
    Btn.TextSize = 12
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Btn

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(45, 45, 65)
    Stroke.Transparency = 0.5
    Stroke.Parent = Btn

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 30, 75)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(22, 22, 30)}):Play()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
    end)

    Btn.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

local function AddTextBox(page, placeholder, callback)
    local Box = Instance.new("TextBox")
    Box.Parent = page
    Box.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
    Box.Size = UDim2.new(1, -10, 0, 34)
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.PlaceholderColor3 = Color3.fromRGB(130, 130, 150)
    Box.TextSize = 12

    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box

    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(45, 45, 65)
    Stroke.Transparency = 0.5
    Stroke.Parent = Box

    Box.Focused:Connect(function()
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)
    Box.FocusLost:Connect(function(enterPressed)
        TweenService:Create(Stroke, TweenInfo.new(0.2), {Transparency = 0.5}):Play()
        if enterPressed then
            pcall(function()
                callback(Box.Text)
            end)
        end
    end)
end

-- Initialize Tabs
CreateTab("Combat", true)
CreateTab("Movement", false)
CreateTab("Visuals", false)
CreateTab("Character", false)
CreateTab("Teleport", false)
CreateTab("Misc", false)

-- [[ 1. COMBAT MENU ]]
local targetAimbotName = ""
AddTextBox(Pages["Combat"], "Target Aimbot (Enter Name)", function(val)
    targetAimbotName = val
end)

RunService.RenderStepped:Connect(function()
    if targetAimbotName ~= "" then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and (string.lower(p.Name):match(string.lower(targetAimbotName)) or string.lower(p.DisplayName):match(string.lower(targetAimbotName))) then
                if p.Character and p.Character:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, p.Character.Head.Position)
                end
            end
        end
    end
end)

local autoAimEnabled = false
AddButton(Pages["Combat"], "Toggle Auto-Aim (Closest Player)", function()
    autoAimEnabled = not autoAimEnabled
end)

RunService.RenderStepped:Connect(function()
    if autoAimEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local myPos = LocalPlayer.Character.HumanoidRootPart.Position
        local nearestTarget = nil
        local shortestDist = math.huge
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                local targetPos = p.Character.HumanoidRootPart.Position
                local dist = (myPos - targetPos).Magnitude
                if dist < shortestDist then
                    shortestDist = dist
                    nearestTarget = p.Character.Head
                end
            end
        end
        
        if nearestTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestTarget.Position)
        end
    end
end)

local shiftlockEnabled = false
AddButton(Pages["Combat"], "Toggle Shiftlock", function()
    shiftlockEnabled = not shiftlockEnabled
    LocalPlayer.DevEnableMouseLock = true
end)

RunService.RenderStepped:Connect(function()
    if shiftlockEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.Humanoid.AutoRotate = false
        local cameraCFrame = Camera.CFrame
        local rootPart = LocalPlayer.Character.HumanoidRootPart
        
        local targetRotation = CFrame.new(rootPart.Position, Vector3.new(cameraCFrame.LookVector.X * 9999, rootPart.Position.Y, cameraCFrame.LookVector.Z * 9999))
        rootPart.CFrame = targetRotation
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.AutoRotate = true
        end
    end
end)

AddButton(Pages["Combat"], "Hitbox Expander (!hitboxexp)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            hrp.Size = Vector3.new(5, 5, 5)
            hrp.Transparency = 0.6
            hrp.CanCollide = false
        end
    end
end)

-- [[ 2. MOVEMENT MENU ]]
AddTextBox(Pages["Movement"], "Set WalkSpeed (e.g. 50)", function(val)
    local num = tonumber(val)
    if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = num
    end
end)

AddTextBox(Pages["Movement"], "Set JumpPower (e.g. 100)", function(val)
    local num = tonumber(val)
    if num and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = num
    end
end)

AddButton(Pages["Movement"], "Speed Boost (Instant +30)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = LocalPlayer.Character.Humanoid.WalkSpeed + 30
    end
end)

-- **YENİ KOMANDA:** Bunny Hop (!bhop)
local bhopEnabled = false
AddButton(Pages["Movement"], "Toggle Bunny Hop (!bhop)", function()
    bhopEnabled = not bhopEnabled
end)

RunService.RenderStepped:Connect(function()
    if bhopEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local humanoid = LocalPlayer.Character.Humanoid
        if humanoid.FloorMaterial ~= Enum.Material.Air then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local noclipEnabled = false
AddButton(Pages["Movement"], "Toggle Noclip", function()
    noclipEnabled = not noclipEnabled
    RunService.Stepped:Connect(function()
        if noclipEnabled and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- Fly Joystick GUI Setup
local flyGui = Instance.new("ScreenGui")
flyGui.Name = "WarnXFlyJoystick"
flyGui.Parent = CoreGui
flyGui.Enabled = false
flyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local JoyFrame = Instance.new("Frame")
JoyFrame.Parent = flyGui
JoyFrame.BackgroundTransparency = 1
JoyFrame.Position = UDim2.new(0.7, 0, 0.6, 0)
JoyFrame.Size = UDim2.new(0, 140, 0, 140)

local function createJoyBtn(text, pos)
    local btn = Instance.new("TextButton")
    btn.Parent = JoyFrame
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    btn.Size = UDim2.new(0, 45, 0, 45)
    btn.Position = pos
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 11
    
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = btn
    return btn
end

local btnForward = createJoyBtn("Fwd", UDim2.new(0.35, 0, 0, 0))
local btnBack = createJoyBtn("Back", UDim2.new(0.35, 0, 0.65, 0))
local btnLeft = createJoyBtn("Left", UDim2.new(0, 0, 0.32, 0))
local btnRight = createJoyBtn("Right", UDim2.new(0.68, 0, 0.32, 0))

local flyMoving = {Fwd = false, Back = false, Left = false, Right = false}
btnForward.MouseButton1Down:Connect(function() flyMoving.Fwd = true end)
btnForward.MouseButton1Up:Connect(function() flyMoving.Fwd = false end)
btnBack.MouseButton1Down:Connect(function() flyMoving.Back = true end)
btnBack.MouseButton1Up:Connect(function() flyMoving.Back = false end)
btnLeft.MouseButton1Down:Connect(function() flyMoving.Left = true end)
btnLeft.MouseButton1Up:Connect(function() flyMoving.Left = false end)
btnRight.MouseButton1Down:Connect(function() flyMoving.Right = true end)
btnRight.MouseButton1Up:Connect(function() flyMoving.Right = false end)

local flyEnabled = false
AddButton(Pages["Movement"], "Toggle Fly (Joystick)", function()
    flyEnabled = not flyEnabled
    flyGui.Enabled = flyEnabled
    
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local root = char.HumanoidRootPart
    
    if flyEnabled then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "WarnXFlyVelocity"
        bv.Parent = root
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        task.spawn(function()
            while flyEnabled and char and char.Parent do
                local moveDir = Vector3.new(0,0,0)
                if flyMoving.Fwd then moveDir = moveDir + Camera.CFrame.LookVector end
                if flyMoving.Back then moveDir = moveDir - Camera.CFrame.LookVector end
                if flyMoving.Left then moveDir = moveDir - Camera.CFrame.RightVector end
                if flyMoving.Right then moveDir = moveDir + Camera.CFrame.RightVector end
                
                bv.Velocity = moveDir * 50
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

local infJumpEnabled = false
AddButton(Pages["Movement"], "Toggle Infinite Jump", function()
    infJumpEnabled = not infJumpEnabled
    UserInputService.JumpRequest:Connect(function()
        if infJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)
end)

-- [[ 3. VISUALS MENU ]]
AddButton(Pages["Visuals"], "Toggle ESP (Boxes)", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and not p.Character:FindFirstChild("WarnXHighlight") then
            local hl = Instance.new("Highlight")
            hl.Name = "WarnXHighlight"
            hl.Adornee = p.Character
            hl.Parent = p.Character
            hl.FillColor = Color3.fromRGB(90, 50, 180)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)
        end
    end
end)

AddButton(Pages["Visuals"], "Toggle Name ESP", function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
            if not p.Character.Head:FindFirstChild("WarnXNameTag") then
                local bg = Instance.new("BillboardGui")
                bg.Name = "WarnXNameTag"
                bg.Parent = p.Character.Head
                bg.Size = UDim2.new(0, 100, 0, 40)
                bg.StudsOffset = Vector3.new(0, 2.5, 0)
                bg.AlwaysOnTop = true
                
                local txt = Instance.new("TextLabel")
                txt.Parent = bg
                txt.BackgroundTransparency = 1
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.Font = Enum.Font.GothamBold
                txt.Text = p.Name
                txt.TextColor3 = Color3.fromRGB(150, 100, 255)
                txt.TextSize = 13
                txt.TextStrokeTransparency = 0.5
            end
        end
    end
end)

AddButton(Pages["Visuals"], "Toggle Fullbright", function()
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
end)

-- [[ 4. CHARACTER MENU ]]
AddTextBox(Pages["Character"], "Character Changer (Enter Username)", function(targetName)
    for _, p in pairs(Players:GetPlayers()) do
        if string.lower(p.Name):match(string.lower(targetName)) or string.lower(p.DisplayName):match(string.lower(targetName)) then
            if p.Character and p.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character = p.Character
                Camera.CameraSubject = p.Character.Humanoid
            end
        end
    end
end)

AddButton(Pages["Character"], "Reset Character", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end)

AddButton(Pages["Character"], "Invisible (Client-Side)", function()
    local char = LocalPlayer.Character
    if char then
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = 1
            end
        end
    end
end)

-- [[ 5. TELEPORT MENU ]]
AddTextBox(Pages["Teleport"], "Goto Player (Enter Name)", function(targetName)
    for _, p in pairs(Players:GetPlayers()) do
        if string.lower(p.Name):match(string.lower(targetName)) or string.lower(p.DisplayName):match(string.lower(targetName)) then
            if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            end
        end
    end
end)

AddButton(Pages["Teleport"], "Get Click TP Tool", function()
    local tool = Instance.new("Tool")
    tool.Name = "WarnX Click TP"
    tool.RequiresHandle = false
    tool.Parent = LocalPlayer.Backpack
    
    tool.Activated:Connect(function()
        local pos = Mouse.Hit + Vector3.new(0, 3, 0)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos.Position)
        end
    end)
end)

local touchBlockActive = false
AddTextBox(Pages["Teleport"], "Touch Block / Keep 25 Studs (Name)", function(targetName)
    touchBlockActive = false
    task.wait(0.1)
    
    local targetPlayer = nil
    for _, p in pairs(Players:GetPlayers()) do
        if string.lower(p.Name):match(string.lower(targetName)) or string.lower(p.DisplayName):match(string.lower(targetName)) then
            targetPlayer = p
            break
        end
    end
    
    if targetPlayer then
        touchBlockActive = true
        task.spawn(function()
            while touchBlockActive do
                task.wait()
                if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local targetHrp = targetPlayer.Character.HumanoidRootPart
                    local myHrp = LocalPlayer.Character.HumanoidRootPart
                    
                    local direction = (myHrp.Position - targetHrp.Position).Unit
                    if direction.Magnitude == 0 then direction = Vector3.new(1,0,0) end
                    myHrp.CFrame = CFrame.new(targetHrp.Position + (direction * 25), targetHrp.Position)
                end
            end
        end)
    end
end)

AddButton(Pages["Teleport"], "Stop Touch Block / Distance Lock", function()
    touchBlockActive = false
end)

-- [[ 6. MISC MENU ]]
AddButton(Pages["Misc"], "Godmode (Infinite Health)", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        hum.MaxHealth = math.huge
        hum.Health = math.huge
    end
end)

AddTextBox(Pages["Misc"], "Set FOV (e.g. 120)", function(val)
    local num = tonumber(val)
    if num then
        Camera.FieldOfView = num
    end
end)

AddButton(Pages["Misc"], "Blink (Teleport Forward)", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 15)
    end
end)

AddButton(Pages["Misc"], "Toggle Third Person (!thirdperson)", function()
    LocalPlayer.CameraMode = Enum.CameraMode.Classic
    LocalPlayer.CameraMaxZoomDistance = 30
    LocalPlayer.CameraMinZoomDistance = 10
end)

AddButton(Pages["Misc"], "FPS Boost (!fpsboost)", function()
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")
    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveTransparency = 1
        Terrain.WaterTransparency = 1
    end
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") or v:IsA("Sky") then
            v:Destroy()
        end
    end
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end)

AddButton(Pages["Misc"], "Server Hop (!serverhop)", function()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

AddButton(Pages["Misc"], "Rejoin Server (!rejoin)", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

print("WarnX Hub Ultimate (With Bunny Hop) Loaded Successfully!")
