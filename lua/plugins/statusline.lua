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

	return statusline .. " %r%h%w%q%m%f %l:%c | %y"
end

vim.opt.statusline = "%!v:lua.AmirrezaStatusLine()"

return {
	-- { "echasnovski/mini.statusline", version = false, opts = {} },
}
