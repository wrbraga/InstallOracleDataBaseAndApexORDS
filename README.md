# JnstallOracleDataBaseAndApexORDS
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
