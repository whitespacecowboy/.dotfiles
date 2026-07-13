return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗"
					}
				},
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"pyright",
					"bashls",
					"clangd",
					"cssls",
					"emmet_ls",
					"lua_ls",
					"vtsls",
					-- "ts_ls"
				}
			})
		end,
	}
}
