unit PanamahSDK.NFe;

interface

uses
  SysUtils, Classes, PanamahSDK.Types, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Cliente, PanamahSDK.Models.Venda;

type

  TPanamahNFeDocumentType = (ndtDESCONHECIDO, ndtENTRADA, ndtSAIDA);

  IPanamahNFeDocument = interface
    ['{D4B3A500-E80F-4B13-82AA-0E3F882E0158}']
    function GetModels: IPanamahModelList;
    function GetDocumentType: TPanamahNFeDocumentType;
    procedure DeserializeFromXML(const AXML: string);
    procedure DeserializeFromFile(const AFilename: string);
    procedure SetDocumentType(AType: TPanamahNFeDocumentType);
    property Models: IPanamahModelList read GetModels;
    property DocumentType: TPanamahNFeDocumentType read GetDocumentType write SetDocumentType;
  end;

  TPanamahNFeDeserializer = class
  public
    class function DeserializeLojaFromEmit(const ANFeXML: string): IPanamahLoja;
    class function DeserializeClienteFromDest(const ANFeXML: string): IPanamahCliente;
    class function DeserializeFornecedorFromEmit(const ANFeXML: string): IPanamahFornecedor;
    class function DeserializeLojaFromDest(const ANFeXML: string): IPanamahLoja;
    class function DeserializeProdutosFromProd(const ANFeXML: string): IPanamahProdutoList;
    class function DeserializeVendaFromNFe(const ANFeXML: string): IPanamahVenda;
  end;

  TPanamahNFeDocument = class(TInterfacedObject, IPanamahNFeDocument)
  private
    FModels: IPanamahModelList;
    FDocumentType: TPanamahNFeDocumentType;
    function GetModels: IPanamahModelList;
    function GetDocumentType: TPanamahNFeDocumentType;
    procedure SetDocumentType(AType: TPanamahNFeDocumentType);
  public
    constructor Create; reintroduce;
    procedure DeserializeFromXML(const AXML: string);
    procedure DeserializeFromFile(const AFilename: string);
    class function FromXML(ADocumentType: TPanamahNFeDocumentType; const AXML: string): IPanamahNFeDocument;
    class function FromFile(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument;
    property Models: IPanamahModelList read GetModels;
    property DocumentType: TPanamahNFeDocumentType read GetDocumentType write SetDocumentType;
  end;

implementation

{ TPanamahNFeDocument }

uses PanamahSDK.XMLUtils, XMLIntf;

constructor TPanamahNFeDocument.Create;
begin
  inherited Create;
  FDocumentType := ndtDESCONHECIDO;
  FModels := TPanamahModelList.Create;
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
  Cliente, Fornecedor, Loja: IPanamahModel;
  Produtos: IPanamahModelList;
begin
  FModels.Clear;
  case FDocumentType of
    ndtDESCONHECIDO,
    ndtSAIDA:
    begin
      Loja := TPanamahNFeDeserializer.DeserializeLojaFromEmit(AXML);
      Cliente := TPanamahNFeDeserializer.DeserializeClienteFromDest(AXML);
      TPanamahModelList(FModels).AddModel(Loja);
      TPanamahModelList(FModels).AddModel(Cliente);
    end;
    ndtENTRADA:
    begin
      Fornecedor := TPanamahNFeDeserializer.DeserializeFornecedorFromEmit(AXML);
      Loja := TPanamahNFeDeserializer.DeserializeLojaFromDest(AXML);
      TPanamahModelList(FModels).AddModel(Fornecedor);
      TPanamahModelList(FModels).AddModel(Loja);
    end;
  end;
  Produtos := TPanamahNFeDeserializer.DeserializeProdutosFromProd(AXML);
  TPanamahModelList(FModels).AddModels(Produtos);
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

function TPanamahNFeDocument.GetDocumentType: TPanamahNFeDocumentType;
begin
  Result := FDocumentType;
end;

function TPanamahNFeDocument.GetModels: IPanamahModelList;
begin
  Result := FModels;
end;

procedure TPanamahNFeDocument.SetDocumentType(AType: TPanamahNFeDocumentType);
begin
  FDocumentType := AType;
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
      Id := GetProdValue(I, Nodes[I], 'cEAN');
      if SameText(Id, EmptyStr) or SameText(Id, 'SEM GTIN') then
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
    Result.Id := XPathValue(Document, '//*[local-name()=''infNFe'']/@Id');
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

end.
