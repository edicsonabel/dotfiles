-- Neovim API Aliases
local cmd = vim.cmd
local exec = vim.api.nvim_exec
local fn = vim.fn
local g = vim.g
local opt = vim.opt

-- General
-- g.mapleader = ';'

--UI
opt.number = true
opt.relativenumber = true
opt.encoding='utf-8'
opt.wrap = false
opt.showmatch = true
opt.showcmd = true
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.hlsearch = false
opt.incsearch = true
opt.smartindent = true
