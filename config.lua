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
	width = 250,
	height = 36,
	pos = {"TOPLEFT", UIParent, "TOPLEFT", 60, -30}
}

C["target"] = {
	width = 250,
	height = 36,
	pos = {"TOPLEFT", "player", "TOPRIGHT", 40, 0}
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
