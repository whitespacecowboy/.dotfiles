-- Navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Write
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })

-- Remove highlight after searching
vim.keymap.set('n', '<C-[>', ':nohl<CR>', { noremap = true, silent = true })

-- Open terminal
vim.keymap.set('n', '<leader>t', ':sp | resize 16 | term<CR>', { noremap = true, silent = true })

-- Exit terminal mode and go to normal mode when pressing Esc
vim.keymap.set('t', '<c-[>', '<C-\\><C-n>', { noremap = true, silent = true })

-- split line
vim.keymap.set('n', '<CR>', 'i<CR><Esc>', { noremap = true, silent = true })

-- make
vim.keymap.set('n', '<leader>r', ':w | make <CR>', { noremap = true, silent = true })

-- Searching on browser
vim.keymap.set('v', 'gs', function()
	vim.cmd('normal! "vy')
	local text = vim.fn.getreg('v')
	text = text:gsub("%s+", '%%20')
	vim.fn.jobstart({ 'xdg-open', 'https://www.google.com/search?q=' .. text .. "&udm=14" }, { detach = true })

end, { noremap = true, silent = true })
