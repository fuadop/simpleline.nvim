local M = {}
local H = {}

H.get_diagnostics_count = function()
	local _s = {}
	for i = 1, 4, 1 do
		local _d = vim.diagnostic.get(0, { severity = i })
		_s[i] = #_d
	end

	return {
		E = _s[1] or 0,
		W = _s[2] or 0,
		I = _s[3] or 0,
		H = _s[4] or 0,
	}
end


---@return string
M.render = function()
	return "%#SimpleLineDiagnosticBg#"
		.. "  "
		-- .. "%{%v:lua.SimpleLine.render_component_text('diagnostics')%}"
		.. M.render_text()
		.. "  "
		.. "%*"
end

---@return string
M.render_text = function()
	local _c = H.get_diagnostics_count()

	return ""
		.. "%#SimpleLineDiagnosticTextRed#"
		.. string.format("E:%d ", _c.E)
		.. "%*"
		.. "%#SimpleLineDiagnosticTextYellow#"
		.. string.format("W:%d ", _c.W)
		.. "%*"
		.. "%#SimpleLineDiagnosticTextBlue#"
		.. string.format("I:%d ", _c.I)
		.. "%*"
		.. "%#SimpleLineDiagnosticTextPurple#"
		.. string.format("H:%d", _c.H)
		.. ""
end

return M
