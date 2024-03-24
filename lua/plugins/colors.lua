return {
	{
		"ellisonleao/gruvbox.nvim",
		config = function()
			require("gruvbox").setup({
				transparent_mode = TRANSPARENT,
				contrast = "hard",
				italic = {
					strings = false,
					emphasis = false,
					comments = false,
					operators = false,
					folds = false,
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = function()
			require("catppuccin").setup({
				no_italic = true, -- Force no italic
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		config = function()
			vim.g.gruvbox_material_background = "hard"
			vim.g.gruvbox_material_foreground = "original"
			vim.g.gruvbox_material_transparent_background = TRANSPARENT
		end,
	},
	{
		"rebelot/kanagawa.nvim",
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
