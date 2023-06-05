#!/usr/bin/env bash
VDIR="/home/pojos"
while true; do
 $VDIR/bin/vault server -config $VDIR/vault/vault.hcl -log-rotate-max-files=1 -log-file=$VDIR/vault/logs/server.log
 wait # needed for trap to work
done

