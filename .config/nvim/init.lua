require("rc/base")

-- ===============================

require("rc/option")
require("rc/display")
require("rc/pluginlist")
require("rc/mappings")
if vim.g.vscode then
	require("rc/vscode-neovim/mappings")
end
vim.defer_fn(function()
	require("rc/command")
end, 50)
require("rc/autocmd")

-- ===============================
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/rc/myplugins/start", [[v:val =~ '\.lua$']])) do
	require("rc/myplugins/start/" .. file:gsub("%.lua$", ""))
end
vim.schedule(function()
	for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/rc/myplugins/opt", [[v:val =~ '\.lua$']])) do
		require("rc/myplugins/opt/" .. file:gsub("%.lua$", ""))
	end
end)

-- ===============================
-- Local Configuration
if vim.fn.filereadable(vim.fn.expand("~/.nvim_local_init.lua")) ~= 0 then
	dofile(vim.fn.expand("~/.nvim_local_init.lua"))
end
