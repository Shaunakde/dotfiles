return {
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    opts = {},
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      local servers = {
        "lua_ls",
        "pyright",
        "bashls",
        "gopls",
        "rust_analyzer",
        "ts_ls",
        "jsonls",
        "marksman",
        "clangd",
        "matlab_ls",
      }

      -- Per-server tweaks. Anything not overridden uses the default config
      -- from nvim-lspconfig's `lsp/<name>.lua`.
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = { globals = { "vim", "MiniPick", "MiniFiles", "MiniBufremove", "MiniNotify" } },
            telemetry = { enable = false },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      -- Diagnostics UI
      vim.diagnostic.config({
        virtual_text = { spacing = 2, prefix = "●" },
        severity_sort = true,
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "",
            [vim.diagnostic.severity.INFO]  = "",
            [vim.diagnostic.severity.HINT]  = "",
          },
        },
      })

      -- LSP keymaps: set on attach so they only apply in LSP-attached buffers.
      -- Neovim 0.11+ already provides defaults: grn (rename), gra (code action),
      -- grr (references), gri (implementation), gO (document symbol), <C-s> in
      -- insert mode (signature help). We add a few extras.
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map("n", "gd",         vim.lsp.buf.definition,      "LSP: Goto Definition")
          map("n", "gD",         vim.lsp.buf.declaration,     "LSP: Goto Declaration")
          map("n", "gy",         vim.lsp.buf.type_definition, "LSP: Goto Type Definition")
          map("n", "<leader>lf", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format buffer")
          map("n", "<leader>ld", vim.diagnostic.open_float,   "LSP: Line Diagnostics")
          map("n", "[d",         function() vim.diagnostic.jump({ count = -1, float = true }) end, "LSP: Prev Diagnostic")
          map("n", "]d",         function() vim.diagnostic.jump({ count =  1, float = true }) end, "LSP: Next Diagnostic")

          -- Inlay hints (if supported)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client:supports_method("textDocument/inlayHint") then
            map("n", "<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
            end, "LSP: Toggle inlay hints")
          end
        end,
      })
    end,
  },
}
