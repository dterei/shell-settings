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

## Licensing

This library is BSD-licensed.

## Authors

This library is written and maintained by [David
Terei](mailto:code@davidterei.com).
