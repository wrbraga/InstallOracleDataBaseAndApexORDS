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

MENSAGEM="Iniciando a busca pelos arquivos do APEX e ORDS!"
mensagem_vermelho;


ARQUIVOAPEX=$(find ${DOWNLOAD} -name "apex_21*.zip")
ARQUIVOORDS=$(find ${DOWNLOAD} -name "ords-21*.zip")

if ! [ -f "${ARQUIVOAPEX}" ]; then
  MENSAGEM="Não foi possivel encontrar o arquivo do APEX 21!"
  mensagem_vermelho;
  exit
else 
  MENSAGEM="Extraindo o conteúdo de ${AMARELO}${ARQUIVOAPEX}${VERDE} para ${AMARELO}${ORACLE_BASE}/apex"
  mensagem_verde;
  mkdir -p "${ORACLE_BASE}/apex"
  unzip ${ARQUIVOAPEX} -d ${ORACLE_BASE} >> /dev/null
fi

if ! [ -f "${ARQUIVOORDS}" ]; then
  echo "Não foi possivel encontrar o arquivo do ORDS 21!"
  exit
else 
  MENSAGEM="Extraindo o conteúdo de ${AMARELO}${ARQUIVOORDS}${VERDE} para ${AMARELO}${ORDS_SOFTLOC}"
  mensagem_verde;
  mkdir -p ${ORDS_SOFTLOC}/config
  MENSAGEM="Copiando o conteúdo estático do APEX para o ORDS!"
  mensagem_verde;
  cp -r ${APEX_SOFTLOC}/images ${ORDS_SOFTLOC}/images >> /dev/null
  unzip ${ARQUIVOORDS} -d ${ORDS_SOFTLOC} >> /dev/null
fi

chown -R oracle:oinstall ${ORACLE_BASE}/{apex,ords}

MENSAGEM="Extração dos arquivos do ${AMARELO}APEX${VERDE} e do ${AMARELO}ORDS${VERDE} feitas para ${VERMELHO}${ORACLE_BASE}. "
mensagem_verde
MENSAGEM="Agora execute o script ${VERMELHO}4_instalacao_apex.sh${END}. Para fazer a instalação do APEX no banco de dados."
mensagem_verde

