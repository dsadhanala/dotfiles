# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

# Setting PATH for Python 3.5
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}"
export PATH
alias hz='$(git rev-parse --show-toplevel)/tools/hz'

# Created by `pipx` on 2025-04-11 04:02:22
export PATH="$PATH:$HOME/.local/bin"
alias hz-cursor='cursor $(git rev-parse --show-toplevel)/.vscode/hz.code-workspace'
