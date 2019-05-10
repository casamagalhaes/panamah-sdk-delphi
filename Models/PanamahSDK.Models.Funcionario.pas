{$M+}
unit PanamahSDK.Models.Funcionario;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahFuncionario = interface(IPanamahModel)
    ['{775987E0-7368-11E9-BBA3-6970D342FA48}']
    function GetDataNascimento: TDateTime;
    function GetId: string;
    function GetLogin: variant;
    function GetNome: string;
    function GetNumeroDocumento: variant;
    function GetAtivo: Boolean;
    function GetSenha: variant;
    function GetLojaIds: IPanamahStringValueList;
    procedure SetDataNascimento(const ADataNascimento: TDateTime);
    procedure SetId(const AId: string);
    procedure SetLogin(const ALogin: variant);
    procedure SetNome(const ANome: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: variant);
    procedure SetAtivo(const AAtivo: Boolean);
    procedure SetSenha(const ASenha: variant);
    procedure SetLojaIds(const ALojaIds: IPanamahStringValueList);
    property DataNascimento: TDateTime read GetDataNascimento write SetDataNascimento;
    property Id: string read GetId write SetId;
    property Login: variant read GetLogin write SetLogin;
    property Nome: string read GetNome write SetNome;
    property NumeroDocumento: variant read GetNumeroDocumento write SetNumeroDocumento;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property Senha: variant read GetSenha write SetSenha;
    property LojaIds: IPanamahStringValueList read GetLojaIds write SetLojaIds;
  end;
  
  IPanamahFuncionarioList = interface(IPanamahModelList)
    ['{775987E1-7368-11E9-BBA3-6970D342FA48}']
    function GetItem(AIndex: Integer): IPanamahFuncionario;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFuncionario);
    procedure Add(const AItem: IPanamahFuncionario);
    property Items[AIndex: Integer]: IPanamahFuncionario read GetItem write SetItem; default;
  end;
  
  TPanamahFuncionario = class(TInterfacedObject, IPanamahFuncionario)
  private
    FDataNascimento: TDateTime;
    FId: string;
    FLogin: variant;
    FNome: string;
    FNumeroDocumento: variant;
    FAtivo: Boolean;
    FSenha: variant;
    FLojaIds: IPanamahStringValueList;
    function GetDataNascimento: TDateTime;
    function GetId: string;
    function GetLogin: variant;
    function GetNome: string;
    function GetNumeroDocumento: variant;
    function GetAtivo: Boolean;
    function GetSenha: variant;
    function GetLojaIds: IPanamahStringValueList;
    procedure SetDataNascimento(const ADataNascimento: TDateTime);
    procedure SetId(const AId: string);
    procedure SetLogin(const ALogin: variant);
    procedure SetNome(const ANome: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: variant);
    procedure SetAtivo(const AAtivo: Boolean);
    procedure SetSenha(const ASenha: variant);
    procedure SetLojaIds(const ALojaIds: IPanamahStringValueList);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahFuncionario;
    function Validate: IPanamahValidationResult;
  published
    property DataNascimento: TDateTime read GetDataNascimento write SetDataNascimento;
    property Id: string read GetId write SetId;
    property Login: variant read GetLogin write SetLogin;
    property Nome: string read GetNome write SetNome;
    property NumeroDocumento: variant read GetNumeroDocumento write SetNumeroDocumento;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property Senha: variant read GetSenha write SetSenha;
    property LojaIds: IPanamahStringValueList read GetLojaIds write SetLojaIds;
  end;

  TPanamahFuncionarioList = class(TInterfacedObject, IPanamahFuncionarioList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahFuncionario;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFuncionario);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahFuncionarioList;
    constructor Create;
    procedure Add(const AItem: IPanamahFuncionario);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahFuncionario read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahFuncionarioValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahFuncionario }

function TPanamahFuncionario.GetDataNascimento: TDateTime;
begin
  Result := FDataNascimento;
end;

procedure TPanamahFuncionario.SetDataNascimento(const ADataNascimento: TDateTime);
begin
  FDataNascimento := ADataNascimento;
end;

function TPanamahFuncionario.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahFuncionario.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahFuncionario.GetLogin: variant;
begin
  Result := FLogin;
end;

procedure TPanamahFuncionario.SetLogin(const ALogin: variant);
begin
  FLogin := ALogin;
end;

function TPanamahFuncionario.GetNome: string;
begin
  Result := FNome;
end;

procedure TPanamahFuncionario.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

function TPanamahFuncionario.GetNumeroDocumento: variant;
begin
  Result := FNumeroDocumento;
end;

procedure TPanamahFuncionario.SetNumeroDocumento(const ANumeroDocumento: variant);
begin
  FNumeroDocumento := ANumeroDocumento;
end;

function TPanamahFuncionario.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

procedure TPanamahFuncionario.SetAtivo(const AAtivo: Boolean);
begin
  FAtivo := AAtivo;
end;

function TPanamahFuncionario.GetSenha: variant;
begin
  Result := FSenha;
end;

procedure TPanamahFuncionario.SetSenha(const ASenha: variant);
begin
  FSenha := ASenha;
end;

function TPanamahFuncionario.GetLojaIds: IPanamahStringValueList;
begin
  Result := FLojaIds;
end;

procedure TPanamahFuncionario.SetLojaIds(const ALojaIds: IPanamahStringValueList);
begin
  FLojaIds := ALojaIds;
end;

procedure TPanamahFuncionario.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FDataNascimento := GetFieldValueAsDatetime(JSONObject, 'dataNascimento');
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLogin := GetFieldValue(JSONObject, 'login');
    FNome := GetFieldValueAsString(JSONObject, 'nome');
    FNumeroDocumento := GetFieldValue(JSONObject, 'numeroDocumento');
    FAtivo := GetFieldValueAsBoolean(JSONObject, 'ativo');
    FSenha := GetFieldValue(JSONObject, 'senha');
    if JSONObject.Field['lojaIds'] is TlkJSONlist then
      FLojaIds := TPanamahStringValueList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['lojaIds']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahFuncionario.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'dataNascimento', FDataNascimento);    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'login', FLogin);    
    SetFieldValue(JSONObject, 'nome', FNome);    
    SetFieldValue(JSONObject, 'numeroDocumento', FNumeroDocumento);    
    SetFieldValue(JSONObject, 'ativo', FAtivo);    
    SetFieldValue(JSONObject, 'senha', FSenha);    
    SetFieldValue(JSONObject, 'lojaIds', FLojaIds);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahFuncionario.FromJSON(const AJSON: string): IPanamahFuncionario;
begin
  Result := TPanamahFuncionario.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahFuncionario.GetModelName: string;
begin
  Result := 'PanamahFuncionario';
end;

function TPanamahFuncionario.Clone: IPanamahModel;
begin
  Result := TPanamahFuncionario.FromJSON(SerializeToJSON);
end;

function TPanamahFuncionario.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahFuncionarioValidator.Create;
  Result := Validator.Validate(Self as IPanamahFuncionario);
end;

{ TPanamahFuncionarioList }

constructor TPanamahFuncionarioList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahFuncionarioList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahFuncionarioList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [FList[I]]), (FList[I] as IPanamahModel).Validate);
end;

class function TPanamahFuncionarioList.FromJSON(const AJSON: string): IPanamahFuncionarioList;
begin
  Result := TPanamahFuncionarioList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahFuncionarioList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahFuncionario;
end;

procedure TPanamahFuncionarioList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahFuncionarioList.Add(const AItem: IPanamahFuncionario);
begin
  FList.Add(AItem);
end;

procedure TPanamahFuncionarioList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahFuncionario;
begin
  Item := TPanamahFuncionario.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahFuncionarioList.Clear;
begin
  FList.Clear;
end;

function TPanamahFuncionarioList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahFuncionarioList.GetItem(AIndex: Integer): IPanamahFuncionario;
begin
  Result := FList.Items[AIndex] as IPanamahFuncionario;
end;

procedure TPanamahFuncionarioList.SetItem(AIndex: Integer;
  const Value: IPanamahFuncionario);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahFuncionarioList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahFuncionarioList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahFuncionario).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahFuncionarioValidator }

function TPanamahFuncionarioValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Funcionario: IPanamahFuncionario;
  Validations: IPanamahValidationResultList;
begin
  Funcionario := AModel as IPanamahFuncionario;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Funcionario.Id) then
    Validations.AddFailure('Funcionario.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Funcionario.Nome) then
    Validations.AddFailure('Funcionario.Nome obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.