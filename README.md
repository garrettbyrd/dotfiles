# dotfiles

Terminal setup managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package    | What it configures                              |
|------------|-------------------------------------------------|
| `bash`     | Shell config (starship, ghostty themes, uv)     |
| `ghostty`  | Terminal emulator (Tokyo Night + custom Amber)   |
| `starship` | Minimal two-line prompt                          |

## Setup

```bash
# Install dependencies
./install.sh

# Clone and symlink configs
git clone <your-repo> ~/dotfiles
cd ~/dotfiles
stow ghostty starship bash

# Add machine-specific aliases (SSH hosts, API keys, etc.)
mkdir -p ~/.bashrc.d
# then drop machine-specific aliases into ~/.bashrc.d/private.sh
```

## Theme switching

```bash
theme-day    # Tokyo Night
theme-night  # Amber (retro phosphor)
```
