local M = {}
M.keymap = function(mode, lhs, rhs, opts)
	vim.keymap.set(mode, lhs, rhs, vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true }))
end
return M

