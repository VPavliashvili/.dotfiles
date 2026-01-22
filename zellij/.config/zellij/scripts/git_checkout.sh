#!/usr/bin/env bash

fzf_window() {
   git branch -a --format='%(refname:short)' | fzf --reverse --no-sort --border "rounded" --info inline --pointer "→" --prompt "Branch > " --header "Select branch" --preview "git show --color=always {1}" --preview-label " Last Commit Changes " --bind "ctrl-u:preview-page-up,ctrl-d:preview-page-down" --bind "ctrl-j:preview-down,ctrl-k:preview-up"
}


if git rev-parse --is-inside-work-tree &>/dev/null; then
    selected=$(fzf_window)
    selected="${selected#origin/}"

    if [ -z "$selected" ]; then
        notify-send "nothing was selected"
        exit 0
    fi

    output=$(git checkout $selected 2>&1)
    if [ $? -ne 0 ]; then
        zellij run -c --floating -- bash -c "
            echo -e '\033[1;31mFailed to checkout branch:\033[0m'
            echo
            echo '$output'
            echo
            read -n 1 -s -p 'Press any key to close...'
        "

        exit 0
    fi

    notify-send "checked out to: $selected"
else
    zellij run -c --floating -- bash -c "
        echo -e '\033[1;31mNot in a git directory\033[0m'
        read -n 1 -s -p 'Press any key to close...'
    "
fi
