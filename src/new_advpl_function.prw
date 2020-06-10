#include 'protheus.ch'
#include 'parmtype.ch'

Static cStat:=''

user function new_advpl_function()
	
	//variaveis locais
	Local nVar0:=1
	Local nVar1:=20
	
	//variaveis private
	Private cPri := 'private!'
	
	//variavel public
	Public __cPublic:= 'RCTI'
	
	TesteEscop(nValor0, @nValor1)
	
return

//-----------função static--------------------------

Static Function TesteEscop(nValor1, nValor2)

Local __cPublic := 'Alterei'
Default nValor1:=0

//Alterando conteudo da variavel
   nValor2:=10
   
//mostrar conteudo da variavel private
Alert("Private:"+ cPri  )

//mostrar conteudo da variavel private
Alert("Publica "+__cPublic)

MsgAlert(nValor2)
Alert("Variavel Static: "+cStatic)

Return