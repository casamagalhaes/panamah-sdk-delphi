{$M+}
unit PanamahSDK.Models.Loja;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahLoja = interface(IPanamahModel)
    ['{081B3194-7736-11E9-A131-EBAF8D88186A}']
    function GetAtiva: Boolean;
    function GetId: string;
    function GetDescricao: string;
    function GetNumeroDocumento: string;
    function GetMatriz: Boolean;
    function GetHoldingId: string;
    function GetRamo: string;
    function GetLogradouro: variant;
    function GetNumero: variant;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    function GetCep: variant;
    function GetDistrito: variant;
    function GetComplemento: variant;
    function GetTelefone: variant;
    function GetQtdCheckouts: Double;
    function GetAreaM2: Double;
    function GetQtdFuncionarios: Double;
    procedure SetAtiva(const AAtiva: Boolean);
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: string);
    procedure SetMatriz(const AMatriz: Boolean);
    procedure SetHoldingId(const AHoldingId: string);
    procedure SetRamo(const ARamo: string);
    procedure SetLogradouro(const ALogradouro: variant);
    procedure SetNumero(const ANumero: variant);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    procedure SetCep(const ACep: variant);
    procedure SetDistrito(const ADistrito: variant);
    procedure SetComplemento(const AComplemento: variant);
    procedure SetTelefone(const ATelefone: variant);
    procedure SetQtdCheckouts(const AQtdCheckouts: Double);
    procedure SetAreaM2(const AAreaM2: Double);
    procedure SetQtdFuncionarios(const AQtdFuncionarios: Double);
    property Ativa: Boolean read GetAtiva write SetAtiva;
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
    property NumeroDocumento: string read GetNumeroDocumento write SetNumeroDocumento;
    property Matriz: Boolean read GetMatriz write SetMatriz;
    property HoldingId: string read GetHoldingId write SetHoldingId;
    property Ramo: string read GetRamo write SetRamo;
    property Logradouro: variant read GetLogradouro write SetLogradouro;
    property Numero: variant read GetNumero write SetNumero;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
    property Cep: variant read GetCep write SetCep;
    property Distrito: variant read GetDistrito write SetDistrito;
    property Complemento: variant read GetComplemento write SetComplemento;
    property Telefone: variant read GetTelefone write SetTelefone;
    property QtdCheckouts: Double read GetQtdCheckouts write SetQtdCheckouts;
    property AreaM2: Double read GetAreaM2 write SetAreaM2;
    property QtdFuncionarios: Double read GetQtdFuncionarios write SetQtdFuncionarios;
  end;
  
  IPanamahLojaList = interface(IPanamahModelList)
    ['{081B3195-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahLoja;
    procedure SetItem(AIndex: Integer; const Value: IPanamahLoja);
    procedure Add(const AItem: IPanamahLoja);
    property Items[AIndex: Integer]: IPanamahLoja read GetItem write SetItem; default;
  end;
  
  TPanamahLoja = class(TInterfacedObject, IPanamahLoja)
  private
    FAtiva: Boolean;
    FId: string;
    FDescricao: string;
    FNumeroDocumento: string;
    FMatriz: Boolean;
    FHoldingId: string;
    FRamo: string;
    FLogradouro: variant;
    FNumero: variant;
    FUf: string;
    FCidade: string;
    FBairro: string;
    FCep: variant;
    FDistrito: variant;
    FComplemento: variant;
    FTelefone: variant;
    FQtdCheckouts: Double;
    FAreaM2: Double;
    FQtdFuncionarios: Double;
    function GetAtiva: Boolean;
    function GetId: string;
    function GetDescricao: string;
    function GetNumeroDocumento: string;
    function GetMatriz: Boolean;
    function GetHoldingId: string;
    function GetRamo: string;
    function GetLogradouro: variant;
    function GetNumero: variant;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    function GetCep: variant;
    function GetDistrito: variant;
    function GetComplemento: variant;
    function GetTelefone: variant;
    function GetQtdCheckouts: Double;
    function GetAreaM2: Double;
    function GetQtdFuncionarios: Double;
    procedure SetAtiva(const AAtiva: Boolean);
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetNumeroDocumento(const ANumeroDocumento: string);
    procedure SetMatriz(const AMatriz: Boolean);
    procedure SetHoldingId(const AHoldingId: string);
    procedure SetRamo(const ARamo: string);
    procedure SetLogradouro(const ALogradouro: variant);
    procedure SetNumero(const ANumero: variant);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    procedure SetCep(const ACep: variant);
    procedure SetDistrito(const ADistrito: variant);
    procedure SetComplemento(const AComplemento: variant);
    procedure SetTelefone(const ATelefone: variant);
    procedure SetQtdCheckouts(const AQtdCheckouts: Double);
    procedure SetAreaM2(const AAreaM2: Double);
    procedure SetQtdFuncionarios(const AQtdFuncionarios: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahLoja;
    function Validate: IPanamahValidationResult;
  published
    property Ativa: Boolean read GetAtiva write SetAtiva;
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
    property NumeroDocumento: string read GetNumeroDocumento write SetNumeroDocumento;
    property Matriz: Boolean read GetMatriz write SetMatriz;
    property HoldingId: string read GetHoldingId write SetHoldingId;
    property Ramo: string read GetRamo write SetRamo;
    property Logradouro: variant read GetLogradouro write SetLogradouro;
    property Numero: variant read GetNumero write SetNumero;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
    property Cep: variant read GetCep write SetCep;
    property Distrito: variant read GetDistrito write SetDistrito;
    property Complemento: variant read GetComplemento write SetComplemento;
    property Telefone: variant read GetTelefone write SetTelefone;
    property QtdCheckouts: Double read GetQtdCheckouts write SetQtdCheckouts;
    property AreaM2: Double read GetAreaM2 write SetAreaM2;
    property QtdFuncionarios: Double read GetQtdFuncionarios write SetQtdFuncionarios;
  end;

  TPanamahLojaList = class(TInterfacedObject, IPanamahLojaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahLoja;
    procedure SetItem(AIndex: Integer; const Value: IPanamahLoja);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahLojaList;
    constructor Create;
    procedure Add(const AItem: IPanamahLoja);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahLoja read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahLojaValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahLoja }

function TPanamahLoja.GetAtiva: Boolean;
begin
  Result := FAtiva;
end;

procedure TPanamahLoja.SetAtiva(const AAtiva: Boolean);
begin
  FAtiva := AAtiva;
end;

function TPanamahLoja.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahLoja.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahLoja.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahLoja.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

function TPanamahLoja.GetNumeroDocumento: string;
begin
  Result := FNumeroDocumento;
end;

procedure TPanamahLoja.SetNumeroDocumento(const ANumeroDocumento: string);
begin
  FNumeroDocumento := ANumeroDocumento;
end;

function TPanamahLoja.GetMatriz: Boolean;
begin
  Result := FMatriz;
end;

procedure TPanamahLoja.SetMatriz(const AMatriz: Boolean);
begin
  FMatriz := AMatriz;
end;

function TPanamahLoja.GetHoldingId: string;
begin
  Result := FHoldingId;
end;

procedure TPanamahLoja.SetHoldingId(const AHoldingId: string);
begin
  FHoldingId := AHoldingId;
end;

function TPanamahLoja.GetRamo: string;
begin
  Result := FRamo;
end;

procedure TPanamahLoja.SetRamo(const ARamo: string);
begin
  FRamo := ARamo;
end;

function TPanamahLoja.GetLogradouro: variant;
begin
  Result := FLogradouro;
end;

procedure TPanamahLoja.SetLogradouro(const ALogradouro: variant);
begin
  FLogradouro := ALogradouro;
end;

function TPanamahLoja.GetNumero: variant;
begin
  Result := FNumero;
end;

procedure TPanamahLoja.SetNumero(const ANumero: variant);
begin
  FNumero := ANumero;
end;

function TPanamahLoja.GetUf: string;
begin
  Result := FUf;
end;

procedure TPanamahLoja.SetUf(const AUf: string);
begin
  FUf := AUf;
end;

function TPanamahLoja.GetCidade: string;
begin
  Result := FCidade;
end;

procedure TPanamahLoja.SetCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

function TPanamahLoja.GetBairro: string;
begin
  Result := FBairro;
end;

procedure TPanamahLoja.SetBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

function TPanamahLoja.GetCep: variant;
begin
  Result := FCep;
end;

procedure TPanamahLoja.SetCep(const ACep: variant);
begin
  FCep := ACep;
end;

function TPanamahLoja.GetDistrito: variant;
begin
  Result := FDistrito;
end;

procedure TPanamahLoja.SetDistrito(const ADistrito: variant);
begin
  FDistrito := ADistrito;
end;

function TPanamahLoja.GetComplemento: variant;
begin
  Result := FComplemento;
end;

procedure TPanamahLoja.SetComplemento(const AComplemento: variant);
begin
  FComplemento := AComplemento;
end;

function TPanamahLoja.GetTelefone: variant;
begin
  Result := FTelefone;
end;

procedure TPanamahLoja.SetTelefone(const ATelefone: variant);
begin
  FTelefone := ATelefone;
end;

function TPanamahLoja.GetQtdCheckouts: Double;
begin
  Result := FQtdCheckouts;
end;

procedure TPanamahLoja.SetQtdCheckouts(const AQtdCheckouts: Double);
begin
  FQtdCheckouts := AQtdCheckouts;
end;

function TPanamahLoja.GetAreaM2: Double;
begin
  Result := FAreaM2;
end;

procedure TPanamahLoja.SetAreaM2(const AAreaM2: Double);
begin
  FAreaM2 := AAreaM2;
end;

function TPanamahLoja.GetQtdFuncionarios: Double;
begin
  Result := FQtdFuncionarios;
end;

procedure TPanamahLoja.SetQtdFuncionarios(const AQtdFuncionarios: Double);
begin
  FQtdFuncionarios := AQtdFuncionarios;
end;

procedure TPanamahLoja.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAtiva := GetFieldValueAsBoolean(JSONObject, 'ativa');
    FId := GetFieldValueAsString(JSONObject, 'id');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FNumeroDocumento := GetFieldValueAsString(JSONObject, 'numeroDocumento');
    FMatriz := GetFieldValueAsBoolean(JSONObject, 'matriz');
    FHoldingId := GetFieldValueAsString(JSONObject, 'holdingId');
    FRamo := GetFieldValueAsString(JSONObject, 'ramo');
    FLogradouro := GetFieldValue(JSONObject, 'logradouro');
    FNumero := GetFieldValue(JSONObject, 'numero');
    FUf := GetFieldValueAsString(JSONObject, 'uf');
    FCidade := GetFieldValueAsString(JSONObject, 'cidade');
    FBairro := GetFieldValueAsString(JSONObject, 'bairro');
    FCep := GetFieldValue(JSONObject, 'cep');
    FDistrito := GetFieldValue(JSONObject, 'distrito');
    FComplemento := GetFieldValue(JSONObject, 'complemento');
    FTelefone := GetFieldValue(JSONObject, 'telefone');
    FQtdCheckouts := GetFieldValueAsDouble(JSONObject, 'qtdCheckouts');
    FAreaM2 := GetFieldValueAsDouble(JSONObject, 'areaM2');
    FQtdFuncionarios := GetFieldValueAsDouble(JSONObject, 'qtdFuncionarios');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahLoja.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'ativa', FAtiva);    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);    
    SetFieldValue(JSONObject, 'numeroDocumento', FNumeroDocumento);    
    SetFieldValue(JSONObject, 'matriz', FMatriz);    
    SetFieldValue(JSONObject, 'holdingId', FHoldingId);    
    SetFieldValue(JSONObject, 'ramo', FRamo);    
    SetFieldValue(JSONObject, 'logradouro', FLogradouro);    
    SetFieldValue(JSONObject, 'numero', FNumero);    
    SetFieldValue(JSONObject, 'uf', FUf);    
    SetFieldValue(JSONObject, 'cidade', FCidade);    
    SetFieldValue(JSONObject, 'bairro', FBairro);    
    SetFieldValue(JSONObject, 'cep', FCep);    
    SetFieldValue(JSONObject, 'distrito', FDistrito);    
    SetFieldValue(JSONObject, 'complemento', FComplemento);    
    SetFieldValue(JSONObject, 'telefone', FTelefone);    
    SetFieldValue(JSONObject, 'qtdCheckouts', FQtdCheckouts);    
    SetFieldValue(JSONObject, 'areaM2', FAreaM2);    
    SetFieldValue(JSONObject, 'qtdFuncionarios', FQtdFuncionarios);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahLoja.FromJSON(const AJSON: string): IPanamahLoja;
begin
  Result := TPanamahLoja.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahLoja.GetModelName: string;
begin
  Result := 'LOJA';
end;

function TPanamahLoja.Clone: IPanamahModel;
begin
  Result := TPanamahLoja.FromJSON(SerializeToJSON);
end;

function TPanamahLoja.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahLojaValidator.Create;
  Result := Validator.Validate(Self as IPanamahLoja);
end;

{ TPanamahLojaList }

constructor TPanamahLojaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahLojaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahLojaList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahLoja).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahLojaList.FromJSON(const AJSON: string): IPanamahLojaList;
begin
  Result := TPanamahLojaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahLojaList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahLoja;
end;

procedure TPanamahLojaList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahLojaList.Add(const AItem: IPanamahLoja);
begin
  FList.Add(AItem);
end;

procedure TPanamahLojaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahLoja;
begin
  Item := TPanamahLoja.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahLojaList.Clear;
begin
  FList.Clear;
end;

function TPanamahLojaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahLojaList.GetItem(AIndex: Integer): IPanamahLoja;
begin
  Result := FList.Items[AIndex] as IPanamahLoja;
end;

procedure TPanamahLojaList.SetItem(AIndex: Integer;
  const Value: IPanamahLoja);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahLojaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahLojaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahLoja).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahLojaValidator }

function TPanamahLojaValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Loja: IPanamahLoja;
  Validations: IPanamahValidationResultList;
begin
  Loja := AModel as IPanamahLoja;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Loja.Id) then
    Validations.AddFailure('Loja.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.Descricao) then
    Validations.AddFailure('Loja.Descricao obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.NumeroDocumento) then
    Validations.AddFailure('Loja.NumeroDocumento obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.HoldingId) then
    Validations.AddFailure('Loja.HoldingId obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.Ramo) then
    Validations.AddFailure('Loja.Ramo obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.Uf) then
    Validations.AddFailure('Loja.Uf obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.Cidade) then
    Validations.AddFailure('Loja.Cidade obrigatorio(a)');
  
  if ModelValueIsEmpty(Loja.Bairro) then
    Validations.AddFailure('Loja.Bairro obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.