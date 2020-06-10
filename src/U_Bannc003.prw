#include 'protheus.ch'
#include 'parmtype.ch'
#include 'TopConn.ch'
user function U_Bannc003()


    Local aArea:= SB1-> (GetArea())
    Local cQuery:=""
    Local aDados:={}
    
    cQuery :="SELECT"
    cQuery += "B1_COD AS CODIGO, "
    cQuery += "B1_DESC AS DESCRICAO"
    cQuery += "FROM"
    cQUERY += " " + RetSQLName("SB1") + "SB1" 
    cQuery += "WHERE"
    Cquery += "B1_MSBLQL != '1'"
    
    // Executando a consulta acima
    
    TCQuery cQuery New Alias "TMP"
    
    While ! TMP -> (EoF())
    AADD(aDados,TMP->CODIGO)
    AADD(aDados,TMP-> DESCRICAO)
     TMP->(DbSkip())
     EndDo
     
     Alert(Len(aDados))
           
           For nCount:=1 To Len(aDados)
           MsgInfo(aDados(nCount))
           Next nCount
           
           
           TMP->(DbCloseArea())
           RestArea(aArea) 
            
    	
return