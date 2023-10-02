#!/bin/bash

BINLOG_INFO=$(docker compose exec -it master bash -c "chmod +x /opt/scripts/*; bash -c /opt/scripts/status.sh");

export SOURCE_FILE=`echo "${BINLOG_INFO}" | grep "File:" | awk '{print $2}'`;
export SOURCE_POS=`echo "${BINLOG_INFO}" | grep "Position:" | awk '{print $2}'`;

envsubst < ./slave/scripts/replication.base.sh > ./slave/scripts/replication.sh;

unset SOURCE_FILE;
unset SOURCE_POS;
