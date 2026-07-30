##  ~/.bashrc.d/ module  #############################################
#
# Install Node Version Manager (NVM) with:
# > curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

if [ -d ~/.nvm ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
