-- ~/.config/nvim/lua/plugins/dashboard.lua
return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        -- Mironvim ASCII-Art als Header
        preset = {
          header = [[    ...     ..      ..        .                                              _            .                        
  x*8888x.:*8888: -"888:     @88>                                           u            @88>                      
 X   48888X `8888H  8888     %8P      .u    .          u.      u.    u.    88Nu.   u.    %8P      ..    .     :    
X8x.  8888X  8888X  !888>     .     .d88B :@8c   ...ue888b   x@88k u@88c. '88888.o888c    .     .888: x888  x888.  
X8888 X8888  88888   "*8%-  .@88u  ="8888f8888r  888R Y888r ^"8888""8888"  ^8888  8888  .@88u  ~`8888~'888X`?888f` 
'*888!X8888> X8888  xH8>   ''888E`   4888>'88"   888R I888>   8888  888R    8888  8888 ''888E`   X888  888X '888>  
  `?8 `8888  X888X X888>     888E    4888> '     888R I888>   8888  888R    8888  8888   888E    X888  888X '888>  
  -^  '888"  X888  8888>     888E    4888>       888R I888>   8888  888R    8888  8888   888E    X888  888X '888>  
   dx '88~x. !88~  8888>     888E   .d888L .+   u8888cJ888    8888  888R   .8888b.888P   888E    X888  888X '888>  
 .8888Xf.888x:!    X888X.:   888&   ^"8888*"     "*888*P"    "*88*" 8888"   ^Y8888*""    888&   "*88%""*88" '888!` 
:""888":~"888"     `888*"    R888"     "Y"         'Y"         ""   'Y"       `Y"        R888"    `~    "    `"`   
    "~'    "~        ""       ""                                                          ""                       
                                                                                                                   
                                                                                                                   
                                                                                                                   ]],
        },
        sections = {
          -- 1. Ganz oben, linke Seite (Pane 1): Mironvim Header
          { section = "header", padding = 1 },

          -- 2. Linke Seite (Pane 1): Deine Menüpunkte
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup", padding = 1 },
        },
      },
    },
  },
}
