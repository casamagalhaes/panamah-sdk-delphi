{$M+}
unit PanamahSDK.Operation;

interface

uses
  Classes, SysUtils, uLkJSON, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums,
  PanamahSDK.Models.Acesso, PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra,
  PanamahSDK.Models.Ean, PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa,
  PanamahSDK.Models.FormaPagamento, PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario,
  PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding, PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Meta, PanamahSDK.Models.Produto, PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao,
  PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar, PanamahSDK.Models.TituloReceber,
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda;

type

  IPanamahOperation = interface(IJSONSerializable)
    ['{2686F170-9BB1-4F78-8EA5-D10E7EE5F15A}']
    function GetOperationType: TPanamahOperationType;
    function GetData: IPanamahModel;
    function GetDataType: string;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(ADataType: string);
    property OperationType: TPanamahOperationType read GetOperationType write SetOperationType;
    property Data: IPanamahModel read GetData write SetData;
  end;

  IPanamahOperationList = interface(IJSONSerializable)
    ['{66CD67F1-487E-429B-B957-5782F20A5C81}']
    function GetItem(AIndex: Integer): IPanamahOperation;
    procedure SetItem(AIndex: Integer; const Value: IPanamahOperation);
    procedure Add(const AItem: IPanamahOperation);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahOperation read GetItem write SetItem; default;
  end;

  TPanamahOperation = class(TInterfacedObject, IPanamahOperation)
  private
    FOperationType: TPanamahOperationType;
    FData: IPanamahModel;
    FDataType: string;
    function GetOperationType: TPanamahOperationType;
    function GetData: IPanamahModel;
    function GetDataType: string;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(ADataType: string);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    constructor Create(AOperationType: TPanamahOperationType; AModel: IPanamahModel); reintroduce; overload;
    constructor Create; reintroduce; overload;
    class function FromJSON(const AJSON: string): IPanamahOperation;
  published
    property OperationType: TPanamahOperationType read GetOperationType write SetOperationType;
    property Data: IPanamahModel read GetData write SetData;
    property DataType: string read GetDataType write SetDataType;
  end;

  TPanamahOperationList = class(TInterfacedObject, IPanamahOperationList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahOperation;
    procedure SetItem(AIndex: Integer; const Value: IPanamahOperation);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahOperationList;
    constructor Create;
    procedure Add(const AItem: IPanamahOperation);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahOperation read GetItem write SetItem; default;
  end;

  function ParseJSONOfModelByDataType(const ADataType, AJSON: string): IPanamahModel;

  function GetDataTypeByModel(AModel: IPanamahModel): string;

implementation

{ TPanamahOperation }

constructor TPanamahOperation.Create(AOperationType: TPanamahOperationType; AModel: IPanamahModel);
begin
  inherited Create;
  FOperationType := AOperationType;
  FData := AModel;
  FDataType := GetDataTypeByModel(FData);
end;

constructor TPanamahOperation.Create;
begin
  inherited Create;
end;

procedure TPanamahOperation.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if SameText(GetFieldValueAsString(JSONObject, 'op'), 'update') then
      FOperationType := otUPDATE
    else
    if SameText(GetFieldValueAsString(JSONObject, 'op'), 'delete') then
      FOperationType := otDELETE;
    FDataType := GetFieldValueAsString(JSONObject, 'tipoIdentificador');
    if JSONObject.Field['data'] is TlkJSONobject then
      FData := ParseJSONOfModelByDataType(FDataType, TlkJSON.GenerateText(JSONObject.Field['data']));
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahOperation.FromJSON(const AJSON: string): IPanamahOperation;
begin
  Result := TPanamahOperation.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahOperation.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    case FOperationType of
      otUPDATE: SetFieldValue(JSONObject, 'op', 'update');
      otDELETE: SetFieldValue(JSONObject, 'op', 'delete');
    end;
    SetFieldValue(JSONObject, 'data', FData);
    SetFieldValue(JSONObject, 'tipoIdentificador', GetDataTypeByModel(FData));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

function TPanamahOperation.GetData: IPanamahModel;
begin
  Result := FData;
end;

function TPanamahOperation.GetDataType: string;
begin
  Result := FDataType;
end;

function TPanamahOperation.GetOperationType: TPanamahOperationType;
begin
  Result := FOperationType;
end;

procedure TPanamahOperation.SetData(AData: IPanamahModel);
begin
  FData := AData;
end;

procedure TPanamahOperation.SetDataType(ADataType: string);
begin
  FDataType := ADataType;
end;

procedure TPanamahOperation.SetOperationType(AOperationType: TPanamahOperationType);
begin
  FOperationType := AOperationType;
end;

function ParseJSONOfModelByDataType(const ADataType, AJSON: string): IPanamahModel;
begin
  if SameText(ADataType, 'ACESSO') then Result := TPanamahAcesso.FromJSON(AJSON) else
  if SameText(ADataType, 'ASSINANTE') then Result := TPanamahAssinante.FromJSON(AJSON) else
  if SameText(ADataType, 'CLIENTE') then Result := TPanamahCliente.FromJSON(AJSON) else
  if SameText(ADataType, 'COMPRA') then Result := TPanamahCompra.FromJSON(AJSON) else
  if SameText(ADataType, 'EAN') then Result := TPanamahEan.FromJSON(AJSON) else
  if SameText(ADataType, 'ESTOQUE_MOVIMENTACAO') then Result := TPanamahEstoqueMovimentacao.FromJSON(AJSON) else
  if SameText(ADataType, 'EVENTO_CAIXA') then Result := TPanamahEventoCaixa.FromJSON(AJSON) else
  if SameText(ADataType, 'FORMA_PAGAMENTO') then Result := TPanamahFormaPagamento.FromJSON(AJSON) else
  if SameText(ADataType, 'FORNECEDOR') then Result := TPanamahFornecedor.FromJSON(AJSON) else
  if SameText(ADataType, 'FUNCIONARIO') then Result := TPanamahFuncionario.FromJSON(AJSON) else
  if SameText(ADataType, 'GRUPO') then Result := TPanamahGrupo.FromJSON(AJSON) else
  if SameText(ADataType, 'HOLDING') then Result := TPanamahHolding.FromJSON(AJSON) else
  if SameText(ADataType, 'LOCAL_ESTOQUE') then Result := TPanamahLocalEstoque.FromJSON(AJSON) else
  if SameText(ADataType, 'LOJA') then Result := TPanamahLoja.FromJSON(AJSON) else
  if SameText(ADataType, 'META') then Result := TPanamahMeta.FromJSON(AJSON) else
  if SameText(ADataType, 'PRODUTO') then Result := TPanamahProduto.FromJSON(AJSON) else
  if SameText(ADataType, 'REVENDA') then Result := TPanamahRevenda.FromJSON(AJSON) else
  if SameText(ADataType, 'SECAO') then Result := TPanamahSecao.FromJSON(AJSON) else
  if SameText(ADataType, 'SUBGRUPO') then Result := TPanamahSubgrupo.FromJSON(AJSON) else
  if SameText(ADataType, 'TITULO_PAGAR') then Result := TPanamahTituloPagar.FromJSON(AJSON) else
  if SameText(ADataType, 'TITULO_RECEBER') then Result := TPanamahTituloReceber.FromJSON(AJSON) else
  if SameText(ADataType, 'TROCA_DEVOLUCAO') then Result := TPanamahTrocaDevolucao.FromJSON(AJSON) else
  if SameText(ADataType, 'TROCA_FORMA_PAGAMENTO') then Result := TPanamahTrocaFormaPagamento.FromJSON(AJSON) else
  if SameText(ADataType, 'VENDA') then Result := TPanamahVenda.FromJSON(AJSON);
end;

function GetDataTypeByModel(AModel: IPanamahModel): string;
begin
  if AModel is TPanamahAcesso then Result := 'ACESSO' else
  if AModel is TPanamahAssinante then Result := 'ASSINANTE' else
  if AModel is TPanamahCliente then Result := 'CLIENTE' else
  if AModel is TPanamahCompra then Result := 'COMPRA' else
  if AModel is TPanamahEan then Result := 'EAN' else
  if AModel is TPanamahEstoqueMovimentacao then Result := 'ESTOQUE_MOVIMENTACAO' else
  if AModel is TPanamahEventoCaixa then Result := 'EVENTO_CAIXA' else
  if AModel is TPanamahFormaPagamento then Result := 'FORMA_PAGAMENTO' else
  if AModel is TPanamahFornecedor then Result := 'FORNECEDOR' else
  if AModel is TPanamahFuncionario then Result := 'FUNCIONARIO' else
  if AModel is TPanamahGrupo then Result := 'GRUPO' else
  if AModel is TPanamahHolding then Result := 'HOLDING' else
  if AModel is TPanamahLocalEstoque then Result := 'LOCAL_ESTOQUE' else
  if AModel is TPanamahLoja then Result := 'LOJA' else
  if AModel is TPanamahMeta then Result := 'META' else
  if AModel is TPanamahProduto then Result := 'PRODUTO' else
  if AModel is TPanamahRevenda then Result := 'REVENDA' else
  if AModel is TPanamahSecao then Result := 'SECAO' else
  if AModel is TPanamahSubgrupo then Result := 'SUBGRUPO' else
  if AModel is TPanamahTituloPagar then Result := 'TITULO_PAGAR' else
  if AModel is TPanamahTituloReceber then Result := 'TITULO_RECEBER' else
  if AModel is TPanamahTrocaDevolucao then Result := 'TROCA_DEVOLUCAO' else
  if AModel is TPanamahTrocaFormaPagamento then Result := 'TROCA_FORMA_PAGAMENTO' else
  if AModel is TPanamahVenda then Result := 'VENDA';
end;

{ TPanamahHoldingList }

constructor TPanamahOperationList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahOperationList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahOperationList.FromJSON(const AJSON: string): IPanamahOperationList;
begin
  Result := TPanamahOperationList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahOperationList.Add(const AItem: IPanamahOperation);
begin
  FList.Add(AItem);
end;

procedure TPanamahOperationList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahOperation;
begin
  Item := TPanamahOperation.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahOperationList.Clear;
begin
  FList.Clear;
end;

function TPanamahOperationList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahOperationList.GetItem(AIndex: Integer): IPanamahOperation;
begin
  Result := FList.Items[AIndex] as IPanamahOperation;
end;

procedure TPanamahOperationList.SetItem(AIndex: Integer;
  const Value: IPanamahOperation);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahOperationList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahOperationList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahOperation).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.
