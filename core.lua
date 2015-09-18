local addon, ns = ...
local C, A, M = unpack(ns)

M.GlobalName = {
	["player"] = "oUF_TutorPlayer",
	["pet"] = "oUF_TutorPet",
	["target"] = "oUF_TutorTarget",
	["targettarget"] = "oUF_TutorTargetTarget",
	["focus"] = "oUF_TutorFocus",
	["focustarget"] = "oUF_TutorFocusTarget",
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

M.styles["pet"] = function(f, unit)
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
	
	A.AddSettings(f.Health, "colorTapping", "colorDisconnected", "colorReaction")
	A.AddSettings(f.Power, "colorTapping", "colorDisconnected", "colorReaction")
end

M.styles["targettarget"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
	
	A.AddSettings(f.Health, "colorTapping", "colorDisconnected", "colorReaction")
	A.AddSettings(f.Power, "colorTapping", "colorDisconnected", "colorReaction")
end

M.styles["focus"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
	
	A.AddSettings(f.Health, "colorTapping", "colorDisconnected", "colorReaction")
	A.AddSettings(f.Power, "colorTapping", "colorDisconnected", "colorReaction")
end

M.styles["focustarget"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
	
	A.AddSettings(f.Health, "colorTapping", "colorDisconnected", "colorReaction")
	A.AddSettings(f.Power, "colorTapping", "colorDisconnected", "colorReaction")
end

M.styles["boss"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreateTexts(f)
	
	A.AddSettings(f.Health, "colorReaction")
	A.AddSettings(f.Power, "colorReaction")
end

M.Styler = function(f, unit)
	if M.styles[unit] then
		M.styles[unit](f, unit)
	elseif unit:find("boss") then
		M.styles["boss"](f, unit)
	elseif unit:find("raid") then
		local parent = f:GetParent():GetName()
		if parent:find("party") then
		elseif parent:find("raid") then
		end
	end
end

------------------------------
-- spawn
------------------------------

oUF:RegisterStyle("oUF_TutorStyle", M.Styler)

oUF:Spawn("player", M.GlobalName.player)
oUF:Spawn("pet", M.GlobalName.pet)
oUF:Spawn("target", M.GlobalName.target)
oUF:Spawn("targettarget", M.GlobalName.targettarget)
oUF:Spawn("focus", M.GlobalName.focus)
oUF:Spawn("focustarget", M.GlobalName.focustarget)

M.Boss = {}
for i = 1, 4 do
	local unit = "boss" .. i
	M.Boss[i] = oUF:Spawn(unit, "oUF_TutorBoss" .. i)
	if i == 1 then
		local rel1, anchor, rel2, offx, offy = unpack(C["boss"]["pos"])
		M.Boss[i]:SetPoint(rel1, anchor, rel2, offx, offy)
	else
		M.Boss[i]:SetPoint("TOPLEFT", M.Boss[i-1], "BOTTOMLEFT", 0, -60)
	end
end

------------------------------
-- layout
------------------------------

for unit, name in pairs(M.GlobalName) do
	local f = _G[name]
	if f then
		A.Position(f)
	end
end