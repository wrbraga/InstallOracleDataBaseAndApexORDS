# Installing Oracle database, APEX, and ORDS on Oracle Linux 8.
shell script for installation of the Oracle DataBase 19, APEX 21 and ORDS 21.

Folder structure: 
```bash
/mnt   << SET VARIABLE 'ORIGEM' in the script '1_instalar_oracle_database_ee_19c.sh' TO PATH
├── download    << CREATE THIS DIRECTORY TO SAVE THE FILES DOWNLOADED
│   ├── apex_21.2_en.zip
│   ├── openjdk-19.0.2_linux-x64_bin.tar.gz
│   ├── oracle-database-ee-19c-1.0-1.x86_64.rpm
│   └── ords-21.4.2.062.1806.zip
└── scripts   << ALL SCRIPTS must be inside this directory (as seen below)
    ├── 1_instalar_oracle_database_ee_19c.sh
    ├── 2_cria_database_no_oracle.sh
    ├── 3_pre_instalacao_APEX_e_ORDS.sh
    ├── 4_instalacao_apex.sh
    ├── 5.0_criacao_conta_ADMIN_APEX.sh
    ├── 5.1_configuracao_ORDS.sh
    ├── 5.2_desbloquear_usuarios.sh
    ├── 5.3_configuracao_inicial_ORDS.sh
    ├── 6_executar_APEX_SERVER.sh
    ├── functions.sh
    ├── set_variaveis.sh
    ├── start.sh
    └── stop.sh
```
Follow the numerical sequence of the scripts for correct execution.

## ISO Oracle Linux 8
1. https://yum.oracle.com/oracle-linux-isos.html
```bash
wget -c https://yum.oracle.com/ISOS/OracleLinux/OL8/u7/x86_64/OracleLinux-R8-U7-x86_64-dvd.iso
```

## OpenJDK 19
1. https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-19.0.2_linux-x64_bin.tar.gz
```bash
wget -c https://download.java.net/java/GA/jdk19.0.2/fdb695a9d9064ad6b064dc6df578380c/7/GPL/openjdk-19.0.2_linux-x64_bin.tar.gz
```
## Oracle Database 19c ee
1. https://www.oracle.com/database/technologies/oracle-database-software-downloads.html
2. https://edelivery.oracle.com/osdc/faces/SoftwareDelivery

## Oracle APEX 21.2
1. https://www.oracle.com/tools/downloads/apex-212-downloads.html
2. https://download.oracle.com/otn_software/apex/apex_21.2_en.zip
```bash
wget -c https://download.oracle.com/otn_software/apex/apex_21.2_en.zip
```

## Oracle REST Data Services 21.4.2
1. https://www.oracle.com/tools/ords/ords-downloads-2142.html
2. https://download.oracle.com/otn_software/java/ords/ords-21.4.2.062.1806.zip
```bash
wget -c https://download.oracle.com/otn_software/java/ords/ords-21.4.2.062.1806.zip
```
## Tip for improve the performance in the libvirt/kvm
Using libvirt enable the option "**Enable share memory**" in Memory setting.

Define **4096MB** of the memory to virtual machine


