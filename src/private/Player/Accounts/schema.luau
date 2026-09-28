--!strict
-- Ayden
-- Sep 27th, 2026

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local gt = require(ReplicatedStorage.Packages.gt)

local Shared = ReplicatedStorage.Shared
local types = require(Shared.types)

type Account = types.Account

local accountSchema: Account = gt.table({
    wins = gt.table({
        survivor = gt.number(),
        attacker = gt.number()
    })
})

return gt.build(accountSchema)