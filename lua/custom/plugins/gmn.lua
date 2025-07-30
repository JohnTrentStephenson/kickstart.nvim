return {
  {
    'meinside/gmn.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      -- IMPORTANT: Explicitly choose the faster, more cost-effective Flash model
      model = 'gemini-1.5-flash-latest', -- Highly recommended for general use and free tier

      -- Optional: Configure safety settings. BLOCK_ONLY_HIGH is good for code.
      safetyThreshold = 'BLOCK_ONLY_HIGH',

      -- Optional: Adjust timeout if you have slow internet, in milliseconds
      -- timeout = 30 * 1000, -- 30 seconds

      -- Optional: Max tokens to generate for general prompts (helps control output length and cost)
      -- This is for specific generation commands, not interactive chat.
      -- max_tokens = 500, -- Example, adjust as needed.

      -- You generally DON'T want to set api_key directly here, prefer env var.
      -- api_key = os.getenv("GEMINI_API_KEY"), -- gmn.nvim usually picks this up automatically
    },
    -- Load this plugin only when its commands are called
    cmd = { 'GeminiGenerate', 'GeminiChat', 'GeminiGenerateGitCommitLog' },
    -- Optional: Setup keybindings for easier access
    config = function(_, opts)
      require('gmn').setup(opts)
      -- Keymaps for Gemini actions
      vim.keymap.set('n', '<leader>gc', '<cmd>GeminiChat<CR>', { desc = 'Gemini: Start Chat' })
      vim.keymap.set('n', '<leader>gg', '<cmd>GeminiGenerate<CR>', { desc = 'Gemini: Generate Text (Prompt)' })
      vim.keymap.set('v', '<leader>gg', ':<C-u>GeminiGenerate<CR>', { desc = 'Gemini: Generate Text (Selection)' })
      vim.keymap.set('n', '<leader>gcm', '<cmd>GeminiGenerateGitCommitLog<CR>', { desc = 'Gemini: Generate Git Commit' })

      -- Example: Generate a code explanation for the current selection
      vim.keymap.set('v', '<leader>ge', ':<C-u>GeminiGenerate Explain this code in detail.<CR>', { desc = 'Gemini: Explain Code' })
    end,
  },
}
