return {

	{ -- LSP
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				"j-hui/fidget.nvim",
				opts = {
					-- options
				},
			},
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({ ensure_installed = { "gopls" } })
			local lsp_servers = {
				gopls = {},
				intelephense = {},
				lua_ls = {
					settings = {
						Lua = {
							telemetry = { enable = false },
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				},
				rust_analyzer = {},
				zls = {},
			}

			for server, config in pairs(lsp_servers) do
				require("lspconfig")[server].setup(config)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })
					local map = function(mode, key, fn, desc)
						vim.keymap.set(mode, key, fn, { buffer = bufnr, desc = "LSP: " .. desc })
					end
					local references = vim.lsp.buf.references
					local implementation = vim.lsp.buf.implementation
					local has_tele, tele = pcall(require, "telescope.builtin")
					if has_tele then
						references = tele.lsp_references
						implementation = tele.lsp_implementations
					end

					local border = "rounded"
					map("n", "[[", vim.diagnostic.goto_prev, "Diagnostics: Next")
					map("n", "]]", vim.diagnostic.goto_next, "Diagnostics: Previous")
					map("n", "C-]", vim.lsp.buf.definition, "[g]oto definition")
					map("n", "gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
					map("n", "gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("n", "gI", implementation, "[g]oto [i]mplementation")
					map("n", "gr", references, "[g]oto [r]eferences")
					map("n", "R", vim.lsp.buf.rename, "Rename")
					map("n", "K", function()
						vim.lsp.buf.hover({ border = border })
					end, "Hover")
					map("n", "C", vim.lsp.buf.code_action, "Code Actions")
					map("n", "<leader>f", vim.lsp.buf.format, "Format")
					map({ "n", "i" }, "<C-s>", function()
						vim.lsp.buf.signature_help({ border = border })
					end, "Signature Help")
					vim.diagnostic.config({
						enabled = false,
						virtual_text = false,
						float = { border = border },
					})
				end,
			})
		end,
	},
}
