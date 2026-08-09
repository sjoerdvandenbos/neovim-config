return {
	'nvim-treesitter/nvim-treesitter',
    branch = "main",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
	config = function()
        -- Nvim ships parsers and queries for c, lua, markdown,
        -- markdown_inline, query, vim and vimdoc, so only the rest needs
        -- installing. Parsers land in stdpath("data")/site, already on 'rtp'.
        local ensure_installed = {
            "bash",
            "haskell",
            "html",
            "javascript",
            "json",
            "python",
            "rust",
            "xml",
            "yaml",
        }

        local installed = require("nvim-treesitter.config").get_installed("parsers")
        local missing = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure_installed)
        if #missing > 0 then
            require("nvim-treesitter").install(missing)
        end

        -- The main branch dropped the highlight/indent modules: both are
        -- driven by Nvim's own treesitter runtime now.
        vim.api.nvim_create_autocmd("FileType", {
            group = vim.api.nvim_create_augroup("sjoerd.treesitter", {}),
            callback = function(event)
                local lang = vim.treesitter.language.get_lang(event.match)
                if not lang or not vim.treesitter.language.add(lang) then
                    return
                end

                vim.treesitter.start(event.buf, lang)

                -- Only where nvim-treesitter installed an indents query;
                -- otherwise Nvim's own indent script stays in charge.
                if vim.treesitter.query.get(lang, "indents") then
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
	end,
}
