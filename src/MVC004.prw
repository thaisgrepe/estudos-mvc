#include 'protheus.ch'
#INCLUDE "FWMVCDEF.CH"

//-------------------------------------------------------------------------------
/*/ {Protheus.doc}  MVC004

Cadastro MVC de Tabela de Cadastro de técnicos

@author Thais Grepe
@since
@version

/*/
//--------------------------------------------------------------------------------
 
user function MVC004()

Local oBrw:= FwMBrowse():New()

oBrw: SetDescription("Cadastro de Chamados ")
oBrw: SetAlias("ZBD")
oBrw:AddLegend("ZBD_STATUS=='1'","GREEN  ", "Aberto")
oBrw:AddLegend("ZBD_STATUS=='2'","BLUE   ", "Em Atendimento")
oBrw:AddLegend("ZBD_STATUS=='3'","YELLOW ", "Aguardando")
oBrw:AddLegend("ZBD_STATUS=='4'","BLACK  ", "Encerrado")
oBrw:AddLegend("ZBD_STATUS=='5'","RED    ", "Em atraso")

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
Local oStruZBD:= FwFormStruct(1,"ZBD")

// Cria o objeto do Modelo de Dados
Local oModel:= MPFormModel(): New("MVC004_M")

//Adiciona ao modelo um componente de formulário
oModel:AddFields("ZBDMASTER",/*cOwner*/,oStruZBD)

//Adiciona a descrição do Modelo de Dados
oModel:SetDescription("Cadastro de Chamados" )

//Adiciona a descrição do Componente do Modelo de Dados
oModel:GetModel("ZBDMASTER"):SetDescription("Cadastro de Chamados")

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
Local oModel:= FwLoadModel("MVC004")

//Cria a estrutura a ser usada na View
Local oStruZBD:= FwFormStruct(2,"ZBD")

//Interface de visualização construída
Local oView

//Cria o objeto de View
oView:= FWFormView():New()

//Define qual Modelo de dados será utilizado na View
oView:= SetModel(oModel)

//Adiciona no nosso View um controle do tipo formulário
oView:AddField("VIEW_ZBD",oStruZBD,"ZBDMASTER")

//Cria um "box" horizontal para receber algum elemento da view
oView:CreateHorizontalBox("TELA",100)

//Relaciona o identificador (ID) da View com o "box" para exibição
oView:SetOwnerView('View_ZBD','TELA')

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

Return FWMVCMenu("MVC004")
