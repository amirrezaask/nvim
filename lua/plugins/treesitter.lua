return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		{ "folke/ts-comments.nvim", opts = {} },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "lua", "go", "gomod", "markdown", "php", "c", "cpp" },
			highlight = { enable = true },
		})
	end,
}
