vim.keymap.set("n", "Y", "y$", { desc = "Copy whole line" })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("i", "<C-c>", "<esc>")
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")
vim.keymap.set("n", "{", "<cmd>cprev<CR>") -- Quick fix list
vim.keymap.set("n", "}", "<cmd>cnext<CR>") -- Quickfix list
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "Q", "<cmd>q<CR>")
vim.keymap.set("n", "<CR>", [[ {-> v:hlsearch ? ':nohl<CR>' : '<CR>'}() ]], { expr = true })
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<M-Left>", "<c-w>5>")
vim.keymap.set("n", "<M-Right>", "<c-w>5<")
vim.keymap.set("n", "<M-Up>", "<C-W>+")
vim.keymap.set("n", "<M-Down>", "<C-W>-")
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
vim.keymap.set("t", "<C-w><C-w>", function()
	vim.cmd([[ wincmd w ]])
end)
vim.keymap.set("n", "<leader>l", vim.diagnostic.open_float, { desc = "Diagnostics: Open float window" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set Local list" })
vim.keymap.set("n", "<leader>g", "<cmd>LazyGit<CR>", { desc = "Lazy Git" })
vim.keymap.set({ "n", "i", "t" }, "<C-h>", "<cmd>tabprev<CR>", {})
vim.keymap.set({ "n", "i", "t" }, "<C-l>", "<cmd>tabnext<CR>", {})

vim.cmd([[ command! W :w ]])

local qflist = false
vim.keymap.set("n", "<C-q>", function()
	if qflist == true then
		qflist = not qflist
		vim.cmd([[ cclose ]])
	else
		qflist = not qflist
		vim.cmd([[ copen ]])
	end
end, { desc = "Open Quickfix list" })
