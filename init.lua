vim.g.mapleader = " "

-- Neovim/Vim will source all files inside ./plugin/ directory
-- We are also going to add lazy.nvim as plugin manager to install and load 3rd party plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = "custom", -- this will load all plugin specs defined in ./lua/custom/*.lua
	change_detection = { notify = false },
})

vim.cmd.colorscheme(os.getenv("NVIM_COLORSCHEME") or "rose-pine-moon")
