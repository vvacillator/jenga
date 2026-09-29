--!strict
-- Ayden
-- Sep 29th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)

local getAngle, setAngle = Charm.signal(0)

return {
	getAngle = getAngle,
	setAngle = setAngle,
}