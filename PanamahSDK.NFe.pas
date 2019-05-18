unit PanamahSDK.NFe;

interface

uses
  StrUtils, SysUtils, Classes, PanamahSDK.Types, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Cliente, PanamahSDK.Models.Venda, ActiveX;

type

  TPanamahNFeDocumentType = (ndtDESCONHECIDO, ndtENTRADA, ndtSAIDA, ndtCANCELAMENTO);

  TPanamahNFeDocumentTypeSet = set of TPanamahNFeDocumentType;

  IPanamahNFeDocument = interface
    ['{D4B3A500-E80F-4B13-82AA-0E3F882E0158}']
    function GetItem(AIndex: Integer): IPanamahModel;
    function GetDocumentType: TPanamahNFeDocumentType;
    function GetCount: Integer;
    function GetId: string;
    procedure DeserializeFromXML(const AXML: string);
    procedure DeserializeFromFile(const AFilename: string);
    procedure SetDocumentType(AType: TPanamahNFeDocumentType);
    procedure SetId(const AId: string);
    property Count: Integer read GetCount;
    property DocumentType: TPanamahNFeDocumentType read GetDocumentType write SetDocumentType;
    property Items[AIndex: Integer]: IPanamahModel read GetItem; default;
    property Id: string read GetId write SetId;
  end;

  IPanamahNFeDocumentList = interface
    ['{2CFB6ECB-36E3-430B-9F6D-A2C090B862AB}']
    function GetCount: Integer;
    function GetItem(AIndex: Integer): IPanamahNFeDocument;
    procedure Clear;
    procedure SetItem(AIndex: Integer; const Value: IPanamahNFeDocument);
    procedure LoadFromDirectory(const ADirectory: string);
    procedure Add(const AItem: IPanamahNFeDocument);
    property Items[AIndex: Integer]: IPanamahNFeDocument read GetItem write SetItem; default;
    property Count: Integer read GetCount;
  end;

  TPanamahNFeDeserializer = class
  public
    class function DeserializeLojaFromEmit(const ANFeXML: string): IPanamahLoja;
    class function DeserializeClienteFromDest(const ANFeXML: string): IPanamahCliente;
    class function DeserializeFornecedorFromEmit(const ANFeXML: string): IPanamahFornecedor;
    class function DeserializeLojaFromDest(const ANFeXML: string): IPanamahLoja;
    class function DeserializeProdutosFromProd(const ANFeXML: string): IPanamahProdutoList;
    class function DeserializeVendaFromNFe(const ANFeXML: string): IPanamahVenda;
    class function GetIdFromXML(const ANFeXML: string): string;
  end;

  TPanamahNFeDocument = class(TInterfacedObject, IPanamahNFeDocument)
  private
    FModels: TInterfaceList;
    FDataTypes: TStrings;
    FDocumentType: TPanamahNFeDocumentType;
    FId: string;
    function GetDocumentType: TPanamahNFeDocumentType;
    function GetItem(AIndex: Integer): IPanamahModel;
    function GetId: string;
    function FindOutDocumentType(const AId: string): TPanamahNFeDocumentType;
    procedure SetDocumentType(AType: TPanamahNFeDocumentType);
    procedure SetId(const AId: string);
    procedure Add(AModel: IPanamahModel);
  public
    constructor Create; reintroduce;
    function GetCount: Integer;
    procedure DeserializeFromXML(const AXML: string);
    procedure DeserializeFromFile(const AFilename: string);
    class function FromXML(ADocumentType: TPanamahNFeDocumentType; const AXML: string): IPanamahNFeDocument;
    class function FromFile(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument;
    destructor Destroy; override;
    property DocumentType: TPanamahNFeDocumentType read GetDocumentType write SetDocumentType;
    property Items[AIndex: Integer]: IPanamahModel read GetItem; default;
    property Count: Integer read GetCount;
    property Id: string read GetId write SetId;
  end;

  TPanamahNFeDocumentList = class(TInterfacedObject, IPanamahNFeDocumentList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahNFeDocument;
    function GetCount: Integer;
    function GetDocumentByType(ATypes: TPanamahNFeDocumentTypeSet): IPanamahNFeDocumentList;
    procedure SetItem(AIndex: Integer; const Value: IPanamahNFeDocument);
  public
    constructor Create; reintroduce;
    procedure Clear;
    procedure Add(const AItem: IPanamahNFeDocument);
    procedure RefreshCanceledDocuments;
    procedure LoadFromDirectory(const ADirectory: string);
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahNFeDocument read GetItem write SetItem; default;
    property Count: Integer read GetCount;
  end;

implementation

{ TPanamahNFeDocument }

uses PanamahSDK.XMLUtils, XMLIntf;

procedure TPanamahNFeDocument.Add(AModel: IPanamahModel);
begin
  FModels.Add(AModel);
  FDataTypes.Add(AModel.ModelName);
end;

constructor TPanamahNFeDocument.Create;
begin
  inherited Create;
  FDocumentType := ndtDESCONHECIDO;
  FModels := TInterfaceList.Create;
  FDataTypes := TStringList.Create;
end;

procedure TPanamahNFeDocument.DeserializeFromFile(const AFilename: string);
var
  XMLFile: TStrings;
begin
  XMLFile := TStringList.Create;
  try
    XMLFile.LoadFromFile(AFilename);
    DeserializeFromXML(XMLFile.Text);
  finally
    XMLFile.Free;
  end;
end;

procedure TPanamahNFeDocument.DeserializeFromXML(const AXML: string);
var
  Cliente: IPanamahCliente;
  Fornecedor: IPanamahFornecedor;
  Loja: IPanamahLoja;
  Produtos: IPanamahProdutoList;
  Venda: IPanamahVenda;
  I: Integer;
begin
  FModels.Clear;
  FId := TPanamahNFeDeserializer.GetIdFromXML(AXML);
  FDocumentType := FindOutDocumentType(FId);
  case FDocumentType of
    ndtDESCONHECIDO,
    ndtSAIDA:
    begin
      Loja := TPanamahNFeDeserializer.DeserializeLojaFromEmit(AXML);
      Cliente := TPanamahNFeDeserializer.DeserializeClienteFromDest(AXML);
      Venda := TPanamahNFeDeserializer.DeserializeVendaFromNFe(AXML);
      Add(Loja);
      Add(Cliente);
      Add(Venda);
    end;
    ndtENTRADA:
    begin
      Fornecedor := TPanamahNFeDeserializer.DeserializeFornecedorFromEmit(AXML);
      Loja := TPanamahNFeDeserializer.DeserializeLojaFromDest(AXML);
      Add(Fornecedor);
      Add(Loja);
    end;
  end;
  Produtos := TPanamahNFeDeserializer.DeserializeProdutosFromProd(AXML);
  for I := 0 to Produtos.Count - 1 do
    Add(Produtos[I]);
end;

destructor TPanamahNFeDocument.Destroy;
begin
  FreeAndNil(FDataTypes);
  FreeAndNil(FModels);
  inherited;
end;

function TPanamahNFeDocument.FindOutDocumentType(const AId: string): TPanamahNFeDocumentType;
begin
  Result := ndtDESCONHECIDO;
  if StartsText('ID110111', AId) then
    Result := ndtCANCELAMENTO;
end;

class function TPanamahNFeDocument.FromFile(ADocumentType: TPanamahNFeDocumentType;
  const AFilename: string): IPanamahNFeDocument;
begin
  Result := TPanamahNFeDocument.Create;
  Result.DocumentType := ADocumentType;
  Result.DeserializeFromFile(AFilename);
end;

class function TPanamahNFeDocument.FromXML(ADocumentType: TPanamahNFeDocumentType;
  const AXML: string): IPanamahNFeDocument;
begin
  Result := TPanamahNFeDocument.Create;
  Result.DocumentType := ADocumentType;
  Result.DeserializeFromXML(AXML);
end;

function TPanamahNFeDocument.GetCount: Integer;
begin
  Result := FModels.Count;
end;

function TPanamahNFeDocument.GetDocumentType: TPanamahNFeDocumentType;
begin
  Result := FDocumentType;
end;

function TPanamahNFeDocument.GetId: string;
begin
  Result := FId;
end;

function TPanamahNFeDocument.GetItem(AIndex: Integer): IPanamahModel;
begin
  if SameText(FDataTypes[AIndex], 'LOJA') then
    Result := FModels[AIndex] as IPanamahLoja
  else if SameText(FDataTypes[AIndex], 'CLIENTE') then
    Result := FModels[AIndex] as IPanamahCliente
  else if SameText(FDataTypes[AIndex], 'FORNECEDOR') then
    Result := FModels[AIndex] as IPanamahFornecedor
  else if SameText(FDataTypes[AIndex], 'PRODUTO') then
    Result := FModels[AIndex] as IPanamahProduto
  else if SameText(FDataTypes[AIndex], 'VENDA') then
    Result := FModels[AIndex] as IPanamahVenda;
end;

procedure TPanamahNFeDocument.SetDocumentType(AType: TPanamahNFeDocumentType);
begin
  FDocumentType := AType;
end;

procedure TPanamahNFeDocument.SetId(const AId: string);
begin
  FId := AId;
end;

{ TPanamahNFeDeserializer }

class function TPanamahNFeDeserializer.DeserializeClienteFromDest(
  const ANFeXML: string): IPanamahCliente;
var
  Document: IXMLDocument;
begin
  Result := TPanamahCliente.Create;
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Result.NumeroDocumento :=
      CoalesceText(
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CNPJ'']'),
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CPF'']')
      );
    Result.Id := Result.NumeroDocumento;
    Result.Nome := XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''xNome'']');
    Result.Uf := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''UF'']');
    Result.Bairro := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xBairro'']');
    Result.Cidade := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xMun'']');
  end;
end;

class function TPanamahNFeDeserializer.DeserializeFornecedorFromEmit(
  const ANFeXML: string): IPanamahFornecedor;
var
  Document: IXMLDocument;
begin
  Result := TPanamahFornecedor.Create;
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Result.Id := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''CNPJ'']');
    Result.Nome := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''xNome'']');
    Result.NumeroDocumento := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''CNPJ'']');
    Result.Uf := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''UF'']');
    Result.Bairro := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xBairro'']');
    Result.Cidade := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xMun'']');
  end;
end;

class function TPanamahNFeDeserializer.DeserializeLojaFromDest(
  const ANFeXML: string): IPanamahLoja;
var
  Document: IXMLDocument;
begin
  Result := TPanamahLoja.Create;
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Result.NumeroDocumento :=
      CoalesceText(
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CNPJ'']'),
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CPF'']')
      );
    Result.Id := Result.NumeroDocumento;
    Result.Descricao := XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''xNome'']');
    Result.Uf := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''UF'']');
    Result.Logradouro := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xLgr'']');
    Result.Numero := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''nro'']');
    Result.Complemento := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xCpl'']');
    Result.Bairro := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xBairro'']');
    Result.Cep := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''CEP'']');
    Result.Cidade := XPathValue(Document, '//*[local-name()=''enderDest'']/*[local-name()=''xMun'']');
  end;
end;

class function TPanamahNFeDeserializer.DeserializeLojaFromEmit(
  const ANFeXML: string): IPanamahLoja;
var
  Document: IXMLDocument;
begin
  Result := TPanamahLoja.Create;
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Result.Id := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''CNPJ'']');
    Result.Descricao := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''xNome'']');
    Result.NumeroDocumento := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''CNPJ'']');
    Result.Uf := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''UF'']');
    Result.Logradouro := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xLgr'']');
    Result.Numero := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''nro'']');
    Result.Complemento := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xCpl'']');
    Result.Bairro := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xBairro'']');
    Result.Cep := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''CEP'']');
    Result.Cidade := XPathValue(Document, '//*[local-name()=''enderEmit'']/*[local-name()=''xMun'']');
  end;
end;

class function TPanamahNFeDeserializer.DeserializeProdutosFromProd(
  const ANFeXML: string): IPanamahProdutoList;

  function GetProdValue(AIndex: Integer; ANode: IXMLNode; ATagName: string): string;
  begin
    Result := TPanamahXMLHelper.XPathValue(
      ANode,
      Format(
        '//*[local-name()=''det''][@nItem=''%d'']' +
        '/*[local-name()=''prod'']' +
        '/*[local-name()=''%s'']', [AIndex + 1, ATagName]
      )
    );
  end;

var
  Document: IXMLDocument;
  Nodes: TCustomXMLNodeArray;
  Produto: IPanamahProduto;
  I: Integer;
  Id: string;
begin
  Result := TPanamahProdutoList.Create;
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Nodes := XPathSelect(Document, '//*[local-name()=''prod'']');
    for I := 0 to Length(Nodes) - 1 do
    begin
      Produto := TPanamahProduto.Create;
      Id := GetProdValue(I, Nodes[I], 'cProd');
      Produto.Id := Id;
      Produto.Descricao := GetProdValue(I, Nodes[I], 'xProd');
      Produto.Ativo := True;
      Result.Add(Produto);
    end;
  end;
end;

class function TPanamahNFeDeserializer.DeserializeVendaFromNFe(
  const ANFeXML: string): IPanamahVenda;

  function GetItemValue(AIndex: Integer; ANode: IXMLNode; ATagName: string): string;
  begin
    Result := TPanamahXMLHelper.XPathValue(
      ANode,
      Format(
        '//*[local-name()=''det''][@nItem=''%d'']' +
        '/*[local-name()=''prod'']' +
        '/*[local-name()=''%s'']', [AIndex + 1, ATagName]
      )
    );
  end;

var
  Document: IXMLDocument;
  Produtos: IPanamahProdutoList;
  Item: IPanamahVendaItem;
  I: Integer;
begin
  Result := TPanamahVenda.Create;
  with TPanamahXMLHelper do
  begin
    Produtos := DeserializeProdutosFromProd(ANFeXML);
    Document := CreateDocument(ANFeXML);
    Result.Id := TPanamahNFeDeserializer.GetIdFromXML(ANFeXML);
    Result.LojaId := XPathValue(Document, '//*[local-name()=''emit'']/*[local-name()=''CNPJ'']');
    Result.ClienteId :=
      CoalesceText(
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CNPJ'']'),
        XPathValue(Document, '//*[local-name()=''dest'']/*[local-name()=''CPF'']')
      );
    Result.Data := ISO8601ToDateTime(XPathValue(Document, '//*[local-name()=''dhEmi'']'));
    Result.DataHoraVenda := Result.Data;
    Result.Efetiva := True;
    Result.QuantidadeItens := Produtos.Count;
    Result.Valor := DecimalDotStringToDouble(XPathValue(Document, '//*[local-name()=''total'']/*[local-name()=''ICMSTot'']/*[local-name()=''vNF'']'));
    if Result.QuantidadeItens > 0 then
    begin
      Result.Itens := TPanamahVendaItemList.Create;
      for I := 0 to Produtos.Count - 1 do
      begin
        Item := TPanamahVendaItem.Create;
        Item.ProdutoId := Produtos[I].Id;
        Item.Quantidade := DecimalDotStringToDouble(GetItemValue(I, Document.DocumentElement, 'qCom'));
        Item.Preco := DecimalDotStringToDouble(GetItemValue(I, Document.DocumentElement, 'vProd'));
        Item.ValorUnitario := DecimalDotStringToDouble(GetItemValue(I, Document.DocumentElement, 'vUnCom'));
        Item.ValorTotal := Item.Quantidade * Item.Preco;
        Item.Desconto := DecimalDotStringToDouble(GetItemValue(I, Document.DocumentElement, 'vDesc'));
        Item.Efetivo := True;
        Result.Itens.Add(Item);
      end;
    end;
  end;
end;

class function TPanamahNFeDeserializer.GetIdFromXML(const ANFeXML: string): string;
var
  Document: IXMLDocument;
begin
  with TPanamahXMLHelper do
  begin
    Document := CreateDocument(ANFeXML);
    Result := CoalesceText(XPathValue(Document, '//*[local-name()=''infNFe'']/@Id'), XPathValue(Document, '//*[local-name()=''infEvento'']/@Id'));
  end;
end;

{ TPanamahNFeDocumentList }

procedure TPanamahNFeDocumentList.Add(const AItem: IPanamahNFeDocument);
begin
  FList.Add(AItem);
end;

procedure TPanamahNFeDocumentList.Clear;
begin
  FList.Clear;
end;

constructor TPanamahNFeDocumentList.Create;
begin
  inherited Create;
  FList := TInterfaceList.Create;
end;

destructor TPanamahNFeDocumentList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahNFeDocumentList.GetCount: Integer;
begin
  Result := FList.Count;
end;

function TPanamahNFeDocumentList.GetDocumentByType(ATypes: TPanamahNFeDocumentTypeSet): IPanamahNFeDocumentList;
var
  I: Integer;
begin
  FList.Lock;
  try
    Result := TPanamahNFeDocumentList.Create;
    for I := 0 to FList.Count - 1 do
      if (FList[I] as IPanamahNFeDocument).DocumentType in ATypes then
        Result.Add(FList[I] as IPanamahNFeDocument);
  finally
    FList.Unlock;
  end;
end;

function TPanamahNFeDocumentList.GetItem(AIndex: Integer): IPanamahNFeDocument;
begin
  Result := FList[AIndex] as IPanamahNFeDocument;
end;

procedure TPanamahNFeDocumentList.LoadFromDirectory(const ADirectory: string);
var
  SearchRec: TSearchRec;
begin
  if DirectoryExists(ADirectory) then
    begin
    if FindFirst(Format('%s\*.xml', [ADirectory]), faAnyFile, SearchRec) = 0 then
    begin
      repeat
        FList.Add(TPanamahNFeDocument.FromFile(ndtDESCONHECIDO, Format('%s\%s', [ADirectory, SearchRec.Name])));
        RefreshCanceledDocuments;
      until FindNext(SearchRec) <> 0;
    end;
  end
  else
    raise EPanamahSDKIOException.Create(Format('Diretório %s não existe.', [ADirectory]));
end;

procedure TPanamahNFeDocumentList.RefreshCanceledDocuments;
var
  Emissao, Cancelamento: IPanamahNFeDocument;
  Cancelamentos, Emissoes: IPanamahNFeDocumentList;
  I1, I2, I3: Integer;
begin
  Cancelamentos := GetDocumentByType([ndtCANCELAMENTO]);
  Emissoes := GetDocumentByType([ndtDESCONHECIDO, ndtENTRADA, ndtSAIDA]);
  for I1 := 0 to Emissoes.Count - 1 do
  begin
    Emissao := Emissoes[I1];
    for I2 := 0 to Cancelamentos.Count - 1 do
    begin
      Cancelamento := Cancelamentos[I2];
      if ContainsText(Cancelamento.Id, OnlyNumbers(Emissao.Id)) then
      begin
        for I3 := 0 to Emissao.Count - 1 do
        begin
          if SameText(Emissao[I3].ModelName, 'VENDA') then
            (Emissao[I3] as IPanamahVenda).Efetiva := False;
        end;
      end;
    end;
  end;
end;

procedure TPanamahNFeDocumentList.SetItem(AIndex: Integer; const Value: IPanamahNFeDocument);
begin
  FList[AIndex] := Value;
end;

initialization
  CoInitialize(nil);

finalization
  CoUninitialize;

end.
