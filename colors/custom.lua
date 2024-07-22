local M = {}

M.colorscheme = function(color_scheme)
   color_scheme = color_scheme or 'onedark'
   local success, colors = pcall(function()
      return require("colors." .. color_scheme)
   end)

   if not success then
      print("Error: colorscheme '" .. color_scheme .. "' not found. Falling back to 'onedark'.")
      colors = require("colors.onedark")
   end

   return {
      foreground = colors.foreground,
      background = colors.background,
      cursor_bg = '#4273ff',
      cursor_border = '#4273ff',
      cursor_fg = colors.cursor_fg,
      selection_bg = colors.selection_bg,
      selection_fg = colors.selection_fg,
      -- ansi = colors.ansi,
      -- brights = colors.brights,
      tab_bar = {
         background = 'rgba(0, 0, 0, 0.4)',
         active_tab = {
            bg_color = colors.selection_bg,
            fg_color = colors.foreground,
         },
         inactive_tab = {
            bg_color = colors.surface0,
            fg_color = colors.subtext1,
         },
         inactive_tab_hover = {
            bg_color = colors.surface0,
            fg_color = colors.foreground,
         },
         new_tab = {
            bg_color = colors.background,
            fg_color = colors.foreground,
         },
         new_tab_hover = {
            bg_color = colors.mantle,
            fg_color = colors.foreground,
            italic = true,
         },
      },
      visual_bell = colors.surface0,
      indexed = {
         [16] = colors.peach,
         [17] = colors.cursor_bg,
      },
      scrollbar_thumb = colors.selection_bg,
      split = colors.overlay0,
      compose_cursor = colors.flamingo, -- nightbuild only
   }
end

return M
