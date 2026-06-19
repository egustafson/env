##  ~/.bashrc.d/ module  #############################################

## Secrets

if [ "$SHLVL" -le 1 ] && [ -n "$VIALAP" ]; then
   if [ -d ~/.password-store ]; then

       export JIRA_API_TOKEN="$(pass mcp/jira-claude)"
       export CONFLUENCE_TOKEN="$(pass mcp/confluence-wiki)"
       export GH_ENTERPRISE_TOKEN="$(pass viasat/github/personal_token_claude)"
       export GH_HOST="git.viasat.com"



   else
     echo "WARN: no ~/.password-store, secrets not set in ~/.bashrc.d/91-viasat-claude.bashrc"
   fi
fi

## Node to support Playwright

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
