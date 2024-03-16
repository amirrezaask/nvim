return {
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				transparent_mode = TRANSPARENT,
				contrast = "hard",
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					italic = false,
					transparency = TRANSPARENT,
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = TRANSPARENT,
			})
		end,
	},
	"tjdevries/colorbuddy.nvim",
}
