-- Kristian Hub - Simplificado (sin verificación)
local scriptURL = "https://pastebin.com/raw/4wEqQep8" -- ← Este sí es real

local success, response = pcall(function()
    local code = game:HttpGet(scriptURL)
    assert(code and code ~= "", "Script vacío o no cargado")
    loadstring(code)()
end)

if not success then
    local errorMsg = typeof(response) == "string" and response or "Unknown Error"

    local gui = Instance.new("ScreenGui")
    gui.Name = "Kristian Hub"
    gui.IgnoreGuiInset = true
    gui.ResetOnSpawn = false
    gui.Parent = game:GetService("CoreGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 0, 0, 0)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = gui

    local corner = Instance.new("UICorner", frame)
    corner.CornerRadius = UDim.new(0, 8)

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, 0, 0, 20)
    bar.Position = UDim2.new(0, 0, 0, 10)
    bar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local label = Instance.new("TextLabel")
    label.Text = "Kristian Hub Error:\n" .. errorMsg
    label.Size = UDim2.new(1, -20, 0, 40)
    label.Position = UDim2.new(0, 10, 0, 35)
    label.TextWrapped = true
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.BackgroundTransparency = 1
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Top
    label.Parent = frame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Text = "Cerrar"
    closeBtn.Size = UDim2.new(0, 60, 0, 25)
    closeBtn.Position = UDim2.new(1, -70, 1, -35)
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.Gotham
    closeBtn.TextSize = 12
    closeBtn.Parent = frame

    local btnCorner = Instance.new("UICorner", closeBtn)
    btnCorner.CornerRadius = UDim.new(0, 6)

    frame:TweenSizeAndPosition(
        UDim2.new(0, 300, 0, 100),
        UDim2.new(0.5, -150, 0.5, -50),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quad,
        0.5,
        true
    )

    task.delay(0.1, function()
        frame.BackgroundTransparency = 0
    end)

    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    task.delay(10, function()
        if gui and gui.Parent then
            game:Kick("Kristian Hub Error:\n" .. errorMsg)
        end
    end)
end
