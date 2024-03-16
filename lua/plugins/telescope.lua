return {
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
}
