-- Поддержка RST таблиц
return {
  {
    -- Плагин для форматирования RST таблиц
    'dhruvasagar/vim-table-mode',
    ft = { 'rst' },
    config = function()
      -- Настройки для RST таблиц
      vim.g.table_mode_corner = '+'
      vim.g.table_mode_separator = '|'
      vim.g.table_mode_fillchar = '-'
      vim.g.table_mode_header_fillchar = '='
      
      -- Автокоманды для RST
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'rst',
        callback = function()
          local opts = { buffer = true, silent = true }
          
          -- Горячие клавиши для работы с таблицами
          vim.keymap.set('n', '<leader>tm', ':TableModeToggle<CR>',
            vim.tbl_extend('force', opts, { desc = '[T]able [M]ode toggle' }))
          vim.keymap.set('n', '<leader>tr', ':TableModeRealign<CR>',
            vim.tbl_extend('force', opts, { desc = '[T]able [R]ealign' }))
          vim.keymap.set('n', '<leader>tt', ':Tableize<CR>',
            vim.tbl_extend('force', opts, { desc = '[T]ableize selection' }))
          
          -- Альтернативный подход: используем matchadd вместо syntax правил
          -- Это более безопасно и не конфликтует с другими парсерами
          
          -- Определяем highlight группы для таблиц
          vim.api.nvim_set_hl(0, 'RstTableBorder', { fg = '#61afef', bold = true })
          vim.api.nvim_set_hl(0, 'RstTableHeader', { fg = '#e06c75', bold = true })
          
          -- Используем matchadd для подсветки (более безопасно)
          pcall(function()
            -- Подсвечиваем только границы grid таблиц (строки с + и |)
            vim.fn.matchadd('RstTableBorder', '^\\s*+[-=+]*+\\s*$', 10)  -- горизонтальные границы
            vim.fn.matchadd('RstTableBorder', '|', 10)  -- вертикальные границы
            -- Подсвечиваем содержимое ячеек таблиц (строки с |, но не заголовки)
            vim.fn.matchadd('RstTableHeader', '^\\s*|.*|\\s*$', 9)
          end)
        end,
      })
    end,
  }
}