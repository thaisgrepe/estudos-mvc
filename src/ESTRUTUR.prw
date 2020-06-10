#include 'protheus.ch'
#include 'parmtype.ch'

user function ESTRUTUR()

Local nNum1:= 22
Local nNum2:= 100
If(nNum1 = nNum2)
	
MsgAlert("A variavél nNum1 é igual a nNum2")

ElseIf (nNum1 > nNum2)
MsgAlert("A variavél é maior")

ElseIf (nNum1 != nNum2)
Alert("A variavél nNum1 é diferente de nNum2")

EndIf
	
return