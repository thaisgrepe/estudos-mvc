#include 'protheus.ch'
#include 'parmtype.ch'

user function ESTRUTUR()

Local nNum1:= 22
Local nNum2:= 100
If(nNum1 = nNum2)
	
MsgAlert("A variav�l nNum1 � igual a nNum2")

ElseIf (nNum1 > nNum2)
MsgAlert("A variav�l � maior")

ElseIf (nNum1 != nNum2)
Alert("A variav�l nNum1 � diferente de nNum2")

EndIf
	
return