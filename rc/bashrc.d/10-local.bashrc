##  ~/.bashrc.d/ module  #############################################
#
# 10-local.bashrc

export LOCAL_HOME="/--disable--/var/local/${USER}"

if [ ! -d "${LOCAL_HOME}" ]; then
    # --> handle no local home
    LOCAL_HOME="${HOME}/.local"
else
    # LOCAL_HOME exists

    # Override XDG paths
    export XDG_CACHE_HOME="$LOCAL_HOME/.cache"
    export XDG_CONFIG_HOME="$LOCAL_HOME/.config"
    export XDG_DATA_HOME="$LOCAL_HOME/.data"
    export XDG_STATE_HOME="$LOCAL_HOME/.state"

    # Tool specific Overrides

    # CARGO_HOME
    # GOPATH
    # ...
fi


## Local Variables:
## mode: shell-script
## sh-shell: bash
## End:
