## Cores para a vida ##
export ORIGEM=$(cat /tmp/origem.tmp)
export DOWNLOAD="${ORIGEM}/download"
export SCRIPT="${ORIGEM}/scripts"


VERMELHO="\e[0;31m"
VERDE="\e[0;32m"
AMARELO="\e[0;33m"
END="\e[m"

function mensagem_verde {
  echo -e "${VERDE}$MENSAGEM${END}"
}

function mensagem_vermelho {
  echo -e "${VERMELHO}$MENSAGEM${END}"
}

