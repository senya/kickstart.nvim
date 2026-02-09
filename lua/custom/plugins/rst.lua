-- Улучшенная поддержка reStructuredText (RST)
return {
  {
    -- Основная поддержка RST через Treesitter
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- Добавляем rst к списку установленных парсеров
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "rst" })
      end
    end,
  },
  
  {
    -- Плагин для работы с RST
    'stsewd/sphinx.nvim',
    ft = { 'rst' },
    build = ':UpdateRemotePlugins',
    config = function()
      -- Настройки для Sphinx
      vim.g.sphinx_include_types = {'py'}
      
      -- Горячие клавиши для RST
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'rst',
        callback = function()
          local opts = { buffer = true, silent = true }
          
          -- Навигация по заголовкам
          vim.keymap.set('n', ']]', ':SphinxGotoNextSection<CR>', 
            vim.tbl_extend('force', opts, { desc = 'Next RST section' }))
          vim.keymap.set('n', '[[', ':SphinxGotoPrevSection<CR>', 
            vim.tbl_extend('force', opts, { desc = 'Previous RST section' }))
          
          -- Предпросмотр
          vim.keymap.set('n', '<leader>rp', ':SphinxPreview<CR>', 
            vim.tbl_extend('force', opts, { desc = '[R]ST [P]review' }))
          
          -- Сборка документации
          vim.keymap.set('n', '<leader>rb', ':SphinxBuild<CR>', 
            vim.tbl_extend('force', opts, { desc = '[R]ST [B]uild' }))
        end,
      })
    end,
  },
  
  -- Настройки для RST файлов (без проблемного плагина vim-restructuredtext)
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      -- Настройки отступов и форматирования для RST
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'rst',
        callback = function()
          vim.bo.shiftwidth = 3  -- RST обычно использует 3 пробела
          vim.bo.tabstop = 3
          vim.bo.softtabstop = 3
          vim.bo.expandtab = true
          vim.bo.textwidth = 79  -- Стандартная ширина для RST
          
          -- Включаем перенос строк для RST
          vim.wo.wrap = true
          vim.wo.linebreak = true
          
          -- Дополнительные настройки для RST
          vim.bo.comments = 'fb:..'
          vim.bo.formatoptions = 'tcroqn'
        end,
      })
    end,
  }
}