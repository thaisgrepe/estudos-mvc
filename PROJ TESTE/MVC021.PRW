#INCLUDE "PROTHEUS.CH"
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------
/*/{Protheus.doc} MVC021

Cadastro MVC de Tabela de Cadastro de Técnicos

@author Thais Grepe
@since 
@version 
/*/
//-------------------------------------------------------------------
User Function MVC021()

Local oBrw := FwMBrowse():New()

oBrw:SetDescription("Cadastro de Clientes por filial") 
oBrw:SetAlias("ZNK")

oBrw:Activate()

Return()

//-------------------------------------------------------------------
/*/{Protheus.doc} ModelDef

Funcao generica MVC do model

@return oModel - Objeto do Modelo MVC

@author Thais Grepe
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ModelDef()

// Cria a estrutura a ser usada no Modelo de Dados
Local oStruZNK  := FwFormStruct(1,"ZNK")

// Cria o objeto do Modelo de Dados
Local oModel    := MPFormModel():New("MVC021_M")

// Adiciona ao modelo um componente de formulário
oModel:AddFields("ZNKMASTER",/*cOwner*/,oStruZNK)

// Adiciona a descrição do Modelo de Dados 
oModel:SetDescription("Cadastro de Clientes por Filial")

// Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZNKMASTER" ):SetDescription("Cadastro de Clientes por Filial")

// Retorna o Modelo de dados 
Return(oModel)

//-------------------------------------------------------------------
/*/{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto da View MVC

@author Thaís Grepe
@since 
@version 
/*/
//-------------------------------------------------------------------
Static Function ViewDef()

// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
Local oModel   := FwLoadModel("MVC021")

// Cria a estrutura a ser usada na View 
Local oStruZNK := FwFormStruct(2,"ZNK")

// Interface de visualização construída 
Local oView 

// Cria o objeto de View
oView := FWFormView():New()

// Define qual o Modelo de dados será utilizado na View
oView:SetModel(oModel)

// Adiciona no nosso View um controle do tipo formulário  
// (antiga Enchoice
oView:AddField("VIEW_ZNK",oStruZNK,"ZNKMASTER")

// Criar um "box" horizontal para receber algum elemento da view 
oView:CreateHorizontalBox("TELA",100)

// Relaciona o identificador (ID) da View com o "box" para exibição 
oView:SetOwnerView( 'VIEW_ZNK', 'TELA' )

// Retorna o objeto de View criado
Return(oView)

//----------------------------------------------------------
/*/{Protheus.doc} MenuDef()
MenuDef   

@author Thaís Grepe
@since 
@version 
/*/
//----------------------------------------------------------
Static Function MenuDef()

Return FWMVCMenu( "MVC021" )