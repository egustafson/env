##  ~/.bashrc.d/ module  #############################################

## Secrets

if [ "$SHLVL" -le 1 ] && [ -n "$VIALAP" ]; then
   if [ -d ~/.password-store ]; then

      export VIASAT_MCP_JIRA_TOKEN="$(pass mcp/jira-claude)"

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
