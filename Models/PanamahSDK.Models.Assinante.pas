{$M+}
unit PanamahSDK.Models.Assinante;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahAssinante = interface(IPanamahModel)
    ['{7757DA30-7368-11E9-BBA3-6970D342FA48}']
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetRevendaId: variant;
    function GetBairro: string;
    function GetSoftwaresAtivos: IPanamahSoftwareAtivoList;
    function GetSoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList;
    function GetSeries: IPanamahStringValueList;
    function GetAtivo: Boolean;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetRevendaId(const ARevendaId: variant);
    procedure SetBairro(const ABairro: string);
    procedure SetSoftwaresAtivos(const ASoftwaresAtivos: IPanamahSoftwareAtivoList);
    procedure SetSoftwaresEmContratosDeManutencao(const ASoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList);
    procedure SetSeries(const ASeries: IPanamahStringValueList);
    procedure SetAtivo(const AAtivo: Boolean);
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property RevendaId: variant read GetRevendaId write SetRevendaId;
    property Bairro: string read GetBairro write SetBairro;
    property SoftwaresAtivos: IPanamahSoftwareAtivoList read GetSoftwaresAtivos write SetSoftwaresAtivos;
    property SoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList read GetSoftwaresEmContratosDeManutencao write SetSoftwaresEmContratosDeManutencao;
    property Series: IPanamahStringValueList read GetSeries write SetSeries;
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;
  
  IPanamahAssinanteList = interface(IPanamahModelList)
    ['{7757DA31-7368-11E9-BBA3-6970D342FA48}']
    function GetItem(AIndex: Integer): IPanamahAssinante;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAssinante);
    procedure Add(const AItem: IPanamahAssinante);
    property Items[AIndex: Integer]: IPanamahAssinante read GetItem write SetItem; default;
  end;
  
  TPanamahAssinante = class(TInterfacedObject, IPanamahAssinante)
  private
    FId: string;
    FNome: string;
    FFantasia: string;
    FRamo: string;
    FUf: string;
    FCidade: string;
    FRevendaId: variant;
    FBairro: string;
    FSoftwaresAtivos: IPanamahSoftwareAtivoList;
    FSoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList;
    FSeries: IPanamahStringValueList;
    FAtivo: Boolean;
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetRevendaId: variant;
    function GetBairro: string;
    function GetSoftwaresAtivos: IPanamahSoftwareAtivoList;
    function GetSoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList;
    function GetSeries: IPanamahStringValueList;
    function GetAtivo: Boolean;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetRevendaId(const ARevendaId: variant);
    procedure SetBairro(const ABairro: string);
    procedure SetSoftwaresAtivos(const ASoftwaresAtivos: IPanamahSoftwareAtivoList);
    procedure SetSoftwaresEmContratosDeManutencao(const ASoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList);
    procedure SetSeries(const ASeries: IPanamahStringValueList);
    procedure SetAtivo(const AAtivo: Boolean);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahAssinante;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property RevendaId: variant read GetRevendaId write SetRevendaId;
    property Bairro: string read GetBairro write SetBairro;
    property SoftwaresAtivos: IPanamahSoftwareAtivoList read GetSoftwaresAtivos write SetSoftwaresAtivos;
    property SoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList read GetSoftwaresEmContratosDeManutencao write SetSoftwaresEmContratosDeManutencao;
    property Series: IPanamahStringValueList read GetSeries write SetSeries;
    property Ativo: Boolean read GetAtivo write SetAtivo;
  end;

  TPanamahAssinanteList = class(TInterfacedObject, IPanamahAssinanteList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahAssinante;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAssinante);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahAssinanteList;
    constructor Create;
    procedure Add(const AItem: IPanamahAssinante);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahAssinante read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahAssinanteValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahAssinante }

function TPanamahAssinante.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahAssinante.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahAssinante.GetNome: string;
begin
  Result := FNome;
end;

procedure TPanamahAssinante.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

function TPanamahAssinante.GetFantasia: string;
begin
  Result := FFantasia;
end;

procedure TPanamahAssinante.SetFantasia(const AFantasia: string);
begin
  FFantasia := AFantasia;
end;

function TPanamahAssinante.GetRamo: string;
begin
  Result := FRamo;
end;

procedure TPanamahAssinante.SetRamo(const ARamo: string);
begin
  FRamo := ARamo;
end;

function TPanamahAssinante.GetUf: string;
begin
  Result := FUf;
end;

procedure TPanamahAssinante.SetUf(const AUf: string);
begin
  FUf := AUf;
end;

function TPanamahAssinante.GetCidade: string;
begin
  Result := FCidade;
end;

procedure TPanamahAssinante.SetCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

function TPanamahAssinante.GetRevendaId: variant;
begin
  Result := FRevendaId;
end;

procedure TPanamahAssinante.SetRevendaId(const ARevendaId: variant);
begin
  FRevendaId := ARevendaId;
end;

function TPanamahAssinante.GetBairro: string;
begin
  Result := FBairro;
end;

procedure TPanamahAssinante.SetBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

function TPanamahAssinante.GetSoftwaresAtivos: IPanamahSoftwareAtivoList;
begin
  Result := FSoftwaresAtivos;
end;

procedure TPanamahAssinante.SetSoftwaresAtivos(const ASoftwaresAtivos: IPanamahSoftwareAtivoList);
begin
  FSoftwaresAtivos := ASoftwaresAtivos;
end;

function TPanamahAssinante.GetSoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList;
begin
  Result := FSoftwaresEmContratosDeManutencao;
end;

procedure TPanamahAssinante.SetSoftwaresEmContratosDeManutencao(const ASoftwaresEmContratosDeManutencao: IPanamahSoftwareContratoManutencaoList);
begin
  FSoftwaresEmContratosDeManutencao := ASoftwaresEmContratosDeManutencao;
end;

function TPanamahAssinante.GetSeries: IPanamahStringValueList;
begin
  Result := FSeries;
end;

procedure TPanamahAssinante.SetSeries(const ASeries: IPanamahStringValueList);
begin
  FSeries := ASeries;
end;

function TPanamahAssinante.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

procedure TPanamahAssinante.SetAtivo(const AAtivo: Boolean);
begin
  FAtivo := AAtivo;
end;

procedure TPanamahAssinante.DeserializeFromJSON(const AJSON: string);
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
    FRevendaId := GetFieldValue(JSONObject, 'revendaId');
    FBairro := GetFieldValueAsString(JSONObject, 'bairro');
    if JSONObject.Field['softwaresAtivos'] is TlkJSONlist then
      FSoftwaresAtivos := TPanamahSoftwareAtivoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['softwaresAtivos']));
    if JSONObject.Field['softwaresEmContratosDeManutencao'] is TlkJSONlist then
      FSoftwaresEmContratosDeManutencao := TPanamahSoftwareContratoManutencaoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['softwaresEmContratosDeManutencao']));
    if JSONObject.Field['series'] is TlkJSONlist then
      FSeries := TPanamahStringValueList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['series']));
    FAtivo := GetFieldValueAsBoolean(JSONObject, 'ativo');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahAssinante.SerializeToJSON: string;
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
    SetFieldValue(JSONObject, 'revendaId', FRevendaId);    
    SetFieldValue(JSONObject, 'bairro', FBairro);    
    SetFieldValue(JSONObject, 'softwaresAtivos', FSoftwaresAtivos);    
    SetFieldValue(JSONObject, 'softwaresEmContratosDeManutencao', FSoftwaresEmContratosDeManutencao);    
    SetFieldValue(JSONObject, 'series', FSeries);    
    SetFieldValue(JSONObject, 'ativo', FAtivo);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahAssinante.FromJSON(const AJSON: string): IPanamahAssinante;
begin
  Result := TPanamahAssinante.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahAssinante.GetModelName: string;
begin
  Result := 'PanamahAssinante';
end;

function TPanamahAssinante.Clone: IPanamahModel;
begin
  Result := TPanamahAssinante.FromJSON(SerializeToJSON);
end;

function TPanamahAssinante.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahAssinanteValidator.Create;
  Result := Validator.Validate(Self as IPanamahAssinante);
end;

{ TPanamahAssinanteList }

constructor TPanamahAssinanteList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahAssinanteList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahAssinanteList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [FList[I]]), (FList[I] as IPanamahModel).Validate);
end;

class function TPanamahAssinanteList.FromJSON(const AJSON: string): IPanamahAssinanteList;
begin
  Result := TPanamahAssinanteList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahAssinanteList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahAssinante;
end;

procedure TPanamahAssinanteList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahAssinanteList.Add(const AItem: IPanamahAssinante);
begin
  FList.Add(AItem);
end;

procedure TPanamahAssinanteList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahAssinante;
begin
  Item := TPanamahAssinante.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahAssinanteList.Clear;
begin
  FList.Clear;
end;

function TPanamahAssinanteList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahAssinanteList.GetItem(AIndex: Integer): IPanamahAssinante;
begin
  Result := FList.Items[AIndex] as IPanamahAssinante;
end;

procedure TPanamahAssinanteList.SetItem(AIndex: Integer;
  const Value: IPanamahAssinante);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahAssinanteList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahAssinanteList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahAssinante).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahAssinanteValidator }

function TPanamahAssinanteValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Assinante: IPanamahAssinante;
  Validations: IPanamahValidationResultList;
begin
  Assinante := AModel as IPanamahAssinante;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Assinante.Id) then
    Validations.AddFailure('Assinante.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Nome) then
    Validations.AddFailure('Assinante.Nome obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Fantasia) then
    Validations.AddFailure('Assinante.Fantasia obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Ramo) then
    Validations.AddFailure('Assinante.Ramo obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Uf) then
    Validations.AddFailure('Assinante.Uf obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Cidade) then
    Validations.AddFailure('Assinante.Cidade obrigatorio(a)');
  
  if ModelValueIsEmpty(Assinante.Bairro) then
    Validations.AddFailure('Assinante.Bairro obrigatorio(a)');
  
  if ModelListIsEmpty(Assinante.SoftwaresAtivos) then
    Validations.AddFailure('Assinante.SoftwaresAtivos obrigatorio(a)');
  
  if ModelListIsEmpty(Assinante.SoftwaresEmContratosDeManutencao) then
    Validations.AddFailure('Assinante.SoftwaresEmContratosDeManutencao obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.