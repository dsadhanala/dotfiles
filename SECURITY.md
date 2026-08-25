# Security notes

## Golden rule

Secrets and any machine/corp-local config never enter this public repo. They
live in `local/` (git-ignored) and are symlinked into place by `install.sh`.
Committed files reference secrets via `${ENV_VAR}` placeholders.

## The `local/` directory (private)

Everything sensitive is consolidated in `local/`, which the public repo
ignores. Manage it as a **separate private repo** (see `local/README.md`):

| `local/` file       | Symlinked to                  |
|---------------------|-------------------------------|
| `secrets`                  | `~/.secrets` (chmod 600)             |
| `localrc`                  | `~/.localrc`                         |
| `gitconfig.local`          | `~/.gitconfig.local`                 |
| `ssh-config`, `npmrcs/`    | `~/.ssh/config`, `~/.npmrcs/`        |
| `claude-settings.json`     | `~/.claude/settings.json`            |
| `zed-context-servers.json` | merged into `~/.config/zed/settings.json` |

Shell rc files source `~/.secrets` and `~/.localrc`; `.gitconfig` `[include]`s
`~/.gitconfig.local`.

## Before adding ANY new file

```bash
grep -rinE 'token|secret|password|api[_-]?key|AKIA|BEGIN .*PRIVATE KEY|oauth' <file>
```

If it has real values or corp identifiers (hostnames, internal URLs, emails,
usernames, project codenames), put the real file in `local/` and commit only a
generic template or `${ENV_VAR}` placeholder version.

## Secret scanning (enforced)

A `pre-commit` hook runs `gitleaks` against staged changes and blocks commits
that contain secrets. `install.sh` installs it. Enable the tool with:

```bash
brew install gitleaks
```

## Excluded from the repo (machine-local / credentials)

`~/.ssh/`, `~/.aws/`, `~/.gnupg/`, `~/.git-credentials`, `~/.netrc`,
`~/.vault-token`, `~/.config/gh/hosts.yml`, `~/.config/gcloud/`, all `*.env`
files, Android emulator tokens, shell history, and `.zcompdump*`.

## Migration notes (one-time)

Secrets, corp env vars, and token-bearing shell aliases were moved out of the
shell configs into `local/secrets` and `local/localrc`; commented/dead copies
were deleted. Pre-scrub backups remain on the machine — delete once verified:

```bash
rm ~/.bash_profile.pre-scrub.* ~/.zshrc.pre-scrub.*
```

## IMPORTANT: rotate previously-exposed credentials

This repo has public history. **Rotate any token that was ever committed** (a
live API key was found and removed during migration). Review history before
pushing:

```bash
gitleaks git ~/dotfiles
```
