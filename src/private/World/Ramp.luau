--!strict
-- Ayden
-- Sep 29th, 2026

-- TEST CODE
-- Will be optimized in the futere to include logic that only allows our attacker to use, nobody else
-- Holder logic should be removed, as we'll detect directly off the players account and get their role

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Charm = require(ReplicatedStorage.Packages.Charm)
local Janitor = require(ReplicatedStorage.Packages.Janitor) --TODO: Make janitor package upper

local Shared = ReplicatedStorage.Shared
local Observers = require(Shared.Util.Observers)

local RampStore = require("../System/Stores/RampStore")

local MIN_ANGLE, MAX_ANGLE = 0, 30
local ANGLE_PER_SECOND = 15

local BUTTONS: {[string]: Button} = {
    Increase = {
        action = "Raise",
        direction = 1
    },
    Decrease = {
        action = "Lower",
        direction = -1
    }
}

type Holder = { client: Player, direction: number }
type Button = { action: string, direction: number }

local ramp = workspace:WaitForChild("Essentials"):WaitForChild("Ramps")
local buttons = ramp:WaitForChild("Buttons")

local job = Janitor.new()
job:LinkToInstance(ramp)

local prompts: { [string]: ProximityPrompt } = {}
local getHolder, setHolder = Charm.signal(nil :: Holder?)

function GetRemaining(direction: number, angle: number): number
    return if direction > 0 then MAX_ANGLE - angle else angle - MIN_ANGLE
end

local getVelocity = Charm.computed(function(): number
    local holder = getHolder()
    if not holder or GetRemaining(holder.direction, RampStore.getAngle()) <= 0 then
        return 0
    end

    return holder.direction
end)

for name, button in pairs(BUTTONS) do
    local prompt = Instance.new("ProximityPrompt")
    prompt.ActionText = button.action
    prompt.ObjectText = "Ramp"
    prompt.RequiresLineOfSight = false
    prompt.Style = Enum.ProximityPromptStyle.Custom
    prompt.Parent = buttons:WaitForChild(name)
    prompts[name] = job:Add(prompt)

    job:Add(prompt.PromptButtonHoldBegan:Connect(function(client: Player)
        if not getHolder() then
            setHolder({
                client = client,
                direction = button.direction
            })
        end
    end))
    job:Add(prompt.PromptButtonHoldEnded:Connect(function(client: Player)
        local holder = getHolder()
        if holder and holder.client == client and holder.direction == button.direction then
            setHolder(nil)
        end
    end))
end

job:Add(Charm.effect(function(): ...(() -> ())?
    if getHolder() then
        return
    end

    local angle = RampStore.getAngle()
    for name, button in pairs(BUTTONS) do
        local remaining = GetRemaining(button.direction, angle)
        prompts[name].HoldDuration = remaining / ANGLE_PER_SECOND
        prompts[name].Enabled = remaining > 0
    end
end), true)

job:Add(Charm.effect(function(): ...(() -> ())?
    local velocity = getVelocity()
    if velocity == 0 then
        return
    end

    local connection = RunService.Heartbeat:Connect(function(deltaTime: number)
        RampStore.setAngle(math.clamp(RampStore.getAngle() + velocity * ANGLE_PER_SECOND * deltaTime, MIN_ANGLE, MAX_ANGLE))
    end)

    return function()
        connection:Disconnect()
    end
end), true)

-- This will be more tied into the store that handles rounds
job:Add(Observers.observePlayers(function(player: Player)
    return function()
        local holder = getHolder()
        if holder and holder.client == player then
            setHolder(nil)
        end
    end
end), true)

return nil