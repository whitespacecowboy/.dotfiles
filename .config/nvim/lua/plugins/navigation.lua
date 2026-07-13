return {
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make'
			},
		},
		config = function()
			require('telescope').setup()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', function() builtin.find_files({ hidden = true }) end, {})
			vim.keymap.set('n', '<leader>fa', function() builtin.find_files({ cwd = '$HOME' , hidden = true }) end, {})
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
		end,
	},

	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		lazy = false,
		config = function ()
			require("oil").setup({
				keymaps = {
					["<leader>v"] = { "actions.select", opts = { vertical = true } },
					["<leader>h"] = { "actions.select", opts = { horizontal = true } },
				},
			})
			vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
		end
	}
}
