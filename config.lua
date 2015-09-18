local addon, ns = ...

------------------------------
-- initialize
------------------------------

-- config, API, main
local C, A, M = CreateFrame("Frame"), CreateFrame("Frame"), CreateFrame("Frame")
table.insert(ns, C)
table.insert(ns, A)
table.insert(ns, M)

------------------------------
-- UF layouts
------------------------------

C["player"] = {
	width = 240,
	height = 40,
	pos = {"TOPLEFT", UIParent, "TOPLEFT", 60, -30}
}

C["pet"] = {
	width = 120,
	height = 24,
	pos = {"TOPLEFT", "player", "BOTTOMLEFT", 0, -12}
}

C["target"] = {
	width = 240,
	height = 40,
	pos = {"TOPLEFT", "player", "TOPRIGHT", 40, 0}
}

C["targettarget"] = {
	width = 120,
	height = 24,
	pos = {"TOPLEFT", "target", "TOPRIGHT", 15, 0}
}

C["focus"] = {
	width = 160,
	height = 30,
	pos = {"TOPLEFT", "player", "BOTTOMLEFT", 0, -160}
}

C["focustarget"] = {
	width = 120,
	height = 24,
	pos = {"TOPLEFT", "focus", "BOTTOMLEFT", 0, -40}
}

C["boss"] = {
	width = 180,
	height = 30,
	pos = {"RIGHT", UIParent, "RIGHT", -260, 120}	-- boss1 point
}

C["playerCastbar"] = {
	width = 240,
	height = 30,
	pos = {"BOTTOM", UIParent, "BOTTOM", 0, 200}
}

------------------------------
-- media
------------------------------

C["media"] = {
	-- fonts
	font1 = "Interface\\AddOns\\oUF_Tutor\\media\\uf_font_kr.ttf",
	font2 = "Interface\\AddOns\\oUF_Tutor\\media\\ExpresswayRg.ttf",
	-- textures
	backdrop = "Interface\\AddOns\\oUF_Tutor\\media\\backdrop",
	edge = "Interface\\AddOns\\oUF_Tutor\\media\\backdrop_edge",
	healthTex = "Interface\\AddOns\\oUF_Tutor\\media\\statusbar512x64",
	powerTex = "Interface\\AddOns\\oUF_Tutor\\media\\fer14",
}
