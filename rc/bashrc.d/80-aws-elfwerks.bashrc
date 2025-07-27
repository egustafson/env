##  ~/.bashrc.d/ module  #############################################

# Enable by defining $ELFWERKS_WORKSTATION in .bashrc-local
#

if [[ -n "$ELFWERKS_WORKSTATION" && "$0" == -* ]]; then

    export AWS_ACCESS_KEY_ID=$(pass aws/ericg/access-id)
    export AWS_SECRET_ACCESS_KEY=$(pass aws/ericg/access-secret)

fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
