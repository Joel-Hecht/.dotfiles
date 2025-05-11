#!bin/bash

alias outlook="firefox --new-window  https://outlook.office365.com/mail &"
alias teams="firefox --new-window  https://teams.microsoft.com/v2/ &"
alias tumblr="firefox --new-window  https://www.tumblr.com &"
alias fencing="firefox --new-window --profile "$(realpath $HOME/.mozilla/firefox/*\.Drexel\ Fencing | sed -e 's/ /\\ /')" & " #uses profile specific to Joe desktop, dont use
alias keychron="chromium 'https://launcher.keychron.com' &"
alias slack="flatpak run com.slack.Slack &"
alias pinta="flatpak run com.github.PintaProject.Pinta &"
