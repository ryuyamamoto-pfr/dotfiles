return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local conform = require("conform")

			conform.setup({
				formatters_by_ft = {
					c = { "clang_format" },
					cpp = { "clang_format" },
					python = { "ruff_format" },
					lua = { "stylua" },
				},

				formatters = {
					clang_format_on_save = {
						command = "clang-format",
						stdin = true,
						args = function(self, ctx)
							local found = vim.fs.find(
								".clang-format",
								{ path = vim.fs.dirname(ctx.filename), upward = true, type = "file" }
							)[1]

							if found then
								return {}
							else
								return { "-style=google" }
							end
						end,
					},
				},
			})

			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = { "*.c", "*.cpp", "*.h", "*.hpp", "*.py", "*.lua" },
				callback = function(args)
					conform.format({
						bufnr = args.buf,
					})
				end,
			})
		end,
	},
}
