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
    function GetId: Variant;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(const ADataType: string);
    procedure SetId(Id: Variant);
    property OperationType: TPanamahOperationType read GetOperationType write SetOperationType;
    property Data: IPanamahModel read GetData write SetData;
    property Id: Variant read GetId write SetId;
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

  TPanamahDataIdOperation = class(TInterfacedObject, IJSONSerializable)
  private
    FId: string;
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    property Id: string read FId write FId;
    constructor Create(const AId: string); reintroduce;
  end;

  TPanamahOperation = class(TInterfacedObject, IPanamahOperation)
  private
    FOperationType: TPanamahOperationType;
    FData: IPanamahModel;
    FDataType: string;
    FId: Variant;
    function GetOperationType: TPanamahOperationType;
    function GetData: IPanamahModel;
    function GetDataType: string;
    function GetId: Variant;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(const ADataType: string);
    procedure SetId(AId: Variant);
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
    property Id: Variant read GetId write SetId;
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
    FDataType := GetFieldValueAsString(JSONObject, 'tipo');
    FId := GetFieldValueAsString(JSONObject, 'id');
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

  procedure SetDataToId(AJSONObject: TlkJSONobject);
  var
    DataJSONObject: TlkJSONobject;
    Id: IJSONSerializable;
  begin
    DataJSONObject := TlkJSON.ParseText(FData.SerializeToJSON) as TlkJSONobject;
    try
      if DataJSONObject.Field['id'] <> nil then
      begin
        Id := TPanamahDataIdOperation.Create(GetFieldValueAsString(DataJSONObject, 'id'));
        SetFieldValue(AJSONObject, 'data', Id);
      end
      else
        SetFieldValue(AJSONObject, 'data', FData);
    finally
      DataJSONObject.Free;
    end;
  end;

var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    case FOperationType of
      otUPDATE:
      begin
        SetFieldValue(JSONObject, 'op', 'update');
        SetFieldValue(JSONObject, 'data', FData);
      end;
      otDELETE:
      begin
        SetFieldValue(JSONObject, 'op', 'delete');
        SetDataToId(JSONObject);
      end;
    end;
    SetFieldValue(JSONObject, 'tipo', GetDataTypeByModel(FData));
    SetFieldValue(JSONObject, 'id', FId);
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

function TPanamahOperation.GetId: Variant;
begin
  Result := FId;
end;

function TPanamahOperation.GetOperationType: TPanamahOperationType;
begin
  Result := FOperationType;
end;

procedure TPanamahOperation.SetData(AData: IPanamahModel);
begin
  FData := AData;
end;

procedure TPanamahOperation.SetDataType(const ADataType: string);
begin
  FDataType := ADataType;
end;

procedure TPanamahOperation.SetId(AId: Variant);
begin
  FId := AId;
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
  Result := AModel.ModelName;
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

{ TPanamahDataIdOperation }

constructor TPanamahDataIdOperation.Create(const AId: string);
begin
  inherited Create;
  FId := AId;
end;

procedure TPanamahDataIdOperation.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahDataIdOperation.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'id', FId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.
