# dotfiles

Reusable, version-controlled configuration for macOS and Linux.

## Layout

```
shared/          linked on every OS
  .gitconfig .gitignore_global .hgignore_global
  .vimrc  .vim/                       (colors, abbreviations, vundles)
  .zshenv .zprofile .zshrc .bashrc .bash_profile
  .tmux.conf                          (OS-aware: clipboard auto-detected via uname)
  config/git/ignore
  config/gh/config.yml                (NOT hosts.yml — holds an OAuth token)
  config/zed/keymap.json
  config/zed/settings.json            (MCP-free base; corp MCP merged in from local/ at install)

macos/           linked only on macOS
  tmux_colors.sh  Monokai.terminal
  config/karabiner/karabiner.json

linux/           linked only on Linux (add Linux-only files here as needed)

vscodium/        editor config (OS-correct user dir chosen by install.sh)
  settings.json  keybindings.json  argv.json
  extensions.txt                      (install list)

local/           git-ignored — all secrets/corp/identity (SEPARATE private repo)
  secrets  localrc  gitconfig.local  ssh-config  npmrcs/
  zed-context-servers.json  claude-settings.json
scripts/merge-zed.py                  (merges Zed base + local MCP at install)

.gitconfig.local.template             (generic identity placeholder)
install.sh  hooks/pre-commit  .gitleaks.toml
```

Why the OS split: some configs genuinely differ per OS (karabiner is
macOS-only, VSCodium's user dir path). `install.sh` detects the OS via `uname`
and links `shared/` plus the matching folder.

`.tmux.conf` is shared: the only OS-specific part (clipboard — `pbcopy`/`pbpaste`
on macOS vs `xclip`/`xsel` on Linux) is handled inside the file with `if-shell`
blocks that tmux auto-selects by `uname`. Comment out a block to force one OS.

## Install on a new machine

```bash
git clone git@github.com:dsadhanala/dotfiles.git ~/dotfiles
git clone <your-private-adobe-repo> ~/dotfiles/local   # secrets/corp config
cd ~/dotfiles
./install.sh
cat vscodium/extensions.txt | xargs -L1 codium --install-extension
```

If you don't have the private repo yet, `install.sh` still links everything
else; create `local/` from the templates in `local/*.template`.

## Secrets & corp config

Everything sensitive lives in the git-ignored `local/` directory (managed as a
separate private repo — see [local/README.md](local/README.md)). Shell rc files
source it via:

```bash
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"     # -> local/secrets
[ -f "$HOME/.localrc" ] && source "$HOME/.localrc"     # -> local/localrc
```

Nothing in `local/` is ever committed to this public repo. See
[SECURITY.md](SECURITY.md).

## Prerequisites

- **oh-my-zsh** (framework installed separately; not vendored here):
  `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`
- **tmux TPM:** `git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`
- **vim Vundle:** `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`
- **gitleaks** (pre-commit secret scanning): `brew install gitleaks`
