#!/bin/bash
if [ $(id -u) -eq 0 ]; then
	echo "Mude para o usuário ORACLE."
	exit
fi

echo "Confirma a exclusão do banco de dados? [s/n]: "
while read -r resp;
do

	resp=$(echo $resp | tr "[:lower:]" "[:upper:]")

	if [ "$resp" != "S" ] && [ "$resp" != "N" ]; then
	 echo "Resposta inválida.[${resp}]"
	 break
	fi

	if [ "${resp}" = "S" ]; then

		echo "Confirma que irá excluir o banco de dados ${ORACLE_SID}? [s/n]"
		read resp
        	resp=$(echo $resp | tr "[:lower:]" "[:upper:]")

	        if [ "$resp" != "S" ] && [ "$resp" != "N" ]; then
        	 echo "Resposta inválida.[${resp}]"
	         break
        	fi

		 if [ "${resp}" = "S" ]; then
			echo "Iniciando a exclusão do banco de dados ${ORACLE_SID}"
			dbca -silent -deleteDatabase -sourceDB ${ORACLE_SID} -skipSYSDBAPasswordPrompt true
			break
		else
			echo "Exclusao cancelada."
			break
		fi

		
	else
		echo "Exclusão do banco ${ORACLE_SID} foi cancelada."
		break
	fi
done

