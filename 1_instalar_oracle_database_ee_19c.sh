#!/bin/bash

export ORIGEM=/mnt
# Altere a variavel ORIGEM de /mnt/APEX para o diretório que contem os arquivos
# que serão usados na instalacao. lembre-se de manter a estrutura:
#/mnt/APEX/   <<<< o diretório que você indicou na variavel
#├── download
#│   ├── apex_21.2_en.zip
#│   ├── openjdk-19.0.2_linux-x64_bin.tar.gz
#│   ├── oracle-database-ee-19c-1.0-1.x86_64.rpm
#│   └── ords-21.4.2.062.1806.zip
#└── scripts
#    ├── 1_instalar_oracle_database_ee_19c.sh
#    ├── 2_cria_database_no_oracle.sh
#    ├── 3_pre_instalacao_APEX_e_ORDS.sh
#    ├── 4_instalacao_apex.sh
#    ├── 5_criacao_conta_ADMIN_APEX.sh
#    ├── 6_instalacao_ORDS.sh
#    ├── functions.sh
#    ├── set_variaveis.sh
#    ├── start.sh
#    └── stop.sh



echo ${ORIGEM} > /tmp/origem.tmp
. "${ORIGEM}/scripts/functions.sh"


MENSAGEM="Não faça isso em produção!\nDesabilitando o firewall!"
mensagem_vermelho
systemctl stop firewalld.service
systemctl disable firewalld.service

sed -e "s/SELINUX=enforcing/SELINUX=permissive/g" /etc/selinux/config > /etc/selinux/config.new
rm -f /etc/selinux/config
mv /etc/selinux/config.new /etc/selinux/config

#- configurando hosts
MENSAGEM="Ajustando os /etc/hosts"
mensagem_verde
IPS=$(ip a | grep "inet" | grep "brd" | tr " " "\t" | cut -f6 | tr "/" "\t" | cut -f1)
HOSTNAME=$(hostname | tr '.' "\t" | cut -f1)
for ip in ${IPS}; do 
  echo ${ip} $HOSTNAME `hostname` >> /etc/hosts; 
done

#Instalando o OpenJDK
MENSAGEM="Instalando o OpenJDK"
mensagem_verde
JAVAFILE="openjdk-19.0.2_linux-x64_bin.tar.gz"
if ! [ -f "${DOWNLOAD}/${JAVAFILE}" ]; then
    wget -c https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/${JAVAFILE} -O ${DOWNLOAD}/${JAVAFILE}
fi
tar xzvf "${DOWNLOAD}/${JAVAFILE}" -C /opt/ >> /dev/null
ln -s /opt/jdk-19.0.2 /opt/jre

#-- instalando pacote preinstall
MENSAGEM="Instando o pacote de pre-instalação"
mensagem_verde
PREINSTALLFILE="oracle-database-preinstall-19c.x86_64"
if ! [ -f "${DOWNLOAD}/${PREINSTALLFILE}" ]; then
    yum -y install oracle-database-preinstall-19c.x86_64
else
    yum -y localinstall  ${DOWNLOAD}/${PREINSTALLFILE}
fi

#- criando grupos e ajustando user oracle
#Obs: caso não tenha criado na instalação do S.O
MENSAGEM="Criando grupos e ajustando user oracle"
mensagem_verde
if [ `grep oracle /etc/passwd` ]; then 
  MENSAGEM= "${AMARELO}Achei o usuário. Próxima etapa."; 
  mensagem_verde
else 
  echo "Não achei o usuário .. Criando o usuario oracle!"; 
  useradd oracle;
  echo "Defina uma senha para o usuario oracle:"; 
  passwd oracle;
fi

# Incluindo o usuario oracle nos grupos necessarios
MENSAGEM="Incluindo o usuário oracle nos grupos necessários!"
mensagem_verde
usermod -g oinstall -aG dba,oper,backupdba,dgdba,kmdba,racdba oracle

# Testando para ver se tem o download do Oracle DataBasse ou se fará via YUM!
RPM=$(find ${DOWNLOAD} -name "oracle-database*.rpm")
if [ -f "${RPM}" ]; then
 MENSAGEM="Fazendo a instalação via ${VERMELHO}${RPM}${END}";
 mensagem_verde;
  yum -y localinstall ${RPM};
else
 MENSAGEM="Fazendo a instalação via ${VERMELHO}repositório online{END}";
 mensagem_verde;
  yum -y oracle-database-ee-19c.x86_64;
fi

## Copiando o script de ajuste das variaveis de ambiente ##
cp $ORIGEM/scripts/set_variaveis.sh /home/oracle
chmod +x /home/oracle/set_variaveis.sh
chown oracle:oinstall /home/oracle/set_variaveis.sh
echo '. /home/oracle/set_variaveis.sh' >> /home/oracle/.bashrc

#-- comando para criação do listener (NETCA)
## 
MENSAGEM="Copiando o arquivo de configuração do Listener Oracle"
mensagem_verde
cp /opt/oracle/product/19c/dbhome_1/assistants/netca/netca.rsp /home/oracle
chown oracle:oinstall /home/oracle/netca.rsp

#arquivo: netca.rsp
MENSAGEM="Iniciando o Listener..."
mensagem_verde
sudo -u oracle /opt/oracle/product/19c/dbhome_1/bin/netca -silent -responsefile /home/oracle/netca.rsp

echo
MENSAGEM="Vou mudar para o usuário ${VERMELHO}oracle${VERDE}.\nExecute o segundo script ${VERMELHO}2_cria_database_no_oracle.sh. \n${AMARELO}LEMBRE-SE:${VERDE}Esta etapa é a mais ${VERMELHO}demorada!"
mensagem_verde
su - oracle

