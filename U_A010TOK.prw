#include 'protheus.ch'
#include 'parmtype.ch'


/*/{Protheus.doc} U_A010TOK
//TODO Descrição auto-gerada.
@author Administrador
@since 12/05/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
user function U_A010TOK()
    Local lExecuta:= .T.
    Local cTipo := AllTrim(M->B1_TIPO)
    Local cConta:= Alltrim(M->B1_CONTA)
    
 	If (cTipo= "PA" .AND. cConta = "001")
 	   Alert("A conta <b> " + cConta +"</b> não pode estar"+;
 	   "associada a um produto do tipo <b>" + cTipo)
 	   lExecuta := .F.
 	   
 	   EndIf
 	    
return(lExecuta)