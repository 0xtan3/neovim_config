-- lazy.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- GitHub Theme
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        -- You can add custom configuration here
        -- For example:
        -- style = 'dark',
        -- transparent = true,
        -- sidebars = {'qf', 'vista_kind', 'terminal', 'packer'},
        -- Change the "hint" color to the "orange" color, and make the "error" color bright red
        -- colors = { hint = "orange", error = "#ff0000" },
      })
      vim.cmd("colorscheme github_dark_dimmed")
    end,
  },

  -- LazyVim and its plugins
  {
    "LazyVim/LazyVim",
    import = "lazyvim.plugins",
  },

  -- Import your personal plugins
  {
    import = "plugins",
  },
}, {
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "github_dark", "tokyonight", "habamax" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
