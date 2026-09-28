--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)

local getAccount, setAccount = Charm.signal(types.accountTemplate)

return {
	getAccount = getAccount,
	setAccount = setAccount
}