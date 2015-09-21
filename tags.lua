local addon, ns = ...
local C, A, M = unpack(ns)

------------------------------
-- New tags
------------------------------

local FormatLargeNumber = function(val)
	if not val then return "0" end
	if val < 1e6 then
		return AbbreviateLargeNumbers(val)
	elseif val < 1e7 then
		return string.format("%.2fm", val/1e6)
	elseif val < 1e8 then
		return string.format("%.1fm", val/1e6)
	else
		return string.format("%dm", val/1e6)
	end
end

oUF.Tags.Methods["curhpabb"] = function(unit)
	return FormatLargeNumber(UnitHealth(unit))
end
oUF.Tags.Events["curhpabb"] = "UNIT_HEALTH"

oUF.Tags.Methods["nameshort"] = function(unit, r)
	local name = UnitName(r or unit)
	if string.byte(name) > 127 then
		if string.len(name) > 18 then
			name = string.sub(name, 1, 15) .. ".."
		end
		return name
	else
		if string.len(name) > 9 then
			name = string.sub(name, 1, 7) .. ".."
		end
		return name
	end
end
oUF.Tags.Events["nameshort"] = "UNIT_NAME_UPDATE"