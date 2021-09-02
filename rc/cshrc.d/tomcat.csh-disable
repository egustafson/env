# I am a -*- shell-script -*-
#

## Tomcat (Catalina)
##
if ( ! $?CATALINA_HOME ) setenv CATALINA_HOME /opt/tomcat
if ( -d ${CATALINA_HOME} ) then
    set path = ( $path ${CATALINA_HOME}/bin )
else 
    unsetenv CATALINA_HOME
endif
