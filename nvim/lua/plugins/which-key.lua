return {
  "folke/which-key.nvim",
  event = 'VimEnter',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- delay = 0,
    spec = {
      { '<leader>f', group = '[F]ind' },
      { '<leader>b', group = '[B]uffers' },
      { '<leader>e', group = '[E]dit/Explore' },
      { '<leader>l', group = '[L]SP' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}
