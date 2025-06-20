-- This script makes sure that the lazy package manager is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	  vim.fn.system({
	      "git",
		  "clone",
		  "--filter=blob:none",
		  "https://github.com/folke/lazy.nvim.git",
		  "--branch=stable", -- latest stable release
		  lazypath,
		})
end
vim.opt.rtp:prepend(lazypath)
		 
require("lazy").setup({
	spec = "config.lazy",
	change_detection = { notify = false }
})
