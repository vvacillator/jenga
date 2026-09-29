--!strict
-- Ayden
-- Sep 29th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Charm = require(ReplicatedStorage.Packages.Charm)
local Ripple = require(ReplicatedStorage.Packages.Ripple)
local Store = require(ReplicatedStorage.Shared.Store)

local core = workspace:WaitForChild("Essentials"):WaitForChild("Ramps"):WaitForChild("Core") :: BasePart
local origin = core:GetPivot()

local spring = Ripple.createSpring(0, { 
    tension = 170, 
    friction = 26, 
    start = true 
})

spring:onChange(function(angle: number)
	core:PivotTo(origin * CFrame.Angles(math.rad(angle), 0, 0))
end)

Charm.effect(function()
	spring:setGoal(Store.AppStore.getRampAngle())
end)

return nil