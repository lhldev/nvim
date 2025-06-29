local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

for i = 1, 9 do
    vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon: Select File " .. i })
end

vim.keymap.set("n", "<leader>0", function() harpoon:list():select(10) end, { desc = "Harpoon: Select File 10" })
