-- Enabling features in nvim-term
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.o.modifiable = true
		vim.o.relativenumber = true
		vim.o.number = true
		vim.o.wrap = true
		vim.o.linebreak = true
	end
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "/home/Mani/.dotfiles/.config/hypr/*.conf",
	command = "!hyprctl reload all"
})
