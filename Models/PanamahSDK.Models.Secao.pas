{$M+}
unit PanamahSDK.Models.Secao;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahSecao = interface(IPanamahModel)
    ['{7758C491-7368-11E9-BBA3-6970D342FA48}']
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
  
  IPanamahSecaoList = interface(IPanamahModelList)
    ['{7758C492-7368-11E9-BBA3-6970D342FA48}']
    function GetItem(AIndex: Integer): IPanamahSecao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahSecao);
    procedure Add(const AItem: IPanamahSecao);
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
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahSecao;
    function Validate: IPanamahValidationResult;
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
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSecaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahSecao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahSecao read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahSecaoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

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

function TPanamahSecao.GetModelName: string;
begin
  Result := 'PanamahSecao';
end;

function TPanamahSecao.Clone: IPanamahModel;
begin
  Result := TPanamahSecao.FromJSON(SerializeToJSON);
end;

function TPanamahSecao.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahSecaoValidator.Create;
  Result := Validator.Validate(Self as IPanamahSecao);
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

function TPanamahSecaoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [FList[I]]), (FList[I] as IPanamahModel).Validate);
end;

class function TPanamahSecaoList.FromJSON(const AJSON: string): IPanamahSecaoList;
begin
  Result := TPanamahSecaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahSecaoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahSecao;
end;

procedure TPanamahSecaoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
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

{ TPanamahSecaoValidator }

function TPanamahSecaoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Secao: IPanamahSecao;
  Validations: IPanamahValidationResultList;
begin
  Secao := AModel as IPanamahSecao;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Secao.Id) then
    Validations.AddFailure('Secao.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Secao.Codigo) then
    Validations.AddFailure('Secao.Codigo obrigatorio(a)');
  
  if ModelValueIsEmpty(Secao.Descricao) then
    Validations.AddFailure('Secao.Descricao obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.