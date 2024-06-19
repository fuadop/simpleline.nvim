-- helper module
local H = {}

---@return string
H.get_branch_name = function()
	local f = io.popen("git branch --color=never --show-current 2> /dev/null")

	if f then
		local _b = string.gsub(f:read("a"), "[\n\r]", "")

		if _b:len() > 0 then
			return string.format("%s %s", "󰊢", _b) -- prefix with git-icon
		end
	end

	return "•"
end

-- main module
local M = {}

---@return string
M.render = function()
	return "%#SimpleLineGit#"
		.. " "
		-- .. "%{%v:lua.SimpleLine.render_component_text('gitbranch')%}"
		.. M.render_text()
		.. " "
		.. "%*"
end

---@return string
M.render_text = function()
	return H.get_branch_name()
end

return M
