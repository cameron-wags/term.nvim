local M = {}

M.state = {
	term_id = nil,
	term_buf = nil,
	term_win = nil,
	shell = nil,
}

-- wipes all traces of the terminal so that sessions won't persist us
function M.kill_term()
	if M.state.term_win and vim.api.nvim_win_is_valid(M.state.term_win) then
		vim.api.nvim_win_close(M.state.term_win, true)
	end
	M.state.term_win = nil

	if M.state.term_buf and vim.api.nvim_buf_is_valid(M.state.term_buf) then
		vim.api.nvim_buf_delete(M.state.term_buf, { force = true })
	end
	M.state.term_buf = nil

	if M.state.term_id then
		vim.fn.jobstop(M.state.term_id)
	end
	M.state.term_id = nil

	vim.schedule(vim.cmd.checktime)
end

function M.open_term()
	vim.cmd 'tabedit new'
	vim.bo.bufhidden = 'wipe'
	M.state.term_win = vim.api.nvim_get_current_win()
	vim.wo.number = false
	vim.wo.relativenumber = false
	vim.wo.signcolumn = 'no'

	if M.state.term_buf == nil then
		M.state.term_buf = vim.api.nvim_create_buf(false, true)
	end

	vim.api.nvim_win_set_buf(M.state.term_win, M.state.term_buf)

	if M.state.term_id == nil then
		M.state.term_id = vim.fn.jobstart({ M.state.shell }, {
			on_exit = M.kill_term,
			term = true,
		})
	end

	vim.cmd.startinsert()
end

function M.close_term()
	-- make sure the terminal window is ours
	if M.state.term_win ~= vim.api.nvim_get_current_win() or not M.state.term_win then
		return
	end

	vim.api.nvim_win_close(M.state.term_win, true)
	vim.schedule(vim.cmd.checktime)
end

return M
