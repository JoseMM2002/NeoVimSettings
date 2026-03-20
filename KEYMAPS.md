# Neovim Keymaps Cheat Sheet

This cheat sheet lists keymaps from your config with explicit origin labels:

- `[explicit]`: directly defined with `vim.keymap.set` or `vim.api.nvim_set_keymap` in your files.
- `[plugin default]`: not explicitly mapped in your config; provided by plugin defaults.
- `[plugin generated]`: created programmatically by your config (for example, Treesitter object loops).

## Core (explicit)

- `[explicit]` `<Space>`: leader key (`lua/josemm/remap.lua`)
- `[explicit]` `<leader>q`: quit all
- `[explicit]` `<leader>so`: source current file
- `[explicit]` `<leader>L`: open Lazy plugin manager
- `[explicit]` `<leader>sv`: vertical split + previous buffer
- `[explicit]` `<leader>sh`: horizontal split + previous buffer
- `[explicit]` `<C-h/j/k/l>`: move across windows
- `[explicit]` `=` / `-`: widen / shrink vertical split
- `[explicit]` `<C-->` / `<C-=>`: increase / decrease horizontal split
- `[explicit]` `jk` (insert): exit insert mode
- `[explicit]` `J` / `K` (visual): move selected lines down/up

## Find / Telescope

- `[explicit]` `<leader>ff`: find files (including hidden)
- `[explicit]` `<leader>fb`: buffers (sorted by recent use)
- `[explicit]` `<leader>fr`: live grep
- `[explicit]` `<leader>fH`: help tags
- `[explicit]` `<leader>fs`: git status picker
- `[explicit]` `<leader>fD`: diagnostics (all)
- `[explicit]` `<leader>fd`: diagnostics (current buffer)
- `[explicit]` `<leader>fL`: document symbols
- `[explicit]` `gr`: LSP references via Telescope
- `[explicit]` `gd`: LSP definitions via Telescope
- `[explicit]` `<leader>tc`: colorscheme picker
- `[explicit]` `<leader>fh`: git file history
- `[explicit]` `<leader>fn`: notifications picker
- `[explicit]` Telescope insert/normal `<C-q>`: send to quickfix + open quickfix

## LSP / Diagnostics

- `[explicit]` `<leader>M`: open Mason
- `[explicit]` `<leader>ca`: code actions
- `[explicit]` `<leader>rn`: rename symbol
- `[explicit]` `<leader>ry`: rename symbol with unnamed register
- `[explicit]` `K`: ufo folded preview fallback to LSP hover
- `[explicit]` `<leader>e`: diagnostic float
- `[explicit]` `]d` / `[d`: next / previous diagnostic + auto float

## Folds (ufo)

- `[explicit]` `zR`: open all folds
- `[explicit]` `zM`: close all folds
- `[explicit]` `zr`: open folds except kinds
- `[explicit]` `zm`: close folds by level

## Treesitter Textobjects

- `[explicit]` `;` / `,`: repeat last treesitter move
- `[plugin generated]` object-selection pattern created in loop (`lua/josemm/lazy/treesitter.lua`):
  - operator/visual: `<part><object>` selects textobject
  - normal: `m<part><object>` next, `M<part><object>` previous
- `[plugin generated]` object suffixes from your table:
  - `f` function, `c` call, `/` comment, `@` decorator, `?` conditional, `b` block, `a` param, `=` assignment, `q` quote, `r` return, `o` object
- `[plugin generated]` part suffixes from your table:
  - `a` outer, `i` inner, plus object-specific keys like `t` type, `l/r` lhs/rhs, `f/e/v/s`

## Completion / AI

### Blink completion

- `[explicit]` `<C-space>`: show menu/docs
- `[explicit]` `<C-e>`: hide (fallback)
- `[explicit]` `<C-y>`: select and accept (fallback)
- `[explicit]` `<CR>`: select and accept (fallback)
- `[explicit]` `<Up>/<Down>`: select prev/next (fallback)
- `[explicit]` `<C-p>/<C-n>`: select prev/next (fallback_to_mappings)
- `[explicit]` `<C-b>/<C-f>`: scroll docs up/down
- `[explicit]` `<Tab>/<S-Tab>`: snippet forward/back; `<Tab>` also skips over closers (`] ) } > " ' ``) before accept/fallback
- `[explicit]` `<C-k>`: show/hide signature (fallback)

### Copilot suggestion

- `[explicit]` `<C-j>`: accept
- `[explicit]` `<C-n>`: next
- `[explicit]` `<C-p>`: previous
- `[explicit]` `<C-e>`: dismiss

## Git

- `[explicit]` `<leader>lg`: open LazyGit
- `[explicit]` `]c` / `[c`: next/prev hunk (gitsigns-aware)
- `[explicit]` `<leader>hs`: stage hunk
- `[explicit]` `<leader>hr`: reset hunk
- `[explicit]` `<leader>hS`: stage buffer
- `[explicit]` `<leader>hu`: undo stage hunk
- `[explicit]` `<leader>hR`: reset buffer
- `[explicit]` `<leader>hp`: preview hunk
- `[explicit]` `<leader>hb`: blame line (full)
- `[explicit]` `<leader>tb`: toggle current-line blame
- `[explicit]` `<leader>hd`: diff this
- `[explicit]` `<leader>hD`: diff this against HEAD
- `[explicit]` `<leader>td`: toggle deleted lines
- `[explicit]` `ih` (operator/visual): select hunk textobject

## Explorer / Files

- `[explicit]` `<leader>fe`: open Oil explorer
- `[explicit]` Oil `<C-r>`: refresh
- `[explicit]` Oil `<C-v>`: open in vertical split
- `[explicit]` Oil `<C-s>`: open in horizontal split
- `[explicit]` `<leader>-`: open Yazi at current file
- `[explicit]` `<leader>cw`: open Yazi at cwd
- `[explicit]` `<C-Up>`: resume/toggle last Yazi session

## Debug (DAP)

- `[explicit]` `<leader>db`: toggle breakpoint
- `[explicit]` `<leader>dc`: continue
- `[explicit]` `<leader>di`: step into
- `[explicit]` `<leader>do`: step over
- `[explicit]` `<leader>du`: step out
- `[explicit]` `<leader>dx`: terminate
- `[explicit]` `<leader>dr`: restart
- `[explicit]` `<leader>dU`: toggle DAP UI

## Notes / REST / Misc

### Env

- `[explicit]` `<leader>ge`: go to `.env` file (Ecolog)

### Formatting

- `[explicit]` `<leader>mp` (normal/visual): format buffer/selection (Conform)

### Notes

- `[explicit]` `<leader>nw`: write note
- `[explicit]` `<leader>nf`: find note
- `[explicit]` `<leader>ng`: get note

### REST (Kulala)

- `[plugin default]` `<leader>rs`: send request (from `global_keymaps = true`, prefix `<leader>r`)
- `[plugin default]` `<leader>ra`: send all requests
- `[plugin default]` `<leader>rb`: open scratchpad
- `[explicit metadata]` extra lazy key hints declared: `<leader>Rs`, `<leader>Ra`, `<leader>Rb`

### Clipboard (OSC52)

- `[explicit]` `<leader>c` (normal): OSCYank operator
- `[explicit]` `<leader>cc` (normal): mapped to `c_` (as configured)
- `[explicit]` `<leader>c` (visual): OSCYank visual

### Commenting (vim-commentary)

- `[plugin default]` `gcc`: toggle comment current line
- `[plugin default]` `gc{motion}`: toggle comment motion (example: `gcap`)
- `[plugin default]` `gc` (visual): toggle selected lines
- `[plugin default]` `:Commentary`: command for line/range

### Other

- `[explicit]` `<leader>U`: toggle Undotree
- `[explicit]` `<leader>aa`: opencode ask with `@this`
- `[explicit]` `<leader>aA`: opencode select action
- `[explicit]` `<leader>al`: opencode operator for range
- `[explicit]` `<leader>all`: add current line to opencode
- `[explicit]` `<leader>rl`: lazy-reload plugin prompt
- `[explicit]` `<leader>?`: which-key buffer-local keymap popup
- `[explicit]` `ga.`: text-case telescope

## Notes About Conflicts and Overrides

- `<C-p>`, `<C-n>`, `<C-e>` are shared by Blink/Copilot in insert context. Effective behavior depends on whether Blink completion is active and fallback chain execution.
- `gr` and `gd` are explicitly remapped to Telescope pickers, overriding common built-in LSP defaults.
- `]c` / `[c` are used by gitsigns with a diff-mode fallback to built-in behavior.
