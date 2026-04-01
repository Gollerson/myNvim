-- ~/.config/nvim/lua/plugins/dashboard.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        sections = {
          -- 1. Ganz oben: Normaler Header (Zentriert)
          { section = "header", padding = 1 },

          -- 2. Linke Seite (Pane 1): Deine Menüpunkte
          { pane = 1, section = "keys", gap = 1, padding = 1 },
          { pane = 1, section = "startup", padding = 1 },

          -- 3. Rechte Seite (Pane 2): Das Pokemon
          {
            pane = 2,
            section = "terminal",
            cmd = "echo 'Fröhliches Coden wünscht dir:' && pokemon-colorscripts -r",
            height = 20,
            padding = 1,
            ttl = 0, -- Jedes Mal neu würfeln
          },
        },
        -- WICHTIG: Damit Panes funktionieren, definieren wir hier die Gesamtbreite
        formats = {
          pane = { width = 45 }, -- Breite jeder Spalte
        },
      },
    },
  },
}
