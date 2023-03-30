#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Mude para  o usuáro ORACLE e execute novamente o script."
   exit 1
fi

. /home/oracle/set_variaveis.sh

echo "Fechando o banco de dados ..."
/bin/bash -c "${ORACLE_HOME}/bin/sqlplus / as sysdba << EOF
    shutdown IMMEDIATE
    quit
EOF" > /dev/null 2>&1

echo "Finalizando o Listener..."
$ORACLE_HOME/bin/lsnrctl stop > /dev/null 2>&1

echo "Tudo fechado!"

rm -f /tmp/status.tmp > /dev/null
