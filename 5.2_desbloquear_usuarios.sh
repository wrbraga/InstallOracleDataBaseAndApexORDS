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

if ! [ -f "${SCRIPTS}/functions.sh" ]; then
 MENSAGEM="Não será possível continuar ... o caminho indicado ${SCRIPTS} não contem os scripts!"
 mensagem_verde;
exit
fi 

cd /opt/oracle/apex

sqlplus / as sysdba <<EOF
 alter session set container=PDB01;
 ALTER USER apex_public_user IDENTIFIED BY Oracle_2023 ACCOUNT UNLOCK;
 ALTER USER apex_listener IDENTIFIED BY Oracle_2023 ACCOUNT UNLOCK;
 ALTER USER apex_rest_public_user IDENTIFIED BY Oracle_2023 ACCOUNT UNLOCK;

 grant all privileges to pdbadmin;

-- Libera o acesso a todos os sites para que consultas Rest
-- Possam ser feitas
DECLARE
  l_principal VARCHAR2(20) := 'APEX_210200';
BEGIN
  DBMS_NETWORK_ACL_ADMIN.create_acl (
    acl          => 'oracle_base_acl.xml', 
    description  => 'An ACL for access all websites',
    principal    => l_principal,
    is_grant     => TRUE, 
    privilege    => 'connect',
    start_date   => SYSTIMESTAMP,
    end_date     => NULL);

  DBMS_NETWORK_ACL_ADMIN.assign_acl (
    acl         => 'oracle_base_acl.xml',
    host        => '*', 
    lower_port  => 80,
    upper_port  => 9999); 

  COMMIT;
END;
EOF

MENSAGEM="Usuários do APEX desbloqueados com ${AMERELO}SUCESSO.${VERDE}.\nAgora execute o script ${VERMELHO}5.3_configuracao_inicial_ORDS.sh${END}. Para preparar a instalação do ORDS."
 mensagem_verde
