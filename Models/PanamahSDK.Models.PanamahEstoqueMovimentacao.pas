{$M+}
unit PanamahSDK.Models.PanamahEstoqueMovimentacao;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahEstoqueMovimentacao = interface(IModel)
    ['{00631CE6-6D1F-11E9-BC68-6769AAA11E00}']
    function GetId: string;
    function GetLocalEstoqueId: string;
    function GetDataHora: TDateTime;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetCusto: Double;
    function GetPreco: Double;
    function GetMarkup: Double;
    procedure SetId(const AId: string);
    procedure SetLocalEstoqueId(const ALocalEstoqueId: string);
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetCusto(const ACusto: Double);
    procedure SetPreco(const APreco: Double);
    procedure SetMarkup(const AMarkup: Double);
    property Id: string read GetId write SetId;
    property LocalEstoqueId: string read GetLocalEstoqueId write SetLocalEstoqueId;
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Custo: Double read GetCusto write SetCusto;
    property Preco: Double read GetPreco write SetPreco;
    property Markup: Double read GetMarkup write SetMarkup;
  end;
  
  IPanamahEstoqueMovimentacaoList = interface(IJSONSerializable)
    ['{00631CE7-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahEstoqueMovimentacao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEstoqueMovimentacao);
    procedure Add(const AItem: IPanamahEstoqueMovimentacao);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahEstoqueMovimentacao read GetItem write SetItem; default;
  end;
  
  TPanamahEstoqueMovimentacao = class(TInterfacedObject, IPanamahEstoqueMovimentacao)
  private
    FId: string;
    FLocalEstoqueId: string;
    FDataHora: TDateTime;
    FProdutoId: string;
    FQuantidade: Double;
    FCusto: Double;
    FPreco: Double;
    FMarkup: Double;
    function GetId: string;
    function GetLocalEstoqueId: string;
    function GetDataHora: TDateTime;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    function GetCusto: Double;
    function GetPreco: Double;
    function GetMarkup: Double;
    procedure SetId(const AId: string);
    procedure SetLocalEstoqueId(const ALocalEstoqueId: string);
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetCusto(const ACusto: Double);
    procedure SetPreco(const APreco: Double);
    procedure SetMarkup(const AMarkup: Double);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEstoqueMovimentacao;
  published
    property Id: string read GetId write SetId;
    property LocalEstoqueId: string read GetLocalEstoqueId write SetLocalEstoqueId;
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Custo: Double read GetCusto write SetCusto;
    property Preco: Double read GetPreco write SetPreco;
    property Markup: Double read GetMarkup write SetMarkup;
  end;

  TPanamahEstoqueMovimentacaoList = class(TInterfacedObject, IPanamahEstoqueMovimentacaoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahEstoqueMovimentacao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEstoqueMovimentacao);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEstoqueMovimentacaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahEstoqueMovimentacao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahEstoqueMovimentacao read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahEstoqueMovimentacao }

function TPanamahEstoqueMovimentacao.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahEstoqueMovimentacao.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahEstoqueMovimentacao.GetLocalEstoqueId: string;
begin
  Result := FLocalEstoqueId;
end;

procedure TPanamahEstoqueMovimentacao.SetLocalEstoqueId(const ALocalEstoqueId: string);
begin
  FLocalEstoqueId := ALocalEstoqueId;
end;

function TPanamahEstoqueMovimentacao.GetDataHora: TDateTime;
begin
  Result := FDataHora;
end;

procedure TPanamahEstoqueMovimentacao.SetDataHora(const ADataHora: TDateTime);
begin
  FDataHora := ADataHora;
end;

function TPanamahEstoqueMovimentacao.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahEstoqueMovimentacao.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahEstoqueMovimentacao.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahEstoqueMovimentacao.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

function TPanamahEstoqueMovimentacao.GetCusto: Double;
begin
  Result := FCusto;
end;

procedure TPanamahEstoqueMovimentacao.SetCusto(const ACusto: Double);
begin
  FCusto := ACusto;
end;

function TPanamahEstoqueMovimentacao.GetPreco: Double;
begin
  Result := FPreco;
end;

procedure TPanamahEstoqueMovimentacao.SetPreco(const APreco: Double);
begin
  FPreco := APreco;
end;

function TPanamahEstoqueMovimentacao.GetMarkup: Double;
begin
  Result := FMarkup;
end;

procedure TPanamahEstoqueMovimentacao.SetMarkup(const AMarkup: Double);
begin
  FMarkup := AMarkup;
end;

procedure TPanamahEstoqueMovimentacao.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLocalEstoqueId := GetFieldValueAsString(JSONObject, 'localEstoqueId');
    FDataHora := GetFieldValueAsDatetime(JSONObject, 'dataHora');
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
    FCusto := GetFieldValueAsDouble(JSONObject, 'custo');
    FPreco := GetFieldValueAsDouble(JSONObject, 'preco');
    FMarkup := GetFieldValueAsDouble(JSONObject, 'markup');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahEstoqueMovimentacao.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'localEstoqueId', FLocalEstoqueId);    
    SetFieldValue(JSONObject, 'dataHora', FDataHora);    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);    
    SetFieldValue(JSONObject, 'custo', FCusto);    
    SetFieldValue(JSONObject, 'preco', FPreco);    
    SetFieldValue(JSONObject, 'markup', FMarkup);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahEstoqueMovimentacao.FromJSON(const AJSON: string): IPanamahEstoqueMovimentacao;
begin
  Result := TPanamahEstoqueMovimentacao.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahEstoqueMovimentacaoList }

constructor TPanamahEstoqueMovimentacaoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahEstoqueMovimentacaoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahEstoqueMovimentacaoList.FromJSON(const AJSON: string): IPanamahEstoqueMovimentacaoList;
begin
  Result := TPanamahEstoqueMovimentacaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahEstoqueMovimentacaoList.Add(const AItem: IPanamahEstoqueMovimentacao);
begin
  FList.Add(AItem);
end;

procedure TPanamahEstoqueMovimentacaoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahEstoqueMovimentacao;
begin
  Item := TPanamahEstoqueMovimentacao.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahEstoqueMovimentacaoList.Clear;
begin
  FList.Clear;
end;

function TPanamahEstoqueMovimentacaoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahEstoqueMovimentacaoList.GetItem(AIndex: Integer): IPanamahEstoqueMovimentacao;
begin
  Result := FList.Items[AIndex] as IPanamahEstoqueMovimentacao;
end;

procedure TPanamahEstoqueMovimentacaoList.SetItem(AIndex: Integer;
  const Value: IPanamahEstoqueMovimentacao);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahEstoqueMovimentacaoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahEstoqueMovimentacaoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahEstoqueMovimentacao).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.