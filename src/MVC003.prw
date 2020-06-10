#include 'protheus.ch'
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------------------
/*/ {Protheus.doc}  MVC003

Cadastro MVC de Tabela de Cadastro de técnicos

@author Thais Grepe
@since
@version

/*/
//--------------------------------------------------------------------------------
 
user function MVC003()

Local oBrw:= FwMBrowse():New()

oBrw: SetDescription("Cadastro de Tipos de Chamados")
oBrw: SetAlias("ZBC")

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
Local oStruZBC:= FwFormStruct(1,"ZBC")

// Cria o objeto do Modelo de Dados
Local oModel:= MPFormModel(): New("MVC003_M")

//Adiciona ao modelo um componente de formulário
oModel:AddFields("ZBCMASTER",/*cOwner*/,oStruZBC)

//Adiciona a descrição do Modelo de Dados
oModel:SetDescription("Cadastro de Tipos de Chamados")

//Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZBCMASTER"):SetDescription("Cadastro de Tipos de Chamados")

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
Local oModel:= FwLoadModel("MVC003")

//Cria a estrutura a ser usada na View
Local oStruZBC:= FwFormStruct(2,"ZBC")

//Interface de visualização construída
Local oView

//Cria o objeto de View
oView:= FWFormView():New()

//Define qual Modelo de dados será utilizado na View
oView:= SetModel(oModel)

//Adiciona no nosso View um controle do tipo formulário
oView:AddField("VIEW_ZBC",oStruZBC,"ZBCMASTER")

//Cria um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox("TELA",100)

//Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView('View_ZBC','TELA')

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

Return FWMVCMenu("MVC003")	
return