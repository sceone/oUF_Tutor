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
	A.CreatePortrait(f)
	A.CreateTexts(f)
	A.CreateCastBar(f)
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
	A.CreatePortrait(f)
	A.CreateTexts(f)
	A.CreateCastBar(f)
	A.CreateAura(f, 24)
	
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
	A.CreateCastBar(f)
	A.CreateAura(f)
	
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
	A.CreateCastBar(f)
	A.CreateAura(f)
	
	A.AddSettings(f.Health, "colorReaction")
	A.AddSettings(f.Power, "colorReaction")
end

M.styles["party"] = function(f, unit)
	print(unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	A.CreatePower(f)
	A.CreatePortrait(f)
	A.CreateTexts(f)
	A.CreateCastBar(f)
	A.CreateAura(f)
	
	f.Health.colorDisconnected = true
	f.Power.colorDisconnected = true
end

M.styles["raid"] = function(f, unit)
	A.InitButton(f, unit)
	A.CreateHealth(f)
	f.Health:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
	A.CreatePower(f)
	A.CreateRaidElements(f)
	
	f.Health.colorDisconnected = true
	f.Power.colorDisconnected = true
end

M.Styler = function(f, unit)
	if M.styles[unit] then
		M.styles[unit](f, unit)
	elseif unit:find("boss") then
		M.styles["boss"](f, unit)
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

-- Group Units
M.Party = oUF:SpawnHeader(
	"oUF_TutorParty",
	nil,
	"custom [@raid1, exists] hide; [group:party,nogroup:raid] show; hide",
	-- attributes
	"initial-width", C.party.width,
	"initial-height", C.party.height,
	"ouF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"showRaid", false,
	"showParty", true,
	"showSolo", false,
	"showPlayer", false,
	"point", "TOP",
	"xOffset", 0,
	"yOffset", -50
)
M.Party:SetPoint(unpack(C.party.pos))

M.Raid25 = oUF:SpawnHeader(
	"oUF_TutorRaid25",
	nil,
	"custom [@raid26, exists] hide;show",
	-- attributes
	"initial-width", C.raid25.width,
	"initial-height", C.raid25.height,
	"ouF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"showRaid", true,
	"showParty", false,
	"showSolo", false,
	"point", "LEFT",
	"xOffset", 4,
	"maxColumns", 6,
	"unitsPerColumn", 5,
	"columnAnchorPoint", "TOP",
	"columnSpacing", 4,
	"groupBy", "GROUP",
	"groupFilter", "1,2,3,4,5,6",
	"groupingOrder", "1,2,3,4,5,6"	
)
M.Raid25:SetPoint(unpack(C.raid25.pos))

M.Raid40 = oUF:SpawnHeader(
	"oUF_TutorRaid40",
	nil,
	"custom [@raid26, exists] show;hide",
	-- attributes
	"initial-width", C.raid40.width,
	"initial-height", C.raid40.height,
	"ouF-initialConfigFunction", [[
		local header = self:GetParent()
		self:SetWidth(header:GetAttribute("initial-width"))
		self:SetHeight(header:GetAttribute("initial-height"))
	]],
	"showRaid", true,
	"showParty", false,
	"showSolo", false,
	"point", "LEFT",
	"xOffset", 4,
	"maxColumns", 8,
	"unitsPerColumn", 5,
	"columnAnchorPoint", "TOP",
	"columnSpacing", 4,
	"groupBy", "GROUP",
	"groupFilter", "1,2,3,4,5,6,7,8",
	"groupingOrder", "1,2,3,4,5,6,7,8"	
)
M.Raid40:SetPoint(unpack(C.raid40.pos))

------------------------------
-- layout
------------------------------

for unit, name in pairs(M.GlobalName) do
	local f = _G[name]
	if f then
		A.Position(f)
	end
end

------------------------------
-- kill Blizzard's raid frame
------------------------------

CompactRaidFrameManager:UnregisterAllEvents()
CompactRaidFrameManager.Show = CompactRaidFrameManager.Hide
CompactRaidFrameManager:Hide()

CompactRaidFrameContainer:UnregisterAllEvents()
CompactRaidFrameContainer.Show = CompactRaidFrameContainer.Hide
CompactRaidFrameContainer:Hide()