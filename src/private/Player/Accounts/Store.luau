--!nocheck
-- Ayden
-- Sep 27th, 2026

-- FIXME: Remove nocheck when createPlayerStore() no longer incorrectly reports
-- that the code is too complex to typecheck

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lyra = require(ReplicatedStorage.Packages.Lyra)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)

local schema = require("./schema")
local accountStore = require("../../System/Stores/AccountStore")

local Players = game:GetService("Players")

type Account = types.Account

local function onAccountChanged(key: string, account: Account)
	local player = Players:GetPlayerByUserId(tonumber(key) :: number)
	if player then
		accountStore.setAccount(player.Name, account)
	end
end

return Lyra.createPlayerStore({
	name = "PlayerData",
	template = types.accountTemplate,
	schema = function(value)
		local ok, reason = schema:matches(value)
		return ok, tostring(reason)
	end,
	changedCallbacks = { onAccountChanged },
})