local wezterm = require('wezterm')
local platform = require('utils.platform')()
local act = wezterm.action

local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   mod.SUPER_REV = 'WIN'
elseif platform.is_linux then
   mod.SUPER = 'CTRL|SHIFT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'CTRL'
elseif platform.is_win or platform.is_linux then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end

-- stylua: ignore
local keys = {
   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   {
      key = 'F5',
      mods = 'NONE',
      action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
   },
   { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
   { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },

   -- cursor movement --
   { key = 'LeftArrow',  mods = mod.SUPER,     action = act.SendString '\x1bOH' },
   { key = 'RightArrow', mods = mod.SUPER,     action = act.SendString '\x1bOF' },
   { key = 'Backspace',  mods = mod.SUPER,     action = act.SendString '\x15' },

   -- copy/paste --
   { key = 'c',          mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

   -- tabs --
   -- tabs: spawn+close
   { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
   { key = 'w',          mods = mod.SUPER, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation
   { key = '{',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
   { key = '}',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
   { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   -- window --
   -- spawn windows
   { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

   -- panes --
   -- panes: split panes
   {
      key = [[?]],
      mods = mod.SUPER,
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = [[/]],
      mods = mod.SUPER_REV,
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },
}

-- stylua: ignore
local mac_keys = {
   -- misc/useful --
   { key = 'F1', mods = 'NONE', action = 'ActivateCopyMode' },
   { key = 'F2', mods = 'NONE', action = act.ActivateCommandPalette },
   { key = 'F3', mods = 'NONE', action = act.ShowLauncher },
   { key = 'F4', mods = 'NONE', action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS' }) },
   {
      key = 'F5',
      mods = 'NONE',
      action = act.ShowLauncherArgs({ flags = 'FUZZY|WORKSPACES' }),
   },
   { key = 'F11', mods = 'NONE',    action = act.ToggleFullScreen },
   { key = 'F12', mods = 'NONE',    action = act.ShowDebugOverlay },

   -- cursor movement --
   { key = 'LeftArrow',  mods = mod.SUPER,     action = act.SendString '\x1bOH' },
   { key = 'RightArrow', mods = mod.SUPER,     action = act.SendString '\x1bOF' },
   { key = 'Backspace',  mods = mod.SUPER,     action = act.SendString '\x15' },

   -- copy/paste --
   { key = 'c',          mods = mod.SUPER,  action = act.CopyTo('Clipboard') },
   { key = 'v',          mods = mod.SUPER,  action = act.PasteFrom('Clipboard') },

   -- tabs --
   -- tabs: spawn+close
   { key = 't',          mods = mod.SUPER,     action = act.SpawnTab('DefaultDomain') },
   { key = 'w',          mods = mod.SUPER, action = act.CloseCurrentTab({ confirm = false }) },

   -- tabs: navigation
   { key = '[',          mods = mod.SUPER,     action = act.ActivateTabRelative(-1) },
   { key = ']',          mods = mod.SUPER,     action = act.ActivateTabRelative(1) },
   { key = '[',          mods = mod.SUPER_REV, action = act.MoveTabRelative(-1) },
   { key = ']',          mods = mod.SUPER_REV, action = act.MoveTabRelative(1) },

   -- window --
   -- spawn windows
   { key = 'n',          mods = mod.SUPER,     action = act.SpawnWindow },

   -- panes --
   -- panes: split panes
   {
      key = [[/]],
      mods = mod.SUPER,
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
   },
   {
      key = [[/]],
      mods = mod.SUPER_REV,
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
   },
}

local mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CTRL',
      action = act.OpenLinkAtMouseCursor,
   },
}

local mac_mouse_bindings = {
   -- Ctrl-click will open the link under the mouse cursor
   {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = mod.SUPER,
      action = act.OpenLinkAtMouseCursor,
   },
}

if platform.is_mac then
   for i = 1, 9 do
      table.insert(mac_keys, {
         key = tostring(i),
         mods = mod.SUPER,
         action = act.ActivateTab(i - 1),
      })
   end
   return {
      disable_default_key_bindings = true,
      keys = mac_keys,
      mouse_bindings = mac_mouse_bindings,
   }
elseif platform.is_win or platform.is_linux then
   for i = 1, 9 do
      table.insert(keys, {
         key = tostring(i),
         mods = 'CTRL',
         action = act.ActivateTab(i - 1),
      })
   end
   return {
      disable_default_key_bindings = true,
      keys = keys,
      mouse_bindings = mouse_bindings,
   }
end
