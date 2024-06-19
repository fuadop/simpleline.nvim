local M = {}

M.components = {}
M._components = {}
M._highlights = {}

_G.SimpleLine = M

M.setup = function(opts)
	-- default components
	M._components = {
		['A'] = {
			id = 'mode',
			package = require('simpleline.components.mode'),
		},
		['B'] = {
			id = 'gitbranch',
			package = require('simpleline.components.gitbranch'),
		},
		-- ['C'] nothing for 'C' yet
		['M'] = {
			id = 'filepath',
			package = require('simpleline.components.filepath')
		},

		['_'] = {
			id = '__blank__',
			package = require('simpleline.components.blank'),
		},

		['X'] = {
			id = 'diagnostics',
			package = require('simpleline.components.diagnostics')
		},
		['Y'] = {
			id = 'position',
			package = require('simpleline.components.position')
		},
		['Z'] = {
			id = 'cursorpos',
			package = require('simpleline.components.cursorpos')
		},
	}

	-- default highlights
	M._highlights = {
		{
			id = 'SimpleLineModeBase',
			gui = 'bold',
			cterm = 'bold',
		},
		{
			id = 'SimpleLineModeNormal',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#7c6f64',
		},
		{
			id = 'SimpleLineModeInsert',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#98971a',
		},
		{
			id = 'SimpleLineModeVisual',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#d65d0e',
		},
		{
			id = 'SimpleLineModeReplace',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#cc241d',
		},
		{
			id = 'SimpleLineModeFallback',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#7c6f64',
		},
		{
			id = 'SimpleLineGit',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#b16286',
			guibg = '#282828',
		},
		{
			id = 'SimpleLinePosition',
			gui = 'bold',
			cterm = 'bold',
			guifg = '#262626',
			guibg = '#928374',
		},
		{
			id = 'SimpleLineDiagnosticBg',
			gui = 'bold',
			cterm = 'bold',
			guibg = '#282828',
		},
		{
			id = 'SimpleLineDiagnosticTextRed',
			gui = 'bold',
			cterm = 'bold',
			guifg = "#cc241d",
		},
		{
			id = 'SimpleLineDiagnosticTextYellow',
			gui = 'bold',
			cterm = 'bold',
			guifg = "#d79921",
		},
		{
			id = 'SimpleLineDiagnosticTextBlue',
			gui = 'bold',
			cterm = 'bold',
			guifg = "#458588",
		},
		{
			id = 'SimpleLineDiagnosticTextPurple',
			gui = 'bold',
			cterm = 'bold',
			guifg = "#b16286",
		},
	}

	-- add the provided extra components
	if opts ~= nil then
		M._components = vim.tbl_deep_extend('force', opts.components or {}, M._components)
	end

	-- load the components to id for global "SimpleLine.render_component_text('[id]')" support
	for _, v in pairs(M._components) do
		if v.id and v.package then
			M.components[v.id] = v.package
		end
	end

	M.register_highlights()

	-- vim.o.stl = '%{%v:lua.SimpleLine.render()%}'
	vim.o.statusline = '%!v:lua.SimpleLine.render()'
end

M.register_highlights = function()
	for _, hl in ipairs(M._highlights) do
		if hl.id ~= nil then
			local _cmd = string.format('hi %s', hl.id)

			for k, v in pairs(hl) do
				if k ~= 'id' then
					_cmd = string.format('%s %s=%s', _cmd, k, v)
				end
			end

			vim.cmd(_cmd)
		end
	end
end
		vim.cmd('hi SimpleLineModeBase gui=bold cterm=bold')
	vim.cmd('hi SimpleLineModeNormal guifg=#262626 guibg=#afaf00')


M.render = function()
	-- | A | B | C |       M     | X | Y | Z |

	return string.format(
		"%s%s%s%%=%s%%=%s%s%s",
		M._components['A'].package.render(),
		M._components['B'].package.render(),
		M._components['_'].package.render(),
		M._components['M'].package.render(),
		M._components['X'].package.render(),
		M._components['Y'].package.render(),
		M._components['Z'].package.render()
	)
end

---@param id string
---@return string
M.render_component_text = function(id)
	local component = M.components[id]

	if component ~= nil then
		return component.render_text()
	end

	return ""
end

return M

