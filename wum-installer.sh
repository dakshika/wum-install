#!/bin/sh
{
    #check the machine architecture
    MACHINE_TYPE=`uname -m`
    if [ ${MACHINE_TYPE} = x86_64 ]; then
       WUM_URL="http://product-dist.wso2.com/downloads/wum/1.0-beta/wum-1.0-beta-linux-x64.tar.gz"
    else
       WUM_URL="http://product-dist.wso2.com/downloads/wum/1.0-beta/wum-1.0-beta-linux-i586.tar.gz"
    fi

    #remove previously logged sessions
    sudo -k

    echo "This installation script requires superuser access."
    echo "You will be prompted to enter sudo password."

    #run with sudo
    sudo sh <<SCRIPT

    #install tarball into
    rm -fr /usr/local/wum
    cd /usr/local/

    if [ -z "$(which wget)" ]; then
        curl -s $WUM_URL --progress-bar | tar xz
    else
        wget -qO- $WUM_URL --show-progress | tar xz
    fi

SCRIPT

     #add simple PATH reminder
     case "$PATH" in
          */usr/local/wum/bin*)
            echo "WSO2 update manager installed successfully"
            ;;
          *)
            echo "Add the WUM to your PATH using:"
            echo "$ export PATH=\$PATH:/usr/local/wum/bin"
            ;;
        esac
}