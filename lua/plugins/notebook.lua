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

return {}
