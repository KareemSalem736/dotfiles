return {
  "nvim-java/nvim-java",
  enabled = false,
  config = function()
    require("java").setup({
      -- Extensions
      lombok = {
        enable = true,
        version = "1.18.42",
      },
      -- JDK installation
      jdk = {
        auto_install = false,
      },
    })
    vim.lsp.enable("jdtls", {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-25",
                path = os.getenv("JAVA_HOME") and (os.getenv("JAVA_HOME") .. "/bin/java") or vim.fn.exepath("java"),
                default = true,
              },
            },
          },
        },
      },
    })
  end,
}
