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

echo -e "
#
db.hostname=${HOSTNAME}
db.port=1521
db.servicename=PDB01
#db.sid=${ORACLE_SID}
db.username=APEX_PUBLIC_USER
migrate.apex.rest=false
rest.services.apex.add=true
rest.services.ords.add=true
schema.tablespace.default=SYSAUX
schema.tablespace.temp=TEMP
standalone.http.port=8080
standalone.static.images=${ORDS_SOFTLOC}/images
user.tablespace.default=SYSAUX
user.tablespace.temp=TEMP
" > ${ORDS_SOFTLOC}/params/ords_params.properties

cd ${ORDS_SOFTLOC}

java -jar ords.war configdir ${ORDS_SOFTLOC}/config

MENSAGEM="${AMARELO}Chegou na parte final.${VERDE}Agora precisaremos lembrar de todas aquelas senhas e usuários. Vou te dar uma ajuda:\n
${END}
Enter the database password for ${AMARELO}ORDS_PUBLIC_USER${END}: ${VERMELHO}Oracle_2023${END}
Confirm password: ${VERMELHO}Oracle_2023${END}
Requires to login with administrator privileges to verify Oracle REST Data Services schema.

Enter the administrator username: ${VERMELHO}sys${END}  
Enter the database password for ${AMARELO}SYS${END} AS SYSDBA: ${VERMELHO}SysPassword1${END}
Confirm password: ${VERMELHO}SysPassword1${END}

Connecting to database user: ${VERMELHO}SYS${END}
Retrieving information.
Enter 1 if you want to use PL/SQL Gateway or 2 to skip this step.
If using Oracle Application Express or migrating from mod_plsql then you must enter 1 [1]: ${VERMELHO}1${END}
Enter the database password for ${AMARELO}APEX_PUBLIC_USER${END}: ${VERMELHO}Oracle_2023${END}
Confirm password: ${VERMELHO}Oracle_2023${END}
Enter the database password for ${AMARELO}APEX_LISTENER${END}: ${VERMELHO}Oracle_2023${END}
Confirm password: ${VERMELHO}Oracle_2023${END}
Enter the database password for ${AMARELO}APEX_REST_PUBLIC_USER${END}: ${VERMELHO}Oracle_2023${END}
Confirm password: ${VERMELHO}Oracle_2023${END}
Enter a number to select a feature to enable:
   [1] SQL Developer Web  (Enables all features)
   [2] REST Enabled SQL
   [3] Database API
   [4] REST Enabled SQL and Database API
   [5] None
Choose [1]: ${VERMELHO}1${END}
 ….
Completed installation for Oracle REST Data Services version 21.4.2.r0621806. Elapsed time: 00:01:49.336
Enter 1 if you wish to start in standalone mode or 2 to exit [1]: ${VERMELHO}1${END}
Enter 1 if using HTTP or 2 if using HTTPS [1]: ${VERMELHO}1${END}
"
mensagem_verde

 java -jar ords.war

