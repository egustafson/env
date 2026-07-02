##  ~/.bashrc.d/ module  #############################################

# Enable with:  $ENABLE_ELFHOST in .bashrc-local
#
if [ -n "${ENABLE_ELFHOST}" ] && [ -x ~/.opencode/bin/opencode ]; then

    export PATH=$PATH:$HOME/.opencode/bin

    if ! command -v pass &> /dev/null; then
        echo "'pass' command not found and opencode needs keys"
    elif ! pass &> /dev/null; then
        echo "no 'pass' database present, opencode needs keys"
    else
        export OPENAI_API_BASE=https://openrouter.ai/api/v1
        export OPENAI_API_KEY=$(pass ai/OPENROUTER_API_KEY)
        export OPENROUTER_API_KEY=$(pass ai/OPENROUTER_API_KEY)
    fi

fi
## Local Variables:
## mode: shell-script
## sh-shell: bash
#@ End:
