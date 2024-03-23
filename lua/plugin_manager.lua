local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- [gc] to comment region/line.
	{ "numToStr/Comment.nvim", opts = {} },

	-- Detect tabstop and shiftwidth automatically.
	{ "tpope/vim-sleuth" },

	-- Highlight TODO in comments
	{ "folke/todo-comments.nvim", opts = {} },

	-- Improved quick fix list experience
	"kevinhwang91/nvim-bqf",

	{
		"folke/noice.nvim",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	require("plugins.colors"),
	require("plugins.git"),
	require("plugins.autocomplete"),
	require("plugins.format"),
	require("plugins.lsp"),
	require("plugins.telescope"),
	require("plugins.statusline"),
	require("plugins.treesitter"),

	-- Custom functionalities
	require("plugins.rooter"),
	require("plugins.notebook"),
}, {})
