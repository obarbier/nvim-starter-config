-- This file can be loaded by calling `lua require('plugins')` from your init.vim


-- 


vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Only required if you have packer configured as `opt`
vim.api.nvim_command("packadd packer.nvim")

function get_setup(name)
  return string.format('require("setup/%s")', name)
end

return require('packer').startup({
  function(use)
    -- Packer can manage itself
    use({ "wbthomason/packer.nvim" })

    -- NO Cconfig needed
    use({ "kdheepak/lazygit.nvim" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "stevearc/dressing.nvim" })
    use({ "onsails/lspkind-nvim" })
    use({ "famiu/bufdelete.nvim" })
    use({ "wellle/targets.vim" })
    use({ "rcarriga/nvim-notify" })

    -- use({ "nvim-treesitter/nvim-treesitter-textobjects" })
    -- use({ "nvim-treesitter/nvim-treesitter-context" })
    -- use({ "windwp/nvim-ts-autotag" })


    
    -- config needed
    use({ "EdenEast/nightfox.nvim", config = get_setup("nightfox") })
    use({ "lukas-reineke/indent-blankline.nvim", config = get_setup("indent-blankline") })
    
    ---- packer.nvim: Error running config for lualine.nvim: /home/obarbier/.config/nvim/lua/setup/lualine.lua:92: module 'auto-session-library' not found:
    -- use({ "catppuccin/nvim", as = "catppuccin", config = get_setup("catppuccin"), before = "lualine.nvim" })
    -- use({
    --   "nvim-lualine/lualine.nvim",
    --   config = get_setup("lualine"),
    --   event = "VimEnter",
    --   requires = { "kyazdani42/nvim-web-devicons", opt = true },
    -- })
    
    use({
      "gen740/SmoothCursor.nvim",
      config = get_setup("smoothcursor"),
    })
    use({
      "folke/zen-mode.nvim",
      config = get_setup("zen-mode"),
    })
    use({ "brenoprata10/nvim-highlight-colors", config = get_setup("highlight-colors") })
    ---- Tree setter eror
    -- use({
    --   "nvim-treesitter/nvim-treesitter",
    --   config = get_setup("treesitter"),
    --   run = ":TSUpdate",
    -- })

    -- -- [packer.nvim] [ERROR 17:08:03] async.lua:20: Error in coroutine: ...ack/packer/start/packer.nvim/lua/packer/plugin_utils.lua:204: Vim(lua):E5108: Error executing lua [string ":lua"]:1: module 'cmp' not found:
    -- use({
    --   "hrsh7th/nvim-cmp",
    --   requires = {
    --     { "hrsh7th/cmp-nvim-lsp" },
    --     { "hrsh7th/cmp-nvim-lua" },
    --     { "hrsh7th/cmp-buffer" },
    --     { "hrsh7th/cmp-path" },
    --     { "hrsh7th/cmp-cmdline" },
    --     { "hrsh7th/vim-vsnip" },
    --     { "hrsh7th/cmp-vsnip" },
    --     { "hrsh7th/vim-vsnip-integ" },
    --     { "hrsh7th/cmp-calc" },
    --     { "rafamadriz/friendly-snippets" },
    --   },
    --   config = get_setup("cmp"),
    -- })
    -- use({
    --   "windwp/nvim-autopairs",
    --   after = "nvim-cmp",
    --   config = get_setup("autopairs"),
    -- })
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    use({
      "rlane/pounce.nvim",
      config = get_setup("pounce"),
    })
    use({
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      event = "BufReadPre",
      config = get_setup("gitsigns"),
    })
    use({ "jose-elias-alvarez/null-ls.nvim", config = get_setup("null-ls") })

    -- --  module 'cmp_nvim_lsp' not found:^
    -- use({ "neovim/nvim-lspconfig", config = get_setup("lsp") })

    --  -- 'telescope._extensions.file_browser.actions' not found:
    -- use({
    --   "nvim-telescope/telescope.nvim",
    --   module = "telescope",
    --   cmd = "Telescope",
    --   requires = {
    --     { "nvim-lua/plenary.nvim" },
    --     -- { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    --   },
    --   config = get_setup("telescope"),
    -- })
    -- use({ "nvim-telescope/telescope-file-browser.nvim" })
    
    use({
      "kylechui/nvim-surround",
      config = function()
        require("nvim-surround").setup({})
      end,
    })
    use({
      "rmagatti/session-lens",
      requires = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
      config = get_setup("session"),
    })
    use({
      "winston0410/range-highlight.nvim",
      requires = { { "winston0410/cmd-parser.nvim" } },
      config = get_setup("range-highlight"),
    })
    use({ "goolord/alpha-nvim", config = get_setup("alpha") })

    use({ "luukvbaal/stabilize.nvim", config = get_setup("stabilize") })
    use({
      "simrat39/symbols-outline.nvim",
      cmd = { "SymbolsOutline" },
      setup = get_setup("outline"),
      config = function() require("stabilize").setup() end
    })

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
        config =  get_setup("nvim-tree-icons"),
      },
      tag = 'nightly', -- optional, updated every week. (see issue #1193)
      config =  get_setup("nvim-tree-config"),
    }


    if packer_bootstrap then
      require("packer").sync()
    end
  end,
  config = {
    display = {
      open_fn = require("packer.util").float,
    },
    profile = {
      enable = true,
      threshold = 1, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  },
})