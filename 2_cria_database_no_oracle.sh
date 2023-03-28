#!/bin/bash

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

MEMORIA=2048
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
    -memoryMgmtType auto_sga \
    -totalMemory $MEMORIA \
    -redoLogFileSize 200 \
    -emConfiguration NONE

MENSAGEM="${AMARELO}Finalmente${VERDE} o banco de dados foi criado. ${VERDE}.\nAgora execute o script ${VERMELHO}3_pre_instalacao_APEX_e_ORDS.sh${END}. Para fazer a PRÉ-instalação do APEX e ORDS."
mensagem_verde

