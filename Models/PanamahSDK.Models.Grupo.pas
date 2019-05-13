{$M+}
unit PanamahSDK.Models.Grupo;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahGrupo = interface(IPanamahModel)
    ['{8E7A6E75-75CB-11E9-8B82-D97403569AFA}']
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
  
  IPanamahGrupoList = interface(IPanamahModelList)
    ['{8E7A6E76-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahGrupo;
    procedure SetItem(AIndex: Integer; const Value: IPanamahGrupo);
    procedure Add(const AItem: IPanamahGrupo);
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
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahGrupo;
    function Validate: IPanamahValidationResult;
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
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahGrupoList;
    constructor Create;
    procedure Add(const AItem: IPanamahGrupo);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahGrupo read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahGrupoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

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

function TPanamahGrupo.GetModelName: string;
begin
  Result := 'GRUPO';
end;

function TPanamahGrupo.Clone: IPanamahModel;
begin
  Result := TPanamahGrupo.FromJSON(SerializeToJSON);
end;

function TPanamahGrupo.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahGrupoValidator.Create;
  Result := Validator.Validate(Self as IPanamahGrupo);
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

function TPanamahGrupoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahGrupo).Validate);
end;

class function TPanamahGrupoList.FromJSON(const AJSON: string): IPanamahGrupoList;
begin
  Result := TPanamahGrupoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahGrupoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahGrupo;
end;

procedure TPanamahGrupoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
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

{ TPanamahGrupoValidator }

function TPanamahGrupoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Grupo: IPanamahGrupo;
  Validations: IPanamahValidationResultList;
begin
  Grupo := AModel as IPanamahGrupo;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Grupo.Id) then
    Validations.AddFailure('Grupo.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Grupo.Codigo) then
    Validations.AddFailure('Grupo.Codigo obrigatorio(a)');
  
  if ModelValueIsEmpty(Grupo.Descricao) then
    Validations.AddFailure('Grupo.Descricao obrigatorio(a)');
  
  if ModelValueIsEmpty(Grupo.SecaoId) then
    Validations.AddFailure('Grupo.SecaoId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.