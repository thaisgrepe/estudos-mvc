#include 'protheus.ch'
#include 'parmtype.ch'

user function BLOCO()

//Local bBloco:= {|| Alert("Ol� Mundo")}
      //Eval(bBloco)
      
      //passagem por par�metros - bloco de c�digos
      Local bBloco:={|cMsg|Alert(cMsg)}
      Eval(bBloco, "Ol� Mundo!")
      
	
return