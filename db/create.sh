#!/bin/sh

if [ "$1" = "travis" ]
then
    psql -U postgres -c "CREATE DATABASE porra_online_test;"
    psql -U postgres -c "CREATE USER porra_online PASSWORD 'porra_online' SUPERUSER;"
else
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists porra_online
    [ "$1" != "test" ] && sudo -u postgres dropdb --if-exists porra_online_test
    [ "$1" != "test" ] && sudo -u postgres dropuser --if-exists porra_online
    sudo -u postgres psql -c "CREATE USER porra_online PASSWORD 'porra_online' SUPERUSER;"
    [ "$1" != "test" ] && sudo -u postgres createdb -O porra_online porra_online
    sudo -u postgres createdb -O porra_online porra_online_test
    LINE="localhost:5432:*:porra_online:porra_online"
    FILE=~/.pgpass
    if [ ! -f $FILE ]
    then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE
    then
        echo "$LINE" >> $FILE
    fi
fi
