-- return {
--   {
--     "olimorris/onedarkpro.nvim",
--     priority = 1000,
--     lazy = false,
--     config = function()
--       vim.opt.background = "dark"
--
--       require("onedarkpro").setup({
--         theme = "onedark", -- onedark / onelight / onedark_vivid / onedark_dark
--         styles = {
--           comments = "italic",
--           keywords = "bold",
--           functions = "NONE",
--           strings = "NONE",
--           variables = "NONE",
--         },
--         options = {
--           transparency = false,
--           terminal_colors = true,
--         },
--       })
--
--       vim.cmd.colorscheme("onedark")
--     end,
--   },
-- }

-- return {
-- {
--   "gmr458/vscode_modern_theme.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vscode_modern").setup({
--       cursorline = true,
--       transparent_background = false,
--       nvim_tree_darker = true,
--     })
--     vim.cmd.colorscheme("vscode_modern")
--   end,
-- }
-- }
--
return {
{
  "rockyzhang24/arctic.nvim",
  dependencies = { "rktjmp/lush.nvim" },
  name = "arctic",
  branch = "main",
  priority = 1000,
  config = function()
    vim.cmd("colorscheme arctic")
  end
}
}
