#include 'protheus.ch'
#include 'parmtype.ch'

user function U_MBRW02()
    Local cAlias      :="SA2" 
    Local aCores      :={}
    Local cFiltra     :="A2_FILIAL=='"+xFilial('SA2')+"'.And. A2_EST=='SP'"
    Private cCadastro :="Cadastro Thais"
    Private aRotina   :={}
    Private aIndexSA2 :={}
    Private bFiltraBrw:={||FilBrowse(cAlias,@aIndexSA2,@cFiltra)}
   
   AADD(aRotina,{"Pesquisar"     ,"AxPesqui"     ,0,1})
   AADD(aRotina,{"Visualizar"    ,"AxVisual"     ,0,2})
   AADD(aRotina,{"Incluir"       ,"U_BInclui"    ,0,3})
   AADD(aRotina,{"Alterar"       ,"U_BAltera"    ,0,4})
   AADD(aRotina,{"Excluir"       ,"U_BDeleta"    ,0,5})
   AADD(aRotina,{"Legenda"       ,"U_BLegenda"   ,0,6})
   
   
   //Acores- Legenda
   
   AADD(aCores,{"A2_TIPO  ==  'F'"  ,"BR_VERDE"  })
   AADD(aCores,{"A2_TIPO  ==  'J'"  ,"BR_AMARELO"})
   AADD(aCores,{"A2_TIPO  ==  'X'"  ,"BR_LARANJA"})
   AADD(aCores,{"A2_TIPO  ==  'R'"  ,"BR_MARROM" })
   AADD(aCores,{"Empty(A2_TIPO)"    ,"BR_PRETO"  })
   
   dbSelecArea(cAlias)
   dbSetOrder(1)
   
   Eval(bFiltraBrw)
   
   dbGoTop()
   mBrowse(6,1,22,75,cAlias,,,,,,aCores)
   
   EndFilBrw(cAlias,aIndexSA2)
   
   
return
/*--------------------------------------------------
          Fun��o BInclui- Inclus�o
--------------------------------------------------*/

User Function BInclui(cAlias,nReg,nOpc)
     Local nOpcao:= 0
     nOpcao:= AxInclui()
     If nOpcao==1
       MsgInfo("Inclus�o efetuada com sucesso!")
     Else
       MsgAlert("Inclus�o Cancelada!")
     EndIf
Return

/*--------------------------------------------------
          Fun��o BAltera- Altera��o
--------------------------------------------------*/

User Function BAltera(cAlias,nReg,nOpc)
     Local nOpcao:= 0
     nOpcao:= AxAltera()
     If nOpcao==1
       MsgInfo("Altera��o efetuada com sucesso!")
     Else
       MsgAlert("Altera��o Cancelada!")
     EndIf
Return    

/*--------------------------------------------------
          Fun��o BDeleta- Exclus�o
--------------------------------------------------*/

User Function BDeleta(cAlias,nReg,nOpc)
     Local nOpcao:= 0
     nOpcao:= AxDeleta()
     If nOpcao==1
       MsgInfo("Exclus�o efetuada com sucesso!")
     Else
       MsgAlert("Exclus�o Cancelada!")
     EndIf
Return

/*--------------------------------------------------
          Fun��o Legenda
--------------------------------------------------*/

User Function BLegenda()
     Local aLegenda:= ()
     
    AADD(aLegenda,{"BR_VERDE"  , "Pessoa F�sica"   })
    AADD(aLegenda,{"BR_AMARELO", "Pessoa Jur�dica" })
    AADD(aLegenda,{"BR_LARANJA", "Exporta��o"      })
    AADD(aLegenda,{"BR_MARROM" , "Fornecedor Rural"})
    AADD(aLegenda,{"BR_PRETO"  , "N�o Classificado"})

 BrwLegenda(cCadastro, "Legenda", aLegenda)

Return
	