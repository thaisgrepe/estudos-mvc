#include 'protheus.ch'
#include 'parmtype.ch'
//programa de atualização

user function U_Modelo1()
	Local cAlias:="SB1"
	Local cTitulo:="cadastro - AXcadastro"
	Local cVldExc:=".T."
	Local cVldAlt:=".T."
		
	AxCadastro(cAlias,cTitulo,cVldExc,cVldAlt)
	
return Nil