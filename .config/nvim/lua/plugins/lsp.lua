return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		config = function()
			local lsp = require('lsp-zero')
			lsp.preset("recommended")
			lsp.extend_lspconfig()
			vim.diagnostic.config({
				virtual_text = true,
				signs = true,
				update_in_insert = true,
				underline = true,
				severity_sort = true,
			})
		end
	},


	{ 'williamboman/mason-lspconfig.nvim' },
	{
		'neovim/nvim-lspconfig',
		vim.lsp.config('bashls', {
			filetypes = { 'bash', 'sh', 'zsh' },
				settings = {
					bashIde = {
						globPattern = "*@(.sh|.inc|.bash|.command|.zsh)"
					}
				}
			}
		)
	}
}
