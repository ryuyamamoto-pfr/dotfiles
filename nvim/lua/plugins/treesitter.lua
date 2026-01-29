return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",  -- 追加：安定版ブランチを使用
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "cpp",
          "csv",
          "dockerfile",
          "gitcommit",
          "gitignore",
          "html",
          "json",
          "lua",
          "markdown",
          "python",
          "vim",
          "xml",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true, disable = { "python", "cpp" } },
      })
    end,
  },
}
