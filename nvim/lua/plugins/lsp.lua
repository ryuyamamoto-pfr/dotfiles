return {
  {
    -- ToDo: refactor
    name = "clangd-lsp",
    dir = vim.fn.stdpath("config"),
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      vim.lsp.config("clangd", {
        cmd = {
          "clangd",
          "--clang-tidy",
          "--function-arg-placeholders=0",
          "--header-insertion=never",
        },
        filetypes = { "c", "cpp" },
        root_markers = {
          "compile_commands.json",
          ".clangd",
        },
        on_attach = function(client, bufnr)
          pcall(function()
            vim.lsp.semantic_tokens.stop(bufnr, client.id)
          end)

          client.server_capabilities.semanticTokensProvider = nil
        end,
      })

      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          "Pipfile",
          ".git",
        },
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
            }
          }
        }
      })

      vim.lsp.enable("clangd")
      vim.lsp.enable("pyright")
    end,
  },
}

