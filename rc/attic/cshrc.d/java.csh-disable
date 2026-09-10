# I am a -*- shell-script -*-
#

## JAVA_HOME
##
if ( ! $?JAVA_HOME ) setenv JAVA_HOME /opt/java
if ( -d ${JAVA_HOME} ) then
    set path = ( $path ${JAVA_HOME}/bin )
else
    unsetenv JAVA_HOME
endif

## ANT_HOME
##
if ( ! $?ANT_HOME ) setenv ANT_HOME /opt/ant
if ( -d ${ANT_HOME} ) then
    set path = ( $path ${ANT_HOME}/bin )
else
    unsetenv ANT_HOME
endif

## MVN_HOME
##
if ( ! $?MVN_HOME ) setenv MVN_HOME /opt/mvn
if ( -d ${MVN_HOME} ) then
    set path = ( $path ${MVN_HOME}/bin )
else
    unsetenv MVN_HOME
endif
