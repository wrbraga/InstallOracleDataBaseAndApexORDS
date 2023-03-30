#!/bin/bash

if [ $(id -u) -eq 0 ]; then
    echo "Mude para  o usuáro ORACLE e execute novamente o script."
   exit 1
fi

echo -e "Este processo demora alguns segundos .. pode levar até mesmo alguns minutos. \nAguarde a mensagem indicando a finalização das tarefas e liberando para execução do próximo script."

${ORACLE_HOME}/bin/lsnrctl start 
#> /dev/null 2>&1

sleep 10s

    if [ $? -eq 0 ]; then
        echo "Servidor ouvindo conexões ... aguarde"
    fi

echo -e "Conectando ao banco de dados para abrir o PDB01 que será usado pelo APEX.  Aguarde ...\n"

/bin/bash -c "${ORACLE_HOME}/bin/sqlplus -s /nolog << EOF
connect / as sysdba;
startup;
alter pluggable database PDB01 open;
alter session set container=PDB01;
quit;
EOF"

sleep 10s

    if [ $? -eq 0 ]; then
        echo "Pronto. Agora você pode começar o seu show."
        echo "O Servidor já está pronto e ouvindo conexões ao banco."
    else        
        echo "O pdb PDB01 que será usado pelo APEX já está aberto."
    fi

   echo "Se o APEX já está instalado execute o script 6_executar_APEX_SERVER.sh para rodar o servidor WEB e poder acessá-lo via browser."

   echo "db" > /tmp/status.tmp   
