#!/bin/bash
if [ ${USER} == "oracle" ]; then

    echo "Aguarde até a mensagem de que o 'O pdb PDB01 que será usado pelo APEX já está aberto'. Depois siga com a execução dos scripts."

    $ORACLE_HOME/bin/lsnrctl start
    $ORACLE_HOME/bin/sqlplus / as sysdba <<EOF
     startup
     alter pluggable database PDB01 open;
     quit
EOF

    echo -e "\n\nPronto! Agora você pode começar o seu show."
    echo "O Servidor já está pronto e ouvindo conexões ao banco."
    echo "O pdb PDB01 que será usado pelo APEX já está aberto."
    echo "db" > /tmp/status.tmp
else

    echo "Mude para  o usuáro ORACLE e execute novamente o script."
fi
