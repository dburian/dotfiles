require("codecompanion").setup({
  opts = {
    log_level = "TRACE", -- TRACE|DEBUG|ERROR|INFO
  },
  strategies = {
    chat = {
      adapter = "codestral",
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
})
