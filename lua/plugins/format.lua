local no_auto_format = { "php" }

return {
	"stevearc/conform.nvim",
	opts = {
		format_on_save = function()
			if vim.tbl_contains(no_auto_format, vim.bo.filetype) then
				return false
			end
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,

		formatters_by_ft = {
			lua = { "stylua", lsp_format = "fallback" },
			go = { "goimports", "gofmt" },
		},
	},
}
