{$M+}
unit PanamahSDK.Models.PanamahTrocaDevolucao;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahTrocaDevolucaoItem = interface(IModel)
    ['{00614822-6D1F-11E9-BC68-6769AAA11E00}']
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
  
  IPanamahTrocaDevolucaoItemList = interface(IJSONSerializable)
    ['{00614823-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucaoItem);
    procedure Add(const AItem: IPanamahTrocaDevolucaoItem);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahTrocaDevolucaoItem read GetItem write SetItem; default;
  end;
  
  IPanamahTrocaDevolucao = interface(IModel)
    ['{0060FA02-6D1F-11E9-BC68-6769AAA11E00}']
    function GetAutorizadorId: variant;
    function GetData: TDateTime;
    function GetVendaId: variant;
    function GetId: string;
    function GetItens: IPanamahTrocaDevolucaoItemList;
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
    procedure SetItens(const AItens: IPanamahTrocaDevolucaoItemList);
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
    property Itens: IPanamahTrocaDevolucaoItemList read GetItens write SetItens;
    property LojaId: string read GetLojaId write SetLojaId;
    property NumeroCaixa: variant read GetNumeroCaixa write SetNumeroCaixa;
    property OperadorId: variant read GetOperadorId write SetOperadorId;
    property Sequencial: variant read GetSequencial write SetSequencial;
    property Valor: Double read GetValor write SetValor;
    property VendedorId: variant read GetVendedorId write SetVendedorId;
  end;
  
  IPanamahTrocaDevolucaoList = interface(IJSONSerializable)
    ['{0060FA03-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahTrocaDevolucao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaDevolucao);
    procedure Add(const AItem: IPanamahTrocaDevolucao);
    procedure Clear;
    function Count: Integer;
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
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItem;
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
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahTrocaDevolucaoItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTrocaDevolucaoItem read GetItem write SetItem; default;
  end;
  
  TPanamahTrocaDevolucao = class(TInterfacedObject, IPanamahTrocaDevolucao)
  private
    FAutorizadorId: variant;
    FData: TDateTime;
    FVendaId: variant;
    FId: string;
    FItens: IPanamahTrocaDevolucaoItemList;
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
    function GetItens: IPanamahTrocaDevolucaoItemList;
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
    procedure SetItens(const AItens: IPanamahTrocaDevolucaoItemList);
    procedure SetLojaId(const ALojaId: string);
    procedure SetNumeroCaixa(const ANumeroCaixa: variant);
    procedure SetOperadorId(const AOperadorId: variant);
    procedure SetSequencial(const ASequencial: variant);
    procedure SetValor(const AValor: Double);
    procedure SetVendedorId(const AVendedorId: variant);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucao;
  published
    property AutorizadorId: variant read GetAutorizadorId write SetAutorizadorId;
    property Data: TDateTime read GetData write SetData;
    property VendaId: variant read GetVendaId write SetVendaId;
    property Id: string read GetId write SetId;
    property Itens: IPanamahTrocaDevolucaoItemList read GetItens write SetItens;
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
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaDevolucaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahTrocaDevolucao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTrocaDevolucao read GetItem write SetItem; default;
  end;
  
implementation

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

class function TPanamahTrocaDevolucaoItemList.FromJSON(const AJSON: string): IPanamahTrocaDevolucaoItemList;
begin
  Result := TPanamahTrocaDevolucaoItemList.Create;
  Result.DeserializeFromJSON(AJSON);
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
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTrocaDevolucaoItem).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
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

function TPanamahTrocaDevolucao.GetItens: IPanamahTrocaDevolucaoItemList;
begin
  Result := FItens;
end;

procedure TPanamahTrocaDevolucao.SetItens(const AItens: IPanamahTrocaDevolucaoItemList);
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
      FItens := TPanamahTrocaDevolucaoItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
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

class function TPanamahTrocaDevolucaoList.FromJSON(const AJSON: string): IPanamahTrocaDevolucaoList;
begin
  Result := TPanamahTrocaDevolucaoList.Create;
  Result.DeserializeFromJSON(AJSON);
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
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTrocaDevolucao).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.