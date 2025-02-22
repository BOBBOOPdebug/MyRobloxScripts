-- This is your self-contained ModuleScript uploaded to GitHub or Pastebin

local module = {}

-- Dynamically create RemoteEvent (no game modification needed)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local adminRemote = Instance.new("RemoteEvent")
adminRemote.Name = "AdminRemote"
adminRemote.Parent = ReplicatedStorage

-- Listen for actions on the RemoteEvent
adminRemote.OnServerEvent:Connect(function(player, action)
    if action == "fire_all" then
        for _, p in pairs(game.Players:GetPlayers()) do
            local character = p.Character
            if character then
                local fire = Instance.new("Fire")
                fire.Size = 10
                fire.Heat = 10
                fire.Parent = character:WaitForChild("HumanoidRootPart")
            end
        end
    elseif action == "kill_all" then
        for _, p in pairs(game.Players:GetPlayers()) do
            local character = p.Character
            if character then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    elseif action == "red_skybox" then
        local lighting = game:GetService("Lighting")
        lighting.Ambient = Color3.fromRGB(255, 0, 0)
    end
end)

-- Client-Side: GUI Creation and Actions
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 450)
    frame.Position = UDim2.new(0, 50, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    frame.Parent = screenGui

    local fireButton = Instance.new("TextButton")
    fireButton.Size = UDim2.new(0, 280, 0, 50)
    fireButton.Position = UDim2.new(0, 10, 0, 70)
    fireButton.Text = "Fire All"
    fireButton.Parent = frame

    fireButton.MouseButton1Click:Connect(function()
        adminRemote:FireServer("fire_all")
    end)

    -- Other Buttons (Kill All, Red Skybox)
    local killButton = Instance.new("TextButton")
    killButton.Size = UDim2.new(0, 280, 0, 50)
    killButton.Position = UDim2.new(0, 10, 0, 130)
    killButton.Text = "Kill All"
    killButton.Parent = frame

    killButton.MouseButton1Click:Connect(function()
        adminRemote:FireServer("kill_all")
    end)

    local skyboxButton = Instance.new("TextButton")
    skyboxButton.Size = UDim2.new(0, 280, 0, 50)
    skyboxButton.Position = UDim2.new(0, 10, 0, 190)
    skyboxButton.Text = "Red Skybox"
    skyboxButton.Parent = frame

    skyboxButton.MouseButton1Click:Connect(function()
        adminRemote:FireServer("red_skybox")
    end)
end

-- Execute the GUI creation
createGUI()

return module
