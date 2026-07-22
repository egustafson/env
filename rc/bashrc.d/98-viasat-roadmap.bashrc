##  ~/.bashrc.d/ module  #############################################

# set MM_{USER,PASS} to support using a Mermaid license that is needed
# for the /Jira-Excel skill from Nathan.

if [ -n "$VIALAP" ] && [ -d ~/.password-store ]; then

    export MM_USERNAME="egustafson"
    export MM_PASSWORD="$(pass viasat/sso)"
fi

## End
