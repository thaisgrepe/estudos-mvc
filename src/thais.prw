#include 'protheus.ch'
#include 'parmtype.ch'

Cadastro MVC DE Tabela de Cadastro de Técnicos

@author Thais Grepe
@since
@version

//--------------------------------------------------

User Function thais()

Local oBrw:= FWBrowser ():New()

oBrw:SetDescription("Cadastro de Tenicos")
oBrw:SetAlias("ZZA")

oBrw:Activate()


//--------------------------------------------------

Static Function ModelDef()

Local oStruZZA:= FWFormStruct(1,"ZZA")
Local oModel:= MPFormModel(): New ("MVC001_M")
oModel:AddFields("ZZAMASTER",/*cOwner*/,oStruZZA)
oModel: SetDescription("Cadastro de Tecnicos")	
oModel: GetModel("ZZAMASTER"):SetDescription("Cadastro de Ténicos") 

return(oModel)

//------------------------------------------------
{Protheus.doc} ViewDef

Funcao generica MVC do View

@return oView - Objeto ds View MVC
@author Thais Grepe
@since
@version

//-------------------------------------------

Static Function ViewDef()

Local oModel:= FWLoadModel(MVC001_M)
Local oStruZZA:= FwFormStruct(2,"ZZA")
Local oView
oView:= FWFormView():New
oView:=SetModel(oModel)
oView:=AddField("VIEW_ZZA",oStruZZA,"ZZAMASTER")
oView:CreateHorizontalBox("TELA",100) 