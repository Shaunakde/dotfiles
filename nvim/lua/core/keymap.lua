-- Helpers to create a Normal mode mapping
local nmap = function(lhs, rhs, desc)
  -- See `:h vim.keymap.set()`
  vim.keymap.set('n', lhs, rhs, { desc = desc })
end
local nmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, { desc = desc })
end
local xmap_leader = function(suffix, rhs, desc)
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, { desc = desc })
end

-- b is for 'Buffer'. Common usage:
-- - `<Leader>bs` - create scratch (temporary) buffer
-- - `<Leader>ba` - navigate to the alternative buffer
-- - `<Leader>bw` - wipeout (fully delete) current buffer
local new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

nmap_leader('ba', '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader('bd', '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader('bD', '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader('bs', new_scratch_buffer,                            'Scratch')
nmap_leader('bw', '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader('bW', '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- w is for 'Write'. ':update' writes only when the buffer is modified.
nmap_leader('w',  '<Cmd>update<CR>',                             'Write (save if changed)')

-- e is for 'Explore' and 'Edit'. Common usage:
-- - `<Leader>ed` - open explorer at current working directory
-- - `<Leader>ef` - open directory of current file (needs to be present on disk)
-- - `<Leader>ei` - edit 'init.lua'
-- - All mappings that use `edit_plugin_file` - edit 'plugin/' config files
local edit_plugin_file = function(filename)
--  return string.format('<Cmd>edit %s/plugin/%s<CR>', vim.fn.stdpath('config'), filename)
    return string.format('<Cmd>edit %s/%s<CR>', vim.fn.stdpath('config'), filename)
end
local explore_at_file = '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>'
local explore_quickfix = function()
  for _, win_id in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.fn.getwininfo(win_id)[1].quickfix == 1 then return vim.cmd('cclose') end
  end
  vim.cmd('copen')
end

nmap_leader('ed', '<Cmd>lua MiniFiles.open()<CR>',          'Directory')
nmap_leader('ee', '<Cmd>Ex<CR>',                            'File Explorer')
nmap_leader('ef', explore_at_file,                          'File directory')
nmap_leader('ei', '<Cmd>edit $MYVIMRC<CR>',                 'init.lua')
nmap_leader('ek', edit_plugin_file('lua/core/keymap.lua'),  'Keymaps config')
-- nmap_leader('em', edit_plugin_file('30_mini.lua'),          'MINI config')
nmap_leader('en', '<Cmd>lua MiniNotify.show_history()<CR>', 'Notifications')
-- nmap_leader('eo', edit_plugin_file('10_options.lua'),       'Options config')
-- nmap_leader('ep', edit_plugin_file('40_plugins.lua'),       'Plugins config')
nmap_leader('eq', explore_quickfix,                         'Quickfix')

-- Remap < and > in visual mode to indent/dedent and then re-select the visual block
vim.keymap.set("v", "<", "<gv", { desc = "Dedent and re-select visual block" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and re-select visual block" })

-- Keybinds to make buffer and window navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Buffer navigation with Shift+H / Shift+L.
-- NOTE: this overrides Neovim's default screen-motion keys:
--   H = jump to the top (High) line of the visible window
--   L = jump to the bottom (Low) line of the visible window
-- (M = middle line is left untouched.) These motions are rarely used; gg/G,
-- <C-d>/<C-u>, and zt/zz/zb cover the same ground.
nmap('H', '<Cmd>bprevious<CR>', 'Previous buffer')
nmap('L', '<Cmd>bnext<CR>',     'Next buffer')

-- Use jk like Escape
-- TODO: Make this work!
-- vim.keymap.set('n', 'jk', '<Esc>', { noremap = true, silent = true })

-- Basic file finding (mini.pick) — wrapped so MiniPick is resolved at call time
vim.keymap.set('n', '<leader>ff', function() MiniPick.builtin.files()     end, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', function() MiniPick.builtin.grep_live() end, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fb', function() MiniPick.builtin.buffers()   end, { desc = '[F]ind [B]uffers' })
vim.keymap.set('n', '<leader>fh', function() MiniPick.builtin.help()      end, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fr', function() MiniPick.builtin.resume()    end, { desc = '[F]ind [R]esume' })
-- vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
-- vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
-- vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
-- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

