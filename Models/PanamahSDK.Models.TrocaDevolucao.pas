{$M+}
unit PanamahSDK.Models.TrocaDevolucao;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahTrocaDevolucaoItem = interface(IPanamahModel)
    ['{081D0656-7736-11E9-A131-EBAF8D88186A}']
    function GetDesconto: Double;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    function GetVendedorId: variant;
    procedure SetDesconto(const ADesconto: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
    procedure SetVendedorId(const AVendedorId: variant);
    property Desconto: Double read GetDesconto write SetDesconto;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
    property VendedorId: variant read GetVendedorId write SetVendedorId;
  end;
  
  IPanamahTrocaDevolucaoItemList = interface(IPanamahModelList)
    ['{081D0657-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucaoItem);
    procedure Add(const AItem: IPanamahTrocaDevolucaoItem);
    property Items[AIndex: Integer]: IPanamahTrocaDevolucaoItem read GetItem write SetItem; default;
  end;
  
  IPanamahTrocaDevolucao = interface(IPanamahModel)
    ['{081C9120-7736-11E9-A131-EBAF8D88186A}']
    function GetAutorizadorId: variant;
    function GetData: TDateTime;
    function GetVendaId: variant;
    function GetId: string;
    function GetItens: IpanamahTrocaDevolucaoItemList;
    function GetLojaId: string;
    function GetNumeroCaixa: variant;
    function GetOperadorId: variant;
    function GetSequencial: variant;
    function GetValor: Double;
    function GetVendedorId: variant;
    procedure SetAutorizadorId(const AAutorizadorId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetVendaId(const AVendaId: variant);
    procedure SetId(const AId: string);
    procedure SetItens(const AItens: IpanamahTrocaDevolucaoItemList);
    procedure SetLojaId(const ALojaId: string);
    procedure SetNumeroCaixa(const ANumeroCaixa: variant);
    procedure SetOperadorId(const AOperadorId: variant);
    procedure SetSequencial(const ASequencial: variant);
    procedure SetValor(const AValor: Double);
    procedure SetVendedorId(const AVendedorId: variant);
    property AutorizadorId: variant read GetAutorizadorId write SetAutorizadorId;
    property Data: TDateTime read GetData write SetData;
    property VendaId: variant read GetVendaId write SetVendaId;
    property Id: string read GetId write SetId;
    property Itens: IpanamahTrocaDevolucaoItemList read GetItens write SetItens;
    property LojaId: string read GetLojaId write SetLojaId;
    property NumeroCaixa: variant read GetNumeroCaixa write SetNumeroCaixa;
    property OperadorId: variant read GetOperadorId write SetOperadorId;
    property Sequencial: variant read GetSequencial write SetSequencial;
    property Valor: Double read GetValor write SetValor;
    property VendedorId: variant read GetVendedorId write SetVendedorId;
  end;
  
  IPanamahTrocaDevolucaoList = interface(IPanamahModelList)
    ['{081C9121-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucao);
    procedure Add(const AItem: IPanamahTrocaDevolucao);
    property Items[AIndex: Integer]: IPanamahTrocaDevolucao read GetItem write SetItem; default;
  end;
  
  TPanamahTrocaDevolucaoItem = class(TInterfacedObject, IPanamahTrocaDevolucaoItem)
  private
    FDesconto: Double;
    FProdutoId: string;
    FQuantidade: Double;
    FValorTotal: Double;
    FValorUnitario: Double;
    FVendedorId: variant;
    function GetDesconto: Double;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    function GetVendedorId: variant;
    procedure SetDesconto(const ADesconto: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
    procedure SetVendedorId(const AVendedorId: variant);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItem;
    function Validate: IPanamahValidationResult;
  published
    property Desconto: Double read GetDesconto write SetDesconto;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
    property VendedorId: variant read GetVendedorId write SetVendedorId;
  end;

  TPanamahTrocaDevolucaoItemList = class(TInterfacedObject, IPanamahTrocaDevolucaoItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucaoItem);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahTrocaDevolucaoItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTrocaDevolucaoItem read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  TPanamahTrocaDevolucao = class(TInterfacedObject, IPanamahTrocaDevolucao)
  private
    FAutorizadorId: variant;
    FData: TDateTime;
    FVendaId: variant;
    FId: string;
    FItens: IpanamahTrocaDevolucaoItemList;
    FLojaId: string;
    FNumeroCaixa: variant;
    FOperadorId: variant;
    FSequencial: variant;
    FValor: Double;
    FVendedorId: variant;
    function GetAutorizadorId: variant;
    function GetData: TDateTime;
    function GetVendaId: variant;
    function GetId: string;
    function GetItens: IpanamahTrocaDevolucaoItemList;
    function GetLojaId: string;
    function GetNumeroCaixa: variant;
    function GetOperadorId: variant;
    function GetSequencial: variant;
    function GetValor: Double;
    function GetVendedorId: variant;
    procedure SetAutorizadorId(const AAutorizadorId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetVendaId(const AVendaId: variant);
    procedure SetId(const AId: string);
    procedure SetItens(const AItens: IpanamahTrocaDevolucaoItemList);
    procedure SetLojaId(const ALojaId: string);
    procedure SetNumeroCaixa(const ANumeroCaixa: variant);
    procedure SetOperadorId(const AOperadorId: variant);
    procedure SetSequencial(const ASequencial: variant);
    procedure SetValor(const AValor: Double);
    procedure SetVendedorId(const AVendedorId: variant);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucao;
    function Validate: IPanamahValidationResult;
  published
    property AutorizadorId: variant read GetAutorizadorId write SetAutorizadorId;
    property Data: TDateTime read GetData write SetData;
    property VendaId: variant read GetVendaId write SetVendaId;
    property Id: string read GetId write SetId;
    property Itens: IpanamahTrocaDevolucaoItemList read GetItens write SetItens;
    property LojaId: string read GetLojaId write SetLojaId;
    property NumeroCaixa: variant read GetNumeroCaixa write SetNumeroCaixa;
    property OperadorId: variant read GetOperadorId write SetOperadorId;
    property Sequencial: variant read GetSequencial write SetSequencial;
    property Valor: Double read GetValor write SetValor;
    property VendedorId: variant read GetVendedorId write SetVendedorId;
  end;

  TPanamahTrocaDevolucaoList = class(TInterfacedObject, IPanamahTrocaDevolucaoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucao);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahTrocaDevolucao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTrocaDevolucao read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahTrocaDevolucaoItemValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
  TPanamahTrocaDevolucaoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahTrocaDevolucaoItem }

function TPanamahTrocaDevolucaoItem.GetDesconto: Double;
begin
  Result := FDesconto;
end;

procedure TPanamahTrocaDevolucaoItem.SetDesconto(const ADesconto: Double);
begin
  FDesconto := ADesconto;
end;

function TPanamahTrocaDevolucaoItem.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahTrocaDevolucaoItem.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahTrocaDevolucaoItem.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahTrocaDevolucaoItem.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

function TPanamahTrocaDevolucaoItem.GetValorTotal: Double;
begin
  Result := FValorTotal;
end;

procedure TPanamahTrocaDevolucaoItem.SetValorTotal(const AValorTotal: Double);
begin
  FValorTotal := AValorTotal;
end;

function TPanamahTrocaDevolucaoItem.GetValorUnitario: Double;
begin
  Result := FValorUnitario;
end;

procedure TPanamahTrocaDevolucaoItem.SetValorUnitario(const AValorUnitario: Double);
begin
  FValorUnitario := AValorUnitario;
end;

function TPanamahTrocaDevolucaoItem.GetVendedorId: variant;
begin
  Result := FVendedorId;
end;

procedure TPanamahTrocaDevolucaoItem.SetVendedorId(const AVendedorId: variant);
begin
  FVendedorId := AVendedorId;
end;

procedure TPanamahTrocaDevolucaoItem.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FDesconto := GetFieldValueAsDouble(JSONObject, 'desconto');
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
    FValorTotal := GetFieldValueAsDouble(JSONObject, 'valorTotal');
    FValorUnitario := GetFieldValueAsDouble(JSONObject, 'valorUnitario');
    FVendedorId := GetFieldValue(JSONObject, 'vendedorId');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTrocaDevolucaoItem.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'desconto', FDesconto);    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);    
    SetFieldValue(JSONObject, 'valorTotal', FValorTotal);    
    SetFieldValue(JSONObject, 'valorUnitario', FValorUnitario);    
    SetFieldValue(JSONObject, 'vendedorId', FVendedorId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTrocaDevolucaoItem.FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItem;
begin
  Result := TPanamahTrocaDevolucaoItem.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaDevolucaoItem.GetModelName: string;
begin
  Result := 'TROCA_DEVOLUCAO_ITENS';
end;

function TPanamahTrocaDevolucaoItem.Clone: IPanamahModel;
begin
  Result := TPanamahTrocaDevolucaoItem.FromJSON(SerializeToJSON);
end;

function TPanamahTrocaDevolucaoItem.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahTrocaDevolucaoItemValidator.Create;
  Result := Validator.Validate(Self as IPanamahTrocaDevolucaoItem);
end;

{ TPanamahTrocaDevolucaoItemList }

constructor TPanamahTrocaDevolucaoItemList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTrocaDevolucaoItemList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahTrocaDevolucaoItemList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahTrocaDevolucaoItem).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahTrocaDevolucaoItemList.FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItemList;
begin
  Result := TPanamahTrocaDevolucaoItemList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaDevolucaoItemList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahTrocaDevolucaoItem;
end;

procedure TPanamahTrocaDevolucaoItemList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaDevolucaoItemList.Add(const AItem: IPanamahTrocaDevolucaoItem);
begin
  FList.Add(AItem);
end;

procedure TPanamahTrocaDevolucaoItemList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTrocaDevolucaoItem;
begin
  Item := TPanamahTrocaDevolucaoItem.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTrocaDevolucaoItemList.Clear;
begin
  FList.Clear;
end;

function TPanamahTrocaDevolucaoItemList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTrocaDevolucaoItemList.GetItem(AIndex: Integer): IPanamahTrocaDevolucaoItem;
begin
  Result := FList.Items[AIndex] as IPanamahTrocaDevolucaoItem;
end;

procedure TPanamahTrocaDevolucaoItemList.SetItem(AIndex: Integer;
  const Value: IPanamahTrocaDevolucaoItem);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaDevolucaoItemList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTrocaDevolucaoItemList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTrocaDevolucaoItem).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahTrocaDevolucaoItemValidator }

function TPanamahTrocaDevolucaoItemValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Itens: IPanamahTrocaDevolucaoItem;
  Validations: IPanamahValidationResultList;
begin
  Itens := AModel as IPanamahTrocaDevolucaoItem;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Itens.ProdutoId) then
    Validations.AddFailure('Itens.ProdutoId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

{ TPanamahTrocaDevolucao }

function TPanamahTrocaDevolucao.GetAutorizadorId: variant;
begin
  Result := FAutorizadorId;
end;

procedure TPanamahTrocaDevolucao.SetAutorizadorId(const AAutorizadorId: variant);
begin
  FAutorizadorId := AAutorizadorId;
end;

function TPanamahTrocaDevolucao.GetData: TDateTime;
begin
  Result := FData;
end;

procedure TPanamahTrocaDevolucao.SetData(const AData: TDateTime);
begin
  FData := AData;
end;

function TPanamahTrocaDevolucao.GetVendaId: variant;
begin
  Result := FVendaId;
end;

procedure TPanamahTrocaDevolucao.SetVendaId(const AVendaId: variant);
begin
  FVendaId := AVendaId;
end;

function TPanamahTrocaDevolucao.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahTrocaDevolucao.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahTrocaDevolucao.GetItens: IpanamahTrocaDevolucaoItemList;
begin
  Result := FItens;
end;

procedure TPanamahTrocaDevolucao.SetItens(const AItens: IpanamahTrocaDevolucaoItemList);
begin
  FItens := AItens;
end;

function TPanamahTrocaDevolucao.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahTrocaDevolucao.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahTrocaDevolucao.GetNumeroCaixa: variant;
begin
  Result := FNumeroCaixa;
end;

procedure TPanamahTrocaDevolucao.SetNumeroCaixa(const ANumeroCaixa: variant);
begin
  FNumeroCaixa := ANumeroCaixa;
end;

function TPanamahTrocaDevolucao.GetOperadorId: variant;
begin
  Result := FOperadorId;
end;

procedure TPanamahTrocaDevolucao.SetOperadorId(const AOperadorId: variant);
begin
  FOperadorId := AOperadorId;
end;

function TPanamahTrocaDevolucao.GetSequencial: variant;
begin
  Result := FSequencial;
end;

procedure TPanamahTrocaDevolucao.SetSequencial(const ASequencial: variant);
begin
  FSequencial := ASequencial;
end;

function TPanamahTrocaDevolucao.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahTrocaDevolucao.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

function TPanamahTrocaDevolucao.GetVendedorId: variant;
begin
  Result := FVendedorId;
end;

procedure TPanamahTrocaDevolucao.SetVendedorId(const AVendedorId: variant);
begin
  FVendedorId := AVendedorId;
end;

procedure TPanamahTrocaDevolucao.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAutorizadorId := GetFieldValue(JSONObject, 'autorizadorId');
    FData := GetFieldValueAsDatetime(JSONObject, 'data');
    FVendaId := GetFieldValue(JSONObject, 'vendaId');
    FId := GetFieldValueAsString(JSONObject, 'id');
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TpanamahTrocaDevolucaoItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FNumeroCaixa := GetFieldValue(JSONObject, 'numeroCaixa');
    FOperadorId := GetFieldValue(JSONObject, 'operadorId');
    FSequencial := GetFieldValue(JSONObject, 'sequencial');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
    FVendedorId := GetFieldValue(JSONObject, 'vendedorId');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTrocaDevolucao.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'autorizadorId', FAutorizadorId);    
    SetFieldValue(JSONObject, 'data', FData);    
    SetFieldValue(JSONObject, 'vendaId', FVendaId);    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'itens', FItens);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'numeroCaixa', FNumeroCaixa);    
    SetFieldValue(JSONObject, 'operadorId', FOperadorId);    
    SetFieldValue(JSONObject, 'sequencial', FSequencial);    
    SetFieldValue(JSONObject, 'valor', FValor);    
    SetFieldValue(JSONObject, 'vendedorId', FVendedorId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTrocaDevolucao.FromJSON(const AJSON: string): IPanamahTrocaDevolucao;
begin
  Result := TPanamahTrocaDevolucao.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaDevolucao.GetModelName: string;
begin
  Result := 'TROCA_DEVOLUCAO';
end;

function TPanamahTrocaDevolucao.Clone: IPanamahModel;
begin
  Result := TPanamahTrocaDevolucao.FromJSON(SerializeToJSON);
end;

function TPanamahTrocaDevolucao.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahTrocaDevolucaoValidator.Create;
  Result := Validator.Validate(Self as IPanamahTrocaDevolucao);
end;

{ TPanamahTrocaDevolucaoList }

constructor TPanamahTrocaDevolucaoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTrocaDevolucaoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahTrocaDevolucaoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahTrocaDevolucao).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahTrocaDevolucaoList.FromJSON(const AJSON: string): IPanamahTrocaDevolucaoList;
begin
  Result := TPanamahTrocaDevolucaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaDevolucaoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahTrocaDevolucao;
end;

procedure TPanamahTrocaDevolucaoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaDevolucaoList.Add(const AItem: IPanamahTrocaDevolucao);
begin
  FList.Add(AItem);
end;

procedure TPanamahTrocaDevolucaoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTrocaDevolucao;
begin
  Item := TPanamahTrocaDevolucao.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTrocaDevolucaoList.Clear;
begin
  FList.Clear;
end;

function TPanamahTrocaDevolucaoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTrocaDevolucaoList.GetItem(AIndex: Integer): IPanamahTrocaDevolucao;
begin
  Result := FList.Items[AIndex] as IPanamahTrocaDevolucao;
end;

procedure TPanamahTrocaDevolucaoList.SetItem(AIndex: Integer;
  const Value: IPanamahTrocaDevolucao);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaDevolucaoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTrocaDevolucaoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTrocaDevolucao).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahTrocaDevolucaoValidator }

function TPanamahTrocaDevolucaoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  TrocaDevolucao: IPanamahTrocaDevolucao;
  Validations: IPanamahValidationResultList;
begin
  TrocaDevolucao := AModel as IPanamahTrocaDevolucao;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(TrocaDevolucao.Id) then
    Validations.AddFailure('TrocaDevolucao.Id obrigatorio(a)');
  
  if ModelListIsEmpty(TrocaDevolucao.Itens) then
    Validations.AddFailure('TrocaDevolucao.Itens obrigatorio(a)')
  else
    Validations.Add(TrocaDevolucao.Itens.Validate);
  
  if ModelValueIsEmpty(TrocaDevolucao.LojaId) then
    Validations.AddFailure('TrocaDevolucao.LojaId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.