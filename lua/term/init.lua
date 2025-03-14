local M = {}

M.setup = function()
	local term = require 'term.term'

	term.state.shell = os.getenv('SHELL')
	if term.state.shell == nil then
		vim.notify('No value found in SHELL environment variable. :Term will do nothing until this is configured.',
			vim.log.levels.WARN)
		return
	end

	vim.api.nvim_create_user_command('Term', term.open_term, {})
	vim.api.nvim_create_user_command('TermClose', term.close_term, {})
end

return M
