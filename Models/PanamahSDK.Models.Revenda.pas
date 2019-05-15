{$M+}
unit PanamahSDK.Models.Revenda;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahRevenda = interface(IPanamahModel)
    ['{081AE370-7736-11E9-A131-EBAF8D88186A}']
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;
  
  IPanamahRevendaList = interface(IPanamahModelList)
    ['{081AE371-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahRevenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahRevenda);
    procedure Add(const AItem: IPanamahRevenda);
    property Items[AIndex: Integer]: IPanamahRevenda read GetItem write SetItem; default;
  end;
  
  TPanamahRevenda = class(TInterfacedObject, IPanamahRevenda)
  private
    FId: string;
    FNome: string;
    FFantasia: string;
    FRamo: string;
    FUf: string;
    FCidade: string;
    FBairro: string;
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahRevenda;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;

  TPanamahRevendaList = class(TInterfacedObject, IPanamahRevendaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahRevenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahRevenda);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahRevendaList;
    constructor Create;
    procedure Add(const AItem: IPanamahRevenda);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahRevenda read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahRevendaValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahRevenda }

function TPanamahRevenda.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahRevenda.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahRevenda.GetNome: string;
begin
  Result := FNome;
end;

procedure TPanamahRevenda.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

function TPanamahRevenda.GetFantasia: string;
begin
  Result := FFantasia;
end;

procedure TPanamahRevenda.SetFantasia(const AFantasia: string);
begin
  FFantasia := AFantasia;
end;

function TPanamahRevenda.GetRamo: string;
begin
  Result := FRamo;
end;

procedure TPanamahRevenda.SetRamo(const ARamo: string);
begin
  FRamo := ARamo;
end;

function TPanamahRevenda.GetUf: string;
begin
  Result := FUf;
end;

procedure TPanamahRevenda.SetUf(const AUf: string);
begin
  FUf := AUf;
end;

function TPanamahRevenda.GetCidade: string;
begin
  Result := FCidade;
end;

procedure TPanamahRevenda.SetCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

function TPanamahRevenda.GetBairro: string;
begin
  Result := FBairro;
end;

procedure TPanamahRevenda.SetBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

procedure TPanamahRevenda.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FNome := GetFieldValueAsString(JSONObject, 'nome');
    FFantasia := GetFieldValueAsString(JSONObject, 'fantasia');
    FRamo := GetFieldValueAsString(JSONObject, 'ramo');
    FUf := GetFieldValueAsString(JSONObject, 'uf');
    FCidade := GetFieldValueAsString(JSONObject, 'cidade');
    FBairro := GetFieldValueAsString(JSONObject, 'bairro');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahRevenda.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'nome', FNome);    
    SetFieldValue(JSONObject, 'fantasia', FFantasia);    
    SetFieldValue(JSONObject, 'ramo', FRamo);    
    SetFieldValue(JSONObject, 'uf', FUf);    
    SetFieldValue(JSONObject, 'cidade', FCidade);    
    SetFieldValue(JSONObject, 'bairro', FBairro);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahRevenda.FromJSON(const AJSON: string): IPanamahRevenda;
begin
  Result := TPanamahRevenda.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahRevenda.GetModelName: string;
begin
  Result := 'REVENDA';
end;

function TPanamahRevenda.Clone: IPanamahModel;
begin
  Result := TPanamahRevenda.FromJSON(SerializeToJSON);
end;

function TPanamahRevenda.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahRevendaValidator.Create;
  Result := Validator.Validate(Self as IPanamahRevenda);
end;

{ TPanamahRevendaList }

constructor TPanamahRevendaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahRevendaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahRevendaList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahRevenda).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahRevendaList.FromJSON(const AJSON: string): IPanamahRevendaList;
begin
  Result := TPanamahRevendaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahRevendaList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahRevenda;
end;

procedure TPanamahRevendaList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahRevendaList.Add(const AItem: IPanamahRevenda);
begin
  FList.Add(AItem);
end;

procedure TPanamahRevendaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahRevenda;
begin
  Item := TPanamahRevenda.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahRevendaList.Clear;
begin
  FList.Clear;
end;

function TPanamahRevendaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahRevendaList.GetItem(AIndex: Integer): IPanamahRevenda;
begin
  Result := FList.Items[AIndex] as IPanamahRevenda;
end;

procedure TPanamahRevendaList.SetItem(AIndex: Integer;
  const Value: IPanamahRevenda);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahRevendaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahRevendaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahRevenda).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahRevendaValidator }

function TPanamahRevendaValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Revenda: IPanamahRevenda;
  Validations: IPanamahValidationResultList;
begin
  Revenda := AModel as IPanamahRevenda;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Revenda.Id) then
    Validations.AddFailure('Revenda.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Nome) then
    Validations.AddFailure('Revenda.Nome obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Fantasia) then
    Validations.AddFailure('Revenda.Fantasia obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Ramo) then
    Validations.AddFailure('Revenda.Ramo obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Uf) then
    Validations.AddFailure('Revenda.Uf obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Cidade) then
    Validations.AddFailure('Revenda.Cidade obrigatorio(a)');
  
  if ModelValueIsEmpty(Revenda.Bairro) then
    Validations.AddFailure('Revenda.Bairro obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.