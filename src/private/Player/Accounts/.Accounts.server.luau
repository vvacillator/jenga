--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local Shared = ReplicatedStorage.Shared
local Observers = require(Shared.Util.Observers)

local Store = require("./Store")
local AccountStore = require("../../System/Stores/AccountStore")

game:BindToClose(function()
    Store:closeAsync()
end)

Observers.observePlayers(function(player: Player): (() -> ())?
    Store:load(player)

    return function()
        Store:unload(player)
        AccountStore.removeAccount(player.Name)
    end
end)