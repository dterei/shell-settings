# Claude Code Preferences

## Style
- Concise responses — no padding, no trailing summaries of what was just done
- Keep explanations, design docs and plans concise and shorter, assume you are
  explaining things to a principal engineer
- Aim for brevity
- Don't explain the motivation or context of the work in any great detail, keep
  such descriptions to a few sentences
- No emojis
- No comments explaining what code does — only why, when non-obvious

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
