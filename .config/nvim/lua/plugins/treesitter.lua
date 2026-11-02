return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	config = function()
		require('nvim-treesitter').install {
			"python",
			"bash",
			"http",
			"json",
			"css",
			"sql",
			"cpp",
			"lua",
			"c",
		}
	end,
}
