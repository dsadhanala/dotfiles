# The following lines were added by Docker Desktop to add commands to your PATH.

# Centralized secrets (git-ignored, not committed)
[ -f "$HOME/.secrets" ] && source "$HOME/.secrets"

# Machine/corp-local config (git-ignored, not committed)
[ -f "$HOME/.localrc" ] && source "$HOME/.localrc"

export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

# folders
alias wsp='cd ~/dev/workspace'
alias hz_dir='cd ~/dev/workspace/hz-bazel'
alias x='cd ~/workspace/hz-bazel/apps/project-x/web'
alias opr='codium ~/.bash_profile'
alias upr='. ~/.bash_profile'

alias sf='defaults write com.apple.Finder AppleShowAllFiles true && killall Finder'
alias hf='defaults write com.apple.Finder AppleShowAllFiles false && killall Finder'

# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home
export BIN=~/bin
export PATH=$BIN:$PATH

alias killport='lsof -i:8989 && kill -9 $(lsof -t -i:8989)'
alias killPx='lsof -i:8080 && kill -9 $(lsof -t -i:8080)'
alias killBazelPorts='pkill -9 -f "bazel.*hz-bazel"'

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
# alias ta='tmux attach -t'
# alias tnew='tmux new -s dps '
alias tls='tmux ls'
# alias tkill='tmux kill-session -t'
# alias tmxN='tmux new -s LocalMac'
# alias tmxA='tmux a -t LocalMac' # -t DevDesk
alias tm='tmux attach || tmux new -s LocalMac'
alias tk='tmux kill-session -t'

# convenience aliases for editing configs
alias ev='codium ~/.vimrc'
alias et='codium ~/.tmux.conf'
alias ez='codium ~/.zshrc'

alias vup='vim -i NONE -c VundleUpdate -c quitall'

# day to day work
alias update='git pull && rush update && rush start:project-x'
alias removePrunedLocalBranches='git fetch --prune && git branch -d -r'
alias unmergedLocalBranches='git branch --no-merged'
alias findMergedBranches='git branch --merged | grep -v "\*" | xargs -n 1 echo'
# alias removeMergedLocalBranches='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias findGoneBranches='git branch -vv | grep ": gone]" | awk "{print $1}"'
alias removeGoneLocalBranches='findGoneBranches | awk "{print $1}" | xargs -n 1 git branch -d'

export PATH=$PATH:/opt/homebrew/bin

# export NVM_DIR="$HOME/.nvm"
#   . "$(brew --prefix nvm)/nvm.sh"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

alias olm=ollama
alias ollamaChangePort='launchctl setenv OLLAMA_HOST "0.0.0.0:8080"'
alias g=gollama # link ollama models to LM Studio
export OLLAMA_ORIGINS="*"

function recentCommits() {
    local num=${1:-9}  # Default to 9 if no parameter provided
    echo "Your last $num commits:"
    echo "-------------------"
    git log -"$num" --pretty=format:"%C(yellow)%h%Creset %C(green)(%cr)%Creset%n%B" --author="$(git config user.name)" --no-merges |
    while IFS= read -r line; do
        if [[ $line =~ ^[a-f0-9]{7} ]]; then
            echo -e "\n• $line"
        elif [[ $line =~ ^(feat|fix|docs|style|refactor|test|chore|perf)\(.*\): ]]; then
            echo "  %C(blue)$line%Creset"
        else
            echo "  $line"
        fi
    done
}

function keepWake() {
    local hours=$1
    if [[ -z "$hours" ]]; then
        echo "Usage: keepWake <hours>"
        echo "Example: keepWake 2 (keeps system awake for 2 hours)"
        return 1
    fi

    local seconds=$(( hours * 3600 ))
    echo "Keeping system awake for $hours hours"
    caffeinate -u -t $seconds
}

alias hzClean='git clean -fdx -e "common/temp" -e "**/node_modules" -e "**/.rush" -e "**/.cache"; rush purge; rush update && rush build --to project-x'

# review this file and looks for opportunities to improve code quality. Find any redundant, duplicate or unused code and remove it. Make sure to document the code using clean and easy to read comments.

unalias hz 2>/dev/null || true
hz() {
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Not inside a git repository"
    return 1
  }
  "$repo_root/tools/hz" "$@"
}
# alias cleanHZ='git clean -fdx -e "common/temp" -e "**/node_modules" -e "**/.rush" -e "**/.cache"'


# Convert images to webp
convert_to_webp() {
  # Default quality is 85, can be overridden with second parameter
  local quality=${2:-100}

  if [ -z "$1" ]; then
    echo "Usage: convert_to_webp image_path [quality]"
    return 1
  fi

  for file in "$@"
  do
    # Skip the second parameter if it's used for quality
    if [ "$file" = "$2" ] && [[ "$2" =~ ^[0-9]+$ ]]; then
      continue
    fi

    echo "Converting file: $file"
    ext=${file##*.}
    cwebp -q $quality "$file" -o "${file/%.$ext/.webp}"
  done
}

git config --global alias.fetchmerge '!f() {
  set -e
  git fetch origin "$1"
  echo "Merging tag $1 -> commit $(git rev-parse "$1")"
  git merge "$1"
}; f'

# git config --unset-all remote.origin.fetch && git config --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
# git fetch origin && git checkout <you>/<branch>

#sudo defaults write /Library/Preferences/com.paloaltonetworks.GlobalProtect.settings.plist '{"Palo Alto Networks" ={GlobalProtect={Settings={default-browser=yes;};};};}'

# MCP env vars

# Secrets for ~/.agents/mcp-servers/mcp.json, referenced there as ${VAR}
# placeholders and resolved by scripts/lib/sync_mcp.py at sync time.

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section

# Claude Code setup using AWS Bedrock
# export AWS_BEARER_TOKEN_BEDROCK="${AWS_BEARER_TOKEN_BEDROCK}"  # set in ~/.secrets if used
# export CLAUDE_CODE_USE_BEDROCK=1
# export AWS_REGION=us-west-2  # or your preferred region

# Optional: Disable prompt caching if needed
# export DISABLE_PROMPT_CACHING=0

# export CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192
# export MAX_THINKING_TOKENS=2048

# sonnet 4.5
# Optional: Override the region for the small/fast model (Haiku)
# export ANTHROPIC_SMALL_FAST_MODEL_AWS_REGION=us-west-2
# export ANTHROPIC_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0'
# export ANTHROPIC_SMALL_FAST_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'
# export ANTHROPIC_DEFAULT_HAIKU_MODEL='us.anthropic.claude-3-5-haiku-20241022-v1:0'
# export ANTHROPIC_DEFAULT_OPUS_MODEL='us.anthropic.claude-opus-4-20250514-v1:0'
# export ANTHROPIC_DEFAULT_SONNET_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0'
# export CLAUDE_CODE_SUBAGENT_MODEL='us.anthropic.claude-sonnet-4-5-20250929-v1:0'

# Convert video to webp - change size 800:600 if needed
# ffmpeg -i imagetovideo-shoe-after.mp4 -vcodec libwebp -filter:v fps=fps=20 -lossless 1 -loop 0 -preset default -an -vsync 0 -s 800:600 edit-image-to-video_hover.webp

alias ipx="NODE_OPTIONS=--max-old-space-size=12288 ibazel run //apps/project-x/web:rspack_bundle_dev.serve"
alias px="NODE_OPTIONS=--max-old-space-size=12288 bazel run //apps/project-x/web:rspack_bundle_dev.serve --watch" #--config=typecheck
alias as="lsof -ti:7001 | xargs kill -9 && bazel run //services/ai-assistant-service:start --watch"
alias sbXA="NODE_OPTIONS=--max-old-space-size=12288 bazel run //apps/project-x/features/x-assistant:storybook_FP --watch"

# bazel query //features/image-section:all
# bazel query 'kind(test, //features/image-section:all)'
# bazel query 'tests(//features/image-section/...)' --output=label_kind

# specific file readable side-by-side diff:
# git diff main --color-words -- src/implementation/onboarding/components/x-masonry-grid/MasonryGrid.ts

# all changes
# git diff main -- .

# summary of changes in specific package
# git diff main --stat -- .

# GARAGE SPRINT 2025

# Fetch only the 'green' tag from origin and merge it into current branch
function mergeGreen() {
  echo "Fetching 'green' tag from origin..."
  git fetch origin tag green --no-tags --force
  echo "Merging tag 'green' (commit: $(git rev-parse green))..."
  git merge green -m "Merge green tag into $(git branch --show-current)"
}

# Clean up all local tags except green
function cleanTags() {
  git tag | grep -v '^green$' | xargs git tag -d
  echo "Kept only 'green' tag locally"
}
unalias openCoverage 2>/dev/null || true
openCoverage() {
  local repo_root
  repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
    echo "Not inside a git repository"
    return 1
  }
  open "$repo_root/bazel-testlogs/features/image-section/wtr_test/test.outputs/coverage-wtr/index.html"
}

function reviewCheck() {
  bazel run //:codeowners -- --pr $1
}

alias auggie='auggie --model prism-a'

export ADB=$HOME/Library/Android/sdk/platform-tools/adb

# jira_local_mcp_token same for WIKI_MCP_TOKEN

# export video with 2x speed. usage `vsx input.mp4 -o output.mp4 -s 2 --gpu  -y`
alias vsx='/usr/local/bin/video_speed_x_cli.sh'

# generate docx from md
function generateDocx() {
  pandoc  $1 -o $2 --toc --toc-depth=2 -f gfm -t docx
}
