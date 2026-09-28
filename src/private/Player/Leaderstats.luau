--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)

local accountStore = require("../System/Stores/AccountStore")

local Players = game:GetService("Players");

type Account = types.Account

Charm.observe(accountStore.getAccounts, function(initialAccount: Account, username: string)
    local player = Players:FindFirstChild(username) :: Player?

	if not player then
		return
	end

	local getAccount = Charm.computed(function(prevAccount: Account?)
		return accountStore.getAccount(username) or prevAccount or initialAccount
	end)

    local leaderstats = Instance.new("Configuration")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local wins = Instance.new("IntValue")
	wins.Name = "Wins"
	wins.Parent = leaderstats

	Charm.effect(function()
		local account = getAccount()
        local total = (account.wins.attacker + account.wins.survivor)
		wins.Value = total
	end)
    
    return function()
        leaderstats:Destroy()
    end
end)

return nil