##  ~/.bashrc.d/ module  #############################################

if [ -n "${ENABLE_PODMAN}" ]; then

    if systemctl --user is-enabled podman.socket &>/dev/null; then
        export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.socket
    fi

    export PODMAN_COMPOSE_PROVIDER="podman"

fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
