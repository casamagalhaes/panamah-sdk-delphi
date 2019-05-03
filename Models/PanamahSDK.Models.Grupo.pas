{$M+}
unit PanamahSDK.Models.Grupo;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahGrupo = interface(IModel)
    ['{0F1D0D10-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetSecaoId: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetSecaoId(const ASecaoId: string);
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
    property SecaoId: string read GetSecaoId write SetSecaoId;
  end;
  
  IPanamahGrupoList = interface(IJSONSerializable)
    ['{0F1D0D11-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahGrupo;
    procedure SetItem(AIndex: Integer; const Value: IPanamahGrupo);
    procedure Add(const AItem: IPanamahGrupo);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahGrupo read GetItem write SetItem; default;
  end;
  
  TPanamahGrupo = class(TInterfacedObject, IPanamahGrupo)
  private
    FId: string;
    FCodigo: string;
    FDescricao: string;
    FSecaoId: string;
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetSecaoId: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetSecaoId(const ASecaoId: string);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahGrupo;
  published
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
    property SecaoId: string read GetSecaoId write SetSecaoId;
  end;

  TPanamahGrupoList = class(TInterfacedObject, IPanamahGrupoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahGrupo;
    procedure SetItem(AIndex: Integer; const Value: IPanamahGrupo);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahGrupoList;
    constructor Create;
    procedure Add(const AItem: IPanamahGrupo);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahGrupo read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahGrupo }

function TPanamahGrupo.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahGrupo.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahGrupo.GetCodigo: string;
begin
  Result := FCodigo;
end;

procedure TPanamahGrupo.SetCodigo(const ACodigo: string);
begin
  FCodigo := ACodigo;
end;

function TPanamahGrupo.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahGrupo.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

function TPanamahGrupo.GetSecaoId: string;
begin
  Result := FSecaoId;
end;

procedure TPanamahGrupo.SetSecaoId(const ASecaoId: string);
begin
  FSecaoId := ASecaoId;
end;

procedure TPanamahGrupo.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FCodigo := GetFieldValueAsString(JSONObject, 'codigo');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FSecaoId := GetFieldValueAsString(JSONObject, 'secaoId');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahGrupo.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'codigo', FCodigo);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);    
    SetFieldValue(JSONObject, 'secaoId', FSecaoId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahGrupo.FromJSON(const AJSON: string): IPanamahGrupo;
begin
  Result := TPanamahGrupo.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahGrupoList }

constructor TPanamahGrupoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahGrupoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahGrupoList.FromJSON(const AJSON: string): IPanamahGrupoList;
begin
  Result := TPanamahGrupoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahGrupoList.Add(const AItem: IPanamahGrupo);
begin
  FList.Add(AItem);
end;

procedure TPanamahGrupoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahGrupo;
begin
  Item := TPanamahGrupo.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahGrupoList.Clear;
begin
  FList.Clear;
end;

function TPanamahGrupoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahGrupoList.GetItem(AIndex: Integer): IPanamahGrupo;
begin
  Result := FList.Items[AIndex] as IPanamahGrupo;
end;

procedure TPanamahGrupoList.SetItem(AIndex: Integer;
  const Value: IPanamahGrupo);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahGrupoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahGrupoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahGrupo).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.