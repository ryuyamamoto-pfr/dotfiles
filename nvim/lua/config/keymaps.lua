local opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('i', 'jj', '<Esc>:<C-u>w<cr', opts)
--vim.keymap.set('n', '<Esc><Esc>', ':nohlsearch')

vim.api.nvim_set_keymap('n', '<Leader>v', ':vs<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>s', ':sp<CR>', opts)

vim.api.nvim_set_keymap('n', '<Leader>h', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<Leader>j', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<Leader>k', '<C-w>k', opts)
vim.api.nvim_set_keymap('n', '<Leader>l', '<C-w>l', opts)

vim.api.nvim_set_keymap('n', 'j', 'gj', opts)
vim.api.nvim_set_keymap('n', 'k', 'gj', opts)

-- telescope config
vim.api.nvim_set_keymap('n', "<Leader>fc", "<cmd>Telescope frecency<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>ff", "<cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fg", "<cmd>Telescope live_grep<CR>", opts)
-- vim.api.nvim_set_keymap('n', "<Leader>fs", "<cmd>Telescope grep_string<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fd", "<cmd>Telescope lsp_definitions<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fr", "<cmd>Telescope lsp_references<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fi", "<cmd>Telescope lsp_implementations<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fb", "<cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap('n', "<Leader>fh", "<cmd>Telescope help_tags<CR>", opts)

vim.keymap.set('n', '<Leader>fs', function()
  require('telescope.builtin').grep_string({
    word_match = '-w',
    additional_args = {
      '--no-follow',
      '--glob', '!**/test/**',
      '--glob', '!**/tests/**',
      '--glob', '!**/*_test.cpp',
      '--glob', '!**/*_test.hpp',
    },
  })
end, { desc = "Grep exact word (no test, no symlink)" })

-- Oil
vim.api.nvim_set_keymap('n', "<Leader>e", "<cmd>Oil<CR>", opts)

-- NERDTree
-- vim.api.nvim_set_keymap('n', "<Leader>e", "<cmd>NvimTreeToggle<CR>", opts)

-- terminal mode for toggle term
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

