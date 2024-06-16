local jdtls_bin = vim.fn.expand('$HOME/jdtls/bin/jdtls')
local jdtls_conf_dir = vim.fn.expand('$HOME/.config/jdtls')
local workspace_dir = vim.fn.expand('$HOME/eclipse-workspace')
local config = {
    cmd = {
        jdtls_bin,
        '-configuration',
        jdtls_conf_dir,
        '-data',
        workspace_dir
    },
    root_dir = vim.fs.root(0, {".git"}),
}
require('jdtls').start_or_attach(config)

