return {
	{ -- Language server protocol client (LSP)
		"neovim/nvim-lspconfig",
		dependencies = {
			{ -- Like the panel in vscode, shows you errors and warnings from LSP
				"folke/trouble.nvim",
				-- dependencies = { "nvim-tree/nvim-web-devicons" },
				config = function()
					require("trouble").setup({})
					vim.keymap.set("n", "<leader>e", ":TroubleToggle<CR>")
				end,
			},
			{ "folke/neodev.nvim", opts = {} },

			{ -- Package manager for neovim install lsp servers in neovim path.
				"williamboman/mason.nvim",
				config = function()
					local function get_path_sep()
						if IS_WINDOWS then
							return "\\"
						else
							return "/"
						end
					end

					local sep = get_path_sep()

					if IS_WINDOWS then
						vim.env.PATH = string.format("%s%smason%sbin;", (vim.fn.stdpath("data")), sep, sep)
							.. vim.env.PATH
					else
						vim.env.PATH = string.format("%s%smason%sbin:", (vim.fn.stdpath("data")), sep, sep)
							.. vim.env.PATH
					end
					require("mason").setup({})
				end,
			},
			-- { "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
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
							workspace = {
								checkThirdParty = false,
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
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

			-- LspInfo window have rounded border
			require("lspconfig.ui.windows").default_options.border = "rounded"

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

					local map = function(mode, key, fn, desc)
						vim.keymap.set(mode, key, fn, { buffer = bufnr, desc = "LSP: " .. desc })
					end

					map("n", "gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
					map("n", "gD", vim.lsp.buf.declaration, "[g]oto [D]eclaration")
					map("n", "gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
					map("n", "gr", vim.lsp.buf.references, "[g]oto [r]eferences")
					map("n", "R", vim.lsp.buf.rename, "Rename")
					map("n", "K", vim.lsp.buf.hover, "Hover")
					map("n", "C", vim.lsp.buf.code_action, "Code Actions")
					map("n", "<leader>f", vim.lsp.buf.format, "Format")
					map({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, "Signature Help")

					-- I hate it when I am writing a piece of code that things start to get all red.
					vim.diagnostic.config({ virtual_text = false })
				end,
			})
		end,
	},
}
