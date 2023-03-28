#!/bin/bash

$ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
 shutdown IMMEDIATE
 quit
EOF

$ORACLE_HOME/bin/lsnrctl stop
