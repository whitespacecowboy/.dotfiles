return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require('gitsigns').setup {}
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.del('n', 'y<C-g>')
		end,
	}
}
