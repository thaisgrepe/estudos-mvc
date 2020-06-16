#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRYEXCEPTION.CH"
#INCLUDE "FWEditPanel.CH"

USER FUNCTION CADASTRO()
LOCAL oBROWSE:= fwMBrowse():New()
oBROWSE:SetAlias("ZMK")
oBROWSE:SetDescription("Cadastro por Filial")
oBROWSE:Activate()

return

/* add legendas*/

Static Function MenuDef()
Local aRotAux:=FWMVCMenu("CADASTRO")
Local aRotina:={}
For nX:=1 To Len(aRotAux)
AADD(aRotina,aRotAux[nX])

Next
Return aRotina

StaticFunction ModelDef()
Local oModel:= MPFormModel(): New("Cadastro")
LocalStForm:=FWFormStruct(1,"ZMK")
LocalStGrid:=FWFormStruct(1,"ZML")
oModel:AddFields("ZMKMASTER",,oStForm)
oModel:AddGrid("ZMLDETAIL","ZMKMASTER",oStGrid,,,,)
oModel:SetRelation('ZMLDETAIL',{{'ZML_FILIAL','xFilial("ZML")'},{'ZML_GRUPO','ZML_CLASS','ZML_REFERENCIA','ZML_MAX','ZML_MIN','ZML_FAIXA','ZML_PESO','ZML_NOTA','ZML_COR'}},ZML->(IndexKey(1))
oModel:SetPrimaryKey{{"ZML_FILIAL",""}}
oModelodel:SetDescription("Modelo3")
oModel:GetModel('ZMKMASTER'):SetDescription('ModeloClientes')
oModel:GetModel('ZMLDETAIL'):SetDescription('ModeloRating')

Return oModel

Static Function ViewDef()
Local oView:NIL
Local oModel:=FWLoadModel(" Cadastro")
Local oStZMK:=FWFormStruct(2,"ZMK")
Local oStZML:=FWFormStruct(2,"ZML")
oView:=FWFormView():New()
oView:SetModel(oModel)
oView:AddField('View_ZMK',oStForm,'ZMKMASTER')
oView:AddGrid('View_ZML',oStGrid,'ZMLDETAIL')
oView:CreateHorizontalBox('Cabec,40')
oView:CreateHorizontalBox('GRID,60')
oView:SetOwnerView('View_ZMK','CABEC')
oView:SetOwnerView('View_ZML','GRID')
oView:EnableTitleView("VIEW_ZMK",'CABEÇALHO')
oView:EnableTitleView("VIEW_ZML",'GRID')

Return oView
