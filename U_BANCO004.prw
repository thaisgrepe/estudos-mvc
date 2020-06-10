#include 'protheus.ch'
#include 'parmtype.ch'

user function U_BANCO004()
	
	Local aAREA:=SB1->(GetArea())
	
	DbSelectArea('SB1') 
	SB1->(DbSetOrder(1))
	SB1->(DbGoTop())
	
	// 	Iniciar a transação.
	Begin Transaction
	
	MsgInfo("A descrição do produto será alterada!", "Atenção")
	
	If SB1-> (DbSeek(FWxFilial('SB1')+ '000002'))
	   RecLock('SB1',.F.)//Trava registro para alteração. Se fosse T, travaria para inclução.
       Replace B1_DESC With "MONITOR DELL 42PL"
       
       SB1->(MsUnlock())
       EndIf
          MsgAlert("Alteração efetuada","Atenção")
    End Transaction
    RestArea(aArea)
          
return