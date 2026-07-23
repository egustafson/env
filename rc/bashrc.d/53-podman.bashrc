##  ~/.bashrc.d/ module  #############################################

## TODO: add a guard so below doesn't clober docker if it's also in use.

if systemctl --user is-enabled podman.socket &>/dev/null; then
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.socket
fi

## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
