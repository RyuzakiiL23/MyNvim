-- set colorscheme to nightfly with protected call
-- in case it isn't installed
-- local status, _ = pcall(vim.cmd, "colorscheme nightfly")
--
-- local mocha = require("catppuccin.palettes").get_palette("mocha")
-- if not mocha then
--   print("Colorscheme not found!") -- print error if colorscheme not installed
--   return
-- end

vim.cmd.colorscheme("catppuccin")
