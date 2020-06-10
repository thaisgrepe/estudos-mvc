#include 'protheus.ch'
#include 'parmtype.ch'

user function U_Banco001()
     Local aArea:= ZZD-> (GetArea())
          
     DbSelectArea("ZZD") // abre a tabela
     SB1->(DbSetOrder(1)) //posiciona no indice 1
	 SB1->(DbGoTop()) //vai pro começo da tabela
	 
	 //posiciona o album de codigo 000002
	 If SB1->(dbSeek(FWXFilial("ZZD")+"000002")) //varre a tabela
	    Alert(ZZD->ZZD_DESC)
	 EndIf
	 
	 RestArea(aArea) //fecha a tabela
return