local o = vim.opt
local g = vim.g
local cmd = vim.cmd

-- global options
o.autoindent = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.copyindent = true

-- commands
cmd('syntax on')

-- coq.nvim
g.coq_settings = {
    auto_start = 'shut-up'
}

-- barbar.nvim
require("barbar")
