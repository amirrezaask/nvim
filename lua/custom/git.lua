return { -- Git Client
	"tpope/vim-fugitive",
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "fugitive",
			callback = function(ev)
				vim.keymap.set("n", "P", "<cmd>Git push<CR>", { buffer = ev.buf })
				vim.keymap.set("n", "p", "<cmd>Git pull --rebase<CR>", { buffer = ev.buf })
			end,
		})
	end,
}
