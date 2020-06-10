#include 'protheus.ch'
#include 'parmtype.ch'

user function U_BANCO004()
	
	Local aAREA:=SB1->(GetArea())
	
	DbSelectArea('SB1') 
	SB1->(DbSetOrder(1))
	SB1->(DbGoTop())
	
	// 	Iniciar a transa��o.
	Begin Transaction
	
	MsgInfo("A descri��o do produto ser� alterada!", "Aten��o")
	
	If SB1-> (DbSeek(FWxFilial('SB1')+ '000002'))
	   RecLock('SB1',.F.)//Trava registro para altera��o. Se fosse T, travaria para inclu��o.
       Replace B1_DESC With "MONITOR DELL 42PL"
       
       SB1->(MsUnlock())
       EndIf
          MsgAlert("Altera��o efetuada","Aten��o")
    End Transaction
    RestArea(aArea)
          
return