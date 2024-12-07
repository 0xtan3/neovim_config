-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- Add the snacks.nvim plugin with custom configuration in your Lazy.nvim setup
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          -- Header Section
          { section = "header" },

          -- Terminal Pane for Colorscript
          {
            pane = 2,
            section = "terminal",
            cmd = "colorscript -e square", -- Ensure 'colorscript' is installed and in PATH
            height = 5,
            padding = 1,
            enabled = vim.fn.executable("colorscript") == 1, -- Only show if colorscript is installed
          },

          -- Key Bindings Section
          { section = "keys", gap = 1, padding = 1 },

          -- Browse Repo Action
          {
            pane = 2,
            icon = " ",
            desc = "Browse Repo",
            padding = 1,
            key = "b",
            action = function()
              Snacks.gitbrowse()
            end,
          },

          -- GitHub Commands Section (Dynamic)
          function()
            local in_git = Snacks.git.get_root() ~= nil
            local has_gh = vim.fn.executable("gh") == 1
            local cmds = {
              -- Notifications
              {
                title = "Notifications",
                cmd = "gh notify -s -a -n5",
                action = function()
                  vim.ui.open("https://github.com/notifications")
                end,
                key = "n",
                icon = " ",
                height = 5,
                enabled = has_gh,
              },
              -- Open Issues
              {
                title = "Open Issues",
                cmd = "gh issue list -L 3",
                key = "i",
                action = function()
                  vim.fn.jobstart("gh issue list --web", { detach = true })
                end,
                icon = " ",
                height = 7,
                enabled = has_gh,
              },
              -- Open PRs
              -- {
              --   icon = " ",
              --   title = "Open PRs",
              --   cmd = "gh pr list -L 3",
              --   key = "p",
              --   action = function()
              --     vim.fn.jobstart("gh pr list --web", { detach = true })
              --   end,
              --   height = 7,
              --   enabled = has_gh,
              -- },
              -- Git Status (Fallback for hub command)
              {
                icon = " ",
                title = "Git Status",
                cmd = "hub status",
                height = 10,
              },
            }
            return vim.tbl_map(function(cmd)
              return vim.tbl_extend("force", {
                pane = 2,
                section = "terminal",
                enabled = cmd.enabled ~= false, -- Default to enabled if not set
                padding = 1,
                ttl = 5 * 60,
                indent = 3,
              }, cmd)
            end, cmds)
          end,

          -- Startup Section
          { section = "startup" },
        },
      },
    },
  },
}
