return { -- Autocomplete menu
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
			},
		})
	end,
}
