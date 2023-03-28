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
SQL=/tmp/etapa5.0.sql
cd /opt/oracle/apex
echo "
alter session set container=PDB01;
@apxchpwd
quit
" > ${SQL}

# 1. Create your Instance Administration Account
 #   Run the apxchpwd.sql script
MENSAGEM="${AMARELO}ATENÇÃO:${VERDE} Esta senha será usada na WEB para gerenciar o APEX. \n${VERMELHO}ANOTE PARA NÃO TER DOR DE CABEÇA.\n${VERDE}Esta senha ${VERMELHO}OBRIGATORIAMENTE${VERDE} deve conter:${AMARELO} MAIS de 8 caracteres, letras (maiusculas e minusculas), símbolos e ao MENOS UM SINAL. \n${AMARELO}USE A SENHA ${VERMELHO}Oracle_2023${VERDE} pois ela já está definida em alguns arquivos de scripts."
mensagem_verde

echo -e "\n"
MENSAGEM="${AMARELO}SIGA A SEQUENCIA DE RESPOSTAS ABAIXO:${VERDE}
\nEnter the administrator's username [ADMIN]${VERMELHO}PRESSESIONE ENTER${VERDE}
Enter ADMIN's email [ADMIN]${VERMELHO}PRESSESIONE ENTER${VERDE}
Enter ADMIN's password [] ${VERMELHO}Oracle_2023${END}"
mensagem_verde

sqlplus sys/SysPassword1 as sysdba @${SQL}
rm -f ${SQL}


MENSAGEM="Configuração da senha do${VERMELHO} ADMIN ${AMARELO}CONCLUÍDA${VERDE}.\nAgora execute o script ${VERMELHO}5.1_configuracao_ORDS.sh${END}. "
mensagem_verde


