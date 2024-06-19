local M = {}

---@return string
M.render = function()
	return "%#SimpleLinePosition#"
		.. " "
		.. "%P"
		.. " "
		.. "%*"
end

---@return string
M.render_text = function()
	return ""
end

return M
