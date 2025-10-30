# Simple oreminer

This mod mines the whole ore vein if you are holding a pickaxe.

The mining process stops if:

- You are too far away from the target (40 blocks by default)
- You take the pickaxe out of your hand
- Your pickaxe is destroyed
- You are dead
- You are out of the game
- You are holding ctrl or shift key down (this behavior can be reversed in
  settings)

## Features

- Super simple (~100 lines of code with extra features, translations and
  settings, but core functionality is just 10-15 lines).
- Compatible with any game or mod
- Works fine with huge ore veins (increase `max_distance` and `max_radius` if
  needed)
- Recognizes trees and tools by their group, so it does not require any
  configuration
- I you don't have the `dwarf` permission (in multiplayer game), trees will
  be cut 100 times slower (you can change the default `delay` in settings)

This mod was created in [Minetestia Forge].
Modified to work with ores by Hanuko33/i3riced.

All my mods uses [Minetest LSP-API] annotations, [StyLua] and [Luacheck].

[Minetestia Forge]: https://github.com/orgs/minetestia/repositories
[Minetest LSP-API]: https://github.com/minetest-toolkit/minetest-lsp-api
[StyLua]: https://github.com/JohnnyMorganz/StyLua
[Luacheck]: https://github.com/mpeterv/luacheck
