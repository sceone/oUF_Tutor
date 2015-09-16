local addon, ns = ...
local C, A, M = unpack(ns)

M.GlobalName = {
	["player"] = "oUF_TutorPlayer",
	["target"] = "oUF_TutorTarget",
}
------------------------------
-- style funcs
------------------------------

M.styles = {}

M.styles["player"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
end

M.styles["target"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
	
	f.Health.colorTapping = true
	f.Health.colorDisconnected = true
	f.Health.colorReaction = true
	f.Power.colorTapping = true
	f.Power.colorDisconnected = true
	f.Power.colorReaction = true
end

M.Styler = function(f, unit)
	if M.styles[unit] then
		M.styles[unit](f, unit)
	end
end

------------------------------
-- spawn
------------------------------

oUF:RegisterStyle("oUF_TutorStyle", M.Styler)
oUF:Spawn("player", M.GlobalName.player)
oUF:Spawn("target", M.GlobalName.target)

------------------------------
-- layout
------------------------------

for unit, name in pairs(M.GlobalName) do
	local f = _G[name]
	if f then
		A.Position(f)
	end
end