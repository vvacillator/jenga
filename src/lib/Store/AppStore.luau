--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)

local getAccount, setAccount = Charm.signal(types.accountTemplate)
local getRampAngle, setRampAngle = Charm.signal(0)

return {
	-- Accounts
	getAccount = getAccount,
	setAccount = setAccount,

	-- Ramp
	getRampAngle = getRampAngle,
	setRampAngle = setRampAngle
}