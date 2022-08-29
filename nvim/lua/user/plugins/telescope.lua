local telescope = require('telescope')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local keymap = require('user.lib.keys').keymap
local telescope_custom_actions = {}

-- multiopen() courtesy of rebelot https://github.com/nvim-telescope/telescope.nvim/issues/1048
local function multiopen(prompt_bufnr, method)
    local edit_file_cmd_map = {
        vertical = "vsplit",
        horizontal = "split",
        default = "edit",
    }
    local edit_buf_cmd_map = {
        vertical = "vert sbuffer",
        horizontal = "sbuffer",
        tab = "tab sbuffer",
        default = "buffer",
    }
    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()
    if #multi_selection > 1 then
        require("telescope.pickers").on_close_prompt(prompt_bufnr)
        pcall(vim.api.nvim_set_current_win, picker.original_win_id)

        for i, entry in ipairs(multi_selection) do
            local filename, row, col

            if entry.path or entry.filename then
                filename = entry.path or entry.filename

                row = entry.row or entry.lnum
                col = vim.F.if_nil(entry.col, 1)
            elseif not entry.bufnr then
                local value = entry.value
                if not value then
                    return
                end

                if type(value) == "table" then
                    value = entry.display
                end

                local sections = vim.split(value, ":")

                filename = sections[1]
                row = tonumber(sections[2])
                col = tonumber(sections[3])
            end

            local entry_bufnr = entry.bufnr

            if entry_bufnr then
                if not vim.api.nvim_buf_get_option(entry_bufnr, "buflisted") then
                    vim.api.nvim_buf_set_option(entry_bufnr, "buflisted", true)
                end
                local command = i == 1 and "buffer" or edit_buf_cmd_map[method]
                pcall(vim.cmd, string.format("%s %s", command, vim.api.nvim_buf_get_name(entry_bufnr)))
            else
                local command = i == 1 and "edit" or edit_file_cmd_map[method]
                if vim.api.nvim_buf_get_name(0) ~= filename or command ~= "edit" then
                    filename = require("plenary.path"):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
                    pcall(vim.cmd, string.format("%s %s", command, filename))
                end
            end

            if row and col then
                pcall(vim.api.nvim_win_set_cursor, 0, { row, col-1 })
            end
        end
    else
        actions["select_" .. method](prompt_bufnr)
    end
end

function telescope_custom_actions.multi_selection_open_vsplit(prompt_bufnr)
    multiopen(prompt_bufnr, "vertical")
end
function telescope_custom_actions.multi_selection_open_split(prompt_bufnr)
    multiopen(prompt_bufnr, "horizontal")
end
function telescope_custom_actions.multi_selection_open(prompt_bufnr)
    multiopen(prompt_bufnr, "default")
end

telescope.setup({
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<C-Down>'] = actions.cycle_history_next,
        ['<C-Up>'] = actions.cycle_history_prev,
        ["<CR>"] = telescope_custom_actions.multi_selection_open,
        ["<C-V>"] = telescope_custom_actions.multi_selection_open_vsplit,
        ["<C-S>"] = telescope_custom_actions.multi_selection_open_split,
      },
    },
    file_ignore_patterns = { '.git/', 'target/' },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    lsp_references = {
      previewer = false,
    },
  },
})

require('telescope').load_extension('fzf')
require('telescope').load_extension('live_grep_args')

keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
keymap('n', '<leader>F', [[<cmd>lua require('telescope.builtin').find_files({ no_ignore = true, prompt_title = 'All Files' })<CR>]]) -- luacheck: no max line length
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
keymap('n', '<leader>g', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>]])
keymap('n', '<leader>h', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
