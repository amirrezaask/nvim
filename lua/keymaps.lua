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
vim.keymap.set("t", "<C-w><C-w>", function()
	vim.cmd([[ wincmd w ]])
end)
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
