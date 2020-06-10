#include 'protheus.ch'
#include 'parmtype.ch'

user function BLOCO()

//Local bBloco:= {|| Alert("Olá Mundo")}
      //Eval(bBloco)
      
      //passagem por parâmetros - bloco de códigos
      Local bBloco:={|cMsg|Alert(cMsg)}
      Eval(bBloco, "Olá Mundo!")
      
	
return