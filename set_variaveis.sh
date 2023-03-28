#!/bin/bash
########################################################################## 
# PROGRAMA:		set_variaveis.sh
# Objetivo:		Configurar variaveis de ambientes
##########################################################################
umask 022
EDITOR=vi;                   export EDITOR
TERM=xterm;                  export TERM
TEMP=/tmp;                   export TEMP
TMPDIR=/tmp;                 export TMPDIR


##########################################################################
# CONFIGURAR AMBIENTE ORACLE  
##########################################################################

export ORACLE_SID=DBApex
export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=/opt/oracle/product/19c/dbhome_1
export ORACLE_UNQNAME=DBApex

export NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1

export ORACLE_OWNER=oracle
export ORACLE_TERM=xterm

export JAVA_HOME=/opt/jre
export ORDS_SOFTLOC=$ORACLE_BASE/ords
export APEX_SOFTLOC=$ORACLE_BASE/apex

#########################################################################
# CONFIGURAR PATH        
#########################################################################

export PATH=$ORACLE_HOME/bin:$ORA_CRS_HOME/bin:$PATH:/usr/local/bin:$JAVA_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$ORA_CRS_HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH
export CLASSPATH=$JAVA_HOME/:$ORACLE_HOME/jlib:$ORACLE_HOME/rdbms/jlib

##########################################################################
# Extra
##########################################################################
alias dba='sqlplus "/ as sysdba"'
