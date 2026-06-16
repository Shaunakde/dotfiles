return {
    'https://github.com/nvim-mini/mini.nvim',
    init = function()

	-- Better Around/Inside textobjects
	require('mini.ai').setup(
            { n_lines = 500 }
        )
 
    require('mini.comment').setup()

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- require('mini.surround').setup() -- requires giving up s
    require('mini.statusline').setup(
        {use_icons = true}
    )

    require('mini.pick').setup()
    require('mini.extra').setup()

    require("mini.colors").setup()
    require("mini.align").setup()
    require("mini.keymap").setup()
    require("mini.basics").setup({
      options = {
        basic = true,
        extra_ui = true,
        win_borders = "bold",
      },
      mappings = {
        basic = true,
        windows = true,
      },
      autocommands = {
        basic = true,
        relnum_in_visual_mode = true,
      },
    })
    require("mini.bracketed").setup()

    require("mini.bufremove").setup()

    require("mini.comment").setup()

    require("mini.cursorword").setup()
    vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true })
    vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = false, bg = NONE })

    require("mini.diff").setup({
      view = {
        style = "sign",
        signs = { add = "█", change = "▒", delete = "" },
      },
    })

    require("mini.doc").setup()
    require("mini.git").setup()
    require("mini.extra").setup()

    require("mini.files").setup({
      mappings = {
        close = 'q',
      },
      windows = {
        preview = true,
        border = "rounded",
        width_preview = 80,
      },
    })

    require("mini.fuzzy").setup()
    require("mini.git").setup()

    require("mini.icons").setup()

    require("mini.indentscope").setup({
      draw = {
        animation = function()
          return 1
        end,
      },
      symbol = "│",
    })

    end
}
