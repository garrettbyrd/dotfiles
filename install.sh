#!/usr/bin/env bash
set -euo pipefail

# Dotfiles dependency installer
# Supports: Fedora/RHEL/Rocky (dnf), Ubuntu/Debian (apt), macOS (brew)

info() { printf '\033[0;34m%s\033[0m\n' "$*"; }
warn() { printf '\033[0;33m%s\033[0m\n' "$*"; }
err()  { printf '\033[0;31m%s\033[0m\n' "$*" >&2; exit 1; }

command_exists() { command -v "$1" &>/dev/null; }

# Detect package manager
if command_exists dnf; then
    PM="dnf"
    INSTALL="sudo dnf install -y"
elif command_exists apt-get; then
    PM="apt"
    INSTALL="sudo apt-get install -y"
elif command_exists brew; then
    PM="brew"
    INSTALL="brew install"
else
    err "No supported package manager found (dnf, apt, brew)"
fi

info "Detected package manager: $PM"

# --- stow ---
if command_exists stow; then
    info "stow: already installed"
else
    info "Installing stow..."
    $INSTALL stow
fi

# --- homebrew (Linux only, needed for some packages) ---
if [[ "$(uname)" == "Linux" ]] && ! command_exists brew; then
    info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# --- ghostty ---
if command_exists ghostty; then
    info "ghostty: already installed ($(ghostty --version 2>/dev/null | head -1))"
else
    info "Installing Ghostty..."
    if [[ "$PM" == "apt" ]]; then
        sudo snap install ghostty --classic
    elif [[ "$PM" == "dnf" ]]; then
        sudo snap install ghostty --classic
    elif [[ "$PM" == "brew" ]]; then
        brew install --cask ghostty
    fi
fi

# --- starship ---
if command_exists starship; then
    info "starship: already installed ($(starship --version | head -1))"
else
    info "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# --- uv ---
if command_exists uv; then
    info "uv: already installed ($(uv --version))"
else
    info "Installing uv..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# --- JetBrains Mono Nerd Font ---
if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd"; then
    info "JetBrains Mono Nerd Font: already installed"
else
    info "Installing JetBrains Mono Nerd Font..."
    if command_exists brew; then
        brew install --cask font-jetbrains-mono-nerd-font
    else
        FONT_DIR="${HOME}/.local/share/fonts"
        mkdir -p "$FONT_DIR"
        TMPDIR=$(mktemp -d)
        curl -fsSL -o "$TMPDIR/jbmono.tar.xz" \
            "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz"
        tar -xf "$TMPDIR/jbmono.tar.xz" -C "$FONT_DIR"
        rm -rf "$TMPDIR"
        fc-cache -f
    fi
fi

info ""
info "Done! Next steps:"
info "  cd ~/dotfiles"
info "  stow ghostty starship bash"
info "  mkdir -p ~/.bashrc.d  # add private.sh for machine-specific aliases"
