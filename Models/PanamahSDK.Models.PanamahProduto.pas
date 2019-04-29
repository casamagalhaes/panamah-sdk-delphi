{$M+}
unit PanamahSDK.Models.PanamahProduto;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  IPanamahProdutoComposicaoItem = interface(IModel)
    ['{9B3ADAD7-4BFF-4342-9795-A3F6BB96C15C}']
    function GetProdutoId: Variant;
    procedure SetProdutoId(const AProdutoId: Variant);
    property ProdutoId: Variant read GetProdutoId write SetProdutoId;
  end;

  IPanamahProdutoComposicaoItemList = interface(IJSONSerializable)
    ['{73E33100-4480-4FDE-9B24-311F2D017F91}']
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;

  IPanamahProdutoComposicao = interface(IModel)
    ['{3F3AB5E7-DCCC-4947-8FE1-6DC4952719D6}']
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(AQuantidade: Double);
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;

  IPanamahProduto = interface(IModel)
    ['{AF7B1CE0-69EA-43E9-8B8A-FC3FEC6F9CDD}']
    function GetDescricao: string;
    function GetFinalidade: Variant;
    function GetId: Variant;
    function GetComposicao: IPanamahProdutoComposicao;
    function GetTipo: TTipoEventoCaixa;
    procedure SetDescricao(const ADescricao: string);
    procedure SetFinalidade(const AFinalidade: Variant);
    procedure SetId(const AId: Variant);
    procedure SetComposicao(AComposicao: IPanamahProdutoComposicao);
    procedure SetTipo(ATipo: TTipoEventoCaixa);
    property Descricao: string read GetDescricao write SetDescricao;
    property Finalidade: Variant read GetFinalidade write SetFinalidade;
    property Id: Variant read GetId write SetId;
    property Composicao: IPanamahProdutoComposicao read GetComposicao write SetComposicao;
    property Tipo: TTipoEventoCaixa read GetTipo write SetTipo;
  end;

  TPanamahProdutoComposicaoItem = class(TInterfacedObject, IPanamahProdutoComposicaoItem)
  private
    FProdutoId: Variant;
    function GetProdutoId: Variant;
    procedure SetProdutoId(const AProdutoId: Variant);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
  published
    property ProdutoId: Variant read GetProdutoId write SetProdutoId;
  end;

  TPanamahProdutoComposicaoItemList = class(TInterfacedObject, IPanamahProdutoComposicaoItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicaoItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;

  TPanamahProdutoComposicao = class(TInterfacedObject, IPanamahProdutoComposicao)
  private
    FQuantidade: Double;
    FItens: IPanamahProdutoComposicaoItemList;
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(AQuantidade: Double);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicao;
  published
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
  end;

  TPanamahProduto = class(TInterfacedObject, IPanamahProduto)
  private
    FComposicao: IPanamahProdutoComposicao;
    FDescricao: string;
    FFinalidade: Variant;
    FId: Variant;
    FTipo: TTipoEventoCaixa;
    function GetComposicao: IPanamahProdutoComposicao;
    function GetDescricao: string;
    function GetFinalidade: Variant;
    function GetId: Variant;
    function GetTipo: TTipoEventoCaixa;
    procedure SetComposicao(AComposicao: IPanamahProdutoComposicao);
    procedure SetDescricao(const ADescricao: string);
    procedure SetFinalidade(const AFinalidade: Variant);
    procedure SetId(const AId: Variant);
    procedure SetTipo(ATipo: TTipoEventoCaixa);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProduto;
  published
    property Composicao: IPanamahProdutoComposicao read GetComposicao write SetComposicao;
    property Descricao: string read GetDescricao write SetDescricao;
    property Finalidade: Variant read GetFinalidade write SetFinalidade;
    property Id: Variant read GetId write SetId;
    property Tipo: TTipoEventoCaixa read GetTipo write SetTipo;
  end;

implementation

{ TPanamahProdutoComposicaoItem }

function TPanamahProdutoComposicaoItem.GetProdutoId: Variant;
begin
  Result := FProdutoId;
end;

procedure TPanamahProdutoComposicaoItem.SetProdutoId(const AProdutoId: Variant);
begin
  FProdutoId := AProdutoId;
end;

procedure TPanamahProdutoComposicaoItem.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FProdutoId := JSONObject.Field['produtoId'].Value;
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProdutoComposicaoItem.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahProdutoComposicaoItemList }

constructor TPanamahProdutoComposicaoItemList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahProdutoComposicaoItemList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahProdutoComposicaoItemList.FromJSON(const AJSON: string): IPanamahProdutoComposicaoItemList;
begin
  Result := TPanamahProdutoComposicaoItemList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahProdutoComposicaoItemList.Add(const AItem: IPanamahProdutoComposicaoItem);
begin
  FList.Add(AItem);
end;

procedure TPanamahProdutoComposicaoItemList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahProdutoComposicaoItem;
begin
  Item := TPanamahProdutoComposicaoItem.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahProdutoComposicaoItemList.Clear;
begin
  FList.Clear;
end;

function TPanamahProdutoComposicaoItemList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahProdutoComposicaoItemList.GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
begin
  Result := FList.Items[AIndex] as IPanamahProdutoComposicaoItem;
end;

procedure TPanamahProdutoComposicaoItemList.SetItem(AIndex: Integer;
  const Value: IPanamahProdutoComposicaoItem);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahProdutoComposicaoItemList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoComposicaoItemList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahProdutoComposicaoItem).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahProdutoComposicao }

procedure TPanamahProdutoComposicao.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TPanamahProdutoComposicaoItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProdutoComposicao.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);
    SetFieldValue(JSONObject, 'itens', FItens);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProdutoComposicao.FromJSON(const AJSON: string): IPanamahProdutoComposicao;
begin
  Result := TPanamahProdutoComposicao.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProdutoComposicao.GetItens: IPanamahProdutoComposicaoItemList;
begin
  Result := FItens;
end;

function TPanamahProdutoComposicao.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahProdutoComposicao.SetItens(AItens: IPanamahProdutoComposicaoItemList);
begin
  FItens := AItens;
end;

procedure TPanamahProdutoComposicao.SetQuantidade(AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

{ TPanamahProduto }

procedure TPanamahProduto.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValue(JSONObject, 'id');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FFinalidade := GetFieldValueAsString(JSONObject, 'finalidade');
    if JSONObject.Field['composicao'] is TlkJSONobject then
      FComposicao := TPanamahProdutoComposicao.FromJSON(TlkJSON.GenerateText(JSONObject.Field['composicao']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProduto.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'id', FId);
    SetFieldValue(JSONObject, 'descricao', FDescricao);
    SetFieldValue(JSONObject, 'finalidade', FFinalidade);
    SetFieldValue(JSONObject, 'composicao', FComposicao);
    SetFieldValue(JSONObject, 'tipo', EnumConverters.Execute('TipoEventoCaixa', Ord(FTipo)));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProduto.FromJSON(const AJSON: string): IPanamahProduto;
begin
  Result := TPanamahProduto.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProduto.GetComposicao: IPanamahProdutoComposicao;
begin
  Result := FComposicao;
end;

function TPanamahProduto.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TPanamahProduto.GetFinalidade: Variant;
begin
  Result := FFinalidade;
end;

function TPanamahProduto.GetId: Variant;
begin
  Result := FId;
end;

function TPanamahProduto.GetTipo: TTipoEventoCaixa;
begin
  Result := FTipo;
end;

procedure TPanamahProduto.SetComposicao(AComposicao: IPanamahProdutoComposicao);
begin
  FComposicao := AComposicao;
end;

procedure TPanamahProduto.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

procedure TPanamahProduto.SetFinalidade(const AFinalidade: Variant);
begin
  FFinalidade := AFinalidade;
end;

procedure TPanamahProduto.SetId(const AId: Variant);
begin
  FId := AId;
end;

procedure TPanamahProduto.SetTipo(ATipo: TTipoEventoCaixa);
begin
  FTipo := ATipo;
end;

end.
