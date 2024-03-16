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

return {}
