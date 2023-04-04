#!/bin/bash

if [ $(id -u) -eq 0 ]; then
 echo "Você não pode estar como ROOT para executar este script."
 exit
fi       

if [ -f /tmp/origem.tmp ]; then
 ORIGEM=$(cat /tmp/origem.tmp)
 export ORIGEM
else 
 echo "Digite o caminho para a pasta que contem as pastas 'download' e 'scripts':"
 read ORIGEM;
 echo ${ORIGEM} > /tmp/origem.tmp
fi

DOWNLOAD=${ORIGEM}/download
SCRIPTS=${ORIGEM}/scripts
. "${SCRIPTS}/functions.sh"
. "${SCRIPTS}/set_variaveis.sh"

#MEMORIA=2048
MEMORIA=1024
NOMEPDB=PDB01

# Senha do usuário SYS
SENHASYS=SysPassword1

# Senha do usuário SYSTEM
SENHASYSTEM=SysPassword1

# Senha do usuário PDBADMIN
SENHAPDBADMIN=PdbPassword1

dbca -silent -createDatabase \
    -gdbname ${ORACLE_UNQNAME} \
    -sid ${ORACLE_SID} \
    -responseFile NO_VALUE \
    -templateName General_Purpose.dbc \
    -characterSet AL32UTF8 \
    -sysPassword ${SENHASYS} \
    -systemPassword ${SENHASYSTEM} \
    -createAsContainerDatabase true \
        -numberOfPDBs 1 \
        -pdbName ${NOMEPDB} \
        -pdbAdminPassword ${SENHAPDBADMIN} \
    -databaseType MULTIPURPOSE \
    -totalMemory $MEMORIA \
    -initParams sga_max_size="${MEMORIA}M",sga_target="${MEMORIA}M",pga_aggregate_target="512M",memory_max_target="${MEMORIA}M",memory_target="${MEMORIA}M" \
    -redoLogFileSize 200 \
    -emConfiguration NONE
#    -memoryMgmtType auto_sga \
#    -memoryPercentage 20 \
#    -automaticMemoryManagement true \

MENSAGEM="${AMARELO}Finalmente${VERDE} o banco de dados foi criado. ${VERDE}.\nAgora execute o script ${VERMELHO}3_pre_instalacao_APEX_e_ORDS.sh${END}. Para fazer a PRÉ-instalação do APEX e ORDS."
mensagem_verde

