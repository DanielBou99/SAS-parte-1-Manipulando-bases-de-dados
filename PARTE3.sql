
LIBNAME DANIEL "/work/sistema/cib/daniel_sas";

OPTIONS OBS=MAX;

PROC CONTENTS DATA=DANIEL.CADASTRO_CLIENTE; RUN;

DATA WORK.TESTE1;
	SET DANIEL.CADASTRO_CLIENTE;

	FORMAT ESTADO $14.;

	IF '01000-000' <= CEP <= '09000-000' THEN
		ESTADO = 'GRANDE SP';
	ELSE IF '10000-000' <= CEP <= '19999-999' THEN
		ESTADO = 'INTERIOR SP';
	ELSE IF '20000-000' <= CEP <= '28999-999' THEN
		ESTADO = 'RIO DE JANEIRO';
	ELSE IF '30000-000' <= CEP <= '39999-999' THEN
		ESTADO = 'MINAS GERAIS';
	ELSE IF '80000-000' <= CEP <= '87999-999' THEN
		ESTADO = 'PARAN?';
	ELSE
		ESTADO = 'DEMAIS ESTADOS';
RUN;

PROC FREQ
	DATA=WORK.TESTE1;
	TABLE ESTADO /LIST MISSING;
RUN;

DATA TESTE2;
	SET DANIEL.CADASTRO_CLIENTE (OBS=MAX KEEP=CPF CEP);

	/* TRANSFORMA PARA N?MERICO */
	PRECEP = INPUT(SUBSTR(CEP,1,2), 2.);

	/* O SAS ESCOLHE A MELHOR FORMATA??O */
	PRECEP2 = INPUT(SUBSTR(CEP,1,2), BEST.); 

	/* REMOVE AS COLUNAS NOME, NASCIMENTO E SEXO */
	/* DROP NOME NASCIMENTO SEXO;*/

RUN;
