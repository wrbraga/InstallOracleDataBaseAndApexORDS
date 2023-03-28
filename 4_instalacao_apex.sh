#!/bin/bash

if [ -f /tmp/origem.tmp ]; then
 ORIGEM=$(cat /tmp/origem.tmp)
else 
 echo "Digite o caminho para a pasta que contem as pastas 'download' e 'scripts':"
 read ORIGEM;
 echo ${ORIGEM} > /tmp/origem.tmp
fi
export ORIGEM
DOWNLOAD=${ORIGEM}/download
SCRIPTS=${ORIGEM}/scripts
. "${SCRIPTS}/functions.sh"
. "${SCRIPTS}/set_variaveis.sh"

if ! [ -f "${SCRIPTS}/functions.sh" ]; then
 MENSAGEM="Não será possível continuar ... o caminho indicado ${SCRIPTS} não contem os scripts!"
 mensagem_verde;
exit
fi 

cd /opt/oracle/apex

if [ ${USER} == "oracle" ]; then
 MENSAGEM="Istalando o APEX no banco de dados ... ${AMARELO}tenha paciência, vai demorar um pouquinho."
 mensagem_verde

sqlplus / as sysdba <<EOF
 alter session set container=PDB01;
 create tablespace apex_tbs datafile '/opt/oracle/oradata/DBAPEX/PDB01/apex_tbs01.dbf' size 300m autoextend on maxsize unlimited;
 @apexins apex_tbs apex_tbs temp /i/;
EOF

else
 MENSAGEM="Você precisa estar como o usuário ${VERMELHO}ORACLE"
 mensagem_verde
fi

 MENSAGEM="Instalação do APEX no banco de dados ${AMERELO}CONCLUÍDA${VERDE}.\nAgora execute o script ${VERMELHO}5.0_criacao_conta_ADMIN_APEX.sh${END}. Para definir a senha do usuário ADMIN que será o administrador WEB do APEX e desbloqueá-lo."
 mensagem_verde
