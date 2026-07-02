##  ~/.bashrc.d/ module  #############################################

# Enable by defining $ENABLE_ELF_AWS in .bashrc-local
#
if [ "$SHLVL" -le 1 ] && [ -n "${ENABLE_ELF_AWS}" ]; then

    if ! command -v pass &> /dev/null; then
        echo "'pass' command not found and ENABLE_ELF_AWS = true"
    elif ! pass &> /dev/null; then
        echo "ENABLE_ELF_AWS is enabled"
    else

        export AWS_ACCESS_KEY_ID=$(pass aws/ericg/access-id)
        export AWS_SECRET_ACCESS_KEY=$(pass aws/ericg/access-secret)

    fi

fi
## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
