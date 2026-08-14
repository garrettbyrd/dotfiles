# dotfiles

Terminal setup managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package    | What it configures                              |
|------------|-------------------------------------------------|
| `bash`     | Shell config (starship, ghostty themes, uv, lsd) |
| `ghostty`  | Terminal emulator (Tokyo Night + custom Amber)   |
| `lsd`      | `ls` replacement with icons and git status       |
| `starship` | Minimal two-line prompt                          |

## Setup

```bash
# Install dependencies
./install.sh

# Clone and symlink configs
git clone git@github.com:garrettbyrd/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow ghostty starship bash lsd

# Add machine-specific aliases (SSH hosts, API keys, etc.)
mkdir -p ~/.bashrc.d
# then drop machine-specific aliases into ~/.bashrc.d/private.sh
```

## File listing

`ls` is aliased to [lsd](https://github.com/lsd-rs/lsd) (icons need a Nerd Font, which
`install.sh` handles).

```bash
ll    # long view w/ git status
la    # all, excluding . and ..
lla   # long + all
lt    # tree, 2 levels deep
```

## Theme switching

```bash
theme-day    # Tokyo Night
theme-night  # Amber (retro phosphor)
```
