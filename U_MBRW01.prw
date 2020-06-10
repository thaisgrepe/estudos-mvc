#include 'protheus.ch'
#include 'parmtype.ch'

user function U_MBRW01()
   Local cAlias:="SB1"
   Private cTitulo:= "Cadastro de Produtos Thais"
   Private aRotina:={}
   
   AADD(aRotina,{"Pesquisar"     ,"AxPesqui"    ,0,1})
   AADD(aRotina,{"Visualizar"    ,"AxVisual"    ,0,2})
   AADD(aRotina,{"Incluir"       ,"AxInclui"    ,0,3})
   AADD(aRotina,{"Alterar"       ,"AxAltera"    ,0,4})
   AADD(aRotina,{"Excluir"       ,"AxDeleta"    ,0,5})
   AADD(aRotina,{"OlaMundo"      ,"U_OLAMUNDO"  ,0,6})
   
   dbSelecArea(cAlias)
   dbSetOrder(1)
   mBrowse(,,,,cAlias)
   
return Nil