function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
  else
      return tostring(o)
   end
end
cmpTable = {}
function cmpSetup(tbl)
    for k, v in pairs(tbl)do
        if cmpTable[k] == nil then
            cmpTable[k]={v}
        else
            table.insert(cmpTable[k], v)
        end
    end
end
require("lazy").setup({
    { 
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    },
	{
        "ellisonleao/gruvbox.nvim", 
        lazy = false, 
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme gruvbox]])
        end,
	},
    { "nvim-treesitter/nvim-treesitter" },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = "nvim-treesitter/nvim-treesitter",
    },
    {
        "nvim-lualine/lualine.nvim", -- TODO: jacob is fancy and usually has cool bars
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    {
        "noib3/nvim-cokeline", -- TODO: what _is_ cokeline and check setup details
        dependencies = "kyazdani42/nvim-web-devicons",
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
--    { "onsails/lspkind-nvim" },
    { "hrsh7th/nvim-cmp" },
    {
        "hrsh7th/cmp-nvim-lsp",
        dependencies = "hrsh7th/nvim-cmp",
--        init = function()
--            local lsp_config = require("lspconfig")
--            lsp_config.util.default_config = vim.tbl_deep_extend(
--            "force",
--            lsp_config.util.default_config, {
--                capabilities = require("cmp_nvim_lsp").default_capabilities(),
--            })
--        end,
        config = function()
            cmpSetup({ sources = { name = "nvim_lsp" } })
        end,
    },
    {
        "hrsh7th/cmp-buffer",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmpSetup({ sources = { name = "buffer" } })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                  { name = "buffer" }
                }
            })
        end,
    },
    {
        "hrsh7th/cmp-cmdline",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            cmpSetup({ sources = { name = "cmdline" } })
            cmp.setup.cmdline({ ":" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                  { name = "cmdline" }
                }
            })
        end,
    },
    {
        "hrsh7th/cmp-calc",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            cmpSetup({ sources = { name = "calc" } })
        end,
    },
    {
        "hrsh7th/cmp-path",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            cmpSetup({ sources = { name = "path" } })
        end,
    },
    {
        "hrsh7th/cmp-look",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            cmpSetup({
                sources = {
                    name = "look",
                    keyword_length = 2,
                    options = {
                        convert_case = true,
                        loud = true
                    }
                },
            })
        end,
    },
    {
        "f3fora/cmp-spell",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            cmpSetup({
                sources = {
                    name = "spell",
                    option = {
                        keep_all_entries = false,
                        enable_in_context = function()
                            return require("cmp.config.context").in_treesitter_capture('spell')
                        end,
                    },
                },
            })
        end,
    },
    {
        "uga-rosa/cmp-dictionary",
        dependencies = "hrsh7th/nvim-cmp",
        config = function()
            cmpSetup({ sources = { name = "dictionary" } })
        end,
    },
    {
        "L3MON4D3/LuaSnip"
    },
    {
        "saadparwaiz1/cmp_luasnip",
        config = function()
            cmpSetup({
                snippet = {
                  expand = function(args)
                    require'luasnip'.lsp_expand(args.body)
                  end
                },
                sources = { name = 'luasnip' },
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = {
            disable_filetype = { "TelescopePrompt", "vim" },
            disable_in_macro = true,
            ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""),
            enable_moveright = true,
            enable_afterquote = true, -- add bracket pairs after quote,
            enable_check_bracket_line = true, --- check bracket in same line,
            map_bs = true, -- map the <BS> key,
            map_c_w = false, -- map <c-w> to delete an pair if possible,
            check_ts = true,
            ts_config = {
                lua = { "string" }, -- it will not add a pair on that treesitter node
                javascript = { "template_string" },
                java = false, -- don't check treesitter on java
            },
            function()
                local cmp_autopairs = require("nvim-autopairs.completion.cmp")
                require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
            end,
        },
    },
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim" ,
            "nvim-treesitter/nvim-treesitter" 
        },
        config = {
            -- prompt for return type
            prompt_func_return_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
            -- prompt for function parameters
            prompt_func_param_type = {
                go = true,
                cpp = true,
                c = true,
                java = true,
            },
        },
    },
    { "powerman/vim-plugin-AnsiEsc" },
    { "kwkarlwang/bufresize.nvim" },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = "mfussenegger/nvim-dap",
    },
    {
        "nvim-telescope/telescope.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
            require("telescope").load_extension("dap")
            require("telescope").load_extension("ui-select")
        end,
        dependencies = {
        "nvim-telescope/telescope-dap.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
    },
    { "tpope/vim-commentary" },
    { "lewis6991/gitsigns.nvim" },
    {
        "akinsho/toggleterm.nvim",
        config = {
            open_mapping = [[<c-`>]],
            size = 15,
            hide_numbers = true,
            shade_terminals = true,
            shading_factor = "0.4",
            start_in_insert = true,
            terminal_mappings = true,
            persist_size = true,
            direction = "horizontal",
            close_on_exit = false,
            },
    },
})
