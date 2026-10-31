require("codecompanion").setup({
  display = {
    chat = {
      show_settings = true,
      start_in_insert_mode = true,
    },
  },
  opts = {
    log_level = "TRACE", -- TRACE|DEBUG|ERROR|INFO
  },
  strategies = {
    chat = {
      adapter = "copilot",
    },
    inline = {
      adapter = "codestral",
    },
    cmd = {
      adapter = "codestral",
    },
  },
  adapters = {
    http = {
      codestral = function()
        return require("codecompanion.adapters").extend("ollama", {
          name = 'codestral',
          env = {
            -- url = "http://gw.llm.ftxt.iszn.cz:11434",
            url = "http://localhost:11434",
          },
          headers = {
            ["Content-Type"] = "application/json",
            ["Authorization"] = "Bearer ${api_key}",
          },
          parameters = {
            sync = true,
          },
          schema = {
            model = {
              default = "codestral:latest",
            },
          }
        })
      end,
    }
  },
  mcp = {
    servers = {
      gitlab = {
        cmd = {
          "npx",
          "mcp-remote",
          "https://mcp-gitlab.ai.iszn.cz/mcp",
          "--header",
          "Authorization: Bearer ${api_key}"
        },
        env = {
          api_key = "GITLAB_MCP_TOKEN",
        },
      },
      youtrack = {
        cmd = {
          "npx",
          "mcp-remote",
          "https://mcp-youtrack.ai.iszn.cz/",
          "--header",
          "Authorization: Bearer ${api_key}"
        },
        env = {
          api_key = "YOUTRACK_MCP_TOKEN",
        },
      },
    },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
