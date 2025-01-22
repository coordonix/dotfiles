alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias rzone="rm *:Zone.I*"

### git ###
alias gst="git status"
alias ga="git add"
alias ga.="git add . --all"
alias gcm="git commit -m"
alias gcmb="git commit -m \"Blank Commit Message\""
alias gpush="git push"
alias gpull="git pull"
alias gsave='f() {
less ~/resources/gitsave.notes
read -p "Enter commit message: " msg
ga. && gcm "$msg" && gpush
}; f'

### convenience ###
alias aliases="vim $HOME/.bash_aliases"
alias vimrc="vim $HOME/.vimrc $HOME/.vimrc.local -O"
alias bashrc="vim $HOME/.bashrc $HOME/.bashrc.local -O"
