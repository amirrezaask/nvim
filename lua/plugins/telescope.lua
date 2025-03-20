return {
	"nvim-telescope/telescope.nvim",
	-- enabled = vim.fn.has("win32") == 1, -- fzf-lua is far more performant and superior but on windows telescope is better.
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",

		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		require("telescope").setup({
			defaults = {
				layout_config = {
					width = 0.95, -- 90% of the editor width
					height = 0.85, -- 80% of the editor height
					preview_width = 0.6, -- Adjust preview width
					prompt_position = "top",
				},
				sorting_strategy = "ascending", -- Ensures results are listed from top to bottom
				file_ignore_patterns = {

					"node_modules",
					"vendor",
				},
			},
		})
		require("telescope").load_extension("ui-select")

		vim.keymap.set("n", "<leader>ff", function()
			require("telescope.builtin").find_files({ previewer = false })
		end)
		vim.keymap.set("n", "<leader><leader>", function()
			require("telescope.builtin").find_files({ previewer = false })
		end)

		vim.keymap.set("n", "<leader>i", function()
			require("telescope.builtin").find_files({
				prompt_title = "Neovim Config",
				cwd = vim.fn.stdpath("config"),
				previewer = false,
			})
		end)

		vim.keymap.set("n", "<c-p>", function()
			require("telescope.builtin").git_files({ previewer = false })
		end)

		vim.keymap.set("n", "??", function()
			require("telescope.builtin").live_grep({})
		end)

		vim.keymap.set("n", "<leader>o", function()
			require("telescope.builtin").lsp_document_symbols({
				previewer = false,
			})
		end)

		vim.keymap.set("n", "<leader>O", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols({
				previewer = false,
			})
		end)

		vim.keymap.set("n", "<leader>h", function()
			require("telescope.builtin").help_tags({})
		end)
		vim.keymap.set("n", "<leader>b", function()
			require("telescope.builtin").buffers({})
		end)
	end,
}
