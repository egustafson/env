##  ~/.bashrc.d/ module  #############################################

kubectl=$(command -v kubectl)
if [ "$SHLVL" -le "1" ] && [ -x "$kubectl" ]; then
    alias kc="source ~/bin/kc.bash"
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
