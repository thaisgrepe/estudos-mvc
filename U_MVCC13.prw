#include 'protheus.ch'
#include 'parmtype.ch'
#include 'FwMvcDef.ch'

/*/{Protheus.doc} MVC013
//TODO Tela de cadastro em MVC com duas entidades
@author Thais Grepe

@type function
/*/
user function MVCC13()
	Local aArea := GetArea()
	Local oBrowse := FwMBrowse():New()
	
	oBrowse:SetAlias("ZMK")
	oBrowse:SetDescription  ("Clientes")
	
	//ativa o browse
	oBrowse:Activate()
	RestArea(aArea)
		
return Nil

Static Function MenuDef()

	Local aRotina := FwMvcMenu("MVCC13")

Return aRotina

Static Function ModelDef()
	Local oModel := MPFormModel():New("XMVC003",,,,)
	Local oStPai := FWFormStruct(1,"ZMK")
	Local oStFilho := FWFormStruct(1,"ZML")
	
	oModel:AddFields("ZMKMASTER",,oStPai)
	oModel:AddGrid('ZMLDETAIL','ZMLMASTER',oStFilho,,,,,)
	
	oModel:SetRelation('ZMLDETAIL',{{'ZML_FILIAL','xFilial("ZML")'},{'ZML_CLASS','ZZB_NOTA','ZML_COR'}},ZZA->(IndexKey(1)))
	
		oModel:SetPrimaryKey({"ZML_FILIAL",""})
		
	oModel:SetDescription("Modelo 3")
	oModel:GetModel('ZMKMASTER'):SetDescription('Clientes por filial')
	oModel:GetModel('ZMLDETAIL'):SetDescription('Rating Clientes')

Return oModel

Static Function ViewDef()
	local oView := Nil
	Local oModel := FWLoadModel("MVCC13")
	Local oStPai := FwFormStruct(2,"ZMK")
	Local oStFilho := FwFormStruct(2,"ZML")
	
	oView := FWFormView():New()
	oView:SetModel(oModel) 
	
	oView:AddField('VIEW_ZMK',oStPai,'ZMKMASTER')
	oView:AddGrid('VIEW_ZML',oStFilho,'ZMLDETAIL')
	
	oView:CreateHorizontalBox('CABEC',40)
	oView:CreateHorizontalBox('GRID',60)
	
	oView:SetOwnerView('VIEW_ZMK','CABEC')
	oView:SetOwnerView('VIEW_ZML','GRID')
	
	oView:EnableTitleView("VIEW_ZMK",'Cabeçalho')
	oView:EnableTitleView("VIEW_ZML",'Grid')


Return oView
