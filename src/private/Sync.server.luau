--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Jolt = require(ReplicatedStorage.Packages.Jolt)
local Charm = require(ReplicatedStorage.Packages.Charm)
local CharmSync = require(ReplicatedStorage.Packages.CharmSync)

local Shared = ReplicatedStorage.Shared
local observers = require(Shared.Util.Observers)

local accountStore = require("./System/Stores/AccountStore")

local Remote = Jolt.Server "Sync"

CharmSync.server.connect(function(client, updates)
    Remote:Fire(client, updates)
    print(updates)
end)

observers.observePlayers(function(player: Player): (() -> ())?
    CharmSync.server.addSignalsToClient(player, {
        [`account-{player.Name}`] = Charm.computed(function()
            return accountStore.getAccount(player.Name)
        end)
    })

    return function()
        CharmSync.server.removeClient(player)
    end
end)