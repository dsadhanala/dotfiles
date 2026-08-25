# linux/

Linux-only dotfiles. `install.sh` links the contents of this folder into place
only when `uname -s` is `Linux`.

Currently empty: `.tmux.conf` lives in `../shared/` and handles the macOS/Linux
clipboard difference internally via `if-shell`. Add files here only when a
config has no shared form and is Linux-specific (e.g. `config/` app configs that
differ from macOS).
