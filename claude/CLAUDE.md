# Claude Code Preferences

## Style
- Concise responses — no padding, no trailing summaries of what was just done
- No emojis
- No multi-paragraph docstrings or comment blocks; one short line max
- No comments explaining what code does — only why, when non-obvious
- Default to writing no comments at all

## Code
- Match the style and conventions of the surrounding code
- No speculative abstractions or premature generalisation
- No error handling for things that can't happen
- Shell scripts must be shellcheck-clean

## Workflow
- Prefer editing existing files over creating new ones
- Don't create docs or READMEs unless explicitly asked
- No backwards-compatibility shims for removed code — delete it cleanly

## Environment
- macOS, zsh, neovim, tmux
- Homebrew for package management
