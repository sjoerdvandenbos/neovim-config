-- Sets the shell pwd to the path argument of nvim when launched from the terminal
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function(event)
        local match = string.find(event.file, "oil://")
        if match then
            local dir = string.gsub(event.file, "oil://", "")
            vim.cmd(string.format("cd %s", dir))
        else
            vim.cmd("cd %:p:h")
        end
    end,
})
