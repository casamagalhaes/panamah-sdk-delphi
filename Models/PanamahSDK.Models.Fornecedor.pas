{$M+}
unit PanamahSDK.Models.Fornecedor;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahFornecedor = interface(IPanamahModel)
    ['{081BF4E9-7736-11E9-A131-EBAF8D88186A}']
    function GetId: string;
    function GetNome: string;
    function GetNumeroDocumento: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property NumeroDocumento: string read GetNumeroDocumento write SetNumeroDocumento;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;
  
  IPanamahFornecedorList = interface(IPanamahModelList)
    ['{081BF4EA-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahFornecedor;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFornecedor);
    procedure Add(const AItem: IPanamahFornecedor);
    property Items[AIndex: Integer]: IPanamahFornecedor read GetItem write SetItem; default;
  end;
  
  TPanamahFornecedor = class(TInterfacedObject, IPanamahFornecedor)
  private
    FId: string;
    FNome: string;
    FNumeroDocumento: string;
    FRamo: string;
    FUf: string;
    FCidade: string;
    FBairro: string;
    function GetId: string;
    function GetNome: string;
    function GetNumeroDocumento: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahFornecedor;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property NumeroDocumento: string read GetNumeroDocumento write SetNumeroDocumento;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;

  TPanamahFornecedorList = class(TInterfacedObject, IPanamahFornecedorList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahFornecedor;
    procedure SetItem(AIndex: Integer; const Value: IPanamahFornecedor);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahFornecedorList;
    constructor Create;
    procedure Add(const AItem: IPanamahFornecedor);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahFornecedor read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahFornecedorValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahFornecedor }

function TPanamahFornecedor.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahFornecedor.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahFornecedor.GetNome: string;
begin
  Result := FNome;
end;

procedure TPanamahFornecedor.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

function TPanamahFornecedor.GetNumeroDocumento: string;
begin
  Result := FNumeroDocumento;
end;

procedure TPanamahFornecedor.SetNumeroDocumento(const ANumeroDocumento: string);
begin
  FNumeroDocumento := ANumeroDocumento;
end;

function TPanamahFornecedor.GetRamo: string;
begin
  Result := FRamo;
end;

procedure TPanamahFornecedor.SetRamo(const ARamo: string);
begin
  FRamo := ARamo;
end;

function TPanamahFornecedor.GetUf: string;
begin
  Result := FUf;
end;

procedure TPanamahFornecedor.SetUf(const AUf: string);
begin
  FUf := AUf;
end;

function TPanamahFornecedor.GetCidade: string;
begin
  Result := FCidade;
end;

procedure TPanamahFornecedor.SetCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

function TPanamahFornecedor.GetBairro: string;
begin
  Result := FBairro;
end;

procedure TPanamahFornecedor.SetBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

procedure TPanamahFornecedor.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FNome := GetFieldValueAsString(JSONObject, 'nome');
    FNumeroDocumento := GetFieldValueAsString(JSONObject, 'numeroDocumento');
    FRamo := GetFieldValueAsString(JSONObject, 'ramo');
    FUf := GetFieldValueAsString(JSONObject, 'uf');
    FCidade := GetFieldValueAsString(JSONObject, 'cidade');
    FBairro := GetFieldValueAsString(JSONObject, 'bairro');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahFornecedor.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'nome', FNome);    
    SetFieldValue(JSONObject, 'numeroDocumento', FNumeroDocumento);    
    SetFieldValue(JSONObject, 'ramo', FRamo);    
    SetFieldValue(JSONObject, 'uf', FUf);    
    SetFieldValue(JSONObject, 'cidade', FCidade);    
    SetFieldValue(JSONObject, 'bairro', FBairro);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahFornecedor.FromJSON(const AJSON: string): IPanamahFornecedor;
begin
  Result := TPanamahFornecedor.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahFornecedor.GetModelName: string;
begin
  Result := 'FORNECEDOR';
end;

function TPanamahFornecedor.Clone: IPanamahModel;
begin
  Result := TPanamahFornecedor.FromJSON(SerializeToJSON);
end;

function TPanamahFornecedor.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahFornecedorValidator.Create;
  Result := Validator.Validate(Self as IPanamahFornecedor);
end;

{ TPanamahFornecedorList }

constructor TPanamahFornecedorList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahFornecedorList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahFornecedorList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahFornecedor).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahFornecedorList.FromJSON(const AJSON: string): IPanamahFornecedorList;
begin
  Result := TPanamahFornecedorList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahFornecedorList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahFornecedor;
end;

procedure TPanamahFornecedorList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahFornecedorList.Add(const AItem: IPanamahFornecedor);
begin
  FList.Add(AItem);
end;

procedure TPanamahFornecedorList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahFornecedor;
begin
  Item := TPanamahFornecedor.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahFornecedorList.Clear;
begin
  FList.Clear;
end;

function TPanamahFornecedorList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahFornecedorList.GetItem(AIndex: Integer): IPanamahFornecedor;
begin
  Result := FList.Items[AIndex] as IPanamahFornecedor;
end;

procedure TPanamahFornecedorList.SetItem(AIndex: Integer;
  const Value: IPanamahFornecedor);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahFornecedorList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahFornecedorList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahFornecedor).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahFornecedorValidator }

function TPanamahFornecedorValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Fornecedor: IPanamahFornecedor;
  Validations: IPanamahValidationResultList;
begin
  Fornecedor := AModel as IPanamahFornecedor;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Fornecedor.Id) then
    Validations.AddFailure('Fornecedor.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.Nome) then
    Validations.AddFailure('Fornecedor.Nome obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.NumeroDocumento) then
    Validations.AddFailure('Fornecedor.NumeroDocumento obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.Ramo) then
    Validations.AddFailure('Fornecedor.Ramo obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.Uf) then
    Validations.AddFailure('Fornecedor.Uf obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.Cidade) then
    Validations.AddFailure('Fornecedor.Cidade obrigatorio(a)');
  
  if ModelValueIsEmpty(Fornecedor.Bairro) then
    Validations.AddFailure('Fornecedor.Bairro obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.