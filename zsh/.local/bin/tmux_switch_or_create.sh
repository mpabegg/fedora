# vim: set filetype=zsh :
#!/bin/bash

# Get session name from argument or fzf selection
session_name=$1
if [ -z "$session_name" ]; then
    session_name=$(tmux ls | awk -F: '{print $1}' | \
        fzf-tmux --prompt="🖥  Switch Session: " -p -w 62% -h 38% --border --reverse)
fi

# Exit if no session selected
[ -z "$session_name" ] && exit 0

# Create session if it doesn't exist
tmux has-session -t "$session_name" 2>/dev/null || \
    tmux new-session -d -s "$session_name"

# Connect to session
if [ -n "$TMUX" ]; then
    tmux switch-client -t "$session_name"
else
    tmux attach-session -t "$session_name"
fi
