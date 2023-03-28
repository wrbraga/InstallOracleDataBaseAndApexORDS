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

SQL=/tmp/etapa5.1.sql
cd /opt/oracle/apex

echo "
alter session set container=PDB01;
@apex_rest_config
quit
" > ${SQL}

# 3. Configure RESTful Services
 #   Run the apex_rest_config.sql script
MENSAGEM="${AMARELO}ATENÇÃO:${VERDE} Agora você irá configurar as senhas dos usuário ${VERMELHO}APEX_LISTENER${VERDE} e do ${VERMELHO}APEX_REST_PUBLIC_USER${VERDE}. ${VERMELHO}ANOTE PARA NÃO TER DOR DE CABEÇA.\n${VERDE}Esta senha ${VERMELHO}OBRIGATORIAMENTE${VERDE} deve conter:${AMARELO} MAIS de 8 caracteres, letras (maiusculas e minusculas), símbolos e oa MENOS UM SINAL.
\n${AMARELO}USE A SENHA ${VERMELHO}Oracle_2023${VERDE} para facilitar sua vida ... é só um servidor de testes.
"
mensagem_verde

echo -e "\n"
MENSAGEM="${AMARELO}SIGA A SEQUENCIA DE RESPOSTAS ABAIXO:${VERDE}
Enter a password for the APEX_LISTENER user          	[]${VERMELHO}Oracle_2023${VERDE}
Enter a password for the APEX_REST_PUBLIC_USER user          	[]${VERMELHO}Oracle_2023${VERDE}
"
mensagem_verde


sqlplus sys/SysPassword1 as sysdba @${SQL}
rm -f ${SQL}

# 2. Configure the APEX_PUBLIC_USER Account
 #   See the Installation Guide for details
MENSAGEM="${AMARELO}FINALMENTE${VERDE} vamos desbloquear os usuário para uso.\nAgora execute o script${VERMELHO}5.2_desbloquear_usuarios.sh${VERDE} para finalizar a configuração."
mensagem_verde


