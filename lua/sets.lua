vim.g.mapleader = " " -- <leader> key for keymaps mapped to <Space>
vim.opt.wrap = true -- Wrap long lines
vim.opt.breakindent = true -- Wrapped lines have same indentation as the actual line.
vim.opt.swapfile = false -- No annoying swapfiles
vim.opt.backup = false -- Disable Vim backups, we have Git :)
vim.opt.undofile = true -- Save undo history
vim.opt.hlsearch = false -- Highlight all matches of a search pattern.
vim.opt.incsearch = true -- Match pattern while typing.
vim.opt.signcolumn = "yes" -- Keep signcolumn always visible
vim.opt.splitbelow = true -- How new splits are created
vim.opt.splitright = true
vim.opt.sw = 4 -- TABs and indentation
vim.opt.ts = 4
vim.opt.expandtab = true
vim.g.netrw_browse_split = 0 -- minimal netrw (vim default file manager)
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.opt.guicursor = ""
vim.opt.timeoutlen = 300 -- vim update time
vim.opt.updatetime = 250
vim.opt.termsync = false
vim.opt.number = true -- Line numbers
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus" -- Clipboard
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true
vim.opt.completeopt = { "menu", "noinsert" }
vim.opt.inccommand = "" -- Preview all substitutions(replacements).
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.cursorline = false
vim.opt.laststatus = 3 -- Global statusline

if vim.fn.has("wsl") == 1 then
	vim.g.clipboard = {
		name = "WslClipboard",
		copy = {
			["+"] = "clip.exe",
			["*"] = "clip.exe",
		},
		paste = {
			["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
			["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
		},
		cache_enabled = 0,
	}
end
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
