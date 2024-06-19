-- Helper module
local H = {}

---eg: convert ~/.config/nvim/git/xxx.xyz to ~/.c/n/g/x
---@param p string
---@return string
H.prettify_path = function(p)
	local _p = ""

	for x in p:gmatch("/[%.%w]+") do
		local _x = x:sub(1, 3)

		if x:sub(2, 2) ~= "." then
			_p = _p .. _x:sub(1, 2)
		else
			_p = _p .. _x
		end
	end

	-- string.last

	return "~" .. _p
end

-- main module
local M = {}

---@return string
M.render = function()
	return " "
		.. ""
		.. " "
		.. "%<" -- fold on file path
		-- .. "%{%v:lua.SimpleLine.render_component_text('filepath')%}"
		.. M.render_text()
		.. " "
		.. "%m%r"
		.. " "
end

---@return string
M.render_text = function()
	return string.format(
		"%s/%s",
		H.prettify_path(vim.fn.expand('%:p:~:h')),
		vim.fn.expand("%:t")
	)
end

return M
