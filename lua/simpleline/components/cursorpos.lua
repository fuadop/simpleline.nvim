-- helper module
local H = {}

---https://github.com/nvim-lualine/lualine.nvim/blob/master/lua/lualine/utils/mode.lua
H.text = {
	['n']     = 'NORMAL',
	['no']    = 'O-PENDING',
	['nov']   = 'O-PENDING',
	['noV']   = 'O-PENDING',
	['no\22'] = 'O-PENDING',
	['niI']   = 'NORMAL',
	['niR']   = 'NORMAL',
	['niV']   = 'NORMAL',
	['nt']    = 'NORMAL',
	['ntT']   = 'NORMAL',
	['v']     = 'VISUAL',
	['vs']    = 'VISUAL',
	['V']     = 'VISUAL',
	['Vs']    = 'VISUAL',
	['\22']   = 'VISUAL',
	['\22s']  = 'VISUAL',
	['s']     = 'SELECT',
	['S']     = 'SELECT',
	['\19']   = 'SELECT',
	['i']     = 'INSERT',
	['ic']    = 'INSERT',
	['ix']    = 'INSERT',
	['R']     = 'REPLACE',
	['Rc']    = 'REPLACE',
	['Rx']    = 'REPLACE',
	['Rv']    = 'REPLACE',
	['Rvc']   = 'REPLACE',
	['Rvx']   = 'REPLACE',
	['c']     = 'COMMAND',
	['cv']    = 'EX',
	['ce']    = 'EX',
	['r']     = 'REPLACE',
	['rm']    = 'MORE',
	['r?']    = 'CONFIRM',
	['!']     = 'SHELL',
	['t']     = 'TERMINAL',
}


H.highlights = {
	['NORMAL'] = '%#SimpleLineModeNormal#',
	['VISUAL'] = '%#SimpleLineModeVisual#',
	['INSERT'] = '%#SimpleLineModeInsert#',
	['REPLACE'] = '%#SimpleLineModeReplace#',
	['FALLBACK'] = '%#SimpleLineModeFallback#',
}

---@return string
H.get_mode_full = function()
	local _mode = vim.api.nvim_get_mode()

	return H.text[_mode.mode] or _mode.mode or "-"
end

---@param mode string
---@return string
H.get_highlight = function(mode)
	return H.highlights[mode] or H.highlights['FALLBACK']
end

-- main module
local M = {}

M.render = function()
	local mode = H.get_mode_full()

	return H.get_highlight(mode)
		.. "  "
		.. "%l:%c"
		.. "  "
		.. "%*"
end

M.render_text = function()
	return H.get_mode_full()
end

return M
