return {
    'neovim/nvim-lspconfig',
    event = {'BufReadPre', 'BufNewFile'},
    dependencies = {
      {'mason-org/mason-lspconfig.nvim'},
    },
    config = function()
      -- Nvim maps grn (rename), gra (code action), grr (references),
      -- gri (implementation), grt (type definition), gO (document symbols),
      -- K (hover) and i_CTRL-S (signature help) on its own, and sets
      -- 'omnifunc', 'tagfunc' and 'formatexpr'. See :help lsp-defaults.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('sjoerd.lsp', {}),
        callback = function(event)
          local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
          local opts = {buffer = event.buf}

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)            -- rename symbol
          vim.keymap.set({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts) -- code actions / refactor
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)         -- go to definition

          -- Lets <C-y> apply snippets, import edits and commands from the
          -- items 'omnifunc' feeds into the completion menu.
          if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf)
          end
        end,
      })

      vim.lsp.config('nixd', {
        filetypes = { 'nix' },
        settings = {
          nixd = {
            options = {
              home_manager = {
                expr = '(import <home-manager/modules> { configuration = ~/.config/home-manager/home.nix; }).options',
              },
            },
            nixpkgs = {
              expr = 'import <nixpkgs> { }',
            },
            formatting = {
              command = { 'nixfmt' },
            },
          },
        },
      })

      if vim.fn.executable('nixd') == 1 then
        vim.lsp.enable('nixd')
      end

      -- lazydev.nvim supplies workspace.library and the `vim` global.
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      require('mason-lspconfig').setup()
    end,
}
