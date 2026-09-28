--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Charm = require(ReplicatedStorage.Packages.Charm)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)
local objects = require(Shared.object)

export type Account = types.Account

type Accounts = {
	[string]: Account,
}

local getAccounts, setAccounts = Charm.signal({} :: Accounts)

local function getAccount(username: string): Account?
	return getAccounts()[username]
end

local function setAccount(username: string, account: Account)
	setAccounts(function(state: Accounts)
		return objects.set(state, username, account)
	end)
end

local function removeAccount(username: string)
	setAccounts(function(state: Accounts)
		return objects.delete(state, username)
	end)
end

return {
	getAccounts = getAccounts,
	getAccount = getAccount,
	setAccount = setAccount,
	removeAccount = removeAccount,
}