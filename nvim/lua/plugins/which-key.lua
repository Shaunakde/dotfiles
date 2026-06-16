return {
  "folke/which-key.nvim",
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- delay = 0,
      },
  spec = {
        { '<leader>f', group = '[S]earch' },
        { '<leader>b', group = '[B]uffers' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      }
}
