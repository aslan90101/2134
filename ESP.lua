local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Undebolted/FTAP/refs/heads/main/OrionLib.lua')))()
local Window = OrionLib:MakeWindow({Name = "ESP Menu", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

-- ESP Settings
local ESPSettings = {
    Names = false,
    Box = false,
    HP = false,
    Traces = false,
    Chams = false,
    NameColor = Color3.fromRGB(255, 255, 255),
    BoxColor = Color3.fromRGB(255, 0, 0),
    HPColor = Color3.fromRGB(0, 255, 0),
    TracesColor = Color3.fromRGB(255, 255, 0),
    ChamsColor = Color3.fromRGB(0, 0, 255)
}

-- Main ESP Tab
local ESPTab = Window:MakeTab({
    Name = "ESP",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Enable ESP Toggle
ESPTab:AddToggle({
    Name = "Enable ESP",
    Default = false,
    Callback = function(Value)
        -- ESP Enable/Disable logic here
    end    
})

-- ESP Features Section
local ESPSection = ESPTab:AddSection({
    Name = "ESP Features"
})

-- Names Toggle
ESPSection:AddToggle({
    Name = "Names",
    Default = false,
    Callback = function(Value)
        ESPSettings.Names = Value
    end    
})

-- Names Color Picker
ESPSection:AddColorpicker({
    Name = "Names Color",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(Value)
        ESPSettings.NameColor = Value
    end  
})

-- Box Toggle
ESPSection:AddToggle({
    Name = "Box",
    Default = false,
    Callback = function(Value)
        ESPSettings.Box = Value
    end    
})

-- Box Color Picker
ESPSection:AddColorpicker({
    Name = "Box Color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Value)
        ESPSettings.BoxColor = Value
    end  
})

-- HP Toggle
ESPSection:AddToggle({
    Name = "HP",
    Default = false,
    Callback = function(Value)
        ESPSettings.HP = Value
    end    
})

-- HP Color Picker
ESPSection:AddColorpicker({
    Name = "HP Color",
    Default = Color3.fromRGB(0, 255, 0),
    Callback = function(Value)
        ESPSettings.HPColor = Value
    end  
})

-- Traces Toggle
ESPSection:AddToggle({
    Name = "Traces",
    Default = false,
    Callback = function(Value)
        ESPSettings.Traces = Value
    end    
})

-- Traces Color Picker
ESPSection:AddColorpicker({
    Name = "Traces Color",
    Default = Color3.fromRGB(255, 255, 0),
    Callback = function(Value)
        ESPSettings.TracesColor = Value
    end  
})

-- Chams Toggle
ESPSection:AddToggle({
    Name = "Chams",
    Default = false,
    Callback = function(Value)
        ESPSettings.Chams = Value
    end    
})

-- Chams Color Picker
ESPSection:AddColorpicker({
    Name = "Chams Color",
    Default = Color3.fromRGB(0, 0, 255),
    Callback = function(Value)
        ESPSettings.ChamsColor = Value
    end  
})

-- ESP Functionality
local function CreateESP(player)
    local ESP = {
        Name = Drawing.new("Text"),
        Box = Drawing.new("Square"),
        HP = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        Cham = Instance.new("Highlight")
    }
    
    -- Set up ESP components
    ESP.Name.Visible = false
    ESP.Name.Size = 14
    ESP.Name.Center = true
    ESP.Name.Outline = true
    
    ESP.Box.Visible = false
    ESP.Box.Thickness = 1
    ESP.Box.Filled = false
    
    ESP.HP.Visible = false
    ESP.HP.Size = 14
    ESP.HP.Center = true
    ESP.HP.Outline = true
    
    ESP.Tracer.Visible = false
    ESP.Tracer.Thickness = 1
    
    ESP.Cham.FillTransparency = 0.5
    ESP.Cham.OutlineTransparency = 0
    ESP.Cham.Parent = player.Character
    
    -- Update ESP
    game:GetService("RunService").RenderStepped:Connect(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local pos, visible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            -- Update Name ESP
            if ESPSettings.Names then
                ESP.Name.Visible = visible
                ESP.Name.Position = Vector2.new(pos.X, pos.Y - 40)
                ESP.Name.Text = player.Name
                ESP.Name.Color = ESPSettings.NameColor
            else
                ESP.Name.Visible = false
            end
            
            -- Update Box ESP
            if ESPSettings.Box then
                ESP.Box.Visible = visible
                ESP.Box.Color = ESPSettings.BoxColor
                -- Box position calculation here
            else
                ESP.Box.Visible = false
            end
            
            -- Update HP ESP
            if ESPSettings.HP and humanoid then
                ESP.HP.Visible = visible
                ESP.HP.Position = Vector2.new(pos.X, pos.Y + 20)
                ESP.HP.Text = math.floor(humanoid.Health) .. "/" .. math.floor(humanoid.MaxHealth)
                ESP.HP.Color = ESPSettings.HPColor
            else
                ESP.HP.Visible = false
            end
            
            -- Update Tracer ESP
            if ESPSettings.Traces then
                ESP.Tracer.Visible = visible
                ESP.Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                ESP.Tracer.To = Vector2.new(pos.X, pos.Y)
                ESP.Tracer.Color = ESPSettings.TracesColor
            else
                ESP.Tracer.Visible = false
            end
            
            -- Update Chams
            if ESPSettings.Chams then
                ESP.Cham.Enabled = true
                ESP.Cham.FillColor = ESPSettings.ChamsColor
                ESP.Cham.OutlineColor = ESPSettings.ChamsColor
            else
                ESP.Cham.Enabled = false
            end
        else
            ESP.Name.Visible = false
            ESP.Box.Visible = false
            ESP.HP.Visible = false
            ESP.Tracer.Visible = false
            ESP.Cham.Enabled = false
        end
    end)
end

-- Create ESP for all players
for _, player in ipairs(game.Players:GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        CreateESP(player)
    end
end

-- Create ESP for new players
game.Players.PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        CreateESP(player)
    end
end)

OrionLib:Init()
