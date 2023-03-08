local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = true,
	sources = {
		diagnostics.rubocop,
		diagnostics.eslint,

		formatting.prettier,
		formatting.rubocop,
		formatting.stylua,

		formatting.eslint,
	},

	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
	-- on_attach = function(client)
	--     if client.server_capabilities.documentFormattingProvider then
	--         vim.cmd([[
	-- 	    augroup LspFormatting
	-- 		autocmd! * <buffer>
	-- 		autocmd BufWritePre <buffer> lua  vim.lsp.buf.format
	-- 	    augroup END
	-- 	    ]])
	--     end
	-- end
})
