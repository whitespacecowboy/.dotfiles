return {
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-buffer' },
	{ 'hrsh7th/cmp-path' },

	{
		"L3MON4D3/LuaSnip",
		{
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip"
		},
	},

	{
		'hrsh7th/nvim-cmp',
		config = function ()
			local cmp = require('cmp')
			local cmp_action = require('lsp-zero').cmp_action()
			cmp.setup({
				experimental = {
					-- ghost_text = true
				},
				window = {
					completion = { -- rounded border; thin-style scrollbar
						border = 'rounded',
						scrollbar = '║',
					},
					documentation = { -- no border; native-style scrollbar
						border = 'rounded',
						scrollbar = '║',
						-- other options
					},
				},
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'buffer' },
					{ name = 'path' },
					{ name = 'luasnip' },
					{ name = 'vim-dadbod-completion' }
				},
				mapping = {
					-- ['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					['<C-f>'] = cmp_action.luasnip_jump_forward(),
					['<C-d>'] = cmp_action.luasnip_jump_backward(),
				}
			})
		end
	},

	{
		'windwp/nvim-autopairs',
		config = true,
		opts = {}
	},

	{
		'nvim-mini/mini.surround',
		version = "*",
		config = function ()
			require('mini.surround').setup({
				mappings = {
					add = 'gsa', -- Add surrounding in Normal and Visual modes
					delete = 'gsd', -- Delete surrounding
					find = 'gsf', -- Find surrounding (to the right)
					find_left = 'gsF', -- Find surrounding (to the left)
					highlight = 'gsh', -- Highlight surrounding
					replace = 'gsr', -- Replace surrounding
					suffix_last = 'l', -- Suffix to search with "prev" method
					suffix_next = 'n', -- Suffix to search with "next" method
				},
				silent = true
			})
		end
	},

	-- {
	-- 	"abecodes/tabout.nvim",
	-- 	lazy = false,
	-- 	config = function ()
	-- 		require("tabout").setup({})
	-- 	end,
	-- }
}
