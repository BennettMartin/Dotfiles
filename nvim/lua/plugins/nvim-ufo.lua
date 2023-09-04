return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = "BufReadPost",
    init = function()
      -- INFO fold commands usually change the foldlevel, which fixes folds, e.g.
      -- auto-closing them after leaving insert mode, however ufo does not seem to
      -- have equivalents for zr and zm because there is no saved fold level.
      -- Consequently, the vim-internal fold levels need to be disabled by setting
      -- them to 99
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    opts = {
      provider_selector = function(_, ft, _)
        local lspWithOutFolding = { "markdown", "bash", "sh", "bash", "zsh", "css" }
        if vim.tbl_contains(lspWithOutFolding, ft) then
          return { "treesitter", "indent" }
        elseif ft == "html" then
          return { "indent" } -- lsp & treesitter do not provide folds
        else
          return { "lsp", "indent" }
        end
      end,
      -- open opening the buffer, close these fold kinds
      -- use `:UfoInspect` to get available fold kinds from the LSP
      close_fold_kinds = { "imports" },
      open_fold_hl_timeout = 500,
    },
  },
}
