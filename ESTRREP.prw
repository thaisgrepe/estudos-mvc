#include 'protheus.ch'
#include 'parmtype.ch'

user function ESTRREP()

Local nCount
Local nNum:= 0

For nCount:= 0 To 10 Step 2

nNum += nCount

Next
Alert("Valor:"+ cValToChar(nNum))
	
return