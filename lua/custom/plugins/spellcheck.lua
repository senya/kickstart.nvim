-- Настройка встроенной проверки орфографии vim
return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Создаем директорию для пользовательского словаря
      local spellfile = vim.fn.stdpath('config') .. '/spell/custom.utf-8.add'
      vim.fn.mkdir(vim.fn.stdpath('config') .. '/spell', 'p')
      
      -- Включаем встроенную проверку орфографии для определенных типов файлов
      vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = { 'COMMIT_EDITMSG', 'MERGE_MSG', 'TAG_EDITMSG', '*.commit', '*.md', '*.txt' },
        callback = function()
          -- Включаем проверку орфографии
          vim.opt_local.spell = true
          vim.opt_local.spelllang = { 'ru', 'en_us' }
          vim.opt_local.spellfile = spellfile
        end,
      })
      
      -- Команды для управления проверкой орфографии
      vim.api.nvim_create_user_command('SpellToggle', function()
        vim.opt_local.spell = not vim.opt_local.spell:get()
        print("Spell check " .. (vim.opt_local.spell:get() and "enabled" or "disabled"))
      end, { desc = 'Toggle spell check' })
      
      vim.api.nvim_create_user_command('SpellAdd', function(opts)
        if opts.args and opts.args ~= '' then
          vim.cmd('spellgood ' .. opts.args)
          print("Added '" .. opts.args .. "' to dictionary")
        else
          -- Добавляем слово под курсором
          local word = vim.fn.expand('<cword>')
          vim.cmd('spellgood ' .. word)
          print("Added '" .. word .. "' to dictionary")
        end
      end, { nargs = '?', desc = 'Add word to dictionary' })
      
      vim.api.nvim_create_user_command('SpellAddSelection', function()
        -- Сохраняем регистр, получаем выделенный текст и восстанавливаем
        local save_reg = vim.fn.getreg('"')
        local save_regtype = vim.fn.getregtype('"')
        
        vim.cmd('normal! gv"zy')
        local text = vim.fn.getreg('z')
        
        -- Восстанавливаем регистр
        vim.fn.setreg('"', save_reg, save_regtype)
        
        if text and text ~= '' then
          vim.cmd('spellgood ' .. text)
          print("Added '" .. text .. "' to dictionary")
        else
          print("No text selected")
        end
      end, { range = true, desc = 'Add selected text to dictionary' })
      
      -- Горячие клавиши для работы с орфографии
      vim.keymap.set('n', '<leader>st', ':SpellToggle<CR>', { desc = '[S]pell [T]oggle' })
      vim.keymap.set('n', '<leader>za', ':SpellAdd<CR>', { desc = '[Z] [A]dd word to spell' })
      vim.keymap.set('v', '<leader>za', ':SpellAddSelection<CR>', { desc = '[Z] [A]dd selection to spell' })
      vim.keymap.set('n', ']s', ']s', { desc = 'Next spelling error' })
      vim.keymap.set('n', '[s', '[s', { desc = 'Previous spelling error' })
      vim.keymap.set('n', 'z=', 'z=', { desc = 'Spelling suggestions' })
    end,
  },
}