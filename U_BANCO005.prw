#include 'protheus.ch'
#include 'parmtype.ch'

user function U_BANCO005()

    Local aArea:= GetArea()
    Local aDados:=()
    Private lMSErroAuto := .F.
    
    //Adicionando dados no vetor para teste de inclusao na tabela SB1
    aDados:= {;
              {"B1_COD","111111",          Nil},;
              {"B1_DESC", "PRODUTO TESTE", Nil},;
              {"B1_TIPO","GG",             Nil},;
              {"B1_UM","PC",               Nil};
              }
  //Inicio do controle de transacao
  Begin Transaction
  // chama cadastro de produto
  MSExecAuto({|x,y|Mata010(x,y)},aDados,3)
  
  //caso ocorra algum erro
   If lMSErroAuto
      Alert ("Ocorreram erros durante a operação! ")
      MostraErro()
      
      DisarmTransaction()
   Else
   MsgInfo("Operação finalizada!","Aviso")
   EndIf
   End Transaction
   
   RestArea(aArea)              	
return