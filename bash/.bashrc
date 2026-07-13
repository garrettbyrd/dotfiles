# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
PATH="$HOME/.deno/bin:$PATH"
export PATH

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# ghostty theme switching (reload via dbus since snap lacks inotify)
ghostty-reload() { gdbus call --session --dest com.mitchellh.ghostty --object-path /com/mitchellh/ghostty --method org.gtk.Actions.Activate 'reload-config' '[]' '{}' > /dev/null 2>&1; }
alias theme-night="sed -i 's/^theme = .*/theme = Amber/' ~/.config/ghostty/config && ghostty-reload"
alias theme-day="sed -i 's/^theme = .*/theme = TokyoNight/' ~/.config/ghostty/config && ghostty-reload"

# ssh (set TERM for remote hosts that lack ghostty terminfo)
alias ssh='TERM=xterm-256color command ssh'

# starship
eval "$(starship init bash)"

# uv
eval "$(uv generate-shell-completion bash)"
eval "$(uvx --generate-shell-completion bash)"

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# gcloud
if [ -f "$HOME/packages/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/packages/google-cloud-sdk/path.bash.inc"; fi
if [ -f "$HOME/packages/google-cloud-sdk/completion.bash.inc" ]; then . "$HOME/packages/google-cloud-sdk/completion.bash.inc"; fi
