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
	
	if unit:match("(boss)%d?$") == "boss" then
		f:SetSize(C["boss"]["width"], C["boss"]["height"])
	elseif not (unit == "party" or unit == "raid") then
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
		name:SetPoint("TOPRIGHT", -8, -4)
		name:SetJustifyH("LEFT")
		name:SetMaxLines(1)
		f:Tag(name, "[level] [name]")
	
		healthVal:SetFont(font2, 12, "OUTLINE")
		healthVal:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -8, 3)
		f:Tag(healthVal, "[curhpabb] | [perhp]%")
		
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

A.CreatePortrait = function(f)
	if f.unit == "player" or f.unit == "target" then
		f.Health:SetPoint("TOPLEFT", 64, 0)
	else
		f.Health:SetPoint("TOPLEFT", 48, 0)
	end
	local p = CreateFrame("PlayerModel", nil, f)
	p:SetPoint("TOPLEFT", 1, -1)
	p:SetPoint("BOTTOMRIGHT", f.Health, "BOTTOMLEFT", -1, 0)
	
	f.Portrait = p
end

A.CreateCastBar = function(f)
	local unit = f.unit
	
	local cb = CreateFrame("StatusBar", f:GetName() .. "CastBar", f)
	cb:SetStatusBarTexture(powerTex)
	cb:SetStatusBarColor(1, .8, 0, 1)
	
	local bg = CreateFrame("Frame", nil, cb)
	cb.bg = bg
	bg:SetFrameLevel(0)
	bg:SetBackdrop(backdropTbl)
	bg:SetBackdropColor(0, 0, 0, 1)
	
	if unit == "player" then
		bg:SetSize(C["playerCastbar"]["width"], C["playerCastbar"]["height"])
		local rel1, anchor, rel2, offx, offy = unpack(C["playerCastbar"]["pos"])
		bg:SetPoint(rel1, anchor, rel2, offx, offy)
	else
		bg:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -4)
		bg:SetPoint("TOPRIGHT", f, "BOTTOMRIGHT", 0, -4)
		bg:SetHeight(unit == "target" and 22 or 18)
	end
	
	cb:SetPoint("TOPLEFT", bg, "TOPLEFT", bg:GetHeight(), -1)
	cb:SetPoint("BOTTOMRIGHT", bg, "BOTTOMRIGHT", -1, 1)
	
	local bg2 = cb:CreateTexture(nil, "BACKGROUND")
	bg2:SetAllPoints()
	bg2:SetTexture(powerTex)
	bg2:SetVertexColor(.3, .24, 0, 1)
	
	local icon = cb:CreateTexture(nil, "ARTWORK")
	icon:SetPoint("TOPLEFT", bg, "TOPLEFT", 1, -1)
	icon:SetPoint("BOTTOMRIGHT", cb, "BOTTOMLEFT", -1, 0)
	icon:SetTexCoord(.1, .9, .1, .9)
	
	local timer = cb:CreateFontString(nil, "OVERLAY")
	timer:SetFont(font2, 11, "OUTLINE")
	timer:SetPoint("RIGHT", -2, 0)
	
	local text = cb:CreateFontString(nil, "OVERLAY")
	text:SetFont(font1, 11, "OUTLINE")
	text:SetJustifyH("LEFT")
	text:SetPoint("LEFT", 2, 0)
	text:SetPoint("RIGHT", timer, "LEFT", -5, 0)
	
	cb.Text = text
	cb.Time = timer
	cb.Icon = icon
	f.Castbar = cb
end

A.CreateAura = function(f, size)
	size, spacing = size or 20, 5
	local numRow = math.floor( f:GetWidth() / (size + spacing) )
	
	local b = CreateFrame("Frame", nil, f)
	b:SetFrameStrata(f:GetFrameStrata())
	b:SetWidth(numRow * (size + spacing))
	b.size = size
	b.spacing = spacing
	b.numRow = numRow
	b.PostCreateIcon = A.PostCreateAura
	
	local d = CreateFrame("Frame", nil, f)
	d:SetFrameStrata(f:GetFrameStrata())
	d:SetWidth(numRow * (size + spacing))
	d.size = size
	d.spacing = spacing
	d.numRow = numRow
	d.PostCreateIcon = A.PostCreateAura
	
	if f.unit == "target" then
		b:SetHeight((size + spacing) * 2)
		b:SetPoint("TOPLEFT", f, "BOTTOMLEFT", 0, -30)
		b.num = numRow * 2
		b.initialAnchor = "TOPLEFT"
		b["growth-x"] = "RIGHT"
		b["growth-y"] = "DOWN"
		b.PostUpdate = A.UpdateTargetDebuffHeader
		
		d:SetHeight((size + spacing) * 4)
		d:SetPoint("TOPLEFT", b, "TOPLEFT")
		d.num = numRow * 4
		d.initialAnchor = "TOPLEFT"
		d["growth-x"] = "RIGHT"
		d["growth-y"] = "DOWN"
	else
		b:SetHeight(size)
		b:SetPoint("BOTTOMRIGHT", f, "TOPRIGHT", 0, 5)
		b.num = 3
		b.initialAnchor = "BOTTOMRIGHT"
		b["growth-x"] = "LEFT"
				
		d:SetHeight(size)
		d:SetPoint("BOTTOMLEFT", f, "TOPLEFT", 0, 5)
		d.num = 3
		d.initialAnchor = "BOTTOMLEFT"
		d["growth-x"] = "RIGHT"
		if f.unit:find("boss") then
			d.filter = "HARMFUL|PLAYER"
		end
	end
	
	f.Buffs = b
	f.Debuffs = d
end

A.CreateRaidElements = function(f)
	local name = f.Health:CreateFontString(nil, "OVERLAY")
	name:SetFont(font1, 12, "OUTLINE")
	name:SetPoint("TOPLEFT", 4, -12)
	f:Tag(name, "[nameshort]")
	
	local role = f.Health:CreateTexture(nil, "OVERLAY")
	role:SetSize(14, 14)
	role:SetPoint("TOPLEFT", 3, 2)
	
	local leader = f.Health:CreateTexture(nil, "OVERLAY")
	leader:SetSize(14, 14)
	leader:SetPoint("LEFT", role, "RIGHT", 3, 0)
	
	f.Name = name
	f.LFDRole = role
	f.Leader = leader
	f.Range = {
		insideAlpha = 1,
		outsideAlpha = .4
	}
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

A.PostCreateAura = function(buffheader, aura)
	aura.icon:SetTexCoord(.1, .9, .1, .9)
	
	aura.cd:SetReverse(true)
	
	aura.bg = aura:CreateTexture(nil, "BACKGROUND")
	aura.bg:SetPoint("TOPLEFT", -1, 1)
	aura.bg:SetPoint("BOTTOMRIGHT", 1, -1)
	aura.bg:SetTexture(.6, .6, .6)
end

local ceil = math.ceil
A.UpdateTargetDebuffHeader = function(Buffs)
	local rows = ceil(Buffs.visibleBuffs / Buffs.numRow)
	local Debuffs = Buffs:GetParent()["Debuffs"]
	local gap = rows == 0 and 0 or 10
	
	Debuffs:SetPoint("TOPLEFT", Buffs, "TOPLEFT", 0, -(rows * (Buffs.size + Buffs.spacing) + gap) )
end