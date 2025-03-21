local floating_term = { win = -1, buf = -1 }

local function toggle_floating_terminal()
	if vim.api.nvim_buf_is_valid(floating_term.buf) and vim.api.nvim_win_is_valid(floating_term.win) then
		vim.api.nvim_win_hide(floating_term.win)
		return
	end

	if not vim.api.nvim_buf_is_valid(floating_term.buf) then
		print("creating floating term buffer")
		floating_term.buf = vim.api.nvim_create_buf(false, true)
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local win = vim.api.nvim_open_win(floating_term.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	if vim.api.nvim_buf_get_option(floating_term.buf, "buftype") ~= "terminal" then
		print("starting terminal")
		vim.cmd.term()
	end

	vim.cmd.startinsert()

	floating_term = { buf = floating_term.buf, win = win }
end

local bottom_terminal = { win = -1, buf = -1 }

local function toggle_bottom_terminal()
	if vim.api.nvim_buf_is_valid(bottom_terminal.buf) and vim.api.nvim_win_is_valid(bottom_terminal.win) then
		vim.api.nvim_win_hide(bottom_terminal.win)
		return
	end

	if not vim.api.nvim_buf_is_valid(bottom_terminal.buf) then
		bottom_terminal.buf = vim.api.nvim_create_buf(false, true)
	end

	local width = vim.o.columns
	local height = math.floor(vim.o.lines * 0.3)

	local win = vim.api.nvim_open_win(bottom_terminal.buf, true, {
		split = "below",
		width = width,
		height = height,
	})

	if vim.api.nvim_buf_get_option(bottom_terminal.buf, "buftype") ~= "terminal" then
		vim.cmd.term()
	end

	vim.cmd.startinsert()

	bottom_terminal = { buf = bottom_terminal.buf, win = win }
end

local tab_terminal_state = { last_tab = -1 }

local function toggle_terminal_tab()
	local current_win = vim.api.nvim_get_current_win()
	if vim.wo[current_win].winbar == "Terminal" then
		vim.api.nvim_set_current_tabpage(tab_terminal_state.last_tab)
		return
	end
	for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
		local win_id = vim.api.nvim_tabpage_get_win(tab_id)
		local buf_id = vim.api.nvim_win_get_buf(win_id)
		if vim.wo[win_id].winbar == "Terminal" and vim.bo[buf_id].buftype == "terminal" then
			tab_terminal_state.last_tab = vim.api.nvim_get_current_tabpage()
			vim.api.nvim_set_current_tabpage(tab_id)
			vim.cmd.startinsert()
			return
		end
	end

	tab_terminal_state.last_tab = vim.api.nvim_get_current_tabpage()
	vim.cmd.tabnew()
	local win_id = vim.api.nvim_get_current_win()
	vim.wo[win_id].winbar = "Terminal"
	vim.cmd.term()
	vim.cmd.startinsert()
end

vim.keymap.set({ "n", "t" }, "<c-j>", toggle_terminal_tab)
