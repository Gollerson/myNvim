-- Minecraft colorscheme ------------------------------------------------
-- Obsidian "title-screen" dark UI; classic Minecraft block palette mapped onto
-- code roles. Aimed at the Monocraft pixel font (`:set guifont=Monocraft`).
--
-- Because ~/.config/nvim is on &rtp, this is found by `:colorscheme minecraft`
-- and by the <leader>uC picker; your selection is then persisted like the rest.
-- Optional: `vim.g.minecraft_transparent = false` forces the solid obsidian BG.

if vim.g.colors_name then
  vim.cmd("hi clear")
end
vim.g.colors_name = "minecraft"
vim.o.background = "dark"

local P = {
  -- stone / obsidian
  bg_deep = "#0c0810",
  bg      = "#161019",
  bg_hi   = "#241b2a",
  edge    = "#32293c",
  cobble  = "#575f6c", -- comments
  powder  = "#7e8794",
  iron    = "#9aa3b2",
  bone    = "#eef1f4",
  endstone= "#d8d2cc",
  -- blocks
  gold      = "#f2c14e",
  tnt       = "#ec8024",
  nether    = "#e2621f",
  emerald   = "#3ad07b",
  lapis     = "#6fa6ee",
  prismarine= "#38e0c8",
  grass     = "#7cc94e",
  creeper   = "#54b86b",
  ice       = "#9cd9ef",
  blaze     = "#ffb84d",
  purpur    = "#c997e8",
  amethyst  = "#a689e8",
  redstone  = "#ea5241",
  brick     = "#d4a06a",
  birch     = "#ead9b0",
  mushroom  = "#d96a5f",
}

local function hl(name, fg, bg, style)
  local kv = {}
  if fg then kv.fg = fg end
  if bg then kv.bg = bg end
  if style then
    for k, v in pairs(style) do
      kv[k] = v
    end
  end
  vim.api.nvim_set_hl(0, name, kv)
end

local function link(group, to)
  vim.api.nvim_set_hl(0, group, { link = to })
end

local trans = not (vim.g.minecraft_transparent == false)
local NORMAL_BG = trans and "NONE" or P.bg

-- editor chrome ---------------------------------------------------------
hl("Normal", P.bone, NORMAL_BG)
hl("NormalNC", P.iron, trans and "NONE" or P.bg)
hl("NormalFloat", P.bone, P.bg_hi)
hl("EndOfBuffer", P.bg_deep)
hl("LineNr", P.powder)
hl("CursorLineNr", P.gold, nil, { bold = true })
hl("CursorLine", nil, P.bg_hi)
hl("CursorColumn", nil, P.bg_hi)
hl("SignColumn", nil, P.bg)
hl("FoldColumn", P.edge, P.bg_deep)
hl("Folded", P.powder, P.bg_deep, { italic = true })
hl("Conceal", P.powder)
hl("NonText", P.bg_hi)
hl("Whitespace", P.bg_hi)
hl("SpecialKey", P.gold)
hl("VertSplit", P.edge, P.bg_deep)
hl("WinSeparator", P.edge, P.bg_deep)
hl("WinBar", P.endstone, P.bg_hi)
hl("WinBarNC", P.powder, P.bg)
hl("ColorColumn", nil, P.bg_hi)
hl("Cursor", P.bone)
hl("CursorIM", P.bone)
hl("lCursor", P.bone)
hl("MatchParen", P.ice, nil, { underline = true, bold = true })
hl("MatchWord", P.ice, nil, { underline = true })
hl("Search", P.bg_deep, P.gold)
hl("CurSearch", P.bg_deep, P.blaze, { bold = true })
hl("IncSearch", P.bg, P.emerald)
hl("Visual", nil, P.edge)
hl("VisualNOS", nil, P.bg_hi, { underline = true })
hl("Question", P.gold)
hl("ModeMsg", P.bone, nil, { bold = true })
hl("MoreMsg", P.emerald)
hl("Directory", P.prismarine)
hl("Title", P.gold, nil, { bold = true })

-- floats / menus ------------------------------------------------------
link("FloatBorder", "WinSeparator")
hl("FloatTitle", P.bone, nil, { bold = true })
hl("Pmenu", P.iron, P.bg_hi)
hl("PmenuSel", P.bg, P.emerald, { bold = true })
hl("PmenuThumb", nil, P.edge)
hl("PmenuSbar", nil, P.bg_hi)
hl("WildMenu", P.bg, P.emerald)

-- status & tabs --------------------------------------------------------
hl("StatusLine", P.endstone, P.bg_hi)
hl("StatusLineNC", P.powder, P.bg)
hl("StatusLineTerm", nil, P.bg)
hl("StatusLineTermNC", nil, P.bg_deep)
hl("TabLine", P.powder, P.bg)
hl("TabLineSel", P.bone, P.bg_hi, { bold = true })
hl("TabLineFill", P.edge, P.bg_deep)

-- messages -------------------------------------------------------------
hl("ErrorMsg", "#ffd9d9", "#3d1111", { bold = true })
hl("WarningMsg", P.blaze, nil, { bold = true })
hl("Error", P.redstone)
hl("Comment", P.cobble, nil, { italic = true })
hl("Todo", P.mushroom, P.bg_deep, { bold = true })

-- diagnostics ----------------------------------------------------------
hl("DiagnosticError", "#ff9c9c", nil, { undercurl = true })
hl("DiagnosticWarn", P.blaze, nil, { undercurl = true })
hl("DiagnosticInfo", P.ice, nil, { undercurl = true })
hl("DiagnosticHint", P.prismarine, nil, { undercurl = true })
hl("DiagnosticOk", P.emerald)
hl("DiagnosticUnderlineError", "#ff9c9c", nil, { undercurl = true })
hl("DiagnosticUnderlineWarn", P.blaze, nil, { undercurl = true })
hl("DiagnosticUnderlineInfo", P.ice, nil, { undercurl = true })
hl("DiagnosticUnderlineHint", P.prismarine, nil, { undercurl = true })
hl("DiagnosticSignError", "#ff9c9c", P.bg)
hl("DiagnosticSignWarn", P.blaze, P.bg)
hl("DiagnosticSignInfo", P.ice, P.bg)
hl("DiagnosticSignHint", P.prismarine, P.bg)
hl("DiagnosticVirtualTextError", "#ff9c9c", P.bg)
hl("DiagnosticVirtualTextWarn", P.blaze, P.bg)
hl("DiagnosticVirtualTextInfo", P.ice, P.bg)
hl("DiagnosticVirtualTextHint", P.prismarine, P.bg)

-- spelling -------------------------------------------------------------
hl("SpellBad", "#ff9c9c", nil, { undercurl = true })
hl("SpellCap", P.prismarine, nil, { undercurl = true })
hl("SpellLocal", P.ice, nil, { undercurl = true })
hl("SpellRare", P.purpur, nil, { undercurl = true })

-- diff -----------------------------------------------------------------
hl("DiffAdd", P.grass, "#10291a")
hl("DiffChange", P.gold, "#2c2206")
hl("DiffDelete", P.redstone, "#2b0d0d")
hl("DiffText", P.bg, P.gold)
link("GitSignsAdd", "DiffAdd")
link("GitSignsChange", "DiffChange")
link("GitSignsDelete", "DiffDelete")
link("GitSignsAddLn", "DiffAdd")
link("GitSignsChangeLn", "DiffChange")
link("GitSignsDeleteLn", "DiffDelete")

-- syntax (runtime & classic) ------------------------------------------
hl("Comment", P.cobble, nil, { italic = true })
hl("Statement", P.lapis)
link("Operator", "Statement")
link("Keyword", "Statement")
link("Label", "Statement")
link("Exception", "Statement")
hl("Identifier", P.grass)
hl("Function", P.tnt)
hl("PreProc", P.purpur)
link("Include", "PreProc")
link("Define", "PreProc")
link("Macro", "PreProc")
link("PreCondit", "PreProc")
hl("Type", P.emerald)
link("StorageClass", "Type")
link("Structure", "Type")
link("Typedef", "Type")
hl("Constant", P.gold)
hl("String", P.prismarine)
hl("Boolean", P.gold)
hl("Character", P.blaze)
hl("Number", P.blaze)
link("Float", "Number")
link("Special", "Type") -- fallback 'special' chrome
link("SpecialChar", "Special")
link("Tag", "Special")
link("Delimiter", "NonText")
link("SpecialComment", "Comment")
hl("Underlined", P.ice, nil, { underline = true })
link("Ignore", "NonText")
link("ToDo", "Todo")

-- treesitter -----------------------------------------------------------
-- comments / docs
link("@comment", "Comment")
link("@comment.error", "Comment")
link("@comment.warning", "Comment")
link("@comment.info", "Comment")
link("@comment.hint", "Comment")
link("@comment.todo", "Todo")
link("@comment.note", "Comment")

-- names (grass = variables / identifiers)
hl("@variable", P.grass)
hl("@variable.builtin", P.ice)
hl("@variable.parameter", P.endstone)
link("@field", "@variable")
link("@property", "@variable")
link("@member", "@variable")

-- constants & literals
hl("@constant", P.gold)
hl("@constant.builtin", P.ice)
hl("@constant.macro", P.purpur)
hl("@constant.mcbool", P.gold)
link("@boolean", "@constant.mcbool")
hl("@number", P.blaze)
hl("@number.float", P.blaze)
link("@float", "@number")
hl("@character", P.prismarine)
hl("@character.special", P.blaze)
hl("@string", P.prismarine)
hl("@string.escape", P.creeper)
link("@string.special", "@string")
link("@string.special.url", "Underlined")
hl("@string.regexp", P.purpur)
hl("@string.documentation", P.birch, nil, { italic = true })

-- functions & methods
hl("@function", P.tnt)
hl("@function.builtin", P.gold)
link("@function.macro", "Macro")
hl("@function.call", P.tnt)
hl("@function.method", P.nether)
hl("@function.method.call", P.nether)
hl("@constructor", P.gold)

-- types
hl("@type", P.emerald)
hl("@type.builtin", P.grass)
link("@type.definition", "@type")
link("@type.qualifier", "@type.builtin")

-- keywords / control
hl("@keyword", P.lapis)
hl("@keyword.function", P.amethyst)
link("@keyword.storage", "@keyword.function")
link("@keyword.return", "@keyword")
link("@keyword.repeat", "@keyword")
link("@keyword.operator", "Operator")
link("@keyword.conditional", "@keyword")
link("@keyword.exception", "@keyword")
link("@conditional", "@keyword.conditional")
link("@repeat", "@keyword.repeat")
link("@keyword.import", "@keyword")
link("@include", "@keyword")
link("@exception", "@keyword.exception")

-- operators & punctuation
hl("@operator", P.tnt)
hl("@punctuation.delimiter", P.iron)
hl("@punctuation.bracket", P.powder)
hl("@punctuation.special", P.gold)
link("@delimiter", "@punctuation.delimiter")

-- preproc / macros / annotations
hl("@preproc", P.purpur)
link("@definex", "@preproc")
hl("@annotation", P.brick)
hl("@attribute", P.brick)
link("@decorator", "@annotation")

-- produce / symbol / label
hl("@label", P.ice)
hl("@tag", P.prismarine)
link("@tag.attribute", "@function")
link("@tag.delimiter", "@punctuation.delimiter")

-- text content (markdown / docs)
hl("@text", P.endstone)
link("@text.literal", "@string")
hl("@text.reference", P.prismarine)
link("@text.title", "Title")
hl("@text.uri", P.prismarine, nil, { underline = true })
hl("@text.underline", P.powder, nil, { underline = true })
hl("@text.emphasis", P.bone, nil, { italic = true })
hl("@text.strong", P.bone, nil, { bold = true })
hl("@text.strikethrough", P.powder, nil, { strikethrough = true })
link("@text.math", "@string")

-- errors / danger in text
hl("@text.todo", P.mushroom, P.bg_deep, { bold = true })
hl("@debug", P.redstone)
link("@error", "Error")

