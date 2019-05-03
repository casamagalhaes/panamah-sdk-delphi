{$M+}
unit PanamahSDK.Models.FormaPagamento;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahFormaPagamento = interface(IModel)
    ['{0F1D8248-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;
  
  IPanamahFormaPagamentoList = interface(IJSONSerializable)
    ['{0F1D8249-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahFormaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFormaPagamento);
    procedure Add(const AItem: IPanamahFormaPagamento);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahFormaPagamento read GetItem write SetItem; default;
  end;
  
  TPanamahFormaPagamento = class(TInterfacedObject, IPanamahFormaPagamento)
  private
    FId: string;
    FDescricao: string;
    function GetId: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahFormaPagamento;
  published
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

  TPanamahFormaPagamentoList = class(TInterfacedObject, IPanamahFormaPagamentoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahFormaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFormaPagamento);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahFormaPagamentoList;
    constructor Create;
    procedure Add(const AItem: IPanamahFormaPagamento);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahFormaPagamento read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahFormaPagamento }

function TPanamahFormaPagamento.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahFormaPagamento.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahFormaPagamento.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahFormaPagamento.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

procedure TPanamahFormaPagamento.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahFormaPagamento.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahFormaPagamento.FromJSON(const AJSON: string): IPanamahFormaPagamento;
begin
  Result := TPanamahFormaPagamento.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahFormaPagamentoList }

constructor TPanamahFormaPagamentoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahFormaPagamentoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahFormaPagamentoList.FromJSON(const AJSON: string): IPanamahFormaPagamentoList;
begin
  Result := TPanamahFormaPagamentoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahFormaPagamentoList.Add(const AItem: IPanamahFormaPagamento);
begin
  FList.Add(AItem);
end;

procedure TPanamahFormaPagamentoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahFormaPagamento;
begin
  Item := TPanamahFormaPagamento.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahFormaPagamentoList.Clear;
begin
  FList.Clear;
end;

function TPanamahFormaPagamentoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahFormaPagamentoList.GetItem(AIndex: Integer): IPanamahFormaPagamento;
begin
  Result := FList.Items[AIndex] as IPanamahFormaPagamento;
end;

procedure TPanamahFormaPagamentoList.SetItem(AIndex: Integer;
  const Value: IPanamahFormaPagamento);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahFormaPagamentoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahFormaPagamentoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahFormaPagamento).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.