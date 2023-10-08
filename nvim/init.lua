vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("filetype plugin indent on")
vim.cmd("set shiftwidth=2")

vim.cmd("set termguicolors")
vim.cmd("set background=dark")
vim.g.gruvbox_material_background= 'soft'
vim.cmd("colorscheme gruvbox-material")

require("nvim-tree").setup()

require'lualine'.setup {
  options = {
    theme = 'gruvbox-material'
  }
}

vim.g.vimwiki_list = {
  {
    path = '~/.config/wiki',
    path_html = '~/.config/html_wiki',
    syntax = 'markdown',
    nested_syntaxes = {
      python = 'python',
    },
  },
}

vim.api.nvim_set_keymap("n", "<leader>t", ":NvimTreeToggle<CR>", { noremap = false })
vim.cmd("nmap <C-s> :w<CR>") 
vim.cmd("map <Up> <Nop>")
vim.cmd("map <Left> <Nop>")
vim.cmd("map <Right> <Nop>")
vim.cmd("map <Down> <Nop>")
