--[[
    By Louis
    2026-10-24 | 1:45 AM
    ΩMEGA DEVICE v0.8
]]

local VERSION = "0.8"

local workspace = game:GetService("Workspace")
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local starterGui = game:GetService("StarterGui")

local function log(message)
    print("[ΩMEGA v" .. VERSION .. "] " .. message)
end

log("Starting collapse protocol...")

local localPlayer = players.LocalPlayer
local myCharacter = localPlayer and localPlayer.Character
local camera = workspace.CurrentCamera

-- Schedule the disconnect
task.delay(10, function()
    pcall(function()
        if localPlayer then
            localPlayer:Kick(
                "\n\n[ΩMEGA DEVICE]\nLouis erased his reality\n"
            )
        end
    end)
end)

-- Hide the default interface
pcall(function()
    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)

-- Clear selected client containers
local coreContainers = {
    game:GetService("ReplicatedStorage"),
    game:GetService("ReplicatedFirst"),
    localPlayer and localPlayer:FindFirstChildOfClass("PlayerGui")
}

for _, container in ipairs(coreContainers) do
    if container then
        pcall(function()
            for _, child in ipairs(container:GetChildren()) do
                child:Destroy()
            end
        end)
    end
end

-- Darken the environment
pcall(function()
    lighting.Ambient = Color3.fromRGB(0, 0, 0)
    lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)

    local sky = lighting:FindFirstChildOfClass("Sky")
    if sky then
        sky:Destroy()
    end
end)

-- Remove selected world objects locally
local function hardErase(instance)
    pcall(function()
        instance:Destroy()
    end)
end

for _, child in ipairs(workspace:GetChildren()) do
    if child ~= workspace.Terrain
        and child ~= camera
        and child ~= myCharacter then
        hardErase(child)
    end
end

-- Check for remaining objects
for _, descendant in ipairs(workspace:GetDescendants()) do
    if descendant ~= workspace.Terrain
        and descendant ~= camera
        and descendant ~= myCharacter
        and descendant.Parent then
        hardErase(descendant)
    end
end

-- Remove the character and camera
if myCharacter then
    hardErase(myCharacter)
end

if camera then
    pcall(function()
        camera:Destroy()
    end)
end

log("Cleanup complete.")