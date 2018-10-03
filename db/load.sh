#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]
then
    psql -h localhost -U porra_online -d porra_online < $BASE_DIR/porra_online.sql
fi
psql -h localhost -U porra_online -d porra_online_test < $BASE_DIR/porra_online.sql
