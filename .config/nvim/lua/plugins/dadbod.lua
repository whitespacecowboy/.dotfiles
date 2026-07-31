return {
	{ "tpope/vim-dadbod" },
	{ "kristijanhusak/vim-dadbod-ui" },
	{ "kristijanhusak/vim-dadbod-completion" },
	vim.api.nvim_set_keymap('n', '<leader>d', ':DBUI<CR>', { noremap = true, silent = true })
}
