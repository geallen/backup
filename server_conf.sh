#!/bin/bash

CPU_PROCESSORS=$(cat /proc/cpuinfo | grep "cpu cores" | wc -l)

CPU_CORES=$(grep "cpu cores" /proc/cpuinfo |sort -u |cut -d":" -f2)

WORKERS=$((CPU_CORES * CPU_PROCESSORS* 2 + 1))

SERVERCONF=~/aa/server/config/repo/server.conf

sed -i 's/.*gunicorn_bind=localhost:..*/gunicorn_bind=0.0.0.0:17010/' $SERVERCONF

sed -i "s/.*gunicorn_workers=.*/gunicorn_workers=$WORKERS/g" $SERVERCONF
