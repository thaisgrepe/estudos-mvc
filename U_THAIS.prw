#include 'protheus.ch'

user function U_THAIS()


//-------------------------------------------------------------------------------
/*/ {Protheus.doc}  MVC012

Cadastro MVC de Tabela de Cadastro de CLIENTES POR FILIAL

@author Thais Grepe
@since
@version

/*/
//--------------------------------------------------------------------------------
 

Local oBrw:= FwMBrowse():New()

oBrw: SetDescription("Cadastro de Clientes")
oBrw: SetAlias("ZMK")

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
Local oStruZMK:= FwFormStruct(1,"ZMK")

// Cria o objeto do Modelo de Dados
Local oModel:= MPFormModel(): New("MVC012_M")

//Adiciona ao modelo um componente de formulario
oModel:AddFields("ZMKMASTER",/*cOwner*/,oStruZMK)

//Adiciona a descricao do Modelo de Dados
oModel:SetDescription("Cadastro de Clientes")

//Adiciona a descricao do Componente do Modelo de Dados
oModel:GetModel("ZMKMASTER"):SetDescription("Cadastro de Clientes")

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
Local oModel:= FwLoadModel("MVC012")

//Cria a estrutura a ser usada na View
Local oStruSA1:= FwFormStruct(2,"ZMK")

//Interface de visualizacao construida
Local oView

//Cria o objeto de View
oView:= FWFormView():New()

//Define qual Modelo de dados sera utilizado na View
oView:= SetModel(oModel)

//Adiciona no nosso View um controle do tipo formulArio
oView:AddField("VIEW_ZMK",oStruZMK,"ZMKMASTER")

//Cria um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox("TELA",100)

//Relaciona o identificador (ID) da View com o "box" para exibiCAo
oView:SetOwnerView('View_ZMK','TELA')

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

Return FWMVCMenu("MVC012")	
return