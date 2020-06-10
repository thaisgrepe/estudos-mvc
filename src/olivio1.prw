#include 'protheus.ch'
#include 'parmtype.ch'

user function olivio1()


	#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRYEXCEPTION.CH"
#INCLUDE "FWEditPanel.CH"

#DEFINE ROTINA_FILE				"MFAMOD02.prw"
#DEFINE VERSAO_ROTINA			"V" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[04])) + "-" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[05])) + "[" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[03])) + "]"

#Define ALIAS_FORM0 			"Z03" //Informe o Alias da Tabela
#Define ALIAS_GRID0 			ALIAS_FORM0
#Define MODELO					"MFAMOD02"
#Define ID_MODEL				"MFMMOD02"
#Define TITULO_MODEL			"Cadastro Modelo MVC - Modelo 2 " + SubStr(VERSAO_ROTINA,1,17)
#Define TITULO_VIEW				TITULO_MODEL
#Define ID_MODEL_FORM0			ALIAS_FORM0+"FORM0"
#Define ID_MODEL_GRID0			ALIAS_GRID0+"GRID0"
#Define ID_VIEW_FORM0			"VIEW_FORM0"
#Define ID_VIEW_GRID0			"VIEW_GRID0"
#Define PREFIXO_ALIAS_FORM0		Right(ALIAS_FORM0,03)
#Define PREFIXO_ALIAS_GRID0		Right(ALIAS_GRID0,03)
	
return