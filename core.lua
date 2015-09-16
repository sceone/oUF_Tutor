-- Style func
local function TargetStyle(f, unit)
	f:SetScript("OnEnter", UnitFrame_OnEnter)
	f:SetScript("OnLeave", UnitFrame_OnLeave)
	
	f:SetPoint("CENTER", UIParent, "TOP", 0, -150)
	f:SetFrameStrata("LOW")
	f:SetWidth(250)
	f:SetHeight(36)
	
	f:SetBackdrop({
		bgFile = "Interface\\CHATFRAME\\CHATFRAMEBACKGROUND",
		tile = true,
		tileSize = 16
	})
	f:SetBackdropColor(.1, .1, .1, .7)

	f.Health = CreateFrame("StatusBar", nil, f)
	f.Health:SetPoint("TOPLEFT")
	f.Health:SetPoint("TOPRIGHT")
	f.Health:SetHeight(28)
	f.Health:SetFrameStrata(f:GetFrameStrata())
	f.Health:SetStatusBarTexture("Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill")
	
	f.Health.frequentUpdates = true
	f.Health.colorTapping = true
	f.Health.colorDisconnected = true
	f.Health.colorClass = true
	f.Health.colorReaction = true
	f.Health.colorHealth = true

	f.Power = CreateFrame("StatusBar", nil, f)
	f.Power:SetPoint("TOPLEFT", f.Health, "BOTTOMLEFT", 0, -1)
	f.Power:SetPoint("BOTTOMRIGHT")
	f.Power:SetFrameStrata(f:GetFrameStrata())
	f.Power:SetStatusBarTexture("Interface\\BUTTONS\\GreyscaleRamp64")
	
	f.Power.frequentUpdates = true
	f.Power.colorTapping = true
	f.Power.colorDisconnected = true
	f.Power.colorPower = true
	f.Power.colorClass = true
	f.Power.colorReaction = true

	f.Health.Value = f.Health:CreateFontString(nil, "OVERLAY")
	f.Health.Value:SetFont("Fonts\\2002.TTF", 11, "OUTLINE")
	f.Health.Value:SetTextColor(.9, .8, .5)
	f.Health.Value:SetPoint("RIGHT", -6, 0)
	f:Tag(f.Health.Value, "[curhp]")

	f.Name = f.Health:CreateFontString(nil, "OVERLAY")
	f.Name:SetFont("Fonts\\2002.TTF", 14, "OUTLINE")
	f.Name:SetPoint("LEFT", 8, 0)
	f:Tag(f.Name, "[name]")
end

oUF:RegisterStyle("oUF_TutorTarget", TargetStyle)
oUF:Spawn("target", "oUF_TutorTarget")