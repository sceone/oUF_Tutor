local addon, ns = ...
local C, A, M = unpack(ns)

------------------------------
-- media
------------------------------

local bgTex = C.media.backdrop
local edgeTex = C.media.edge
local healthTex = C.media.healthTex
local powerTex = C.media.powerTex
local font1 = C.media.font1
local font2 = C.media.font2
local backdropTbl = {
	bgFile = bgTex,
	tile = true,
	tileSize = 16,
}

------------------------------
-- Layout API
------------------------------

A.InitButton = function(f, unit)
	f:SetScript("OnEnter", UnitFrame_OnEnter)
	f:SetScript("OnLeave", UnitFrame_OnLeave)
	
	f:SetFrameStrata("LOW")
	
	--if unit:match("(raid)%d?$") ~= "raid" and unit:match("(party)%d?$") ~= "party" then
	if unit:match("(boss)%d?$") == "boss" then
		f:SetSize(C["boss"]["width"], C["boss"]["height"])
	elseif not unit:find("raid") then
		f:SetSize(C[unit]["width"], C[unit]["height"])
	end
	
	f:SetBackdrop(backdropTbl)
	f:SetBackdropColor(.1, .1, .1)
	A.CreateShadow(f)
end

A.CreateHealth = function(f)
	local health = CreateFrame("StatusBar", nil, f)
	health:SetFrameStrata(f:GetFrameStrata())
	health:SetPoint("TOPLEFT")
	health:SetPoint("TOPRIGHT")
	health:SetStatusBarTexture(healthTex)
	
	if f.unit == "player" or f.unit == "target" or f.unit:match("(boss)%d?$") == "boss" then
		health:SetHeight(f:GetHeight() - 10)
	else
		health:SetHeight(f:GetHeight() - 7)
	end
	
	health.bg = health:CreateTexture(nil, "BACKGROUND")
	health.bg:SetAllPoints()
	health.bg:SetTexture(bgTex)
	
	A.AddSettings(health, "frequentUpdates", "colorClass", "colorHealth")
	health.bg.multiplier = 0.2
	
	f.Health = health
end

A.CreatePower = function(f)
	local power = CreateFrame("StatusBar", nil, f)
	power:SetFrameStrata(f:GetFrameStrata())
	power:SetPoint("BOTTOMLEFT")
	power:SetPoint("BOTTOMRIGHT")
	power:SetStatusBarTexture(powerTex)
	
	if f.unit == "player" or f.unit == "target" or f.unit:match("(boss)%d?$") == "boss" then
		power:SetHeight(9)
	else
		power:SetHeight(6)
	end
		
	power.bg = power:CreateTexture(nil, "BACKGROUND")
	power.bg:SetAllPoints()
	power.bg:SetTexture(bgTex)
	
	A.AddSettings(power, "colorPower", "colorClass")
	power.bg.multiplier = 0.2
	
	f.Power = power
end

A.CreateTexts = function(f)
	local parent = f.Health or f
	
	local name = parent:CreateFontString(nil, "OVERLAY")
	
	local healthVal = parent:CreateFontString(nil, "OVERLAY")
	healthVal:SetTextColor(.8, .8, .8)
	
	if f.unit == "player" or f.unit == "target" or f.unit:match("(boss)%d?$") == "boss" then
		name:SetFont(font1, 14, "OUTLINE")
		name:SetPoint("TOPLEFT", 8, -4)
		f:Tag(name, "[level] [name]")
	
		healthVal:SetFont(font2, 12, "OUTLINE")
		healthVal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8, 3)
		f:Tag(healthVal, "[curhp] | [perhp]%")
		
		local powerVal = parent:CreateFontString(nil, "OVERLAY")
		powerVal:SetFont(font2, 12, "OUTLINE")
		powerVal:SetPoint("BOTTOMLEFT", f, "BOTTOMLEFT", 8, 3)
		powerVal:SetTextColor(.8, .8, .8)
		f:Tag(powerVal, "[curpp]")
		f.PowerValue = powerVal
	else
		name:SetFont(font1, 12, "OUTLINE")
		name:SetPoint("LEFT", 6, 0)
		f:Tag(name, "[name]")
	
		healthVal:SetFont(font2, 11, "OUTLINE")
		healthVal:SetPoint("RIGHT", -4, 0)
		f:Tag(healthVal, "[perhp]%")
	end
	
	f.Name = name
	f.HealthValue = healthVal
end

A.Position = function(f)
	local unit = f.unit
	local pos = C[unit] and C[unit]["pos"]
	if not pos then return end
	
	local rel1, anchor, rel2, offx, offy = unpack(pos)
	anchor = A.GetAnchor(anchor)

	f:SetPoint(rel1, anchor, rel2, offx, offy)
end

A.AddSettings = function(element, ...)
	for _, key in pairs({...}) do
		if not element[key] then
			element[key] = true
		end
	end
end

------------------------------
-- Util
------------------------------

A.CreateShadow = function(f)
	if f.Shadow then return end
	
	local shadow = CreateFrame("Frame", nil, f)
	shadow:SetFrameStrata(f:GetFrameStrata())
	shadow:SetFrameLevel( max(0, f:GetFrameLevel() - 1) )
	shadow:SetPoint("TOPLEFT", -4, 4)
	shadow:SetPoint("BOTTOMRIGHT", 4, -4)
	
	shadow:SetBackdrop({
		edgeFile = edgeTex,
		edgeSize = 4,
		insets = {left = 4, right = 4, top = 4, bottom = 4}
	})
	shadow:SetBackdropColor(1, 1, 1, 0)
	shadow:SetBackdropBorderColor(0, 0, 0, .8)
	
	f.Shadow = shadow
end

A.GetAnchor = function(anchor)
	if type(anchor) == "string" then
		return _G[ M.GlobalName[anchor] ]
	else
		return anchor
	end
end

