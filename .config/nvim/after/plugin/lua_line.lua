local base16_tomorrow_night = {
  ['00'] = "1d1f21",
  ['01'] = "282a2e",
  ['02'] = "373b41",
  ['03'] = "969896",
  ['04'] = "b4b7b4",
  ['05'] = "c5c8c6",
  ['06'] = "e0e0e0",
  ['07'] = "ffffff",
  ['08'] = "cc6666",
  ['09'] = "de935f",
  ['0A'] = "f0c674",
  ['0B'] = "b5bd68",
  ['0C'] = "8abeb7",
  ['0D'] = "81a2be",
  ['0E'] = "b294bb",
  ['0F'] = "a3685a",
}

local base16_color = function(index)
  return vim.g['base16_gui' .. index] or base16_tomorrow_night[index]
end


local colors_semantic = {
  bg = base16_color('00'),
  alt_bg = base16_color('02'),
  dark_fg = base16_color('03'),
  fg = base16_color('04'),
  light_fg = base16_color('05'),
  normal = base16_color('0D'),
  insert = base16_color('0B'),
  visual = base16_color('0E'),
  replace = base16_color('09'),
}

local theme = {
  normal = {
    a = {
      fg = colors_semantic.bg,
      bg = colors_semantic.normal
    },
    b = {
      fg = colors_semantic.light_fg,
      bg = colors_semantic.alt_bg
    },
    c = {
      fg = colors_semantic.fg,
      bg = colors_semantic.alt_bg,
    },
  },
  replace = {
    a = {
      fg = colors_semantic.bg,
      bg = colors_semantic.replace
    },
    b = {
      fg = colors_semantic.light_fg,
      bg = colors_semantic.alt_bg
    },
  },
  insert = {
    a = {
      fg = colors_semantic.bg,
      bg = colors_semantic.insert
    },
    b = {
      fg = colors_semantic.light_fg,
      bg = colors_semantic.alt_bg
    },
  },
  visual = {
    a = {
      fg = colors_semantic.bg,
      bg = colors_semantic.visual
    },
    b = {
      fg = colors_semantic.light_fg,
      bg = colors_semantic.alt_bg
    },
  },
  inactive = {
    a = {
      fg = colors_semantic.dark_fg,
      bg = colors_semantic.bg
    },
    b = {
      fg = colors_semantic.dark_fg,
      bg = colors_semantic.bg
    },
    c = {
      fg = colors_semantic.dark_fg,
      bg = colors_semantic.bg
    },
  }
}

theme.command = theme.normal
theme.terminal = theme.insert

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = theme,
    component_separators = { left = '|', right = '|' },
    section_separators = {},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { { '%=', separator = '' }, { 'filename', path = 1 } },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
