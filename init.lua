--    ___         _                      ___       __
--   / _ | __ _  (_)__________ ___ ___ _/ _ | ___ / /__
--  / __ |/  ' \/ / __/ __/ -_)_ // _ `/ __ |(_-</  '_/
-- /_/ |_/_/_/_/_/_/ /_/  \__//__/\_,_/_/ |_/___/_/\_\
-- Neovim configuration for true and brave.

-- Wrap long lines
vim.opt.wrap = true

-- Wrapped lines have same indentation as the actual line.
vim.opt.breakindent = true

-- No annoying swapfiles
vim.opt.swapfile = false

-- Disable Vim backups, we have Git :)
vim.opt.backup = false

-- Save undo history
vim.opt.undofile = true

-- Highlight all matches of a search pattern.
vim.opt.hlsearch = false

-- Match pattern while typing.
vim.opt.incsearch = true

-- Keep signcolumn always visible
vim.opt.signcolumn = "yes"

-- How new splits are created
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight current line which cursor is on.
vim.opt.cursorline = true

-- TABs and indentation
vim.opt.sw = 4
vim.opt.ts = 4
vim.opt.expandtab = true

-- minimal netrw (vim default file manager)
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- vim update time
vim.opt.timeoutlen = 300
vim.opt.updatetime = 250

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"

-- No need to show the mode, we have it in statusline
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Preview all substitutions(replacements).
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

IS_WINDOWS = vim.fn.has("win32") == 1

-- <leader> key for keymaps mapped to <Space>
vim.g.mapleader = " "

-- Make yanking act like other operations
vim.keymap.set("n", "Y", "y$", { desc = "Copy whole line" })

-- Esc should remove incsearch highlights
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy into clipboard" })

-- Copy current line into system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Copy line into clipboard" })

-- Paste clipboard content
vim.keymap.set("n", "<leader>p", [["+p]], { desc = "Paste from clipboard" })

-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the clipboard
vim.keymap.set("x", "p", '"_dP')

-- Simpler exiting insert mode
vim.keymap.set("i", "<C-c>", "<esc>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")

-- Quickfix list
vim.keymap.set({ "n" }, "<C-[>", "<cmd>cprev<CR>", { desc = "Previous quick fix list item" })
vim.keymap.set({ "n" }, "<C-]>", "<cmd>cnext<CR>", { desc = "Next quick fix list item" })
local qflist = false
function ToggleQFList()
	if qflist == true then
		qflist = not qflist
		vim.cmd([[ cclose ]])
	else
		qflist = not qflist
		vim.cmd([[ copen ]])
	end
end

vim.keymap.set({ "n" }, "<C-q>", ToggleQFList, { desc = "Open Quickfix list" })
vim.keymap.set({ "i" }, "<C-Space>", "<C-x><C-o>")

-- When moving around always have cursor centered in screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- Disable annoying Q mode
vim.keymap.set("n", "Q", "<cmd>q<CR>")

-- Pressing <CR> will disable current highlights from last search
vim.keymap.set("n", "<CR>", [[ {-> v:hlsearch ? ':nohl<CR>' : '<CR>'}() ]], { expr = true })

-- Edit config file
vim.keymap.set("n", "<leader>i", "<cmd>edit $MYVIMRC<CR>")

-- Wrapped lines act as normal lines
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Terminal and Tabs
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set({ "i", "n", "t" }, "<C-k>", "<cmd>tabnext<CR>")
vim.keymap.set({ "i", "n", "t" }, "<C-j>", "<cmd>tabprev<CR>")
vim.keymap.set({ "i" }, "<C-a>", "<C-x><C-o>") -- simpler omnifunc completion

-- Diagnostics
vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, { desc = "Diagnostics: Open float window" })
vim.keymap.set("n", "[[", vim.diagnostic.goto_prev, { desc = "Diagnostics: Next" })
vim.keymap.set("n", "]]", vim.diagnostic.goto_next, { desc = "Diagnostics: Previous" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set Local list" })

-- W is alias for w
vim.cmd([[
    command! W :w
]])

-- Highlight on Yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- statusline
local mode_texts = {
	n = "Normal",
	i = "Insert",
	v = "Visual",
	c = "Complete",
}

function AmirrezaStatusLine()
	local statusline = ""
	local mode = vim.api.nvim_get_mode().mode
	if mode_texts[mode] ~= nil then
		mode = mode_texts[mode]
	end

	statusline = statusline .. mode

	local branch = ""
	if vim.b.gitsigns_head ~= nil then
		branch = "Git:" .. vim.b.gitsigns_head
		statusline = statusline .. " | " .. branch .. " |"
	end

	return statusline .. " %r%h%w%q%m%f | %y"
end

vim.opt.statusline = "%!v:lua.AmirrezaStatusLine()"

-- Transparency Control
-- To control this set NVIM_TRANSPARENT to true in your environment
TRANSPARENT = os.getenv("NVIM_TRANSPARENT") == "true"
--
-- local font_family = ""
-- local font_size = 15
-- vim.g.neovide_scroll_animation_length = 0.10
-- vim.g.neovide_cursor_animation_length = 0.03
-- vim.g.neovide_cursor_vfx_mode = ""
--
-- function Font(font, size)
-- 	font_family = font
-- 	font_size = size
-- 	vim.opt.guifont = string.format("%s:h%d", font, size)
-- end
--
-- function FontSizeInc()
-- 	font_size = 1 + font_size
-- 	Font(font_family, font_size)
-- end
--
-- function FontSizeDec()
-- 	font_size = font_size - 1
-- 	Font(font_family, font_size)
-- end
--
-- function FontSize(size)
-- 	font_size = size
-- 	Font(font_family, font_size)
-- end
--
-- vim.api.nvim_create_user_command("FontSize", function(opts)
-- 	FontSize(tonumber(opts.fargs[1]))
-- end, { nargs = 1 })
--
-- vim.api.nvim_create_user_command("Font", function(opts)
-- 	local splitted = vim.split(opts.args, ":")
-- 	if #splitted < 2 then
-- 		error("Font command input should be in [FontName]:[FontSize] format")
-- 	end
-- 	Font(splitted[1], splitted[2])
-- end, { nargs = "*" })
--
-- Font("JetBrainsMono Nerd Font Mono", 16)
--
-- Lazy package manager
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

	-- Show git changed signs next to line numbers.
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

	-- Git Client
	{ "tpope/vim-fugitive" },

	-- Colorschemes
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

	-- Highlight TODO in comments
	{ "folke/todo-comments.nvim", opts = {} },

	{ "nvim-tree/nvim-web-devicons" },

	{ -- Treesitter, see :help treesitter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "vimdoc", "go", "gomod" },
				auto_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},

	"equalsraf/neovim-gui-shim", -- NeovimQt commands

	"kevinhwang91/nvim-bqf", -- Improved quick fix list experience

	-- Autocomplete popup
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp_select = { behavior = require("cmp").SelectBehavior.Select }
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
			local cmp = require("cmp")
			cmp.setup({
				preselect = require("cmp.types").cmp.PreselectMode.None,
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					-- ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

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
			{ "j-hui/fidget.nvim", opts = {} },
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

	{ -- Autoformat
		"stevearc/conform.nvim",
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt" },
			},
		},
	},

	{ -- Fuzzy finder
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("telescope").load_extension("ui-select") -- Use telescope for vim.ui.select
			local builtin = require("telescope.builtin")
			local no_preview = { previewer = false }
			local dropdown = require("telescope.themes").get_dropdown
			local map = function(mode, key, fn, desc)
				vim.keymap.set(mode, key, fn, { desc = "Telescope: " .. desc })
			end

			local projects_root = "~/w"
			if IS_WINDOWS then
				projects_root = "C:/w"
			end

			local function find_projects()
				local repos = vim.fs.find({ ".git" }, { limit = math.huge, path = projects_root })
				local paths = {}
				for _, repo in ipairs(repos) do
					table.insert(paths, vim.fs.dirname(repo))
				end

				return paths
			end

			map("n", "<C-p>", function()
				builtin.git_files(dropdown({
					previewer = false,
					prompt_title = string.format("Git Files: %s", vim.fn.getcwd()),
				}))
			end, "Git Files")

			map("n", "<leader><CR>", function()
				vim.ui.select(find_projects(), {
					prompt = "Select Project:",
				}, function(proj)
					if proj == "" or proj == nil then
						return
					end
					builtin.find_files(dropdown({ previewer = false, cwd = proj }))
				end)
			end, "Find File in project")

			map("n", "<leader><leader>", function()
				builtin.find_files(dropdown({
					previewer = false,
					prompt_title = string.format("Find Files: %s", vim.fn.getcwd()),
				}))
			end, "Fuzzy Find in current buffer project")

			map("n", "<leader>b", function()
				builtin.buffers(dropdown({ previewer = false }))
			end, "Buffers")

			map("n", "<leader>/", function()
				builtin.current_buffer_fuzzy_find(dropdown({ previewer = false }))
			end, "Fuzzy find in current buffer")

			map("n", "<leader>.", function()
				builtin.grep_string({ previewer = false, layout_config = { height = 0.7, width = 0.9 } })
			end, "Grep current word")

			map("n", "<leader>o", function()
				builtin.treesitter(dropdown(no_preview))
			end, "Treesitter symbols")

			map("n", "??", function()
				builtin.live_grep({
					previewer = false,
					prompt_title = string.format("Grep: %s", vim.fn.getcwd()),
					layout_config = { height = 0.9, width = 0.9 },
				})
			end, "Grep in project")

			map("n", "<leader>h", function()
				builtin.help_tags()
			end, "Help Tags")

			map("n", "<leader>w", function()
				builtin.lsp_dynamic_workspace_symbols()
			end, "LSP workspace symbols")

			map("n", "<leader>i", function()
				builtin.find_files(dropdown({ previewer = false, cwd = vim.fn.stdpath("config") }))
			end, "Neovim Config")
		end,
	},
}, {})

-- Change current working directory based on the buffer project root.
local augroup = vim.api.nvim_create_augroup("amirreza-chcwd", {})
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local filename = ev.file
		local start_from = vim.fs.dirname(filename)

		local root = vim.fs.dirname(
			vim.fs.find({ ".git", "go.mod", "package.json", "cargo.toml" }, { upward = true, path = start_from })[1]
		)
		if root ~= nil and root ~= "" then
			local abs_path = require("plenary.path").new(root or vim.fn.getcwd()):absolute()
			vim.fn.chdir(abs_path)
		end
	end,
	group = augroup,
})

-- Notebook: If I am editing my notebook files <C-k> will update and push, like obsidian
local notebook_augroup = vim.api.nvim_create_augroup("amirreza-notebook", {})
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function(ev)
		local filename = ev.file
		local dir = vim.fs.dirname(filename)
		local abs_dir = require("plenary.path").new(dir or vim.fn.getcwd()):absolute()
		if string.match(abs_dir, "notebook") ~= nil then
			vim.keymap.set("n", "<c-k>", function()
				vim.cmd([[
                !git add . && git commit -m "notebook update" && git push
            ]])
			end, { desc = "Sync Notebook" })
		end
	end,
	group = notebook_augroup,
})
if IS_WINDOWS then
	vim.keymap.set("n", "<leader>n", function()
		require("telescope.builtin").find_files({ cwd = "C:\\w\\notebook" })
	end, { desc = "Find Note" })
else
	vim.keymap.set("n", "<leader>n", function()
		require("telescope.builtin").find_files({ cwd = "~/w/notebook" })
	end, { desc = "Find Note" })
end

-- Set the colorscheme
vim.cmd.colorscheme("tokyonight")

-- Term command to launch terminal
if IS_WINDOWS then
	vim.api.nvim_create_user_command("Term", function()
		vim.cmd([[ tabnew | term pwsh.exe]])
	end, {})
else
	vim.api.nvim_create_user_command("Term", function()
		vim.cmd([[ tabnew | term ]])
	end, {})
end
