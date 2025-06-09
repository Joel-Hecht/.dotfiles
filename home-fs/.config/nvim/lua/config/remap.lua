local which_key = require("which-key")
local builtin = require("telescope.builtin")

local non_lsp_mappings = {
		--keys in this dict require leader key " " to activate
	

	--keys here will happena ll the time i think
	--these are real remaps
	
}

which_key.add(non_lsp_mappings)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
	callback = function(event)
		local opts = { buffer = event.buf }
		
		local mappings = {
			g = {
				d = { vim.lsp.buf.definition, "Go to Definition" },
				l = {vim.diagnostic.open_float, "open diagnostic float" }, --I hav eno idea what this does
			},
			K = { vim.lsp.buf.hover, "Show hover information" },
			["<leader>"] = {
				l = {
					name = "LSP",
					a = { vim.lsp.buf.code_action, "Code Action" },
					r = { vim.lsp.buf.references, "References" },
					n = { vim.lsp.buf.rename, "Rename" },
					w = { vim.lsp.buf.workspace_symbol, "Workspace symbol" },
					d = { vim.diagnostic.open_float, "Open diagnostic float" },

				},
			},
			["[d"] = { vim.diagnostic.goto_next, "Go to next diagnostic" },
			["]d"] = { vim.diagnostic.goto_prev, "Go to previous diagnostic" },
		}

	 	which_key.add(mapptings, opts)

	end,
})



local telescope_mappings = {
	
	 	{ "<leader>f", group = "Find"},
		{"<leader>ff", builtin.find_files , desc = "Find files" },
		{ "<leader>fg", builtin.git_files , desc = "Find git files" },
		{ "<leader>fl", builtin.live_grep , desc = "Live grep" },
}

which_key.add(telescope_mappings)

which_key.add({ { ";",  builtin.buffers, desc = "Find buffers"  } } )

