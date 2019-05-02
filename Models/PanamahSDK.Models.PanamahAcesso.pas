{$M+}
unit PanamahSDK.Models.PanamahAcesso;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahAcesso = interface(IModel)
    ['{00605DC0-6D1F-11E9-BC68-6769AAA11E00}']
    function GetId: string;
    function GetFuncionarioIds: IPanamahStringValueList;
    procedure SetId(const AId: string);
    procedure SetFuncionarioIds(const AFuncionarioIds: IPanamahStringValueList);
    property Id: string read GetId write SetId;
    property FuncionarioIds: IPanamahStringValueList read GetFuncionarioIds write SetFuncionarioIds;
  end;
  
  IPanamahAcessoList = interface(IJSONSerializable)
    ['{00605DC1-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahAcesso;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAcesso);
    procedure Add(const AItem: IPanamahAcesso);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahAcesso read GetItem write SetItem; default;
  end;
  
  TPanamahAcesso = class(TInterfacedObject, IPanamahAcesso)
  private
    FId: string;
    FFuncionarioIds: IPanamahStringValueList;
    function GetId: string;
    function GetFuncionarioIds: IPanamahStringValueList;
    procedure SetId(const AId: string);
    procedure SetFuncionarioIds(const AFuncionarioIds: IPanamahStringValueList);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahAcesso;
  published
    property Id: string read GetId write SetId;
    property FuncionarioIds: IPanamahStringValueList read GetFuncionarioIds write SetFuncionarioIds;
  end;

  TPanamahAcessoList = class(TInterfacedObject, IPanamahAcessoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahAcesso;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAcesso);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahAcessoList;
    constructor Create;
    procedure Add(const AItem: IPanamahAcesso);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahAcesso read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahAcesso }

function TPanamahAcesso.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahAcesso.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahAcesso.GetFuncionarioIds: IPanamahStringValueList;
begin
  Result := FFuncionarioIds;
end;

procedure TPanamahAcesso.SetFuncionarioIds(const AFuncionarioIds: IPanamahStringValueList);
begin
  FFuncionarioIds := AFuncionarioIds;
end;

procedure TPanamahAcesso.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    if JSONObject.Field['funcionarioIds'] is TlkJSONlist then
      FFuncionarioIds := TPanamahStringValueList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['funcionarioIds']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahAcesso.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'funcionarioIds', FFuncionarioIds);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahAcesso.FromJSON(const AJSON: string): IPanamahAcesso;
begin
  Result := TPanamahAcesso.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahAcessoList }

constructor TPanamahAcessoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahAcessoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahAcessoList.FromJSON(const AJSON: string): IPanamahAcessoList;
begin
  Result := TPanamahAcessoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahAcessoList.Add(const AItem: IPanamahAcesso);
begin
  FList.Add(AItem);
end;

procedure TPanamahAcessoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahAcesso;
begin
  Item := TPanamahAcesso.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahAcessoList.Clear;
begin
  FList.Clear;
end;

function TPanamahAcessoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahAcessoList.GetItem(AIndex: Integer): IPanamahAcesso;
begin
  Result := FList.Items[AIndex] as IPanamahAcesso;
end;

procedure TPanamahAcessoList.SetItem(AIndex: Integer;
  const Value: IPanamahAcesso);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahAcessoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahAcessoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahAcesso).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.