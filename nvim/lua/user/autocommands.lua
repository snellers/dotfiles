vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank ({ higroup = "IncSearch", timeout = 200 })
  end,
})

local highlight_group = vim.api.nvim_create_augroup('GeneralColorSchemeTweaks', { clear = true })
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    -- makes some of the spacer sections in the status line the same colour
    local status_line = vim.api.nvim_get_hl_by_name('StatusLine', true)
    local non_text = vim.api.nvim_get_hl_by_name('NonText', true)
    vim.api.nvim_set_hl(0, 'StatusLineNonText', { fg = non_text.foreground, bg = status_line.background })
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.sql", "*.pls", "*.tps", "*.psql", "*.pks", "*.trg" },
  callback = function()
    vim.cmd [[
      set filetype=sql
      syntax on
    ]]
  end,
})
