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

cd ${ORDS_SOFTLOC}

MENSAGEM="Aguarde a ordem para ${VERDE} acessar o APEX via browser.${VERMELHO}."
mensagem_vermelho
sleep 10s

java -jar ords.war  > /tmp/output.log 2>&1 &

while : 
do 
 SAIDA=$(grep jetty /tmp/output.log)
 if ! [ -z "${SAIDA}" ] 
 then   
    break
 fi
done

MENSAGEM="Pronto. Já pode abrir o browser e acessar o APEX."
mensagem_verde

IP=$(cat /etc/hosts | grep $HOSTNAME | head -1 | tr ' ' '\t'| cut -f1)
MENSAGEM="
Abra seu navegador no endereço abaixo e use os dados de ${VERMELHO}WORKSPACE, USER e PASSWORD${VERDE} para acessar o APEX.\n${AMARELO}Parabéns${VERDE}. Você chegou ao final da instalação.
URL ${VERMELHO}http://${IP}:8080${VERDE}
workspace: ${VERMELHO}internal${VERDE}
user: ${VERMELHO}admin${VERDE}
password: ${VERMELHO}Oracle_2023${VERDE}
"
mensagem_verde


MENSAGEM="${END}Após o BOOT, ${AMARELO}SEMPRE${END} execute o script ${VERMELHO}start.sh${END} para iniciar o Banco de dados.\nAntes de desligar a máquina, execute o ${VERMELHO}stop.sh${END} para fechar o banco de dados sem corrompe-lo.${END}" 
mensagem_verde

PID=$(pgrep -f "java -jar ords.war")
MENSAGEM="${END}Para fechar o servidor WEB do APEX, digite ${AMARELO}kill -9 ${PID}${END}" 
mensagem_verde


