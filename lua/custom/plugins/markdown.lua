-- Улучшенная подсветка и поддержка Markdown
return {
  {
    -- Улучшенная подсветка Markdown с поддержкой таблиц, LaTeX и других элементов
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown' },
    config = function()
      require('render-markdown').setup({
        -- Включить рендеринг по умолчанию
        enabled = true,
        
        -- Настройки заголовков
        heading = {
          -- Включить подсветку заголовков
          enabled = true,
          -- Использовать разные символы для разных уровней
          sign = true,
          -- Настройки иконок для заголовков
          icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
          -- Цвета для разных уровней заголовков
          backgrounds = {
            'RenderMarkdownH1Bg',
            'RenderMarkdownH2Bg', 
            'RenderMarkdownH3Bg',
            'RenderMarkdownH4Bg',
            'RenderMarkdownH5Bg',
            'RenderMarkdownH6Bg',
          },
        },
        
        -- Настройки кода
        code = {
          -- Включить подсветку блоков кода
          enabled = true,
          -- Подсветка inline кода
          sign = false,
          -- Стиль для блоков кода
          style = 'full',
          -- Отступы
          left_pad = 2,
          right_pad = 2,
        },
        
        -- Настройки списков
        bullet = {
          enabled = true,
          icons = { '●', '○', '◆', '◇' },
        },
        
        -- Настройки чекбоксов
        checkbox = {
          enabled = true,
          unchecked = {
            icon = '󰄱 ',
            highlight = 'RenderMarkdownUnchecked',
          },
          checked = {
            icon = '󰱒 ',
            highlight = 'RenderMarkdownChecked',
          },
        },
        
        -- Настройки таблиц - это то что вам нужно!
        pipe_table = {
          enabled = true,
          preset = 'round', -- 'none', 'round', 'double', 'heavy'
          style = 'full',
        },
        
        -- Настройки ссылок
        link = {
          enabled = true,
          image = '󰥶 ',
          hyperlink = '󰌹 ',
          highlight = 'RenderMarkdownLink',
        },
        
        -- Настройки цитат
        quote = {
          enabled = true,
          icon = '▋',
          highlight = 'RenderMarkdownQuote',
        },
      })
      
      -- Горячие клавиши для переключения рендеринга
      vim.keymap.set('n', '<leader>mr', ':RenderMarkdown toggle<CR>', 
        { desc = '[M]arkdown [R]ender toggle', silent = true })
    end,
  },
  
  {
    -- Дополнительные возможности для Markdown
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npm install',
    config = function()
      -- Настройки предварительного просмотра
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_open_ip = ''
      vim.g.mkdp_browser = ''
      vim.g.mkdp_echo_preview_url = 0
      vim.g.mkdp_browserfunc = ''
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {}
      }
      vim.g.mkdp_markdown_css = ''
      vim.g.mkdp_highlight_css = ''
      vim.g.mkdp_port = ''
      vim.g.mkdp_page_title = '「${name}」'
      vim.g.mkdp_filetypes = {'markdown'}
      
      -- Горячие клавиши
      vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<CR>', 
        { desc = '[M]arkdown [P]review toggle', silent = true })
    end,
  }
}