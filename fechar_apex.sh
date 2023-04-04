#!/bin/bash
# Este script mata o processo do java fechando assim o servidor WEB
# Execute para finalizar os serviços
# Após este script, execute o stop.sh para fechar o banco de dados
# e desligar ou reiniciar a máquina

while :
do 
 PID=$(pgrep -f "java -jar ords.war")
 if ! [ -z "${PID}" ]; then
  kill -9 ${PID}  
 else
  echo "Apex fechado!"
  break
 fi
done
