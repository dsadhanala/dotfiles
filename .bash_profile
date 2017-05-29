# folders
alias wsp='cd ~/workspace'
alias opr='vim ~/.bash_profile'
alias upr='. ~/.bash_profile'

alias sf='defaults write com.apple.Finder AppleShowAllFiles true && killall Finder'
alias hf='defaults write com.apple.Finder AppleShowAllFiles false && killall Finder'

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home
export BIN=~/bin
export PATH=$BIN:$PATH

alias killport='lsof -i:8989 && kill -9 $(lsof -t -i:8989)'

# git alias
alias sa='alias | grep'
alias gda='git add . -A; git stash --all; git stash drop'
alias gci='git clean -n -d -x'
alias gca='git clean -df; git checkout -- .'
alias gdb='git push origin --delete'
alias gfp='git fetch --all --prune'

# check status from all packages
alias gstatus='find . -name ".git" -type d | sed "s/\/.git//" | xargs -P10 -I{} git -C {} status \';
#alias gstatus='find . -type d -depth 1 -exec echo git --git-dir={}/.git --work-tree=$PWD/{} status \';
alias gfetch='find . -name ".git" -type d | sed "s/\/.git//" | xargs -P10 -I{} git -C {} fetch origin/master';
alias gpull='find . -name ".git" -type d | sed "s/\/.git//" | xargs -P10 -I{} git -C {} pull --rebase';

# aliases for Tmux
#alias tmux='tmux -2'
alias ta='tmux attach -t'
alias tnew='tmux new -s'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'
alias tmxN='tmux new -s LocalMac'
alias tmxA='tmux a -t LocalMac' # -t DevDesk
alias tm='tmux attach || tmux new'
alias tk='tmux kill-session -t'

# convenience aliases for editing configs
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'
alias ez='vim ~/.zshrc'

alias vup='vim -i NONE -c VundleUpdate -c quitall'

export NVM_DIR="$HOME/.nvm"
  . "$(brew --prefix nvm)/nvm.sh"
