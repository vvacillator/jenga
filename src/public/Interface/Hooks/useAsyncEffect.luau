local ReplicatedStorage = game:GetService("ReplicatedStorage")
local react = require(ReplicatedStorage.Packages.React)
local Promise = require(ReplicatedStorage.Packages.Promise)

type Promise = unknown

type EffectCallback = () -> ()
type PromiseCallback = () -> Promise

type Callback = EffectCallback | PromiseCallback

--[[
	Runs an async effect and cancels the promise when unmounting the effect.
	Note that effects paused by `:await()` still run while cancelled, so prefer
	to use promise chaining instead.

	@param effect The async effect to run.
	@param deps The dependencies to run the effect on.
]]
local function useAsyncEffect(effect: Callback, deps: { any }?): ()
	react.useEffect(function()
		local callback: Promise
		if Promise.is(effect) then
			callback = (effect :: PromiseCallback)()
		else
			callback = Promise.try(effect)
		end

		return function()
			callback:cancel()
		end
	end, deps)
end

return useAsyncEffect