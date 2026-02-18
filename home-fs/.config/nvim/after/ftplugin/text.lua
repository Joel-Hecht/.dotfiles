-- spell check
vim.cmd("setlocal spell")

-- line wrapping
vim.cmd("setlocal wrap")

-- move up and down display lines, instead of actual lines
-- useful for movement in large paragraphs
vim.keymap.set("n", "j", "gj")
vim.keymap.set("v", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("v", "k", "gk")
vim.keymap.set("n", "gk", "k")
