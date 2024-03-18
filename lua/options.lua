-- Wrap long lines
vim.opt.wrap = true

-- Wrapped lines have same indentation as the actual line.
vim.opt.breakindent = true

-- No annoying swapfiles
vim.opt.swapfile = false

-- Disable Vim backups, we have Git :)
vim.opt.backup = false

-- Save undo history
vim.opt.undofile = true

-- Highlight all matches of a search pattern.
vim.opt.hlsearch = false

-- Match pattern while typing.
vim.opt.incsearch = true

-- Keep signcolumn always visible
vim.opt.signcolumn = "yes"

-- How new splits are created
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight current line which cursor is on.
vim.opt.cursorline = true

-- TABs and indentation
vim.opt.sw = 4
vim.opt.ts = 4
vim.opt.expandtab = true

-- minimal netrw (vim default file manager)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- vim update time
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

-- No need to show the mode, we have it in statusline
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview all substitutions(replacements).
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

IS_WINDOWS = vim.fn.has("win32") == 1

-- Transparency Control
-- To control this set NVIM_TRANSPARENT to true in your environment
TRANSPARENT = os.getenv("NVIM_TRANSPARENT") == "true"

-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

if IS_WINDOWS then
	vim.api.nvim_create_user_command("Term", function()
		vim.cmd([[ tabnew | term pwsh.exe]])
	end, {})
	vim.api.nvim_create_user_command("VTerm", function()
		vim.cmd([[ vnew | term pwsh.exe]])
	end, {})
else
	vim.api.nvim_create_user_command("Term", function()
		vim.cmd([[ tabnew | term ]])
	end, {})
	vim.api.nvim_create_user_command("VTerm", function()
		vim.cmd([[ vnew | term ]])
	end, {})
end
