-- Enable auto-formatting
vim.g.prettier_autoformat = 1

-- Specify the path to the Prettier executable
vim.g.prettier_exec_cmd_path = '/home/lhl/.nvm/versions/node/v22.9.0/bin/prettier'

-- Set additional Prettier options
vim.g.prettier_config_tab_width = 2
vim.g.prettier_config_single_quote = 1
vim.g.prettier_config_trailing_comma = 'es5'

-- Auto-format files on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts", "*.css", "*.html", "*.json" },
  command = "Prettier",
})

