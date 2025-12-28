-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ----------------------------
-- --[ Lazy Package Manager ]--
-- ----------------------------
-- Load the package manager
require("config.lazy")
require("core")
