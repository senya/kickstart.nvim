-- vim-interestingwords - подсветка нескольких слов разными цветами
-- Позволяет выделять слова как при поиске (*), но несколько слов одновременно разными цветами

return {
  'lfv89/vim-interestingwords',
  config = function()
    -- Настройки плагина
    vim.g.interestingWordsGUIColors = {
      '#8CCBEA', '#A4E57E', '#FFDB72', '#FF7272', '#FFB3FF', '#9999FF'
    }
    
    vim.g.interestingWordsTermColors = {
      '154', '121', '211', '137', '214', '222'
    }
    
    -- Настройка горячих клавиш
    -- m - подсветить/убрать подсветку слова под курсором (как * но с цветами)
    vim.keymap.set('n', 'm', ':call InterestingWords("n")<cr>',
      { desc = 'Highlight/unhighlight word under cursor', silent = true })
    
    -- M - убрать всю подсветку
    vim.keymap.set('n', 'M', ':call UncolorAllWords()<cr>',
      { desc = 'Clear all word highlights', silent = true })
    
    -- В визуальном режиме тоже можно подсвечивать выделенный текст
    vim.keymap.set('v', 'm', ':call InterestingWords("v")<cr>',
      { desc = 'Highlight/unhighlight selection', silent = true })
  end,
}