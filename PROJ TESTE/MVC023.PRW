#INCLUDE "TOTVS.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "TRYEXCEPTION.CH"
#INCLUDE "FWEditPanel.CH"

#DEFINE ROTINA_FILE				"MVC023.prw"
#DEFINE VERSAO_ROTINA			"V" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[04])) + "-" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[05])) + "[" + Trim(AllToChar(GetAPOInfo(ROTINA_FILE)[03])) + "]"

#Define ALIAS_FORM0 			"ZNK" //Informe o Alias da Tabela
#Define ALIAS_GRID0 			"ZNL"
#Define MODELO					"MVC023"
#Define ID_MODEL				"MVC023_M"
#Define TITULO_MODEL			"Modelo Politicas de Credito por Cliente " + SubStr(VERSAO_ROTINA,1,17)
#Define TITULO_VIEW				"Politicas de Credito por Cliente"
#Define ID_MODEL_FORM0			"ZNKMASTER"
#Define ID_MODEL_GRID0			"ZNLDETAIL"
#Define ID_VIEW_FORM0			"VIEW_ZNK"
#Define ID_VIEW_GRID0			"VIEW_ZNL"
#Define PREFIXO_ALIAS_FORM0		Right(ZNKMASTER,03)
#Define PREFIXO_ALIAS_GRID0		Right(ZNKDETAIL,03)

#DEFINE TYPE_HEADER				1
#DEFINE TYPE_ITEMS				2

/*/{Protheus.doc} MVC023

Fonte Modelo de MVC - Interface Modelo 2
REMOVA COMENTÁRIOS, FUNÇÕES NÃO USADAS AO USAR O MODELO

@type function
@author Carlos Eduardo Niemeyer Rodrigues
@since 18/08/2017
@version P11,P12
@database MSSQL,Oracle

@param [aAutoCab], Array, Array com os Dados do Cabeçalho no Formato de Rotina Automática (Vide Campos de Cabeçalho na Interface)
@param [aAutoItens], Array, Array com os Dados dos Itens no Formato de Rotina Automática
@param [nOperacao], Numerico, Operação a ser realizada, sendo 3=Inclusão, 4=Alteração, 5=Exclusão
/*/
User Function MVC023(aAutoCab,aAutoItens,nOperacao)
	Local oFwMBrowse		:= Nil
	Local cAliasForm 		:= "ZNK"
	Local cModelo			:= MVC23_M
	Local cTitulo			:= POLITICA DE CREDITO POR CLIENTE
	Local cIDModelForm		:= ZNKMASTER
	Local cIDModelGrid		:= ZNLDETAIL
	Local cPrefForm			:= ZNKMASTER
	Local cPrefGrid			:= ZNLDETAIL	
	Local bKeyCTRL_X		:= {|| }
	Local bFecharEdicao		:= {|| ( oView := FwViewActive(), Iif( Type("oView") == "O" , oView:ButtonCancelAction() , .F. ) ) }			
	
	If ValType(aAutoCab) == "A" .And. ValType(aAutoItens) == "A" 
		runAutoExecute(aAutoCab,aAutoItens,nOperacao)
	Else	
		If ( FwAliasInDic(cAliasForm) )
			Private aRotina			:= MenuDef()
			
			oFwMBrowse := FWMBrowse():New()
			oFwMBrowse:SetAlias(ZNK)		
			oFwMBrowse:SetDescription(POLITICA DE CREDITO POR CLIENTE)
			oFwMBrowse:SetMenuDef(MVC023_M)
			
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
	Local cModelo			:= MVC023
	Local cIDModel			:= MVC023_M
	Local cTitulo			:= "Modelo Politica de Credito por Cliente"
	Local cIDModelForm		:= "ZNKMASTER"
	Local cIDModelGrid		:= "ZNLDETAIL"	
	Local cAliasForm 		:= "ZNK"
	Local cAliasGrid 		:= "ZNL"
	Local oStructForm 		:= Nil
	Local oStructGrid		:= Nil
	Local oModel 			:= Nil							 
	Local bActivate			:= {|oModel| activeForm(oModel) }
	Local bCommit			:= {|oModel| saveForm(oModel)}
	Local bCancel   		:= {|oModel| cancForm(oModel)}
	Local bPreValidacao		:= {|oModel| preValid(oModel)}
	Local bPosValidacao		:= {|oModel| posValid(oModel)} 
	Local bLinePre			:= {|oModelGrid,  nLine,  cAction, cField| LinepreValid(oModelGrid,  nLine,  cAction, cField)}
	
	Local cPrefForm			:= "ZNKMASTER"
	Local cPrefGrid			:= "ZNLDETAIL"
	Local cCpoFILIAL		:= "ZNL_FILIAL"
	Local cCpoGRUPO			:= "ZNL_GRUPO"
	Local cCpoCLASSIFICA	:= "ZNL_CLASS"
	Local cCpoREFERENCIA    := "ZNL_REFER"
	Local cCpoMAXIMO		:= "ZNL_MAX"
	Local cCpoMINIMO		:= "ZNL_MIN"
	Local cCpoFAIXA  		:= "ZNL_FAIXA"
    Local cCpoPESO  		:= "ZNL_PESO"
    Local cCpoNOTA  		:= "ZNL_NOTA"
    Local cCpoCOR   		:= "ZNL_COR"
    Local cCpoCODIGO        := "ZNL_COD"

	oStructForm	:= FWFormStruct( 1, "ZNK" , {|cCampo| AllTrim(cCampo)+"|" $ cCamposCab })	
	oStructGrid := FWFormStruct( 1, "ZNL" )
	
	//Evita Falha na Criação de campos Autonumerados no cabeçalho
	oStructGrid:SetProperty( cCpoCodigo , MODEL_FIELD_INIT,  {|| "" } )
	
	oModel		:= MPFormModel():New(MVC023_M,bPreValidacao,bPosValidacao,bCommit,bCancel)
	
	oModel:AddFields('ZNKMASTER', /*cOwner*/, oStructForm,/*bPreValidacao*/,/*bPosValidacao*/,/*bCarga*/)
	
	oModel:AddGrid( 'ZNLDETAIL','ZNKMASTER',oStructGrid,bLinePre,/*bLinePost*/,/*bPreVal*/,/*bPosVal*/)
	oModel:GetModel('ZNLDETAIL): SetDescription('Politica de Credito')	
	
	//Nota: No modelo 2 os campos de cabeçalho precisam todos estar dentro da relação para correta gravação dos dados, exceto campos virtuais
	
	oModel:SetRelation('ZNLDETAIL',{{'ZNL_FILIAL','xFilial("ZNL")'},{'ZNL_COD','ZNK_COD'}},ZNL->(IndexKey(1)))
    oModel:SetPrimaryKey( {"ZNKMASTER" cCpoFilial, cCpocodigo, cCpoNOME, cCpoCONDICAO, cCpoLIMITE, cCpoPRAZO, cCpoMESATIVO,cCpoSEMANATIVO,cCpoMATMEDIO,cCpoALTOCUSTO,cCpoPREMIUM} )
	oModel:SetActivate(bActivate)
	oModel:SetDescription(Clientes e Politicas de Credito)
	oModel:GetModel('ZNKMASTER'):SetDescription(CLIENTES POR FILIAL)

Return oModel

/*
	Função que Cria a Interface do Cadastro
*/
Static Function ViewDef()
	Local cModelo			:= FWLoadModel("MVC023")
	Local cIDModel			:= MVC023_M
	Local cTitulo			:= "Politicas de Credito por Cliente"
	Local cIDModelForm		:= ZNKMASTER
	Local cIDModelGrid		:= ZNKDETAIL
    Local cIDViewForm		:= VIEW_ZNK
	Local cIDViewGrid		:= VIEW_ZNL
    Local cAliasForm 		:= ZNK
	Local cAliasGrid 		:= ZNL
	Local oModel 			:= Nil
	Local oStructForm		:= Nil
	Local oStructGrid		:= Nil
	Local oView				:= Nil
	Local nOperation		:= 3
	
    Local cPrefForm			:= "ZNKMASTER"
	Local cPrefGrid			:= "ZNLDETAIL"
	Local cCpoFILIAL		:= "ZNL_FILIAL"
	Local cCpoGRUPO			:= "ZNL_GRUPO"
	Local cCpoCLASSIFICA	:= "ZNL_CLASS"
	Local cCpoREFERENCIA    := "ZNL_REFER"
	Local cCpoMAXIMO		:= "ZNL_MAX"
	Local cCpoMINIMO		:= "ZNL_MIN"
	Local cCpoFAIXA  		:= "ZNL_FAIXA"
    Local cCpoPESO  		:= "ZNL_PESO"
    Local cCpoNOTA  		:= "ZNL_NOTA"
    Local cCpoCOR   		:= "ZNL_COR"
    Local cCpoCODIGO        := "ZNL_COD"

	oModel 		:= FWLoadModel( "MVC023" )
	nOperacao	:= oModel:GetOperation()
	
	oStructForm	:= FWFormStruct( 2,"ZNK", {|cCampo| AllTrim(cCampo)+"|" $ cCamposCab })
	
	oStructGrid	:= FWFormStruct( 2, "ZNL" )                           
	
	oView 		:= FWFormView():New()

	oView:SetModel(oModel)

	oView:AddField('VIEW_ZNK',oStructForm,'ZNKMASTER')
	
	oView:AddGrid('VIEW_ZNL',oStructGrid,'ZNLDETAIL')
	
	oView:CreateHorizontalBox('SUPERIOR',40)
	oView:CreateHorizontalBox('INFERIOR',60)
	
	oView:SetOwnerView('VIEW_ZNK','SUPERIOR' )
	oView:SetOwnerView('VIEW_ZNK','INFERIOR' )
	
	oView:EnableTitleView("VIEW_ZNK","CLIENTES")
	oView:EnableTitleView("VIEW_ZNL","POLITICAS DE CREDITO")
	
Return oView

/*
	Rotina para Exportação de Dados do Modelo Ativo para o Excel
*/
Static Function exportModeltoExcel(lUseGrid)
	Local oModel		:= FwModelActive()
	Local cIDModelForm	:= ZNKMASTER
	Local cIDModelGrid	:= ZNLDETAIL
	Local oModelForm	:= oModel:GetModel(ZNKMASTER)
	Local oModelGrid	:= Iif(lUseGrid,oModel:GetModel(ZNLDETAIL),Nil)
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
	Local aButtons	:= {}
	Local aRotina 	:= {}
	
	//aRotina := FWMVCMenu( cModelo )
	
    ADD OPTION aRotina TITLE 'Visualizar' ACTION 'VIEWDEF.' + cModelo     OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'    ACTION 'VIEWDEF.' + cModelo     OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'    ACTION 'VIEWDEF.' + cModelo     OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'    ACTION 'VIEWDEF.' + cModelo     OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Copiar'     ACTION 'VIEWDEF.' + cModelo     OPERATION 9 ACCESS 0
	
	If ( FwIsInCallStack("U_" + cModelo) )
		ADD OPTION aRotina TITLE "Central de Processos"		ACTION 'u_MFAGEN40(,,,,cTags:="' + cModelo + '")' OPERATION 10 ACCESS 0
	
		aButtons := u_MFAGEN40(,,,,cTags:=cModelo,,.T.)
		ADD OPTION aRotina TITLE "Central de Processos On-Line..."	ACTION aButtons OPERATION 10 ACCESS 0
	Endif		
	
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

	If ( nOperation == MODEL_OPERATION_INSERT )
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
	Local cIDModelGrid	:= ZNLDETAIL
	Local oModelGrid	:= oModel:GetModel(ZNLDETAIL)
	Local lRet			:= .T.
	
Return lRet


/*
	Função de Validação executada na Ativação do Modelo
*/
Static Function activeForm(oModel)
	Local cIDModelForm		:= ZNKMASTER
    Local cIDModelGrid		:= ZNLDETAIL
	Local nOperation		:= oModel:GetOperation()
	Local oModelGrid		:= oModel:GetModel(ZNLDETAIL)
	Local aSaveLines 		:= FWSaveRows()
	Local nRecord			:= 0
	Local lRet				:= .T.
	
	Local cPrefForm			:="ZNKMASTER"
    Local cPrefGrid			:="ZNLDETAIL"


Return lRet

/*
	Executa a Rotina Automática de Gravação
*/
Static Function runAutoExecute(aAutoCab,aAutoItens,nOperacao)
	Local cModelo 		:= MVC023
	Local cAliasForm 	:= "ZNK"
	Local cAliasGrid 	:= "ZNL"
	Local cIDModelForm 	:= "ZNKMASTER"
	Local cIDModelGrid 	:= "ZNLDETAIL"
	Local oClassMVCAuto := ClassMVCAuto():newClassMVCAuto()	
	Local aRet			:= {}
	Local cErro			:= ""
	Local lRet 			:= .F.
	
	Default aAutoCab	:= {}
	Default aAutoItens	:= {}
	Default nOperacao	:= 3
	
	If podeExecutar(aAutoCab,aAutoItens,@cErro)

		//Se chamado por rotina externa - Reduz a Carga de Dados do Dicionário de Dados
		If Type("oMVC023") == "O"
			oClassMVCAuto:setObjectModel(oMVC023)
		Endif
	
		oClassMVCAuto:setAliasForm("ZNK")
		oClassMVCAuto:setAliasGrid("ZNL")
		oClassMVCAuto:setModelo(cMVC023)
		oClassMVCAuto:setModelForm("ZNKMASTER")
		oClassMVCAuto:setModelGrid("ZNLDETAIL")
		
		oClassMVCAuto:setAutoCab(aAutoCab)
		oClassMVCAuto:setAutoItens(aAutoItens)
		oClassMVCAuto:setOperacao(nOperacao)
		oClassMVCAuto:setUseTransaction(.F.)
		
		oClassMVCAuto:setRegMemory(.F.)
		
		oClassMVCAuto:lAudit := .F.
		
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
	Default cPrefixo	:= "[MVC023][" + DtoC(DDATABASE) + "][" + Time() + "] "	
	
	If lAtivaLog
		u_CMGEN13(cPrefixo + OEMToAnsi(cMensagem))
	Endif
	
Return
