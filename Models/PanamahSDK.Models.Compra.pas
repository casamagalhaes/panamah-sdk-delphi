{$M+}
unit PanamahSDK.Models.Compra;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahCompraItem = interface(IModel)
    ['{0F206870-6DAE-11E9-88EA-EB5361679635}']
    function GetAcrescimo: Double;
    function GetDesconto: Double;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Desconto: Double read GetDesconto write SetDesconto;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
  end;
  
  IPanamahCompraItemList = interface(IJSONSerializable)
    ['{0F206871-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahCompraItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahCompraItem);
    procedure Add(const AItem: IPanamahCompraItem);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahCompraItem read GetItem write SetItem; default;
  end;
  
  IPanamahCompra = interface(IModel)
    ['{0F204160-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetLojaId: string;
    function GetFornecedorId: variant;
    function GetFuncionarioId: variant;
    function GetDataEntrada: TDateTime;
    function GetDataEmissao: TDateTime;
    function GetDataHoraCompra: TDateTime;
    function GetDesconto: Double;
    function GetEfetiva: Boolean;
    function GetQuantidadeItens: Double;
    function GetTipoDesconto: variant;
    function GetValor: Double;
    function GetAcrescimo: Double;
    function GetItens: IPanamahCompraItemList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetFornecedorId(const AFornecedorId: variant);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetDataEntrada(const ADataEntrada: TDateTime);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataHoraCompra(const ADataHoraCompra: TDateTime);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetiva(const AEfetiva: Boolean);
    procedure SetQuantidadeItens(const AQuantidadeItens: Double);
    procedure SetTipoDesconto(const ATipoDesconto: variant);
    procedure SetValor(const AValor: Double);
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetItens(const AItens: IPanamahCompraItemList);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property FornecedorId: variant read GetFornecedorId write SetFornecedorId;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property DataEntrada: TDateTime read GetDataEntrada write SetDataEntrada;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataHoraCompra: TDateTime read GetDataHoraCompra write SetDataHoraCompra;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetiva: Boolean read GetEfetiva write SetEfetiva;
    property QuantidadeItens: Double read GetQuantidadeItens write SetQuantidadeItens;
    property TipoDesconto: variant read GetTipoDesconto write SetTipoDesconto;
    property Valor: Double read GetValor write SetValor;
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Itens: IPanamahCompraItemList read GetItens write SetItens;
  end;
  
  IPanamahCompraList = interface(IJSONSerializable)
    ['{0F204161-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahCompra;
    procedure SetItem(AIndex: Integer; const Value: IPanamahCompra);
    procedure Add(const AItem: IPanamahCompra);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahCompra read GetItem write SetItem; default;
  end;
  
  TPanamahCompraItem = class(TInterfacedObject, IPanamahCompraItem)
  private
    FAcrescimo: Double;
    FDesconto: Double;
    FProdutoId: string;
    FQuantidade: Double;
    FValorTotal: Double;
    FValorUnitario: Double;
    function GetAcrescimo: Double;
    function GetDesconto: Double;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahCompraItem;
  published
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Desconto: Double read GetDesconto write SetDesconto;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
  end;

  TPanamahCompraItemList = class(TInterfacedObject, IPanamahCompraItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahCompraItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahCompraItem);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahCompraItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahCompraItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahCompraItem read GetItem write SetItem; default;
  end;
  
  TPanamahCompra = class(TInterfacedObject, IPanamahCompra)
  private
    FId: string;
    FLojaId: string;
    FFornecedorId: variant;
    FFuncionarioId: variant;
    FDataEntrada: TDateTime;
    FDataEmissao: TDateTime;
    FDataHoraCompra: TDateTime;
    FDesconto: Double;
    FEfetiva: Boolean;
    FQuantidadeItens: Double;
    FTipoDesconto: variant;
    FValor: Double;
    FAcrescimo: Double;
    FItens: IPanamahCompraItemList;
    function GetId: string;
    function GetLojaId: string;
    function GetFornecedorId: variant;
    function GetFuncionarioId: variant;
    function GetDataEntrada: TDateTime;
    function GetDataEmissao: TDateTime;
    function GetDataHoraCompra: TDateTime;
    function GetDesconto: Double;
    function GetEfetiva: Boolean;
    function GetQuantidadeItens: Double;
    function GetTipoDesconto: variant;
    function GetValor: Double;
    function GetAcrescimo: Double;
    function GetItens: IPanamahCompraItemList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetFornecedorId(const AFornecedorId: variant);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetDataEntrada(const ADataEntrada: TDateTime);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataHoraCompra(const ADataHoraCompra: TDateTime);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetiva(const AEfetiva: Boolean);
    procedure SetQuantidadeItens(const AQuantidadeItens: Double);
    procedure SetTipoDesconto(const ATipoDesconto: variant);
    procedure SetValor(const AValor: Double);
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetItens(const AItens: IPanamahCompraItemList);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahCompra;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property FornecedorId: variant read GetFornecedorId write SetFornecedorId;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property DataEntrada: TDateTime read GetDataEntrada write SetDataEntrada;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataHoraCompra: TDateTime read GetDataHoraCompra write SetDataHoraCompra;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetiva: Boolean read GetEfetiva write SetEfetiva;
    property QuantidadeItens: Double read GetQuantidadeItens write SetQuantidadeItens;
    property TipoDesconto: variant read GetTipoDesconto write SetTipoDesconto;
    property Valor: Double read GetValor write SetValor;
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Itens: IPanamahCompraItemList read GetItens write SetItens;
  end;

  TPanamahCompraList = class(TInterfacedObject, IPanamahCompraList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahCompra;
    procedure SetItem(AIndex: Integer; const Value: IPanamahCompra);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahCompraList;
    constructor Create;
    procedure Add(const AItem: IPanamahCompra);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahCompra read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahCompraItem }

function TPanamahCompraItem.GetAcrescimo: Double;
begin
  Result := FAcrescimo;
end;

procedure TPanamahCompraItem.SetAcrescimo(const AAcrescimo: Double);
begin
  FAcrescimo := AAcrescimo;
end;

function TPanamahCompraItem.GetDesconto: Double;
begin
  Result := FDesconto;
end;

procedure TPanamahCompraItem.SetDesconto(const ADesconto: Double);
begin
  FDesconto := ADesconto;
end;

function TPanamahCompraItem.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahCompraItem.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahCompraItem.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahCompraItem.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

function TPanamahCompraItem.GetValorTotal: Double;
begin
  Result := FValorTotal;
end;

procedure TPanamahCompraItem.SetValorTotal(const AValorTotal: Double);
begin
  FValorTotal := AValorTotal;
end;

function TPanamahCompraItem.GetValorUnitario: Double;
begin
  Result := FValorUnitario;
end;

procedure TPanamahCompraItem.SetValorUnitario(const AValorUnitario: Double);
begin
  FValorUnitario := AValorUnitario;
end;

procedure TPanamahCompraItem.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAcrescimo := GetFieldValueAsDouble(JSONObject, 'acrescimo');
    FDesconto := GetFieldValueAsDouble(JSONObject, 'desconto');
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
    FValorTotal := GetFieldValueAsDouble(JSONObject, 'valorTotal');
    FValorUnitario := GetFieldValueAsDouble(JSONObject, 'valorUnitario');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahCompraItem.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'acrescimo', FAcrescimo);    
    SetFieldValue(JSONObject, 'desconto', FDesconto);    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);    
    SetFieldValue(JSONObject, 'valorTotal', FValorTotal);    
    SetFieldValue(JSONObject, 'valorUnitario', FValorUnitario);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahCompraItem.FromJSON(const AJSON: string): IPanamahCompraItem;
begin
  Result := TPanamahCompraItem.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahCompraItemList }

constructor TPanamahCompraItemList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahCompraItemList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahCompraItemList.FromJSON(const AJSON: string): IPanamahCompraItemList;
begin
  Result := TPanamahCompraItemList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahCompraItemList.Add(const AItem: IPanamahCompraItem);
begin
  FList.Add(AItem);
end;

procedure TPanamahCompraItemList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahCompraItem;
begin
  Item := TPanamahCompraItem.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahCompraItemList.Clear;
begin
  FList.Clear;
end;

function TPanamahCompraItemList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahCompraItemList.GetItem(AIndex: Integer): IPanamahCompraItem;
begin
  Result := FList.Items[AIndex] as IPanamahCompraItem;
end;

procedure TPanamahCompraItemList.SetItem(AIndex: Integer;
  const Value: IPanamahCompraItem);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahCompraItemList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahCompraItemList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahCompraItem).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahCompra }

function TPanamahCompra.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahCompra.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahCompra.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahCompra.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahCompra.GetFornecedorId: variant;
begin
  Result := FFornecedorId;
end;

procedure TPanamahCompra.SetFornecedorId(const AFornecedorId: variant);
begin
  FFornecedorId := AFornecedorId;
end;

function TPanamahCompra.GetFuncionarioId: variant;
begin
  Result := FFuncionarioId;
end;

procedure TPanamahCompra.SetFuncionarioId(const AFuncionarioId: variant);
begin
  FFuncionarioId := AFuncionarioId;
end;

function TPanamahCompra.GetDataEntrada: TDateTime;
begin
  Result := FDataEntrada;
end;

procedure TPanamahCompra.SetDataEntrada(const ADataEntrada: TDateTime);
begin
  FDataEntrada := ADataEntrada;
end;

function TPanamahCompra.GetDataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

procedure TPanamahCompra.SetDataEmissao(const ADataEmissao: TDateTime);
begin
  FDataEmissao := ADataEmissao;
end;

function TPanamahCompra.GetDataHoraCompra: TDateTime;
begin
  Result := FDataHoraCompra;
end;

procedure TPanamahCompra.SetDataHoraCompra(const ADataHoraCompra: TDateTime);
begin
  FDataHoraCompra := ADataHoraCompra;
end;

function TPanamahCompra.GetDesconto: Double;
begin
  Result := FDesconto;
end;

procedure TPanamahCompra.SetDesconto(const ADesconto: Double);
begin
  FDesconto := ADesconto;
end;

function TPanamahCompra.GetEfetiva: Boolean;
begin
  Result := FEfetiva;
end;

procedure TPanamahCompra.SetEfetiva(const AEfetiva: Boolean);
begin
  FEfetiva := AEfetiva;
end;

function TPanamahCompra.GetQuantidadeItens: Double;
begin
  Result := FQuantidadeItens;
end;

procedure TPanamahCompra.SetQuantidadeItens(const AQuantidadeItens: Double);
begin
  FQuantidadeItens := AQuantidadeItens;
end;

function TPanamahCompra.GetTipoDesconto: variant;
begin
  Result := FTipoDesconto;
end;

procedure TPanamahCompra.SetTipoDesconto(const ATipoDesconto: variant);
begin
  FTipoDesconto := ATipoDesconto;
end;

function TPanamahCompra.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahCompra.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

function TPanamahCompra.GetAcrescimo: Double;
begin
  Result := FAcrescimo;
end;

procedure TPanamahCompra.SetAcrescimo(const AAcrescimo: Double);
begin
  FAcrescimo := AAcrescimo;
end;

function TPanamahCompra.GetItens: IPanamahCompraItemList;
begin
  Result := FItens;
end;

procedure TPanamahCompra.SetItens(const AItens: IPanamahCompraItemList);
begin
  FItens := AItens;
end;

procedure TPanamahCompra.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FFornecedorId := GetFieldValue(JSONObject, 'fornecedorId');
    FFuncionarioId := GetFieldValue(JSONObject, 'funcionarioId');
    FDataEntrada := GetFieldValueAsDatetime(JSONObject, 'dataEntrada');
    FDataEmissao := GetFieldValueAsDatetime(JSONObject, 'dataEmissao');
    FDataHoraCompra := GetFieldValueAsDatetime(JSONObject, 'dataHoraCompra');
    FDesconto := GetFieldValueAsDouble(JSONObject, 'desconto');
    FEfetiva := GetFieldValueAsBoolean(JSONObject, 'efetiva');
    FQuantidadeItens := GetFieldValueAsDouble(JSONObject, 'quantidadeItens');
    FTipoDesconto := GetFieldValue(JSONObject, 'tipoDesconto');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
    FAcrescimo := GetFieldValueAsDouble(JSONObject, 'acrescimo');
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TPanamahCompraItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahCompra.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'fornecedorId', FFornecedorId);    
    SetFieldValue(JSONObject, 'funcionarioId', FFuncionarioId);    
    SetFieldValue(JSONObject, 'dataEntrada', FDataEntrada);    
    SetFieldValue(JSONObject, 'dataEmissao', FDataEmissao);    
    SetFieldValue(JSONObject, 'dataHoraCompra', FDataHoraCompra);    
    SetFieldValue(JSONObject, 'desconto', FDesconto);    
    SetFieldValue(JSONObject, 'efetiva', FEfetiva);    
    SetFieldValue(JSONObject, 'quantidadeItens', FQuantidadeItens);    
    SetFieldValue(JSONObject, 'tipoDesconto', FTipoDesconto);    
    SetFieldValue(JSONObject, 'valor', FValor);    
    SetFieldValue(JSONObject, 'acrescimo', FAcrescimo);    
    SetFieldValue(JSONObject, 'itens', FItens);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahCompra.FromJSON(const AJSON: string): IPanamahCompra;
begin
  Result := TPanamahCompra.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahCompraList }

constructor TPanamahCompraList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahCompraList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahCompraList.FromJSON(const AJSON: string): IPanamahCompraList;
begin
  Result := TPanamahCompraList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahCompraList.Add(const AItem: IPanamahCompra);
begin
  FList.Add(AItem);
end;

procedure TPanamahCompraList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahCompra;
begin
  Item := TPanamahCompra.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahCompraList.Clear;
begin
  FList.Clear;
end;

function TPanamahCompraList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahCompraList.GetItem(AIndex: Integer): IPanamahCompra;
begin
  Result := FList.Items[AIndex] as IPanamahCompra;
end;

procedure TPanamahCompraList.SetItem(AIndex: Integer;
  const Value: IPanamahCompra);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahCompraList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahCompraList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahCompra).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.