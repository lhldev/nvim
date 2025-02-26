vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>dd", "\"_dd")
vim.keymap.set("v", "<leader>d", "\"_d")

vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-c>", "\"+y")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<leader>r", ":call RunCurrentFile()<CR>")
vim.keymap.set("v", "<leader>c", ":lua ToggleComment()<CR>")

vim.keymap.set("v", "<Tab>", ":lua IndentForward()<CR>")
vim.keymap.set("v", "<S-Tab>", ":lua IndentBackward()<CR>")

vim.keymap.set('n', '<leader>p', ':let @+=expand("%:p")<CR>')
