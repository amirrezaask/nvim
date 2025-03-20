return {
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		enabled = false,
		-- enabled = vim.fn.has("win32") == 0,
		config = function()
			local fzfLua = require("fzf-lua")
			fzfLua.setup({
				keymap = {
					fzf = {
						["ctrl-q"] = "select-all+accept",
					},
				},
				defaults = {
					previewer = false,
				},
				commands = {
					actions = {
						["enter"] = function(selected)
							vim.cmd(selected[1])
						end,
					},
				},
			})
			vim.keymap.set("n", "<leader><leader>", fzfLua.files)
			vim.keymap.set("n", "<leader>b", fzfLua.buffers)
			vim.keymap.set("n", "<leader>h", fzfLua.help_tags)
			vim.keymap.set("n", "<C-p>", fzfLua.git_files)
			vim.keymap.set("n", "??", fzfLua.live_grep)
			vim.keymap.set("n", "<leader>o", fzfLua.lsp_document_symbols)
			vim.keymap.set("n", "<leader>O", fzfLua.lsp_live_workspace_symbols)
			vim.keymap.set("n", "<leader>;", fzfLua.commands)
			vim.keymap.set("n", "<leader>i", function()
				fzfLua.files({ cwd = "~/.config/nvim" })
			end)
		end,
	},
}
