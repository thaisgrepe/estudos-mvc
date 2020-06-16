#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRYEXCEPTION.CH"
#INCLUDE "FWEditPanel.CH"

#DEFINE ROTINA_FILE				"RATING.prw"
#DEFINE VERSAO_ROTINA			"V" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[04])) + "-" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[05])) + "[" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[03])) + "]"
	
#Define ALIAS_FORM0 			"ZKM" //Informe o Alias da Tabela
#Define MODELO					"RATING01"
#Define ID_MODEL				"RATING01_MODEL"
#Define TITULO_MODEL			"Cadastro RATING - Modelo 1 " + SubStr(VERSAO_ROTINA,1,17)
#Define TITULO_VIEW				CADASTRO RATING
#Define ID_MODEL_FORM0			RATING01_FORM0+"FORM0"
#Define ID_VIEW_FORM0			"RATING01_VIEW"
#Define PREFIXO_ALIAS_FORM0		Right(ZMK_FORM0,03),
0

#DEFINE TYPE_HEADER				1
#DEFINE TYPE_ITEMS				2

/*/{Protheus.doc} RATING

Fonte Modelo de MVC - Interface Modelo 1
REMOVA COMENTÁRIOS, FUNÇÕES NÃO USADAS AO USAR O MODELO

@type function
@author Carlos Eduardo Niemeyer Rodrigues
@since 20/08/2017
@version P11,P12
@database MSSQL,Oracle

@param [aAutoCab], Array, Array com os Dados do Cabeçalho no Formato de Rotina Automática (Vide Campos de Cabeçalho na Interface)
@param [nOperacao], Numerico, Operação a ser realizada, sendo 3=Inclusão, 4=Alteração, 5=Exclusão
/*/ 
User Function RATING01(aAutoCab,nOperacao)
	Local oFwMBrowse		:= Nil
	Local cAliasForm 		:= ZMK_FORM0
	Local cModelo			:= RATING01_MODEL
	Local cTitulo			:= CADASTRO RATING
	Local cIDModelForm		:= RATING01_MODEL_FORM0
	Local bKeyCTRL_X		:= {|| }
	Local bFecharEdicao		:= {|| ( oView := FwViewActive(), Iif( Type("oView") == "O" , oView:ButtonCancelAction() , .F. ) ) }
	
	If ValType(aAutoCab) == "A"
		runAutoExecute(aAutoCab,nOperacao)
	Else
		If ( FwAliasInDic(cAliasForm) )
			Private aRotina		:= MenuDef()

			oFwMBrowse:= FWMBrowse():New()
			oFwMBrowse:SetAlias(ZMK)
			oFwMBrowse:SetDescription(CADASTRO DE RATING)
			oFwMBrowse:SetMenuDef(RATING01_MODEL)
			
			oFwMBrowse:SetLocate()	
			oFwMBrowse:SetAmbiente(.F.)
			oFwMBrowse:SetWalkthru(.T.)		
			oFwMBrowse:SetDetails(.T.)
			oFwMBrowse:SetSizeDetails(60)
			oFwMBrowse:SetSizeBrowse(40)

			oFwMBrowse:SetCacheView(.T.)
			
			oFwMBrowse:SetAttach( .T. )
			oFwMBrowse:SetOpenChart( .T. )	
			
			bKeyCTRL_X	:= SetKey( K_CTRL_X, bFecharEdicao )
					
			oFwMBrowse:Activate()
			
			SetKey( K_CTRL_X, bKeyCTRL_X )
		Else
			MsgStop("Atenção! Alias da Tabela '" + cAliasForm + "' não encontrado nesse grupo de empresa.","MAFRA")
		Endif
	Endif
	
Return

/*
	Função que Define o Modelo de Dados do Cadastro
*/
Static Function ModelDef()
	Local cModelo			:= RATING01_MODEL
	Local cIDModel			:= RATING01_MODEL
	Local cTitulo			:= CADASTRO RATING
	Local cIDModelForm		:= RATING01_MODEL_FORM0
	Local cAliasForm 		:= ZMK_FORM0
	Local oStructForm 		:= Nil
	Local oModel 			:= Nil							 
	Local bActivate			:= {|oModel| activeForm(oModel) }
	Local bCommit			:= {|oModel| saveForm(oModel)}
	Local bCancel   		:= {|oModel| cancForm(oModel)}
	Local bPreValidacao		:= {|oModel| preValid(oModel)}
	Local bPosValidacao		:= {|oModel| posValid(oModel)} 
	
	Local cPrefForm			:= PREFIXO_ZMK_FORM0
	Local cCpoFilial		:= cPrefForm+"_FILIAL"
	Local cCpoCodigo		:= cPrefForm+"_COD"
	
	oStructForm	:= FWFormStruct( 1, ZMK )	

	oModel	:= MPFormModel():New(cIdModel,bPreValidacao,bPosValidacao,/*bCommit*/,/*bCancel*/)
	
	oModel:AddFields( RATING01_MODEL_FORM0, /*cOwner*/, oStructForm,/*bPreValidacao*/,/*bPosValidacao*/,/*bCarga*/)	
	
	oModel:SetPrimaryKey( { cCpoFilial, cCpoCodigo } )
	oModel:SetActivate(bActivate)
	oModel:SetDescription(cTitulo)	
	oModel:GetModel(cIDModelForm):SetDescription(cTitulo)

Return oModel

/*
	Função que Cria a Interface do Cadastro
*/
Static Function ViewDef()
	Local cModelo			:= RATING01_MODEL
	Local cIDModel			:= RATING01_MODEL
	Local cTitulo			:= CADASTRO RATING
	Local cIDModelForm		:= RATING01_MODEL_FORM0
	Local cIDViewForm		:= RATING01_VIEW_FORM0
	Local cAliasForm 		:= ZMK_FORM0
	Local oModel 			:= Nil
	Local oStructForm		:= Nil
	Local oView				:= Nil
	Local nOperation		:= MODEL_OPERATION_INSERT
	
	Local cPrefForm			:= PREFIXO_ZMK_FORM0
	Local cCpoFilial		:= cPrefForm+"_FILIAL"
	Local cCpoCodigo		:= cPrefForm+"_COD"

	oModel 		:= FWLoadModel( cModelo )
	nOperacao	:= oModel:GetOperation()
	
	oStructForm	:= FWFormStruct( 2, ZMK )

	oView 		:= FWFormView():New()

	oView:SetModel(oModel)

	oView:AddField(RATING01_VIEW_Form0,oStructForm,RATING01_MODEL_FORM0)
	
	/*
	 FF_LAYOUT_VERT_DESCR_TOP - Vertical com descrição acima do get
	 FF_LAYOUT_VERT_DESCR_LEFT - Vertical com descrição a esquerda
	 FF_LAYOUT_HORZ_DESCR_TOP - Horizontal com descrição acima do get
	 FF_LAYOUT_HORZ_DESCR_LEFT - Horizontal com descrição a esquerda           
	*/
	oView:SetViewProperty(cIDViewForm,"SETLAYOUT",{ FF_LAYOUT_VERT_DESCR_TOP , 5 } )	
	
	oView:CreateHorizontalBox('TOTAL',100)
	
	oView:SetOwnerView( cIDViewForm,'TOTAL' )
	
	oView:AddUserButton( 'Exportar Dados para o Excel', 'EXECUTE', {|| exportModeltoExcel() },'Exportar para Excel',VK_F9,,.F. )
	oView:AddUserButton( 'Central de Processos', 'CLIPS', {|oView| u_MFAGEN40(,,,,cTags:=cModelo) },'Central de Processos Relacionados...',,,.T. )

Return oView



/*
	Função que Monta o Menu da Rotina do Cadastro
*/
Static Function MenuDef()
	Local cModelo	:= RATING01_MODEL 
	Local aButtons	:= {}
	Local aRotina 	:= {}

	//aRotina := FWMVCMenu( cModelo )
	
    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.' + RATING01_MODEL OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.' + RATING01_MODEL OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.' + RATING01_MODEL OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.' + RATING01_MODEL OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.' + RATING01_MODEL OPERATION 9 ACCESS 0
    ADD OPTION aRotina TITLE "Central de Processos On-Line..."	ACTION aButtons OPERATION 10 ACCESS 0
	
    Endif	

Return aRotina

