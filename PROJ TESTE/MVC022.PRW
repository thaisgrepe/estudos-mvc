#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch'

/*/{Protheus.doc} MVC002
//TODO Tela de cadastro em MVC com duas entidades
@author Thais Grepe
@version 

@type function
/*/
user function MVC022()
	Local aArea := GetArea()
	Local oBrowse := FwMBrowse():New()
	
	oBrowse:SetAlias("ZNK")
	oBrowse:SetDescription  ("Cadastro de Clientes por Filial")
	
	//ativa o browse
	oBrowse:Activate()
	RestArea(aArea)
		
return Nil

Static Function MenuDef()

	Local aRotina := FwMvcMenu("MVC022")

Return aRotina

Static Function ModelDef()
	Local oModel := MPFormModel():New("XMVC003",,,,)
	Local oStPai := FWFormStruct(1,"ZNK")
	Local oStFilho := FWFormStruct(1,"ZNL")
	
	oModel:AddFields("ZNKMASTER",,oStPai)
	oModel:AddGrid('ZNLDETAIL','ZNKMASTER',oStFilho,,,,,)
	
	oModel:SetRelation('ZNLDETAIL',{{'ZNL_FILIAL','xFilial("ZNL")'},{'ZNL_COD','ZNK_COD'}},ZNL->(IndexKey(1)))
	
		oModel:SetPrimaryKey({"ZNK_FILIAL",""})
		
	oModel:SetDescription("Modelo 3")
	oModel:GetModel('ZNKMASTER'):SetDescription('Modelo cadastro')
	oModel:GetModel('ZNLDETAIL'):SetDescription('Modelo credito')

Return oModel

Static Function ViewDef()
	local oView := Nil
	Local oModel := FWLoadModel("MVC022")
	Local oStPai := FwFormStruct(2,"ZNK")
	Local oStFilho := FwFormStruct(2,"ZNL")
	
	oView := FWFormView():New()
	oView:SetModel(oModel) 
	
	oView:AddField('VIEW_ZNK',oStPai,'ZNKMASTER')
	oView:AddGrid('VIEW_ZNL',oStFilho,'ZNLDETAIL')
	
	oView:CreateHorizontalBox('CABEC',40)
	oView:CreateHorizontalBox('GRID',60)
	
	oView:SetOwnerView('VIEW_ZNK','CABEC')
	oView:SetOwnerView('VIEW_ZNL','GRID')
	
	oView:EnableTitleView("VIEW_ZNK",'CLIENTES')
	oView:EnableTitleView("VIEW_ZNL",'POLITICAS DE CREDITO')


Return oView











