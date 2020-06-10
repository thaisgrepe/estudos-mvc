#include 'protheus.ch'
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------------------
/*/ {Protheus.doc}  MVC001

Cadastro MVC de Tabela de Cadastro de técnicos

@author Thais Grepe
@since
@version

/*/
//--------------------------------------------------------------------------------
 
user function MVC001()

Local oBrw:= FwMBrowse():New()

oBrw: SetDescription("Cadastro de Técnicos")
oBrw: SetAlias("ZBA")

oBrw: Activate()
	
return

//-----------------------------------------------------------------------------
/* /{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Thais Grepe
@since
@version
/*/
//----------------------------------------------------------------------------

Static Function ModelDef()


// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZBA:= FwFormStruct(1,"ZBA")

// Cria o objeto do Modelo de Dados
Local oModel:= MPFormModel(): New("MVC001_M")

//Adiciona ao modelo um componente de formulário
oModel:AddFields("ZBAMASTER",/*cOwner*/,oStruZBA)

//Adiciona a descrição do Modelo de Dados
oModel:SetDescription("Cadastro de Técnicos")

//Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZBAMASTER"):SetDescription("Cadastro de Técnicos")

//Retorna ao Modelo de Dados
Return 

//--------------------------------------------------------------------------
/*/
Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Thais Grepe
@since
@version
/*/
//----------------------------------------------------------------------------

Static Function ViewDef()

//Cria um objeto de Modelo de Dados baseado no ModelDef( do fonte informado)
Local oModel:= FwLoadModel("MVC001")

//Cria a estrutura a ser usada na View
Local oStruZBA:= FwFormStruct(2,"ZBA")

//Interface de visualização construída
Local oView

//Cria o objeto de View
oView:= FWFormView():New()

//Define qual Modelo de dados será utilizado na View
oView:= SetModel(oModel)

//Adiciona no nosso View um controle do tipo formulário
oView:AddField("VIEW_ZBA",oStruZBA,"ZBAMASTER")

//Cria um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox("TELA",100)

//Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView('View_ZBA','TELA')

//Retorna o objeto de View criado
Return(oView)

//--------------------------------------------------------------------------
/*/ {Protheus.doc} MenuDef()

@author Thais Grepe
@since
@version
/*/
//----------------------------------------------------------------------------

Static Function MenuDef()

Return FWMVCMenu("MVC001")
