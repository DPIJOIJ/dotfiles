local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.api.nvim_command("silent !git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- cSpell:disable
vim.cmd([[packadd packer.nvim]])
require("rc/packer")

return require("packer").startup(function(use)
	-- ------------------------------------------------------------
	-- Installer

	-- Plugin Manager
	use({ "wbthomason/packer.nvim", opt = true })

	-- External package Installer
	use({
		"williamboman/mason.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/mason")
		end,
	})

	-- ------------------------------------------------------------
	-- Library

	--------------------------------
	-- Vim script Library
	use({ "tpope/vim-repeat", event = "VimEnter" })
	-- use {'mattn/webapi-vim'}

	--------------------------------
	-- Lua Library
	use({ "nvim-lua/popup.nvim", module = "popup" })
	use({ "nvim-lua/plenary.nvim" }) -- do not lazy load
	use({ "kkharji/sqlite.lua", module = "sqlite" })
	use({ "MunifTanjim/nui.nvim", module = "nui" })

	--------------------------------
	-- UI Library
	use({
		"stevearc/dressing.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dressing")
		end,
	})

	--------------------------------
	-- Denops Library
	-- use {'vim-denops/denops.vim'}

	--------------------------------
	-- Notify
	use({ "rcarriga/nvim-notify", module = "notify" })

	--------------------------------
	-- ColorScheme
	local colorscheme = "nightfox.nvim"
	use({
		"EdenEast/nightfox.nvim",
		event = { "VimEnter", "ColorSchemePre" },
		config = function()
			require("rc/pluginconfig/nightfox")
		end,
	})

	--------------------------------
	-- Font
	if not os.getenv("DISABLE_DEVICONS") or os.getenv("DISABLE_DEVICONS") == "false" then
		-- use {'ryanoasis/vim-devicons'}
		use({ "kyazdani42/nvim-web-devicons", after = colorscheme })
	end
	use({
		"delphinus/cellwidths.nvim",
		event = "BufEnter",
		config = function()
			require("cellwidths").setup({
				name = "cica",
			})
		end,
	})

	--------------------------------------------------------------
	-- LSP & completion

	--------------------------------
	-- Auto Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			{ "L3MON4D3/LuaSnip", opt = true, event = "VimEnter" },
			{ "windwp/nvim-autopairs", opt = true, event = "VimEnter" },
		},
		after = { "LuaSnip", "nvim-autopairs" },
		config = function()
			require("rc/pluginconfig/nvim-cmp")
		end,
	})
	use({
		"onsails/lspkind-nvim",
		module = "lspkind",
		config = function()
			require("rc/pluginconfig/lspkind-nvim")
		end,
	})
	use({ "hrsh7th/cmp-nvim-lsp", module = "cmp_nvim_lsp" })
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp-document-symbol", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-omni", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" })
	-- use({ "zbirenbaum/copilot-cmp", after = { "nvim-cmp", "copilot.lua" } })
	-- use({ "hrsh7th/cmp-copilot", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-emoji", after = "nvim-cmp" })
	use({ "hrsh7th/cmp-calc", after = "nvim-cmp" })
	use({ "f3fora/cmp-spell", after = "nvim-cmp" })
	use({ "yutkat/cmp-mocword", after = "nvim-cmp" })
	use({
		"uga-rosa/cmp-dictionary",
		after = "nvim-cmp",
		config = function()
			require("rc/pluginconfig/cmp-dictionary")
		end,
	})
	use({ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" })
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		after = "nvim-cmp",
	})
	use({ "ray-x/cmp-treesitter", after = "nvim-cmp" })
	use({ "lukas-reineke/cmp-rg", after = "nvim-cmp" })
	use({ "lukas-reineke/cmp-under-comparator", module = "cmp-under-comparator" })

	--------------------------------
	-- Language Server Protocol(LSP)
	use({
		"williamboman/mason-lspconfig.nvim",
		after = { "mason.nvim", "nvim-lspconfig", "cmp-nvim-lsp", "nlsp-settings.nvim" },
		config = function()
			require("rc/pluginconfig/mason-lspconfig")
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		event = { "VimEnter" },
		config = function()
			require("rc/pluginconfig/nvim-lspconfig")
		end,
	})

	-- -> hrsh7th/cmp-nvim-lsp-signature-help, hrsh7th/cmp-nvim-lsp-document-symbol
	-- use({
	-- 	"ray-x/lsp_signature.nvim",
	-- 	after = "nvim-lspconfig",
	-- 	config = function()
	-- 		require("rc/pluginconfig/lsp_signature")
	-- 	end,
	-- })
	use({
		"tamago324/nlsp-settings.nvim",
		after = { "nvim-lspconfig" },
		config = function()
			require("rc/pluginconfig/nlsp-settings")
		end,
	})
	use({ "weilbith/nvim-lsp-smag", after = "nvim-lspconfig" })
	-- library for litee
	-- use {
	--   'ldelossa/litee.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require('litee.lib').setup({}) end
	-- }

	--------------------------------
	-- LSP's UI
	-- use {'nvim-lua/lsp-status.nvim', after = 'nvim-lspconfig'}
	-- use {
	--   'nvim-lua/lsp_extensions.nvim',
	--   after = 'mason.nvim',
	--   config = function() require 'rc/pluginconfig/lsp_extensions' end
	-- }
	use({
		"glepnir/lspsaga.nvim",
		after = "mason.nvim",
		config = function()
			require("rc/pluginconfig/lspsaga")
		end,
	})
	use({
		"folke/lsp-colors.nvim",
		module = "lsp-colors",
	})
	use({
		"folke/trouble.nvim",
		after = { "mason.nvim" },
		config = function()
			require("rc/pluginconfig/trouble")
		end,
	})
	use({
		"EthanJWright/toolwindow.nvim",
		requires = { { "akinsho/toggleterm.nvim", opt = true, event = "VimEnter" } },
		after = { "trouble.nvim", "toggleterm.nvim" },
		config = function()
			require("rc/pluginconfig/toolwindow")
		end,
	})
	use({
		"j-hui/fidget.nvim",
		after = "mason.nvim",
		config = function()
			require("rc/pluginconfig/fidget")
		end,
	})
	-- use {
	--   'ray-x/navigator.lua',
	--   after = 'mason.nvim',
	--   requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make', opt = true},
	--   config = function() require 'rc/pluginconfig/navigator' end
	-- }
	-- use {
	--   'onsails/diaglist.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/diaglist' end
	-- }
	-- -> lspsaa
	-- use {
	--   'rmagatti/goto-preview',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/goto-preview' end
	-- }
	-- -> lspsaa
	-- use {
	--   'filipdutescu/renamer.nvim',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/renamer' end
	-- }
	-- -> lspsaa
	-- use {
	--   'kosayoda/nvim-lightbulb',
	--   after = 'nvim-lspconfig',
	--   config = function() require 'rc/pluginconfig/nvim-lightbulb' end
	-- }
	-- weilbith/nvim-code-action-menu
	-- RishabhRD/nvim-lsputils
	-- aspeddro/lsp_menu.nvim

	--------------------------------
	-- AI completion
	-- use {'zxqfl/tabnine-vim'}
	-- use({ "github/copilot.vim", cmd = { "Copilot" } })
	-- use({
	-- 	"zbirenbaum/copilot.lua",
	-- 	after = "copilot.vim",
	-- 	config = function()
	-- 		vim.schedule(function()
	-- 			require("copilot")
	-- 		end)
	-- 	end,
	-- })

	--------------------------------------------------------------
	-- FuzzyFinders

	--------------------------------
	-- telescope.nvim
	use({
		"nvim-telescope/telescope.nvim",
		-- requires = { { "nvim-lua/plenary.nvim", opt = true }, { "nvim-lua/popup.nvim", opt = true } },
		after = { colorscheme },
		-- event = "VimEnter",
		config = function()
			require("rc/pluginconfig/telescope")
		end,
	})
	use({
		"nvim-telescope/telescope-frecency.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("frecency")
		end,
	})
	use({
		"nvim-telescope/telescope-github.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("gh")
		end,
	})
	use({
		"nvim-telescope/telescope-ui-select.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	})
	-- use({
	-- 	"nvim-telescope/telescope-project.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("project")
	-- 	end,
	-- })
	-- use({
	-- 	"nvim-telescope/telescope-vimspector.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("vimspector")
	-- 	end,
	-- })
	use({ "nvim-telescope/telescope-symbols.nvim", after = { "telescope.nvim" } })
	-- use({
	-- 	"nvim-telescope/telescope-ghq.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("ghq")
	-- 	end,
	-- })
	-- use({
	-- 	"nvim-telescope/telescope-fzf-writer.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("fzf_writer")
	-- 	end,
	-- })
	use({
		"nvim-telescope/telescope-packer.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("packer")
		end,
	})
	use({
		"crispgm/telescope-heading.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("heading")
		end,
	})
	use({
		"LinArcX/telescope-changes.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("changes")
		end,
	})
	use({
		"nvim-telescope/telescope-live-grep-args.nvim",
		after = { "telescope.nvim" },
		config = function()
			require("telescope").load_extension("live_grep_args")
		end,
	})
	use({
		"nvim-telescope/telescope-smart-history.nvim",
		requires = { { "nvim-telescope/telescope.nvim", opt = true }, { "kkharji/sqlite.lua", opt = true } },
		after = { "telescope.nvim", "sqlite.lua" },
		config = function()
			require("telescope").load_extension("smart_history")
		end,
		run = function()
			os.execute("mkdir -p " .. vim.fn.stdpath("state") .. "databases/")
		end,
	})
	-- I don't want to set items myself
	-- use { "LinArcX/telescope-command-palette.nvim", 	after = { "telescope.nvim" } }
	-- -> filer
	-- use({
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("file_browser")
	-- 	end,
	-- })
	-- use {"sunjon/telescope-arecibo.nvim",
	--   after = {'telescope.nvim'},
	--   rocks = {"openssl", "lua-http-parser"},
	--   config = function() require('telescope').load_extension('arecibo') end
	-- }
	if vim.fn.executable("ueberzug") == 1 then
		use({
			"nvim-telescope/telescope-media-files.nvim",
			after = { "telescope.nvim" },
			config = function()
				require("telescope").load_extension("media_files")
			end,
		})
	end
	-- use({
	-- 	"LinArcX/telescope-command-palette.nvim",
	-- 	after = { "telescope.nvim" },
	-- 	config = function()
	-- 		require("telescope").load_extension("command_palette")
	-- 	end,
	-- })

	--------------------------------
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		after = { colorscheme },
		-- event = "VimEnter",
		run = ":TSUpdate",
		config = function()
			require("rc/pluginconfig/nvim-treesitter")
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", after = { "nvim-treesitter" } })
	use({ "nvim-treesitter/nvim-treesitter-refactor", after = { "nvim-treesitter" } })
	use({ "nvim-treesitter/nvim-tree-docs", after = { "nvim-treesitter" } })
	use({ "vigoux/architext.nvim", after = { "nvim-treesitter" } })
	use({ "yioneko/nvim-yati", after = "nvim-treesitter" })
	-- -> use hop
	-- mfussenegger/nvim-treehopper
	-- use({
	-- 	"bryall/contextprint.nvim",
	-- 	after = { "nvim-treesitter" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/contextprint")
	-- 	end,
	-- })
	-- Error on :Gina status
	-- use {
	--   'code-biscuits/nvim-biscuits',
	--   after = {'nvim-treesitter', colorscheme},
	--   config = function() require 'rc/pluginconfig/nvim-biscuits' end
	-- }
	-- -> vim-matchup
	-- use({ "theHamsta/nvim-treesitter-pairs", after = { "nvim-treesitter" } })
	-- use({
	-- 	"nvim-treesitter/playground",
	-- 	after = { "nvim-treesitter" },
	-- })

	--------------------------------
	-- Treesitter textobject & operator
	use({ "nvim-treesitter/nvim-treesitter-textobjects", after = { "nvim-treesitter" } })
	-- incremental-selection
	-- use({ "RRethy/nvim-treesitter-textsubjects", after = { "nvim-treesitter" } })
	use({
		"mizlan/iswap.nvim",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/iswap")
		end,
	})
	use({
		"mfussenegger/nvim-treehopper",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-treehopper")
		end,
	})
	use({
		"David-Kunz/treesitter-unit",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/treesitter-unit")
		end,
	})

	--------------------------------
	-- Treesitter UI customize
	use({ "p00f/nvim-ts-rainbow", after = { "nvim-treesitter" } })
	use({ "haringsrob/nvim_context_vt", after = { "nvim-treesitter", colorscheme } })
	use({
		"m-demare/hlargs.nvim",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/hlargs")
		end,
	})
	use({
		"romgrk/nvim-treesitter-context",
		-- after = {'nvim-treesitter'},
		cmd = { "TSContextEnable" },
	})

	--------------------------------------------------------------
	-- Appearance

	--------------------------------
	-- Statusline
	use({
		"nvim-lualine/lualine.nvim",
		after = colorscheme,
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("rc/pluginconfig/lualine")
		end,
	})
	use({
		"SmiteshP/nvim-navic",
		module = "nvim-navic",
		setup = function()
			require("rc/pluginconfig/nvim-navic")
		end,
	})

	--------------------------------
	-- Bufferline
	if not vim.g.vscode then
		use({
			"akinsho/bufferline.nvim",
			after = colorscheme,
			config = function()
				require("rc/pluginconfig/bufferline")
			end,
		})
	end

	----------------------------------
	---- Syntax

	--------------------------------
	-- Highlight
	-- There are Lua plugin. I haven't tried it yet because I'm satisfied with coc.
	-- norcalli/nvim-colorizer.lua
	-- use {'powerman/vim-plugin-AnsiEsc', event = "VimEnter"}
	use({
		"xiyaowong/nvim-cursorword",
		after = colorscheme,
		config = function()
			require("rc/pluginconfig/nvim-cursorword")
		end,
	})
	-- use({
	-- 	"RRethy/vim-illuminate",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/vim-illuminate")
	-- 	end,
	-- })
	use({
		"norcalli/nvim-colorizer.lua",
		event = "VimEnter",
		config = function()
			require("colorizer").setup()
		end,
	})
	use({
		"t9md/vim-quickhl",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-quickhl.vim")
		end,
	})
	use({
		"Pocco81/HighStr.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/HighStr")
		end,
	})
	-- use({
	-- 	"Djancyp/better-comments.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/better-comments")
	-- 	end,
	-- })
	use({
		"folke/todo-comments.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/todo-comments")
		end,
	})
	use({
		"melkster/modicator.nvim",
		after = { colorscheme },
		config = function()
			require("rc/pluginconfig/modicator")
		end,
	})
	-- use({
	-- 	"mvllow/modes.nvim",
	-- 	after = { colorscheme },
	-- 	config = function()
	-- 		require("rc/pluginconfig/modes")
	-- 	end,
	-- })
	use({
		"m00qek/baleia.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/baleia")
		end,
	})

	--------------------------------
	-- Filetype detection
	-- use do_filetype_lua
	-- use {'nathom/filetype.nvim', setup = function() vim.g.did_load_filetypes = 1 end}

	--------------------------------
	-- Layout
	-- original autocmd
	-- use({
	-- 	"myusuf3/numbers.vim",
	-- 	cmd = { "NumbersToggle", "NumbersOnOff" },
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/numbers.vim")
	-- 	end,
	-- })
	-- I didn't use zen-mode much
	-- use {'kdav5758/TrueZen.nvim', cmd = {'TZAtaraxis', 'TZMinimalist', 'TZBottom', 'TZTop', 'TZLeft'}}
	-- use {'folke/zen-mode.nvim', cmd = {'ZenMode'}}

	--------------------------------
	-- Sidebar
	-- conflict with clever-f (augroup sidebar_nvim_prevent_buffer_override)
	use({
		"GustavoKatel/sidebar.nvim",
		cmd = { "SidebarNvimToggle" },
		config = function()
			require("rc/pluginconfig/sidebar")
		end,
	})

	--------------------------------
	-- Menu
	-- use {'kizza/actionmenu.nvim', event = "VimEnter"}
	use({
		"sunjon/stylish.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/stylish")
		end,
	})

	--------------------------------
	-- Startup screen
	use({
		"goolord/alpha-nvim",
		config = function()
			require("rc/pluginconfig/alpha-nvim")
		end,
	})
	-- startup-nvim/startup.nvim

	--------------------------------
	-- Scrollbar
	use({
		"petertriho/nvim-scrollbar",
		requires = { { "kevinhwang91/nvim-hlslens", opt = true } },
		after = { colorscheme, "nvim-hlslens" },
		config = function()
			require("rc/pluginconfig/nvim-scrollbar")
		end,
	})

	--------------------------------
	-- Cursor
	use({
		"edluffy/specs.nvim",
		cmd = { "SpecsEnable" },
		config = function()
			require("rc/pluginconfig/specs")
		end,
	})

	--------------------------------
	-- Sign
	-- buggy
	-- use {'dsummersl/nvim-sluice'}

	--------------------------------
	-- Minimap
	-- if vim.fn.executable('cargo') == 1 then
	--   use {'wfxr/minimap.vim',
	--     -- event = "VimEnter",
	--     cmd = {'Minimap'},
	--     run = 'cargo install --locked code-minimap'
	--   }
	-- end
	-- archived
	-- use({ "rinx/nvim-minimap", cmd = { "MinimapOpen" } })

	-- ------------------------------------------------------------
	-- Editing

	-- ------------------------------
	--  Key Bind (Map)
	-- -> use snippets
	-- use({ "kana/vim-smartchr", event = "VimEnter" })
	-- use {'kana/vim-arpeggio', event = "VimEnter"}
	-- use {'tpope/vim-sexp-mappings-for-regular-people', event = "VimEnter"}

	--------------------------------
	-- Move
	use({
		"phaazon/hop.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hop")
		end,
	})
	----------------
	-- Horizontal Move
	use({
		"jinh0/eyeliner.nvim",
		event = "VimEnter",
		config = function()
			require("eyeliner").setup({})
		end,
	})
	-- use {'gukz/ftFt.nvim', event = "VimEnter", config = function() require 'rc/pluginconfig/ftFt' end}
	-- still wasn't great.
	use({
		"ggandor/lightspeed.nvim",
		event = "VimEnter",
		setup = function()
			vim.g.lightspeed_no_default_keymaps = true
		end,
		config = function()
			require("rc/pluginconfig/lightspeed")
		end,
	})

	----------------
	-- Vertical Move
	use({
		"haya14busa/vim-edgemotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-edgemotion.vim")
		end,
	})
	use({
		"machakann/vim-columnmove",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-columnmove.vim")
		end,
	})
	-- use({
	-- 	"ziontee113/syntax-tree-surfer",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/syntax-tree-surfer")
	-- 	end,
	-- })
	-- Not moving as expected
	-- use({ "drybalka/tree-climber.nvim", event = "VimEnter" })

	----------------
	-- Word Move
	use({
		"justinmk/vim-ipmotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-ipmotion.vim")
		end,
	})
	use({
		"bkad/CamelCaseMotion",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/CamelCaseMotion.vim")
		end,
	})
	use({ "yutkat/wb-only-current-line.nvim", event = "VimEnter" })

	--------------------------------
	-- Jump
	use({
		"osyo-manga/vim-milfeulle",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-milfeulle.vim")
		end,
	})
	-- -> bufferline
	-- use({
	-- 	"Bakudankun/BackAndForward.vim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/BackAndForward.vim")
	-- 	end,
	-- })
	-- not useful but cool
	-- use {'nacro90/numb.nvim',
	--  config = function() require'rc/pluginconfig/numb' end
	-- }

	--------------------------------
	-- Scroll
	-- use {'psliwka/vim-smoothie'} -- slow
	-- I realized I don't like smart scrolling.
	-- use({
	-- 	"declancm/cinnamon.nvim",
	-- 	event = "CursorMoved",
	-- 	config = function()
	-- 		require("rc/pluginconfig/cinnamon")
	-- 	end,
	-- })

	--------------------------------
	-- Select
	-- -> treesitter incremental selection
	-- use({
	-- 	"ziontee113/syntax-tree-surfer",
	-- 	after = "nvim-treesitter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/syntax-tree-surfer")
	-- 	end,
	-- })
	-- -> treesitter incremental selection
	-- use({
	-- 	"terryma/vim-expand-region",
	-- 	event = "VimEnter",
	-- 	setup = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/vim-expand-region.vim")
	-- 	end,
	-- })
	-- -> do not use
	-- use({
	-- 	"terryma/vim-multiple-cursors",
	-- 	event = "VimEnter",
	-- 	setup = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/vim-multiple-cursors.vim")
	-- 	end,
	-- })
	-- use({
	-- 	"kana/vim-niceblock",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-niceblock.vim")
	-- 	end,
	-- })
	-- use {'mg979/vim-visual-multi'} -- -> mapping infection

	--------------------------------
	-- Edit/Insert
	use({
		"RRethy/nvim-align",
		cmd = { "Align" },
	})
	use({
		"thinca/vim-partedit",
		-- event = "VimEnter",
		cmd = { "Partedit" },
	})
	use({
		"yutkat/delete-word-to-chars.vim",
		event = "VimEnter",
		config = function()
			require("delete-word-to-chars").setup()
		end,
	})

	--------------------------------
	-- Text Object
	-- nvim-treesitter-textobj
	-- use({ "kana/vim-textobj-user", event = "VimEnter" })
	-- use({ "kana/vim-textobj-line", after = { "vim-textobj-user" } })
	-- use({ "kana/vim-textobj-entire", after = { "vim-textobj-user" } })
	-- use({ "kana/vim-textobj-function", after = { "vim-textobj-user" } })
	-- use({ "reedes/vim-textobj-sentence", after = { "vim-textobj-user" } })
	-- use({
	-- 	"machakann/vim-textobj-functioncall",
	-- 	after = { "vim-textobj-user" },
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-textobj-functioncall.vim")
	-- 	end,
	-- })
	-- vim-swap
	-- use({ "sgur/vim-textobj-parameter", after = { "vim-textobj-user" } }) -- -> vim-swap
	-- Not much maintenance lately
	-- use {'wellle/targets.vim'} -- -> kana/vim-textobj-user

	-- do not use
	-- 'thinca/vim-textobj-between' -- -> sandwich
	-- 'mattn/vim-textobj-url'
	-- slow on startup
	-- use {'kana/vim-textobj-indent'}
	-- use {'haya14busa/vim-textobj-function-syntax'}
	-- use {'kana/vim-textobj-datetime'}
	-- use {'lucapette/vim-textobj-underscore'}

	--------------------------------
	-- Operator
	-- use({ "kana/vim-operator-user", event = "VimEnter" })
	-- use({
	-- 	"kana/vim-operator-replace",
	-- 	after = { "vim-operator-user" },
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-operator-replace.vim")
	-- 	end,
	-- })
	use({
		"gbprod/substitute.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/substitute")
		end,
	})
	use({
		"kylechui/nvim-surround",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-surround")
		end,
	})
	-- use({
	-- 	"machakann/vim-sandwich",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-sandwich.vim")
	-- 	end,
	-- })
	-- -> iswap.nvim
	-- use({
	-- 	"machakann/vim-swap",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-swap.vim")
	-- 	end,
	-- })
	-- use({ "axlebedev/vim-case-change", event = "VimEnter" })
	-- use({
	-- 	"mopp/vim-operator-convert-case",
	-- 	requires = { { "kana/vim-operator-user", event = "VimEnter" } },
	-- 	after = { "vim-operator-user" },
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-operator-convert-case.vim")
	-- 	end,
	-- })
	-- use({
	-- 	"johmsalas/text-case.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/text-case")
	-- 	end,
	-- })
	-- use {'osyo-manga/vim-operator-stay-cursor'}

	-----------------
	-- Join
	use({
		"AckslD/nvim-trevJ.lua",
		module = "trevj",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-trevJ")
		end,
	})

	-----------------
	-- Adding and subtracting
	-- use({ "deris/vim-rengbang", event = "VimEnter" })
	use({
		"monaqa/dial.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/dial")
		end,
	})
	-- use {'zegervdv/nrpattern.nvim',
	--   config = function() require'rc/pluginconfig/nrpattern' end
	-- }

	--------------------------------
	-- Yank
	-- use({
	-- 	"gbprod/yanky.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/yanky")
	-- 	end,
	-- })
	use({
		"hrsh7th/nvim-pasta",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-pasta")
		end,
	})
	-- use({
	-- 	"bfredl/nvim-miniyank",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/nvim-miniyank.vim")
	-- 	end,
	-- })
	use({
		"AckslD/nvim-neoclip.lua",
		requires = { { "nvim-telescope/telescope.nvim", opt = true }, { "kkharji/sqlite.lua", opt = true } },
		after = { "telescope.nvim", "sqlite.lua" },
		config = function()
			require("rc/pluginconfig/nvim-neoclip")
		end,
	})
	-- -> AckslD/nvim-neoclip.lua
	-- use({
	-- 	"gennaro-tedesco/nvim-peekup",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/nvim-peekup")
	-- 	end,
	-- })
	use({ "yutkat/osc52.nvim", event = "VimEnter" })
	-- use({ "chikatoike/concealedyank.vim", event = "VimEnter" })
	-- include yoink g:yoinkSyncSystemClipboardOnFocus
	use({ "yutkat/save-clipboard-on-exit.nvim", event = "VimEnter" })

	--------------------------------
	-- Paste
	-- use({ "yutkat/auto-paste-mode.vim", event = "VimEnter" })
	if vim.fn.has("clipboard") == 1 then
		use({
			"tversteeg/registers.nvim",
			event = "VimEnter",
			config = function()
				require("rc/pluginconfig/registers")
			end,
		})
	end
	use({
		"AckslD/nvim-anywise-reg.lua",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-anywise-reg")
		end,
	})
	-- -> AckslD/nvim-anywise-reg.lua
	-- use({
	-- 	"deris/vim-pasta",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-pasta.vim")
	-- 	end,
	-- })

	--------------------------------------------------------------
	-- Search

	--------------------------------
	-- Find
	use({
		"kevinhwang91/nvim-hlslens",
		after = { "lasterisk.nvim" },
		config = function()
			require("rc/pluginconfig/nvim-hlslens")
		end,
	})
	use({
		"rapan931/lasterisk.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/lasterisk")
		end,
	})
	-- -> nvim-hlslens
	-- use({
	-- 	"rapan931/utahraptor.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/utahraptor")
	-- 	end,
	-- })

	--------------------------------
	-- Replace
	use({ "lambdalisue/reword.vim", event = "VimEnter" })
	use({ "haya14busa/vim-metarepeat", event = "VimEnter" })

	--------------------------------
	-- Grep tool
	use({
		"windwp/nvim-spectre",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-spectre")
		end,
	})
	-- use {'dyng/ctrlsf.vim'}

	--------------------------------------------------------------
	-- File switcher

	--------------------------------
	-- Open
	use({ "wsdjeg/vim-fetch", event = "VimEnter" })

	--------------------------------
	-- Buffer
	use({
		"famiu/bufdelete.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/bufdelete")
		end,
	})

	--------------------------------
	-- Buffer switcher
	use({
		"stevearc/stickybuf.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/stickybuf")
		end,
	})

	--------------------------------
	-- Tab
	-- use {'kana/vim-tabpagecd'}
	-- use {'taohex/lightline-buffer'} -- -> 今後に期待

	--------------------------------
	-- Filer
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "main",
		requires = {
			"MunifTanjim/nui.nvim",
		},
		after = { "nvim-window-picker" },
		config = function()
			require("rc/pluginconfig/neo-tree")
		end,
	})

	--------------------------------
	-- Window
	-- use({
	-- 	"tkmpypy/chowcho.nvim",
	-- 	event = "WinNew",
	-- 	config = function()
	-- 		require("rc/pluginconfig/chowcho")
	-- 	end,
	-- })
	use({
		"s1n7ax/nvim-window-picker",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-window-picker")
		end,
	})
	-- use {'andymass/vim-tradewinds', event = "WinNew"}
	use({
		"kwkarlwang/bufresize.nvim",
		event = "WinNew",
		config = function()
			require("rc/pluginconfig/bufresize")
		end,
	})
	-- -> do not use eventignore! https://github.com/luukvbaal/stabilize.nvim/commit/718561393f885dbbc9de8ed71089772af0dbbb3f
	-- use {
	--   'luukvbaal/stabilize.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/stabilize' end
	-- }

	------------------------------------------------------------
	-- Standard Feature Enhancement

	--------------------------------
	-- Undo
	use({
		"simnalamburt/vim-mundo",
		-- event = "VimEnter"
		cmd = { "MundoShow" },
	})
	-- use {'mbbill/undotree'} -- -> not maintained recently
	-- cool but too slow
	-- if not vim.g.vscode then
	--   use {'machakann/vim-highlightedundo',
	--     config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/vim-highlightedundo.vim') end
	--   }
	-- end

	--------------------------------
	-- Diff
	use({
		"AndrewRadev/linediff.vim",
		-- event = "VimEnter"
		cmd = { "Linediff" },
	})
	-- set diffopt+=internal,algorithm:patience
	-- use({ "chrisbra/vim-diff-enhanced", event = "VimEnter" })

	--------------------------------
	-- Mark
	use({
		"chentoast/marks.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/marks")
		end,
	})
	-- can't jump to the file number
	-- use {
	--   'ThePrimeagen/harpoon',
	--   event = "VimEnter",
	--   requires = {{'nvim-lua/plenary.nvim', opt = true}, {'nvim-lua/popup.nvim', opt = true}},
	--   config = function() require 'rc/pluginconfig/harpoon' end
	-- }
	-- use {
	--   'brandoncc/telescope-harpoon.nvim',
	--   after = {'harpoon', 'telescope.nvim'},
	--   config = function() require('telescope').load_extension('harpoon') end
	-- }
	-- don't work
	-- use {'edluffy/hologram.nvim', config = function() require 'rc/pluginconfig/hologram' end}

	--------------------------------
	-- Fold
	-- unused
	-- use({
	-- 	"anuvyklack/pretty-fold.nvim",
	-- 	requires = 'anuvyklack/nvim-keymap-amend',
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("pretty-fold").setup()
	-- 		require("pretty-fold.preview").setup()
	-- 	end,
	-- })

	--------------------------------
	-- Manual
	use({
		"thinca/vim-ref",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-ref.vim")
		end,
	})
	use({
		"folke/which-key.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/which-key")
		end,
	})
	-- use({
	-- 	"sudormrfbin/cheatsheet.nvim",
	-- 	requires = { { "nvim-telescope/telescope.nvim", opt = true } },
	-- 	after = { "telescope.nvim" },
	-- })

	--------------------------------
	-- Help

	--------------------------------
	-- Tag
	-- use lsp
	-- if vim.fn.executable("global") == 1 then
	-- 	use({
	-- 		"jsfaint/gen_tags.vim",
	-- 		-- event = "VimEnter",
	-- 		cmd = { "GenCtags", "GenGTAGS" },
	-- 		config = function()
	-- 			vim.cmd("source ~/.config/nvim/rc/pluginconfig/gen_tags.vim")
	-- 		end,
	-- 	})
	-- end

	--------------------------------
	-- Quickfix
	use({
		"kevinhwang91/nvim-bqf",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-bqf")
		end,
	})
	use({
		"gabrielpoca/replacer.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/replacer")
		end,
	})
	use({
		"stevearc/qf_helper.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/qf_helper")
		end,
	})

	--------------------------------
	-- Session
	-- do not use the session per current directory
	use({
		"jedrzejboczar/possession.nvim",
		config = function()
			require("rc/pluginconfig/possession")
		end,
	})
	-- use({
	-- 	"Shatur/neovim-session-manager",
	-- 	config = function()
	-- 		require("rc/pluginconfig/neovim-session-manager")
	-- 	end,
	-- })
	-- use({
	-- 	"olimorris/persisted.nvim",
	-- 	config = function()
	-- 		require("rc/pluginconfig/persisted")
	-- 	end,
	-- })

	--------------------------------
	-- Macro
	-- Not convenient
	-- use({
	-- 	"zdcthomas/medit",
	-- 	event = "VimEnter",
	-- 	setup = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginsetup/medit.vim")
	-- 	end,
	-- })

	--------------------------------
	-- SpellCheck
	-- -> null-ls(cspell)
	-- https://github.com/neovim/neovim/pull/19419
	-- use({
	-- 	"lewis6991/spellsitter.nvim",
	-- 	after = "nvim-treesitter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/spellsitter")
	-- 	end,
	-- })

	--------------------------------
	-- SpellCorrect (iabbr)
	use({
		"Pocco81/AbbrevMan.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/AbbrevMan")
		end,
	})

	--------------------------------
	-- Command
	use({
		"sbulav/nredir.nvim",
		cmd = { "Nredir" },
	})
	-- use({ "thinca/vim-ambicmd", event = "VimEnter" })
	-- use({ "tyru/vim-altercmd", event = "VimEnter" })
	use({
		"jghauser/mkdir.nvim",
		event = "VimEnter",
		config = function()
			require("mkdir")
		end,
	})
	use({ "sQVe/sort.nvim", cmd = { "Sort" } })
	use({ "yutkat/confirm-quit.nvim", event = "CmdlineEnter" })
	use({
		"smjonas/live-command.nvim",
		event = "CmdlineEnter",
		config = function()
			require("rc/pluginconfig/live-command")
		end,
	})
	-- -> filer
	-- use {'tpope/vim-eunuch'}

	--------------------------------
	-- Commandline
	use({
		"folke/noice.nvim",
		after = { "cmp-cmdline" },
		config = function()
			require("rc/pluginconfig/noice")
		end,
	})
	use({ "hrsh7th/cmp-cmdline", after = "nvim-cmp" })
	use({ "dmitmel/cmp-cmdline-history", after = "nvim-cmp" })
	-- -> cmp-cmdline
	-- wilder did not work
	-- use {'VonHeikemen/fine-cmdline.nvim', requires = "MunifTanjim/nui.nvim"}

	--------------------------------
	-- History
	use({
		"yutkat/history-ignore.nvim",
		event = "CmdlineEnter",
		config = function()
			require("history-ignore").setup()
		end,
	})

	--------------------------------
	-- Terminal
	use({
		"akinsho/toggleterm.nvim",
		-- after = { colorscheme },
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/toggleterm")
		end,
	})
	use({
		"yutkat/term-gf.nvim",
		event = "VimEnter",
		config = function()
			require("term-gf").setup()
		end,
	})
	-- use {'kassio/neoterm'} -- include repl
	-- use {'numToStr/FTerm.nvim'}

	--------------------------------
	-- Backup/Swap
	use({
		"aiya000/aho-bakaup.vim",
		event = "VimEnter",
		setup = function()
			vim.cmd("source ~/.config/nvim/rc/pluginsetup/aho-bakaup.vim")
		end,
	})
	-- use {'chrisbra/vim-autosave'}

	--------------------------------------------------------------
	-- New features

	--------------------------------
	-- Translate
	use({
		"uga-rosa/translate.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/translate")
		end,
	})

	--------------------------------
	-- Popup Info
	use({
		"lewis6991/hover.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/hover")
		end,
	})

	--------------------------------
	-- Screenshot
	-- Not much use
	-- use({ "segeljakt/vim-silicon", cmd = { "Silicon" } })

	--------------------------------
	-- Command Palette
	-- not use
	-- use({
	-- 	"mrjones2014/legendary.nvim",
	-- 	after = { "dressing.nvim", "telescope.nvim" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/legendary")
	-- 	end,
	-- })

	--------------------------------
	-- Memo
	use({
		"renerocksai/telekasten.nvim",
		after = { "telescope.nvim" },
		require = { "renerocksai/calendar-vim" },
		config = function()
			require("rc/pluginconfig/telekasten")
		end,
	})
	-- Furkanzmc/zettelkasten.nvim
	-- if vim.fn.executable("zk") == 1 then
	-- 	use({
	-- 		"mickael-menu/zk-nvim",
	-- 		event = "VimEnter",
	-- 		run = function()
	-- 			local dir = vim.fn.stdpath("data") .. "/zk/"
	-- 			os.execute("mkdir -p " .. dir)
	-- 		end,
	-- 		config = function()
	-- 			require("rc/pluginconfig/zk-nvim")
	-- 		end,
	-- 	})
	-- end
	-- use {'stevearc/gkeep.nvim', event = "VimEnter", run = ':UpdateRemotePlugins'}

	--------------------------------
	-- Scratch
	-- -> memo plugin

	--------------------------------
	-- Hex
	-- -> https://github.com/WerWolv/ImHex
	-- use({ "Shougo/vinarise.vim", cmd = { "Vinarise" } })

	--------------------------------
	-- Browser integration
	-- use({
	-- 	"tyru/open-browser.vim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/open-browser.vim")
	-- 	end,
	-- })
	-- use({ "tyru/open-browser-github.vim", after = { "open-browser.vim" } })

	--------------------------------
	-- Mode extension
	use({
		"anuvyklack/hydra.nvim",
		after = "gitsigns.nvim",
		config = function()
			require("rc/pluginconfig/hydra")
		end,
	})

	--------------------------------
	-- Template
	use({
		"glepnir/template.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/template")
		end,
	})

	--------------------------------
	-- Performance Improvement
	-- startup time didn't change much
	-- use({
	-- 	"lewis6991/impatient.nvim",
	-- 	config = function()
	-- 		require("impatient")
	-- 	end,
	-- })

	--------------------------------
	-- Analytics
	if not os.getenv("DISABLE_WAKATIME") or os.getenv("DISABLE_WAKATIME") == "true" then
		if vim.fn.filereadable(vim.fn.expand("~/.wakatime.cfg")) == 1 then
			use({ "wakatime/vim-wakatime", event = "VimEnter" })
		end
	end

	--------------------------------
	-- LiveShare
	-- use {'jbyuki/instant.nvim'}

	--------------------------------
	-- Patch
	-- https://github.com/neovim/neovim/issues/12587
	-- Cursor position shifted when indentation is lost
	-- if has('nvim')
	--  use {'antoinemadec/FixCursorHold.nvim'}
	-- endif

	--------------------------------
	-- etc
	-- use {
	--   'yutkat/dps-coding-now.nvim',
	--   cond = function() return os.getenv("CODING_NOW_GITHUB_TOKEN") ~= nil end,
	--   after = {'denops.vim'}
	-- }
	-- use {'sunjon/extmark-toy.nvim'}

	--------------------------------------------------------------
	-- Coding

	--------------------------------
	-- Writing assistant
	use({
		"nmac427/guess-indent.nvim",
		event = { "BufNewFile", "BufReadPre" },
		config = function()
			require("guess-indent").setup()
		end,
	})
	-- use({ "zsugabubus/crazy8.nvim", event = { "BufNewFile", "BufReadPost" } })
	-- NMAC427/guess-indent.nvim
	use({
		"lfilho/cosco.vim",
		event = "VimEnter",
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/cosco.vim")
		end,
	})
	-- don't work on rust
	-- use({
	-- 	"TornaxO7/tree-setter",
	-- 	after = { "nvim-treesitter" },
	-- })
	-- use ime
	-- use({
	-- 	"protex/better-digraphs.nvim",
	-- 	event = "InsertEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/better-digraphs")
	-- 	end,
	-- })
	-- use {
	--   'abecodes/tabout.nvim',
	--   after = {'nvim-treesitter', 'coc.nvim'},
	--   config = function() require 'rc/pluginconfig/tabout' end
	-- }
	--
	--------------------------------
	-- Reading assistant
	use({
		"lukas-reineke/indent-blankline.nvim",
		-- after = { colorscheme },
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/indent-blankline")
		end,
	})
	use({
		"kristijanhusak/line-notes.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/line-notes")
		end,
	})
	-- romgrk/nvim-treesitter-context

	--------------------------------
	-- Comment out
	use({
		"numToStr/Comment.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/Comment")
		end,
	})
	use({
		"s1n7ax/nvim-comment-frame",
		requires = { { "nvim-treesitter/nvim-treesitter", opt = true } },
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-comment-frame")
		end,
	})
	use({
		"LudoPinelli/comment-box.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/comment-box")
		end,
	})

	--------------------------------
	-- Annotation
	use({
		"danymat/neogen",
		config = function()
			require("rc/pluginconfig/neogen")
		end,
		after = { "nvim-treesitter" },
	})

	--------------------------------
	-- Brackets
	use({
		"andymass/vim-matchup",
		after = { "nvim-treesitter" },
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-matchup.vim")
		end,
	})
	-- do not work correnctly
	-- use {'monkoose/matchparen.nvim', config = function() require 'rc/pluginconfig/matchparen' end}
	use({
		"windwp/nvim-autopairs",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-autopairs")
		end,
	})
	-- ZhiyuanLck/smart-pairs
	-- use {'steelsojka/pears.nvim',
	--   after = {'nvim-treesitter'},
	--   config = function() require'rc/pluginconfig/pears' end
	-- }
	use({
		"windwp/nvim-ts-autotag",
		requires = { { "nvim-treesitter/nvim-treesitter", opt = true } },
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-ts-autotag")
		end,
	})

	--------------------------------
	-- Endwise
	use({
		"RRethy/nvim-treesitter-endwise",
		requires = { { "nvim-treesitter/nvim-treesitter", opt = true } },
		after = { "nvim-treesitter" },
	})

	--------------------------------
	-- Code jump
	-- use({
	-- 	"kana/vim-altr",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-altr.vim")
	-- 	end,
	-- })
	use({
		"rgroli/other.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/other")
		end,
	})
	-- micmine/jumpwire.nvim
	-- use({ "tpope/vim-apathy", event = "VimEnter" })

	--------------------------------
	-- Test
	use({
		"klen/nvim-test",
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-test")
		end,
	})
	if vim.fn.executable("cargo") == 1 then
		use({ "michaelb/sniprun", run = "bash install.sh", cmd = { "SnipRun" } })
	end

	--------------------------------
	-- Task runner
	use({
		"stevearc/overseer.nvim",
		after = { "dressing.nvim" },
		config = function()
			require("rc/pluginconfig/overseer")
		end,
	})
	-- use({
	-- 	"yutkat/taskrun.nvim",
	-- 	after = { "toggleterm.nvim", "nvim-notify" },
	-- 	config = function()
	-- 		require("rc/pluginconfig/taskrun")
	-- 	end,
	-- })
	-- use({
	-- 	"pianocomposer321/yabs.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("rc/pluginconfig/yabs")
	-- 	end,
	-- })

	--------------------------------
	-- Lint
	use({
		"jose-elias-alvarez/null-ls.nvim",
		after = "mason.nvim",
		config = function()
			require("rc/pluginconfig/null-ls")
		end,
	})

	--------------------------------
	-- Format
	-- -> null-ls.nvim
	-- use({ "gpanders/editorconfig.nvim", event = "VimEnter" })
	-- -> null-ls
	-- use {
	--   'lukas-reineke/format.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/format' end
	-- }
	-- -> null-ls
	-- use({
	-- 	"cappyzawa/trim.nvim",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		require("trim").setup()
	-- 	end,
	-- })

	--------------------------------
	-- Code outline
	-- use {'ElPiloto/sidekick.nvim'}
	use({
		"stevearc/aerial.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/aerial")
		end,
	})
	-- use {
	--   'simrat39/symbols-outline.nvim',
	--   event = "VimEnter",
	--   config = function() require 'rc/pluginconfig/symbols-outline' end
	-- }
	-- use {
	--   'ldelossa/litee-symboltree.nvim',
	--   after = {'nvim-lspconfig', 'litee.nvim'},
	--   config = function() require('litee.symboltree').setup({}) end
	-- }

	--------------------------------
	-- Call Hierarchy
	-- use {
	--   'ldelossa/litee-calltree.nvim',
	--   after = {'nvim-lspconfig', 'litee.nvim'},
	--   config = function() require('litee.calltree').setup({}) end
	-- }

	--------------------------------
	-- Snippet
	use({
		"L3MON4D3/LuaSnip",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/LuaSnip")
		end,
	})
	use({
		"benfowler/telescope-luasnip.nvim",
		after = { "telescope.nvim", "LuaSnip" },
		config = function()
			require("telescope").load_extension("luasnip")
		end,
	})

	--------------------------------
	-- Snippet Pack
	-- use({ "molleweide/LuaSnip-snippets.nvim", event = "VimEnter" })
	use({ "rafamadriz/friendly-snippets", opt = true })

	--------------------------------
	-- Project
	-- use {'ygm2/rooter.nvim', event = "VimEnter"}
	use({
		"ahmedkhalf/project.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/project")
		end,
	})
	-- use({
	-- 	"airblade/vim-rooter",
	-- 	event = "VimEnter",
	-- 	config = function()
	-- 		vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-rooter.vim")
	-- 	end,
	-- })
	use({
		"klen/nvim-config-local",
		config = function()
			require("rc/pluginconfig/nvim-config-local")
		end,
	})
	-- lua buf too simple
	-- use {'windwp/nvim-projectconfig'}

	--------------------------------
	-- Git
	use({
		"TimUntersberger/neogit",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/neogit")
		end,
	})
	use({
		"akinsho/git-conflict.nvim",
		event = "VimEnter",
		config = function()
			require("git-conflict").setup()
		end,
	})
	use({ "yutkat/convert-git-url.nvim", cmd = { "ConvertGitUrl" } })
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/gitsigns")
		end,
	})
	use({
		"sindrets/diffview.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/diffview")
		end,
	})
	-- don't work
	-- use {'tanvirtin/vgit.nvim'}

	--------------------------------
	-- Git command assistant
	use({ "rhysd/committia.vim" })
	use({ "hotwatermorning/auto-git-diff", ft = { "gitrebase" } })

	--------------------------------
	-- GitHub
	use({ "pwntester/octo.nvim", cmd = { "Octo" } })

	--------------------------------
	-- Debugger
	use({
		"mfussenegger/nvim-dap",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/nvim-dap")
		end,
	})
	use({
		"rcarriga/nvim-dap-ui",
		after = { "nvim-dap" },
		config = function()
			require("rc/pluginconfig/nvim-dap-ui")
		end,
	})
	use({ "theHamsta/nvim-dap-virtual-text", after = { "nvim-dap" } })
	use({
		"nvim-telescope/telescope-dap.nvim",
		requires = {
			{ "mfussenegger/nvim-dap", opt = true },
			{ "nvim-telescope/telescope.nvim", opt = true },
		},
		after = { "nvim-dap", "telescope.nvim" },
	})
	-- archived
	-- use({ "Pocco81/DAPInstall.nvim", after = { "nvim-dap" } })
	use({
		"andrewferrier/debugprint.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/debugprint")
		end,
	})

	--------------------------------
	-- REPL
	use({
		"hkupty/iron.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/iron")
		end,
	})

	--------------------------------------------------------------
	-- Programming Languages

	--------------------------------
	-- JavaScript
	use({
		"vuki656/package-info.nvim",
		requires = "MunifTanjim/nui.nvim",
		event = "VimEnter",
		config = function()
			require("rc/pluginconfig/package-info")
		end,
	})
	use({
		"bennypowers/nvim-regexplainer",
		requires = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			{ "nvim-treesitter/nvim-treesitter", opt = true },
		},
		after = { "nvim-treesitter" },
		config = function()
			require("rc/pluginconfig/nvim-regexplainer")
		end,
	})

	--------------------------------
	-- Python
	-- use {'python-mode/python-mode',
	--   branch = 'develop',
	--   ft = {'python'},
	--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/python-mode.vim') end
	-- }
	-- use {'mgedmin/python-imports.vim',
	--   ft = {'python'}
	-- }

	--------------------------------
	-- Rust
	use({
		"simrat39/rust-tools.nvim",
		module = "rust-tools",
		-- after = { "nvim-lspconfig" },
		-- ft = { "rust" },
		-- config = function()
		-- 	require("rc/pluginconfig/rust-tools")
		-- end,
	})
	-- use {'rhysd/rust-doc.vim',
	--   ft = {'rust'},
	--   config = function() vim.cmd('source ~/.config/nvim/rc/pluginconfig/rust-doc.vim') end
	-- }

	--------------------------------
	-- Markdown
	use({ "iamcco/markdown-preview.nvim", ft = { "markdown" }, run = ":call mkdp#util#install()" })
	-- use markdown-preview.nvim
	-- if vim.fn.executable('glow') == 1 then
	--   use {'npxbr/glow.nvim',
	--     ft = {'markdown'},
	--     run = ':GlowInstall',
	--   }
	-- end
	use({
		"SidOfc/mkdx",
		ft = { "markdown" },
		setup = function()
			vim.cmd("source ~/.config/nvim/rc/pluginsetup/mkdx.vim")
		end,
	})
	use({
		"dhruvasagar/vim-table-mode",
		-- event = "VimEnter",
		cmd = { "TableModeEnable" },
		config = function()
			vim.cmd("source ~/.config/nvim/rc/pluginconfig/vim-table-mode.vim")
		end,
	})
	-- slow to build
	-- use {'euclio/vim-markdown-composer',
	--   run = 'cargo build --release'
	-- }

	--------------------------------
	-- SQL
	-- use {'dbext.vim'} -- helptagのエラーが出る。とりあえず使わないので無効。
	-- use {'tpope/vim-dadbod', event = "VimEnter"}
	use({ "alcesleo/vim-uppercase-sql", event = "VimEnter" })

	--------------------------------
	-- CSV
	-- use({ "mechatroner/rainbow_csv", ft = { "csv" } })
	-- buggy
	use({
		"chen244/csv-tools.lua",
		ft = { "csv" },
		config = function()
			require("rc/pluginconfig/csv-tools")
		end,
	})

	--------------------------------
	-- Log
	-- -> treesitter
	-- use({ "MTDL9/vim-log-highlighting", ft = { "log" } })

	--------------------------------
	-- Json
	-- use({ "neoclide/jsonc.vim", ft = { "json", "jsonc" } })

	--------------------------------
	-- Neovim Lua development
	-- do not customize K mapping
	-- use({ "tjdevries/nlua.nvim", event = "VimEnter" })
	-- use({ "tjdevries/manillua.nvim", event = "VimEnter" })
	use({ "bfredl/nvim-luadev", event = "VimEnter" })
	use({ "folke/lua-dev.nvim", module = "lua-dev" })
	use({ "wadackel/nvim-syntax-info", cmd = { "SyntaxInfo" } })

	--------------------------------------------------------------
	-- Load local plugins
	if vim.fn.filereadable(vim.fn.expand("~/.nvim_pluginlist_local.lua")) == 1 then
		local local_plugins = dofile(vim.fn.expand("~/.nvim_pluginlist_local.lua"))
		for _, p in ipairs(local_plugins) do
			use(p)
		end
	end
end)
