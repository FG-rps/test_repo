-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local hl_groups = vim.api.nvim_get_hl(0, {}) for key, hl_group in pairs(hl_groups) do if hl_group.italic then vim.api.nvim_set_hl(0, key, vim.tbl_extend("force", hl_group, {italic = false})) end end
