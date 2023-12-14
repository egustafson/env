# I am a csh -*- shell-script -*-

set kubectl = `which kubectl`
if ($?loginsh && -x "${kubectl}") then
    alias kc source ~/bin/kc.csh
endif
