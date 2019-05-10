{$M+}
unit PanamahSDK.Models.Subgrupo;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahSubgrupo = interface(IPanamahModel)
    ['{7758EBA6-7368-11E9-BBA3-6970D342FA48}']
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetSecaoId: string;
    function GetGrupoId: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetGrupoId(const AGrupoId: string);
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property GrupoId: string read GetGrupoId write SetGrupoId;
  end;
  
  IPanamahSubgrupoList = interface(IPanamahModelList)
    ['{7758EBA7-7368-11E9-BBA3-6970D342FA48}']
    function GetItem(AIndex: Integer): IPanamahSubgrupo;
    procedure SetItem(AIndex: Integer; const Value: IPanamahSubgrupo);
    procedure Add(const AItem: IPanamahSubgrupo);
    property Items[AIndex: Integer]: IPanamahSubgrupo read GetItem write SetItem; default;
  end;
  
  TPanamahSubgrupo = class(TInterfacedObject, IPanamahSubgrupo)
  private
    FId: string;
    FCodigo: string;
    FDescricao: string;
    FSecaoId: string;
    FGrupoId: string;
    function GetId: string;
    function GetCodigo: string;
    function GetDescricao: string;
    function GetSecaoId: string;
    function GetGrupoId: string;
    procedure SetId(const AId: string);
    procedure SetCodigo(const ACodigo: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetGrupoId(const AGrupoId: string);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahSubgrupo;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Codigo: string read GetCodigo write SetCodigo;
    property Descricao: string read GetDescricao write SetDescricao;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property GrupoId: string read GetGrupoId write SetGrupoId;
  end;

  TPanamahSubgrupoList = class(TInterfacedObject, IPanamahSubgrupoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahSubgrupo;
    procedure SetItem(AIndex: Integer; const Value: IPanamahSubgrupo);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSubgrupoList;
    constructor Create;
    procedure Add(const AItem: IPanamahSubgrupo);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahSubgrupo read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahSubgrupoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahSubgrupo }

function TPanamahSubgrupo.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahSubgrupo.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahSubgrupo.GetCodigo: string;
begin
  Result := FCodigo;
end;

procedure TPanamahSubgrupo.SetCodigo(const ACodigo: string);
begin
  FCodigo := ACodigo;
end;

function TPanamahSubgrupo.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahSubgrupo.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

function TPanamahSubgrupo.GetSecaoId: string;
begin
  Result := FSecaoId;
end;

procedure TPanamahSubgrupo.SetSecaoId(const ASecaoId: string);
begin
  FSecaoId := ASecaoId;
end;

function TPanamahSubgrupo.GetGrupoId: string;
begin
  Result := FGrupoId;
end;

procedure TPanamahSubgrupo.SetGrupoId(const AGrupoId: string);
begin
  FGrupoId := AGrupoId;
end;

procedure TPanamahSubgrupo.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FCodigo := GetFieldValueAsString(JSONObject, 'codigo');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FSecaoId := GetFieldValueAsString(JSONObject, 'secaoId');
    FGrupoId := GetFieldValueAsString(JSONObject, 'grupoId');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahSubgrupo.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'codigo', FCodigo);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);    
    SetFieldValue(JSONObject, 'secaoId', FSecaoId);    
    SetFieldValue(JSONObject, 'grupoId', FGrupoId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahSubgrupo.FromJSON(const AJSON: string): IPanamahSubgrupo;
begin
  Result := TPanamahSubgrupo.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahSubgrupo.GetModelName: string;
begin
  Result := 'PanamahSubgrupo';
end;

function TPanamahSubgrupo.Clone: IPanamahModel;
begin
  Result := TPanamahSubgrupo.FromJSON(SerializeToJSON);
end;

function TPanamahSubgrupo.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahSubgrupoValidator.Create;
  Result := Validator.Validate(Self as IPanamahSubgrupo);
end;

{ TPanamahSubgrupoList }

constructor TPanamahSubgrupoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahSubgrupoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahSubgrupoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [FList[I]]), (FList[I] as IPanamahModel).Validate);
end;

class function TPanamahSubgrupoList.FromJSON(const AJSON: string): IPanamahSubgrupoList;
begin
  Result := TPanamahSubgrupoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahSubgrupoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahSubgrupo;
end;

procedure TPanamahSubgrupoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahSubgrupoList.Add(const AItem: IPanamahSubgrupo);
begin
  FList.Add(AItem);
end;

procedure TPanamahSubgrupoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahSubgrupo;
begin
  Item := TPanamahSubgrupo.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahSubgrupoList.Clear;
begin
  FList.Clear;
end;

function TPanamahSubgrupoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahSubgrupoList.GetItem(AIndex: Integer): IPanamahSubgrupo;
begin
  Result := FList.Items[AIndex] as IPanamahSubgrupo;
end;

procedure TPanamahSubgrupoList.SetItem(AIndex: Integer;
  const Value: IPanamahSubgrupo);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahSubgrupoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahSubgrupoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahSubgrupo).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahSubgrupoValidator }

function TPanamahSubgrupoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Subgrupo: IPanamahSubgrupo;
  Validations: IPanamahValidationResultList;
begin
  Subgrupo := AModel as IPanamahSubgrupo;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Subgrupo.Id) then
    Validations.AddFailure('Subgrupo.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Subgrupo.Codigo) then
    Validations.AddFailure('Subgrupo.Codigo obrigatorio(a)');
  
  if ModelValueIsEmpty(Subgrupo.Descricao) then
    Validations.AddFailure('Subgrupo.Descricao obrigatorio(a)');
  
  if ModelValueIsEmpty(Subgrupo.SecaoId) then
    Validations.AddFailure('Subgrupo.SecaoId obrigatorio(a)');
  
  if ModelValueIsEmpty(Subgrupo.GrupoId) then
    Validations.AddFailure('Subgrupo.GrupoId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.