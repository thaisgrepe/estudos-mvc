#include 'protheus.ch'
#include 'parmtype.ch'

user function olitha()
	#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRYEXCEPTION.CH"
#INCLUDE "FWEditPanel.CH"

#DEFINE ROTINA_FILE				"MFAMOD02.prw"
#DEFINE VERSAO_ROTINA			"V" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[04])) + "-" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[05])) + "[" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[03])) + "]"

#Define ALIAS_FORM0 			"Z03" //Informe o Alias da Tabela
#Define ALIAS_GRID0 			ALIAS_FORM0
#Define MODELO					"MFAMOD02"
#Define ID_MODEL				"MFMMOD02"
#Define TITULO_MODEL			"Cadastro Modelo MVC - Modelo 2 " + SubStr(VERSAO_ROTINA,1,17)
#Define TITULO_VIEW				TITULO_MODEL
#Define ID_MODEL_FORM0			ALIAS_FORM0+"FORM0"
#Define ID_MODEL_GRID0			ALIAS_GRID0+"GRID0"
#Define ID_VIEW_FORM0			"VIEW_FORM0"
#Define ID_VIEW_GRID0			"VIEW_GRID0"
#Define PREFIXO_ALIAS_FORM0		Right(ALIAS_FORM0,03)
#Define PREFIXO_ALIAS_GRID0		Right(ALIAS_GRID0,03)

#DEFINE TYPE_HEADER				1
#DEFINE TYPE_ITEMS				2

/*/{Protheus.doc} MFAMOD02

Fonte Modelo de MVC - Interface Modelo 2

@type function
@author Carlos Eduardo Niemeyer Rodrigues
@since 18/08/2017
@version P11,P12
@database MSSQL,Oracle

@param [aAutoCab], Array, Array com os Dados do Cabeçalho no Formato de Rotina Automática (Vide Campos de Cabeçalho na Interface)
@param [aAutoItens], Array, Array com os Dados dos Itens no Formato de Rotina Automática
@param [nOperacao], Numerico, Operação a ser realizada, sendo 3=Inclusão, 4=Alteração, 5=Exclusão
/*/
User Function MFAMOD02(aAutoCab,aAutoItens,nOperacao)
	Local oFwMBrowse		:= Nil
	Local cAliasForm 		:= ALIAS_FORM0
	Local cModelo			:= MODELO
	Local cTitulo			:= TITULO_MODEL
	Local cIDModelForm		:= ID_MODEL_FORM0
	Local cIDModelGrid		:= ID_MODEL_GRID0
	Local cPrefForm			:= PREFIXO_ALIAS_FORM0
	Local cPrefGrid			:= PREFIXO_ALIAS_GRID0	
	Local bKeyCTRL_X		:= {|| }
	Local bFecharEdicao		:= {|| ( oView := FwViewActive(), Iif( Type("oView") == "O" , oView:ButtonCancelAction() , .F. ) ) }			
	
	If ValType(aAutoCab) == "A" .And. ValType(aAutoItens) == "A" 
		runAutoExecute(aAutoCab,aAutoItens,nOperacao)
	Else	
		Private aRotina			:= MenuDef()
		
		oFwMBrowse := FWMBrowse():New()
		oFwMBrowse:SetAlias(cAliasForm)		
		oFwMBrowse:SetDescription(cTitulo)
		oFwMBrowse:SetMenuDef(cModelo)
		
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
	Endif
	
Return

/*
	Função que Define o Modelo de Dados do Cadastro
*/
Static Function ModelDef()
	Local cModelo			:= MODELO
	Local cIDModel			:= ID_MODEL
	Local cTitulo			:= TITULO_MODEL
	Local cIDModelForm		:= ID_MODEL_FORM0
	Local cIDModelGrid		:= ID_MODEL_GRID0	
	Local cAliasForm 		:= ALIAS_FORM0
	Local cAliasGrid 		:= ALIAS_GRID0
	Local oStructForm 		:= Nil
	Local oStructGrid		:= Nil
	Local oModel 			:= Nil							 
	Local bActivate			:= {|oModel| activeForm(oModel) }
	Local bCommit			:= {|oModel| saveForm(oModel)}
	Local bCancel   		:= {|oModel| cancForm(oModel)}
	Local bPreValidacao		:= {|oModel| preValid(oModel)}
	Local bPosValidacao		:= {|oModel| posValid(oModel)} 
	Local bLinePre			:= {|oModelGrid,  nLine,  cAction, cField| LinepreValid(oModelGrid,  nLine,  cAction, cField)}
	
	Local cPrefForm			:= PREFIXO_ALIAS_FORM0
	Local cPrefGrid			:= PREFIXO_ALIAS_GRID0
	Local cCpoFilial		:= cPrefForm+"_FILIAL"
	Local cCpoCodigo		:= cPrefForm+"_CODIGO"
	Local cCpoAno			:= cPrefForm+"_ANO"
	Local cCpoTrimestre		:= cPrefForm+"_TRIMES"
	Local cCpoVendedor		:= cPrefForm+"_VEND"
	Local cCpoTipo			:= cPrefForm+"_TIPO"
	Local cCpoGrupoMeta		:= cPrefForm+"_GRPMET"
	Local cCamposCab		:= cCpoFilial+"|"+cCpoAno+"|"+cCpoTrimestre+"|"
	
	oStructForm	:= FWFormStruct( 1, cAliasForm , {|cCampo| AllTrim(cCampo)+"|" $ cCamposCab })	
	oStructGrid := FWFormStruct( 1, cAliasGrid )
	
	oStructGrid:SetProperty( cCpoAno , MODEL_FIELD_OBRIGAT,  .F. )
	oStructGrid:SetProperty( cCpoTrimestre , MODEL_FIELD_OBRIGAT,  .F. )
	
	//Evita Falha na Criação de campos Autonumerados no cabeçalho
	oStructGrid:SetProperty( cCpoCodigo , MODEL_FIELD_INIT,  {|| "" } )
	
	oModel		:= MPFormModel():New(cIdModel,bPreValidacao,bPosValidacao,bCommit,bCancel)
	
	oModel:AddFields( cIDModelForm, /*cOwner*/, oStructForm,/*bPreValidacao*/,/*bPosValidacao*/,/*bCarga*/)
	
	oModel:AddGrid( cIDModelGrid,cIDModelForm,oStructGrid,bLinePre,/*bLinePost*/,/*bPreVal*/,/*bPosVal*/)
	oModel:GetModel(cIDModelGrid):SetUniqueLine( { cCpoVendedor, cCpoTipo, cCpoGrupoMeta} )	
	
	//Nota: No modelo 2 os campos de cabeçalho precisam todos estar dentro da relação para correta gravação dos dados
	oModel:SetRelation(cIDModelGrid,{{cCpoFilial,'xFilial("'+cAliasForm+'")'},{cCpoAno,cCpoAno},{cCpoTrimestre,cCpoTrimestre}},(cAliasGrid)->(IndexKey(1)))
	
	oModel:SetPrimaryKey( { cCpoFilial, cCpoAno, cCpoTrimestre, cCpoVendedor, cCpoTipo, cCpoGrupoMeta } )
	oModel:SetActivate(bActivate)
	oModel:SetDescription(cTitulo)
	
	oModel:GetModel(cIDModelForm):SetDescription(cTitulo)

Return oModel

/*
	Função que Cria a Interface do Cadastro
*/
Static Function ViewDef()
	Local cModelo			:= MODELO
	Local cIDModel			:= ID_MODEL
	Local cTitulo			:= TITULO_VIEW
	Local cIDModelForm		:= ID_MODEL_FORM0
	Local cIDModelGrid		:= ID_MODEL_GRID0
	Local cIDViewForm		:= ID_VIEW_FORM0
	Local cIDViewGrid		:= ID_VIEW_GRID0
	Local cAliasForm 		:= ALIAS_FORM0
	Local cAliasGrid 		:= ALIAS_GRID0
	Local oModel 			:= Nil
	Local oStructForm		:= Nil
	Local oStructGrid		:= Nil
	Local oView				:= Nil
	Local nOperation		:= 3
	
	Local cPrefForm			:= PREFIXO_ALIAS_FORM0
	Local cPrefGrid			:= PREFIXO_ALIAS_GRID0
	Local cCpoFilial		:= cPrefForm+"_FILIAL"
	Local cCpoAno			:= cPrefForm+"_ANO"
	Local cCpoTrimestre		:= cPrefForm+"_TRIMES"
	Local cCpoVendedor		:= cPrefForm+"_VEND"
	Local cCpoTipo			:= cPrefForm+"_TIPO"
	Local cCpoGrupoMeta		:= cPrefForm+"_GRPMET"
	Local cCamposCab		:= cCpoFilial+"|"+cCpoAno+"|"+cCpoTrimestre+"|"

	oModel 		:= FWLoadModel( cModelo )
	nOperacao	:= oModel:GetOperation()
	
	oStructForm	:= FWFormStruct( 2, cAliasForm , {|cCampo| AllTrim(cCampo)+"|" $ cCamposCab })
	
	oStructGrid	:= FWFormStruct( 2, cAliasGrid )                           
	oStructGrid:RemoveField(cCpoAno)
	oStructGrid:RemoveField(cCpoTrimestre)
	
	oView 		:= FWFormView():New()

	oView:SetModel(oModel)

	oView:AddField(cIDViewForm,oStructForm,cIDModelForm)
	
	/*
	 FF_LAYOUT_VERT_DESCR_TOP - Vertical com descrição acima do get
	 FF_LAYOUT_VERT_DESCR_LEFT - Vertical com descrição a esquerda
	 FF_LAYOUT_HORZ_DESCR_TOP - Horizontal com descrição acima do get
	 FF_LAYOUT_HORZ_DESCR_LEFT - Horizontal com descrição a esquerda           
	*/
	oView:SetViewProperty(cIDViewForm,"SETLAYOUT",{ FF_LAYOUT_VERT_DESCR_TOP , 5 } )	
	
	oView:AddGrid(cIDViewGrid,oStructGrid,cIDModelGrid)
	
	oView:CreateHorizontalBox('SUPERIOR',20)
	oView:CreateHorizontalBox('INFERIOR',80)
	
	oView:SetOwnerView( cIDViewForm,'SUPERIOR' )
	oView:SetOwnerView( cIDViewGrid,'INFERIOR' )
	
	oView:SetViewProperty(cIDViewGrid,"ENABLENEWGRID")
	//oView:SetViewProperty(cIDViewGrid,"ENABLEDCOPYLINE",{VK_F12})
	oView:SetViewProperty(cIDViewGrid,"GRIDFILTER")
	oView:SetViewProperty(cIDViewGrid,"GRIDSEEK")	
	
	oView:EnableTitleView(cIDViewForm,"Período")
	oView:EnableTitleView(cIDViewGrid,"Metas por Vendedor e Grupos de Produtos")
	
	oView:AddUserButton( 'Exportar Dados para o Excel', 'EXECUTE', {|| exportModeltoExcel(.T.) },'Exportar para Excel',VK_F9,,.F. )
	oView:AddUserButton( 'Central de Procesos', 'CLIPS', {|oView| u_MFAGEN40(,,,,cTags:=cModelo) },'Central de Processos Relacionados...',,,.T. )
	
Return oView

/*
	Rotina para Exportação de Dados do Modelo Ativo para o Excel
*/
Static Function exportModeltoExcel(lUseGrid)
	Local oModel		:= FwModelActive()
	Local cIDModelForm	:= ID_MODEL_FORM0
	Local cIDModelGrid	:= ID_MODEL_GRID0
	Local oModelForm	:= oModel:GetModel(cIDModelForm)
	Local oModelGrid	:= Iif(lUseGrid,oModel:GetModel(cIDModelGrid),Nil)
	Local aFormHeader	:= {}
	Local aFormData		:= {}
	Local aGridHeader	:= {}
	Local aGridData		:= {}
	Local aExport		:= {}
	Local bAcao 		:= {|| }
	
	Default lUseGrid	:= .F.
	
	loadDataModel(oModelForm,@aFormHeader,@aFormData,.T.,TYPE_HEADER)
	If lUseGrid
		loadDataModel(oModelGrid,@aGridHeader,@aGridData,.T.,TYPE_ITEMS)
	Endif

	aAdd( aExport, {"CABECALHO", oModelForm:GetDescription(), aFormHeader, aFormData } )
	If lUseGrid
		aAdd( aExport, {"GETDADOS", oModelGrid:GetDescription(), aGridHeader, aGridData } )	
	Endif
	
	bAcao 	:= { || DlgToExcel(aExport) }
	
	FwMsgRun( ,bAcao, "MAFRA", "Exportando Dados para o Excel..." )
	
Return

/*
	Carrega os Dados de Estrutura do Model
*/
Static Function loadDataModel(oModel,aFields,aData,lUseTitle,nType)
	Local nRecord			:= 0
	Local nField			:= 0
	Local cField			:= ""	
	Local uContent			:= ""
	Local cAlias			:= ""
	Local aHeader			:= {}
	Local aRecord			:= {}
	Local oIpArraysObject	:= Nil
	
	Default lUseTitle		:= .T.
	
	aFields	:= {}
	aData	:= {}

	If ValType(oModel) == "O"
		If nType == TYPE_HEADER
			For nField:=1 to Len(oModel:oFormModelStruct:aFields)		
				cField 	:= oModel:oFormModelStruct:aFields[nField,03]
				
				If !Empty(cField)
					uContent	:= oModel:GetValue(cField)
					
					If lUseTitle
						cField := RetTitle(cField)
					Endif
					aAdd( aFields, cField )
					aAdd( aData, uContent )
				Endif
			Next nField
		Else	
			For nRecord:=1 to oModel:GetQtdLine()
				oModel:GoLine(nRecord)
		
				aRecord := {}
				For nField:=1 to Len(oModel:oFormModelStruct:aFields)				
					cField 		:= oModel:oFormModelStruct:aFields[nField,03]
					
					If !Empty(cField)
						uContent	:= oModel:GetValue(cField)			
						
						If nRecord == 1
							aAdd( aFields, cField )
						Endif
						aAdd( aRecord, uContent )
					Endif
				Next nField
				aAdd( aRecord, .F. )
				
				aAdd( aData , aRecord )
				
			Next nRecord
			
			oIpArraysObject := IpArraysObject():newIpArraysObject()
			aFields := oIpArraysObject:convToHeader(aFields,.T.)
			freeObj(oIpArraysObject)
		Endif
	Endif
	
Return

/*
	Função que Monta o Menu da Rotina do Cadastro
*/
Static Function MenuDef()
	Local cModelo	:= MODELO 
	Local aRotina 	:= {}
	
	//aRotina := FWMVCMenu( cModelo )
	
    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.' + cModelo     OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.' + cModelo     OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.' + cModelo     OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.' + cModelo     OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.' + cModelo     OPERATION 9 ACCESS 0
	ADD OPTION aRotina TITLE "Central de Processos"		ACTION 'u_MFAGEN40(,,,,cTags:="' + cModelo + '")' OPERATION 10 ACCESS 0
	
Return aRotina

/*
	Função para Salvar os Dados do Cadastro usando MVC
*/ 
Static Function saveForm(oModel)
	Local nOperation	:= oModel:GetOperation()
	Local lRet 			:= .T.
	 
	FWModelActive(oModel)
	lRet := FWFormCommit(oModel)
	
Return lRet

/*
	Função executado no Cancelamento da Tela de Cadastro
*/ 
Static Function cancForm(oModel)
	Local nOperation	:= oModel:GetOperation()
	Local lRet			:= .T.

	If nOperation == MODEL_OPERATION_INSERT
		RollBackSX8()
	EndIf		

Return lRet

/*
	Função para Validar os Dados Antes da Confirmação da Linha da Grid
*/
Static Function LinepreValid(oModelGrid, nLinha, cAcao, cCampo)
	Local oModel		:= oModelGrid:GetModel()
	Local nOperation	:= oModel:GetOperation()
	Local lRet			:= .T.
	
Return lRet

/*
	Função para Validar os Dados Antes da Confirmação da Tela do Cadastro
*/
Static Function preValid(oModel)
	Local nOperation	:= oModel:GetOperation()
	Local cIDModelGrid	:= ID_MODEL_GRID0
	Local oModelGrid	:= oModel:GetModel(cIDModelGrid)
	Local lRet			:= .T.
	
Return lRet

/*
	Função para Validar os Dados Após Confirmação da Tela de Cadastro - Verifica se pode incluir
*/
Static Function posValid(oModel)
	Local cIDModelForm	:= ID_MODEL_FORM0
	Local cIDModelGrid	:= ID_MODEL_GRID0
	Local cAliasForm 	:= ALIAS_FORM0
	Local nOperation	:= oModel:GetOperation()
	Local lRet			:= .T.
	
	Local cPrefForm		:= PREFIXO_ALIAS_FORM0
	Local cPrefGrid		:= PREFIXO_ALIAS_GRID0
	Local cCpoAno		:= cPrefForm+"_ANO"
	Local cCpoTrimestre	:= cPrefForm+"_TRIMES"
	Local cFilMeta		:= xFilial(cAliasForm)
	Local cAno 			:= oModel:GetValue(cIDModelForm,cCpoAno)
	Local cTrimestre	:= oModel:GetValue(cIDModelForm,cCpoTrimestre)

	If nOperation = MODEL_OPERATION_INSERT			
		dbSelectArea(cAliasForm)
		(cAliasForm)->(dbSetOrder(1))
		If (cAliasForm)->(dbSeek(cFilMeta+cAno+cTrimestre))
			Help(,,"HELP",,"Atenção! Já existe meta para o período informado na base de dados para esta filial. Use a opção alterar.",1,0)
			lRet := .F.
		Endif		
	Endif	

Return lRet

/*
	Função de Validação executada na Ativação do Modelo
*/
Static Function activeForm(oModel)
	Local cIDModelForm		:= ID_MODEL_FORM0
	Local cIDModelGrid		:= ID_MODEL_GRID0
	Local nOperation		:= oModel:GetOperation()
	Local oModelGrid		:= oModel:GetModel(cIDModelGrid)
	Local aSaveLines 		:= FWSaveRows()
	Local nRecord			:= 0
	Local lRet				:= .T.
	
	Local cPrefForm			:= PREFIXO_ALIAS_FORM0
	Local cPrefGrid			:= PREFIXO_ALIAS_GRID0


Return lRet

/*
	Executa a Rotina Automática de Gravação
*/
Static Function runAutoExecute(aAutoCab,aAutoItens,nOperacao)
	Local cModelo 		:= MODELO
	Local cAliasForm 	:= ALIAS_FORM0
	Local cAliasGrid 	:= ALIAS_GRID0
	Local cIDModelForm 	:= cAliasForm+"FORM0"
	Local cIDModelGrid 	:= cAliasGrid+"GRID0"
	Local oClassMVCAuto := ClassMVCAuto():newClassMVCAuto()	
	Local aRet			:= {}
	Local cErro			:= ""
	Local lRet 			:= .F.
	
	Default aAutoCab	:= {}
	Default aAutoItens	:= {}
	Default nOperacao	:= 3
	
	If podeExecutar(aAutoCab,aAutoItens,@cErro)

		//Se chamado por rotina externa - Reduz a Carga de Dados do Dicionário de Dados
		If Type("oMFAMOD02") == "O"
			oClassMVCAuto:setObjectModel(oMFAMOD02)
		Endif
	
		oClassMVCAuto:setAliasForm(cAliasForm)
		oClassMVCAuto:setAliasGrid(cAliasGrid)
		oClassMVCAuto:setModelo(cModelo)
		oClassMVCAuto:setModelForm(cIDModelForm)
		oClassMVCAuto:setModelGrid(cIDModelGrid)
		
		oClassMVCAuto:setAutoCab(aAutoCab)
		oClassMVCAuto:setAutoItens(aAutoItens)
		oClassMVCAuto:setOperacao(nOperacao)
		oClassMVCAuto:setUseTransaction(.T.)
		
		oClassMVCAuto:setRegMemory(.T.)
		
		aRet 	:= oClassMVCAuto:execute()	
		lRet	:= aRet[01]
		cErro   := aRet[02]
	Endif
	
	If lRet
		lMsErroAuto := .F.
	Else
		lMsErroAuto := .T.
		showLogInConsole(cErro)
		Help(,,"HELP",,cErro,1,0)
	Endif

Return lRet

/*
	Verifica se pode Executar
*/
Static Function podeExecutar(aAutoCab,aAutoItens,cErro)
	Local lRet	:= .F.
	
	Begin Sequence
	
		If Len(aAutoCab) == 0
			cErro := "Falha na Carga dos Dados de Cabeçalho."
			Break
		Endif
		
		If Len(aAutoItens) == 0
			cErro := "Falha na Carga dos Dados dos Itens."
			Break
		Endif		
		
		lRet := .T.
	
	End Sequence
	
	If !lRet
		showLogInConsole(cErro)
	Endif
	
Return lRet

/*
	Apresenta a Mensagem no Console do Protheus
*/
Static Function showLogInConsole(cMensagem,lAtivaLog,cPrefixo)
	Default lAtivaLog	:= GetNewPar("ZZ_LOGS",.T.)
	Default cMensagem 	:= ""
	Default cPrefixo	:= "[MFAMOD02][" + DtoC(DDATABASE) + "][" + Time() + "] "	
	
	If lAtivaLog
		u_CMGEN13(cPrefixo + OEMToAnsi(cMensagem))
	Endif
return