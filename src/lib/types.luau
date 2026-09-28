--!strict
-- Ayden
-- Sep 27th, 2026

export type Account = {
    wins: {
        survivor: number,
        attacker: number
    }
}

local accountTemplate: Account = {
    wins = {
        survivor = 0,
        attacker = 0
    }
}

return {
    accountTemplate = accountTemplate
}