##  ~/.bashrc.d/ module  #############################################

kubectl=$(command -v kubectl)
if [ -x "$kubectl" ]; then
    alias kc="source ~/bin/kc.bash"
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
