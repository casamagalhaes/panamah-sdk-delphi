{$M+}
unit PanamahSDK.Models.Secao;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahSecao = interface(IModel)
    ['{0F1C97E8-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
  end;
  
  IPanamahSecaoList = interface(IJSONSerializable)
    ['{0F1C97E9-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahSecao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahSecao);
    procedure Add(const AItem: IPanamahSecao);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahSecao read GetItem write SetItem; default;
  end;
  
  TPanamahSecao = class(TInterfacedObject, IPanamahSecao)
  private
    FId: string;
    FCodigo: string;
    FDescricao: string;
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSecao;
  published
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

  TPanamahSecaoList = class(TInterfacedObject, IPanamahSecaoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahSecao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahSecao);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSecaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahSecao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahSecao read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahSecao }

function TPanamahSecao.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahSecao.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahSecao.GetCodigo: string;
begin
  Result := FCodigo;
end;

procedure TPanamahSecao.SetCodigo(const ACodigo: string);
begin
  FCodigo := ACodigo;
end;

function TPanamahSecao.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahSecao.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

procedure TPanamahSecao.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FCodigo := GetFieldValueAsString(JSONObject, 'codigo');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahSecao.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'codigo', FCodigo);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahSecao.FromJSON(const AJSON: string): IPanamahSecao;
begin
  Result := TPanamahSecao.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahSecaoList }

constructor TPanamahSecaoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahSecaoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahSecaoList.FromJSON(const AJSON: string): IPanamahSecaoList;
begin
  Result := TPanamahSecaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahSecaoList.Add(const AItem: IPanamahSecao);
begin
  FList.Add(AItem);
end;

procedure TPanamahSecaoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahSecao;
begin
  Item := TPanamahSecao.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahSecaoList.Clear;
begin
  FList.Clear;
end;

function TPanamahSecaoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahSecaoList.GetItem(AIndex: Integer): IPanamahSecao;
begin
  Result := FList.Items[AIndex] as IPanamahSecao;
end;

procedure TPanamahSecaoList.SetItem(AIndex: Integer;
  const Value: IPanamahSecao);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahSecaoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahSecaoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahSecao).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.