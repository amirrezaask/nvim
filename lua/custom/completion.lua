return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp_select = { behavior = require("cmp").SelectBehavior.Select }
			local cmp = require("cmp")
			cmp.setup({
				preselect = require("cmp.types").cmp.PreselectMode.None,
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
					["<C-Space>"] = cmp.mapping.complete(),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{
						name = "lazydev",
						group_index = 0, -- set group index to 0 to skip loading LuaLS completions
					},
				},
			})
		end,
	},
	-- {
	-- 	"saghen/blink.cmp",
	-- 	dependencies = { "rafamadriz/friendly-snippets" },
	-- 	version = "*",
	-- 	opts = {
	-- 		keymap = { preset = "enter" },
	-- 		appearance = {
	-- 			nerd_font_variant = "mono",
	-- 		},
	-- 		completion = {
	-- 			documentation = {
	-- 				auto_show = true,
	-- 			},
	-- 		},
	-- 		sources = {
	-- 			default = { "lsp", "path", "snippets", "buffer" },
	-- 		},
	-- 		fuzzy = { implementation = "prefer_rust_with_warning" },
	-- 	},
	-- 	opts_extend = { "sources.default" },
	-- },
}
