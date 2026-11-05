return {
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod" },
			{ "kristijanhusak/vim-dadbod-completion" },
		},
		init = function()
			vim.g.dbs = {
				{
					name = "watchlist",
					url = "mariadb://mani:password@%2Frun%2Fmysqld%2Fmysqld.sock/watchlist"
				}
			}
		end,
		vim.api.nvim_set_keymap('n', '<leader>d', ':DBUI<CR>', { noremap = true, silent = true })
	},
}
