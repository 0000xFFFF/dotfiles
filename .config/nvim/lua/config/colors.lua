function ColorMyPencils(color)
	-- color = color or "molokayo"
	-- color = color or "gruvbox"
	color = color or "onehalfdark"
	vim.cmd.colorscheme(color)
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
