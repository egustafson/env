##  ~/.bashrc.d/ module  #############################################

if [ "$SHLVL" -le "1" ]; then
    docker=$(command -v docker)
    if [ -x "$docker" ]; then
        is_podman=$($docker version 2>&1 | grep -i podman | wc -l)
    else
        podman=$(command -v podman)
        if [ -x "$podman" ]; then
            is_podman="1"
        fi
    fi
fi

if [ "$is_podman" -ge "1" ]; then
    #
    # Tiltfile has problems, disable devkit
    #
    export DOCKER_BUILDKIT=0
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
