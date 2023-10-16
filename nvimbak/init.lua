require("josean.plugins-setup")
require("josean.core.options")
require("josean.core.keymaps")
require("josean.core.colorscheme")
require("josean.plugins.comment")
require("josean.plugins.nvim-tree")
require("josean.plugins.lualine")
--require("josean.plugins.telescope")

-- Define the keybinding

vim.api.nvim_set_keymap(
  "n",
  "<leader>be",
  ':lua require("josean.plugins.betty_checker").check_betty_errors()<CR>',
  { noremap = true, silent = true }
)

-- Define the autocommand to run check_betty_errors in normal mode
-- vim.cmd([[
--   augroup BettyChecker
--     autocmd!
--     autocmd CursorMoved * lua require("josean.plugins.betty_checker").check_betty_errors()
--   augroup END
-- ]])
require("josean.plugins.nvim-cmp")
require("josean.plugins.lsp.mason")
require("josean.plugins.lsp.lspsaga")
require("josean.plugins.lsp.lspconfig")
require("josean.plugins.lsp.null-ls")
require("josean.plugins.autopairs")
require("josean.plugins.treesitter")
require("josean.plugins.gitsigns")
vim.api.nvim_set_keymap(
  "n",
  "<leader>pe", -- Use "pe" for PyCodeStyle
  ':lua require("pycodestyle_checker").check_pep8_errors()<CR>',
  { noremap = true, silent = true }
)
