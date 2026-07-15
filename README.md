# Shell Settings

My personal shell settings, heavily customised and refined over the years.

## Files

| File | Description |
|------|-------------|
| `.shenv` | Shared env vars and PATH setup — sourced by all shells |
| `.zshenv` | Zsh: always loaded; sources `.shenv` for non-login shells |
| `.zprofile` | Zsh: login shell; sources `.shenv` |
| `.zshrc` | Zsh: interactive shell config, completions, prompt, keybindings |
| `.profile` | Bash: login shell; delegates to `.bashrc` and sets locale |
| `.bashrc` | Bash: interactive shell config, completions, prompt |
| `.aliases` | Shared aliases and shell functions (git, ls, cd, kubectl, etc.) |
| `.gitignore_global` | Global gitignore |
| `.gitconfig` | Git config (symlinked to `~/.gitconfig` by `setup.sh`) |
| `.tmux.conf` | Tmux config |
| `.ghci` / `.ghc` | GHCi config |
| `alacritty.toml` | Alacritty terminal config |
| `.scripts/` | Personal utility scripts (added to `PATH` by `.shenv`) |
| `zsh-completes/` | Extra zsh completions (symlinked to `~/.zsh/zsh-completes/`) |

## Setup

Run `setup.sh` to symlink all dotfiles into `~/`. It also:

- Links `config` → `~/.ssh/config` (machine-specific, gitignored)
- Links `alacritty.toml` → `~/.config/alacritty/alacritty.toml`
- Creates `~/.zsh/` and links `zsh-completes/` into it

Run `brew-setup.sh` on macOS to install packages via Homebrew.

## Zsh Load Order

| Context | Files loaded |
|---------|-------------|
| Always | `zshenv` |
| Login only | `zshenv` → `zprofile` → `zlogin` |
| Interactive only | `zshenv` → `zshrc` |
| Login + Interactive | `zshenv` → `zprofile` → `zshrc` → `zlogin` |

Common contexts: a new tmux window or SSH session is login+interactive; a plain terminal tab is interactive only; running a script is neither.

## Arch & Zsh

Arch resets `PATH` after sourcing `.zshenv`, forcing PATH setup into `.zprofile`. To handle this without duplicating logic, `.shenv` is sourced from both `.zshenv` (non-login) and `.zprofile` (login). Zsh also sets `typeset -U path` to deduplicate PATH entries across nested/re-sourced shells; bash deduplicates manually via `awk` at the end of `.shenv`.

## Git Config

`.gitconfig` is symlinked to `~/.gitconfig` by `setup.sh`.

**Workflow settings:**
* `pull.rebase = true` — avoids accidental merge commits on pull
* `rebase.autosquash = true` — auto-applies `fixup!`/`squash!` prefixes
* `merge.conflictstyle = zdiff3` — shows common ancestor in conflict markers
* `rerere.enabled = true` — remembers conflict resolutions across repeated rebases

**Diff:** `core.pager = delta` routes all diff output through [delta](https://github.com/dandavison/delta) for syntax-highlighted, navigable diffs (`n`/`N` between hunks).

**Large repo performance:**
* `core.fsmonitor` + `core.untrackedCache` — FSEvents-backed monitor so
  `status`/`add`/`commit` stop rescanning the whole tree.
* `index.version = 4` + `index.skipHash` — a leaner, faster index.
* `fetch.writeCommitGraph` — keeps the commit-graph fresh for fast
  `log`/`blame`/`merge-base`; `fetch.prune` tidies deleted remote branches.

Per-repo operational levers for very large repos:

```sh
git maintenance start                    # prefetch + repack on a schedule
git clone --filter=blob:none <url>       # partial clone
git sparse-checkout set --cone <dirs>    # check out only what you need
```

## Zsh Plugins

Sourced conditionally from common install paths (Homebrew ARM/Intel, Arch, Debian):

* **zsh-autosuggestions** — Fish-like inline suggestions from history; right arrow or `End` to accept
* **zsh-syntax-highlighting** — colours commands red/green as you type (sourced last, as required)

## Tools

Key tools wired up in the config:

| Tool | Wired up in | Notes |
|------|-------------|-------|
| [bat](https://github.com/sharkdp/bat) | `.shenv`, `.aliases` | `MANPAGER` for syntax-highlighted man pages; `cat` aliased to `bat` |
| [fzf](https://github.com/junegunn/fzf) | `.zshrc` | Fuzzy finder; uses `fd` for file listing and `bat` for previews |
| [zoxide](https://github.com/ajeetdsouza/zoxide) | `.zshrc` | Smart `cd`; `z <query>` jumps to frecent dirs, `zi` for interactive selection |
| [delta](https://github.com/dandavison/delta) | `gitconfig_template` | Pager for all git diff output |
| [direnv](https://direnv.net) | `.zshrc` | Per-directory env var loading |

## Licensing

BSD-licensed. Written and maintained by [David Terei](mailto:code@davidterei.com).
