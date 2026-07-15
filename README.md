# Shell Settings

My personal shell settings, heavily customised and refined over the years.

## Zsh Load Order

Global: zshenv -> zprofile -> zshrc -> zlogin

None:
* zshenv

Login Only:
* zshenv -> zprofile -> zlogin

Interactive Only:
* zshenv -> zshrc

Login + Interactive:
* zshenv -> zprofile -> zshrc -> zlogin

## Understanding Login + Interactive

* New gnome-terminal: interactive
* New tmux: login + interactive
* New ssh: login + interactive
* ssh <cmd>: none
* ./script: none

## Arch & Zsh

Arch in a very annoying decision resets your `PATH` after sourcing `.zshenv`,
forcing you to set your `PATH` in `.zprofile` or `.zshrc`. We work around this
by sourcing `.shenv` to set the `PATH` from both `.zshenv` and `.zprofile`, but
observing if this isn't a login shell to ensure only one of them fires.

## Large Repos

`gitconfig_template` enables settings that speed up big working trees and deep
histories (also applied to `~/.gitconfig` directly, since the template isn't
auto-symlinked):

* `core.fsmonitor` + `core.untrackedCache` — an FSEvents-backed monitor so
  `status`/`add`/`commit` stop rescanning the whole tree.
* `index.version = 4` + `index.skipHash` — a leaner, faster index.
* `fetch.writeCommitGraph` — keeps the commit-graph fresh for fast
  `log`/`blame`/`merge-base`; `fetch.prune` tidies deleted remote branches.

Two bigger levers are per-repo and operational, not config — run them in the
large repos themselves:

* Background maintenance (prefetch + commit-graph hourly, repack daily):

  ```sh
  cd /path/to/big-repo
  git maintenance start          # register + schedule (launchd on macOS)
  # git maintenance stop / unregister to undo
  ```

* For very large monorepos, clone only what you need:

  ```sh
  git clone --filter=blob:none <url>       # partial clone: fetch blobs on demand
  git sparse-checkout set --cone <dirs>    # check out only the paths you work in
  ```

## Licensing

This library is BSD-licensed.

## Authors

This library is written and maintained by [David
Terei](mailto:code@davidterei.com).
