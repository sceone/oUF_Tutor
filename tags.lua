local addon, ns = ...
local C, A, M = unpack(ns)

------------------------------
-- New tags
------------------------------

oUF.Tags.Methods["curhpabb"] = function(unit)
	return AbbreviateLargeNumbers(UnitHealth(unit))
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