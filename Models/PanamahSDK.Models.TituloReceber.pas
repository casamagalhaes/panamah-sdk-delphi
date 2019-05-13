{$M+}
unit PanamahSDK.Models.TituloReceber;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahTituloReceberPagamento = interface(IPanamahModel)
    ['{8E7DF0E5-75CB-11E9-8B82-D97403569AFA}']
    function GetDataHora: TDateTime;
    function GetValor: Double;
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetValor(const AValor: Double);
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Valor: Double read GetValor write SetValor;
  end;
  
  IPanamahTituloReceberPagamentoList = interface(IPanamahModelList)
    ['{8E7DF0E6-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahTituloReceberPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloReceberPagamento);
    procedure Add(const AItem: IPanamahTituloReceberPagamento);
    property Items[AIndex: Integer]: IPanamahTituloReceberPagamento read GetItem write SetItem; default;
  end;
  
  IPanamahTituloReceber = interface(IPanamahModel)
    ['{8E7DC9D8-75CB-11E9-8B82-D97403569AFA}']
    function GetId: string;
    function GetLojaId: string;
    function GetClienteId: string;
    function GetDocumento: string;
    function GetValorNominal: Double;
    function GetValorJuros: Double;
    function GetValorMulta: Double;
    function GetValorDevido: Double;
    function GetValorPago: Double;
    function GetDataEmissao: TDateTime;
    function GetDataVencimento: TDateTime;
    function GetPagamentos: IpanamahTituloReceberPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetClienteId(const AClienteId: string);
    procedure SetDocumento(const ADocumento: string);
    procedure SetValorNominal(const AValorNominal: Double);
    procedure SetValorJuros(const AValorJuros: Double);
    procedure SetValorMulta(const AValorMulta: Double);
    procedure SetValorDevido(const AValorDevido: Double);
    procedure SetValorPago(const AValorPago: Double);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataVencimento(const ADataVencimento: TDateTime);
    procedure SetPagamentos(const APagamentos: IpanamahTituloReceberPagamentoList);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property ClienteId: string read GetClienteId write SetClienteId;
    property Documento: string read GetDocumento write SetDocumento;
    property ValorNominal: Double read GetValorNominal write SetValorNominal;
    property ValorJuros: Double read GetValorJuros write SetValorJuros;
    property ValorMulta: Double read GetValorMulta write SetValorMulta;
    property ValorDevido: Double read GetValorDevido write SetValorDevido;
    property ValorPago: Double read GetValorPago write SetValorPago;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataVencimento: TDateTime read GetDataVencimento write SetDataVencimento;
    property Pagamentos: IpanamahTituloReceberPagamentoList read GetPagamentos write SetPagamentos;
  end;
  
  IPanamahTituloReceberList = interface(IPanamahModelList)
    ['{8E7DC9D9-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahTituloReceber;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloReceber);
    procedure Add(const AItem: IPanamahTituloReceber);
    property Items[AIndex: Integer]: IPanamahTituloReceber read GetItem write SetItem; default;
  end;
  
  TPanamahTituloReceberPagamento = class(TInterfacedObject, IPanamahTituloReceberPagamento)
  private
    FDataHora: TDateTime;
    FValor: Double;
    function GetDataHora: TDateTime;
    function GetValor: Double;
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetValor(const AValor: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahTituloReceberPagamento;
    function Validate: IPanamahValidationResult;
  published
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Valor: Double read GetValor write SetValor;
  end;

  TPanamahTituloReceberPagamentoList = class(TInterfacedObject, IPanamahTituloReceberPagamentoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTituloReceberPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloReceberPagamento);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloReceberPagamentoList;
    constructor Create;
    procedure Add(const AItem: IPanamahTituloReceberPagamento);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTituloReceberPagamento read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  TPanamahTituloReceber = class(TInterfacedObject, IPanamahTituloReceber)
  private
    FId: string;
    FLojaId: string;
    FClienteId: string;
    FDocumento: string;
    FValorNominal: Double;
    FValorJuros: Double;
    FValorMulta: Double;
    FValorDevido: Double;
    FValorPago: Double;
    FDataEmissao: TDateTime;
    FDataVencimento: TDateTime;
    FPagamentos: IpanamahTituloReceberPagamentoList;
    function GetId: string;
    function GetLojaId: string;
    function GetClienteId: string;
    function GetDocumento: string;
    function GetValorNominal: Double;
    function GetValorJuros: Double;
    function GetValorMulta: Double;
    function GetValorDevido: Double;
    function GetValorPago: Double;
    function GetDataEmissao: TDateTime;
    function GetDataVencimento: TDateTime;
    function GetPagamentos: IpanamahTituloReceberPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetClienteId(const AClienteId: string);
    procedure SetDocumento(const ADocumento: string);
    procedure SetValorNominal(const AValorNominal: Double);
    procedure SetValorJuros(const AValorJuros: Double);
    procedure SetValorMulta(const AValorMulta: Double);
    procedure SetValorDevido(const AValorDevido: Double);
    procedure SetValorPago(const AValorPago: Double);
    procedure SetDataEmissao(const ADataEmissao: TDateTime);
    procedure SetDataVencimento(const ADataVencimento: TDateTime);
    procedure SetPagamentos(const APagamentos: IpanamahTituloReceberPagamentoList);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahTituloReceber;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property ClienteId: string read GetClienteId write SetClienteId;
    property Documento: string read GetDocumento write SetDocumento;
    property ValorNominal: Double read GetValorNominal write SetValorNominal;
    property ValorJuros: Double read GetValorJuros write SetValorJuros;
    property ValorMulta: Double read GetValorMulta write SetValorMulta;
    property ValorDevido: Double read GetValorDevido write SetValorDevido;
    property ValorPago: Double read GetValorPago write SetValorPago;
    property DataEmissao: TDateTime read GetDataEmissao write SetDataEmissao;
    property DataVencimento: TDateTime read GetDataVencimento write SetDataVencimento;
    property Pagamentos: IpanamahTituloReceberPagamentoList read GetPagamentos write SetPagamentos;
  end;

  TPanamahTituloReceberList = class(TInterfacedObject, IPanamahTituloReceberList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTituloReceber;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTituloReceber);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTituloReceberList;
    constructor Create;
    procedure Add(const AItem: IPanamahTituloReceber);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTituloReceber read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahTituloReceberPagamentoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
  TPanamahTituloReceberValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahTituloReceberPagamento }

function TPanamahTituloReceberPagamento.GetDataHora: TDateTime;
begin
  Result := FDataHora;
end;

procedure TPanamahTituloReceberPagamento.SetDataHora(const ADataHora: TDateTime);
begin
  FDataHora := ADataHora;
end;

function TPanamahTituloReceberPagamento.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahTituloReceberPagamento.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

procedure TPanamahTituloReceberPagamento.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FDataHora := GetFieldValueAsDatetime(JSONObject, 'dataHora');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTituloReceberPagamento.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'dataHora', FDataHora);    
    SetFieldValue(JSONObject, 'valor', FValor);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTituloReceberPagamento.FromJSON(const AJSON: string): IPanamahTituloReceberPagamento;
begin
  Result := TPanamahTituloReceberPagamento.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTituloReceberPagamento.GetModelName: string;
begin
  Result := 'TITULO_RECEBER_PAGAMENTOS';
end;

function TPanamahTituloReceberPagamento.Clone: IPanamahModel;
begin
  Result := TPanamahTituloReceberPagamento.FromJSON(SerializeToJSON);
end;

function TPanamahTituloReceberPagamento.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahTituloReceberPagamentoValidator.Create;
  Result := Validator.Validate(Self as IPanamahTituloReceberPagamento);
end;

{ TPanamahTituloReceberPagamentoList }

constructor TPanamahTituloReceberPagamentoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTituloReceberPagamentoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahTituloReceberPagamentoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahTituloReceberPagamento).Validate);
end;

class function TPanamahTituloReceberPagamentoList.FromJSON(const AJSON: string): IPanamahTituloReceberPagamentoList;
begin
  Result := TPanamahTituloReceberPagamentoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTituloReceberPagamentoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahTituloReceberPagamento;
end;

procedure TPanamahTituloReceberPagamentoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloReceberPagamentoList.Add(const AItem: IPanamahTituloReceberPagamento);
begin
  FList.Add(AItem);
end;

procedure TPanamahTituloReceberPagamentoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTituloReceberPagamento;
begin
  Item := TPanamahTituloReceberPagamento.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTituloReceberPagamentoList.Clear;
begin
  FList.Clear;
end;

function TPanamahTituloReceberPagamentoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTituloReceberPagamentoList.GetItem(AIndex: Integer): IPanamahTituloReceberPagamento;
begin
  Result := FList.Items[AIndex] as IPanamahTituloReceberPagamento;
end;

procedure TPanamahTituloReceberPagamentoList.SetItem(AIndex: Integer;
  const Value: IPanamahTituloReceberPagamento);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloReceberPagamentoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTituloReceberPagamentoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTituloReceberPagamento).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahTituloReceberPagamentoValidator }

function TPanamahTituloReceberPagamentoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Pagamentos: IPanamahTituloReceberPagamento;
  Validations: IPanamahValidationResultList;
begin
  Pagamentos := AModel as IPanamahTituloReceberPagamento;
  Validations := TPanamahValidationResultList.Create;
  
  Result := Validations.GetAggregate;
end;

{ TPanamahTituloReceber }

function TPanamahTituloReceber.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahTituloReceber.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahTituloReceber.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahTituloReceber.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahTituloReceber.GetClienteId: string;
begin
  Result := FClienteId;
end;

procedure TPanamahTituloReceber.SetClienteId(const AClienteId: string);
begin
  FClienteId := AClienteId;
end;

function TPanamahTituloReceber.GetDocumento: string;
begin
  Result := FDocumento;
end;

procedure TPanamahTituloReceber.SetDocumento(const ADocumento: string);
begin
  FDocumento := ADocumento;
end;

function TPanamahTituloReceber.GetValorNominal: Double;
begin
  Result := FValorNominal;
end;

procedure TPanamahTituloReceber.SetValorNominal(const AValorNominal: Double);
begin
  FValorNominal := AValorNominal;
end;

function TPanamahTituloReceber.GetValorJuros: Double;
begin
  Result := FValorJuros;
end;

procedure TPanamahTituloReceber.SetValorJuros(const AValorJuros: Double);
begin
  FValorJuros := AValorJuros;
end;

function TPanamahTituloReceber.GetValorMulta: Double;
begin
  Result := FValorMulta;
end;

procedure TPanamahTituloReceber.SetValorMulta(const AValorMulta: Double);
begin
  FValorMulta := AValorMulta;
end;

function TPanamahTituloReceber.GetValorDevido: Double;
begin
  Result := FValorDevido;
end;

procedure TPanamahTituloReceber.SetValorDevido(const AValorDevido: Double);
begin
  FValorDevido := AValorDevido;
end;

function TPanamahTituloReceber.GetValorPago: Double;
begin
  Result := FValorPago;
end;

procedure TPanamahTituloReceber.SetValorPago(const AValorPago: Double);
begin
  FValorPago := AValorPago;
end;

function TPanamahTituloReceber.GetDataEmissao: TDateTime;
begin
  Result := FDataEmissao;
end;

procedure TPanamahTituloReceber.SetDataEmissao(const ADataEmissao: TDateTime);
begin
  FDataEmissao := ADataEmissao;
end;

function TPanamahTituloReceber.GetDataVencimento: TDateTime;
begin
  Result := FDataVencimento;
end;

procedure TPanamahTituloReceber.SetDataVencimento(const ADataVencimento: TDateTime);
begin
  FDataVencimento := ADataVencimento;
end;

function TPanamahTituloReceber.GetPagamentos: IpanamahTituloReceberPagamentoList;
begin
  Result := FPagamentos;
end;

procedure TPanamahTituloReceber.SetPagamentos(const APagamentos: IpanamahTituloReceberPagamentoList);
begin
  FPagamentos := APagamentos;
end;

procedure TPanamahTituloReceber.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FClienteId := GetFieldValueAsString(JSONObject, 'clienteId');
    FDocumento := GetFieldValueAsString(JSONObject, 'documento');
    FValorNominal := GetFieldValueAsDouble(JSONObject, 'valorNominal');
    FValorJuros := GetFieldValueAsDouble(JSONObject, 'valorJuros');
    FValorMulta := GetFieldValueAsDouble(JSONObject, 'valorMulta');
    FValorDevido := GetFieldValueAsDouble(JSONObject, 'valorDevido');
    FValorPago := GetFieldValueAsDouble(JSONObject, 'valorPago');
    FDataEmissao := GetFieldValueAsDatetime(JSONObject, 'dataEmissao');
    FDataVencimento := GetFieldValueAsDatetime(JSONObject, 'dataVencimento');
    if JSONObject.Field['pagamentos'] is TlkJSONlist then
      FPagamentos := TpanamahTituloReceberPagamentoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['pagamentos']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTituloReceber.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'clienteId', FClienteId);    
    SetFieldValue(JSONObject, 'documento', FDocumento);    
    SetFieldValue(JSONObject, 'valorNominal', FValorNominal);    
    SetFieldValue(JSONObject, 'valorJuros', FValorJuros);    
    SetFieldValue(JSONObject, 'valorMulta', FValorMulta);    
    SetFieldValue(JSONObject, 'valorDevido', FValorDevido);    
    SetFieldValue(JSONObject, 'valorPago', FValorPago);    
    SetFieldValue(JSONObject, 'dataEmissao', FDataEmissao);    
    SetFieldValue(JSONObject, 'dataVencimento', FDataVencimento);    
    SetFieldValue(JSONObject, 'pagamentos', FPagamentos);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTituloReceber.FromJSON(const AJSON: string): IPanamahTituloReceber;
begin
  Result := TPanamahTituloReceber.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTituloReceber.GetModelName: string;
begin
  Result := 'TITULO_RECEBER';
end;

function TPanamahTituloReceber.Clone: IPanamahModel;
begin
  Result := TPanamahTituloReceber.FromJSON(SerializeToJSON);
end;

function TPanamahTituloReceber.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahTituloReceberValidator.Create;
  Result := Validator.Validate(Self as IPanamahTituloReceber);
end;

{ TPanamahTituloReceberList }

constructor TPanamahTituloReceberList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTituloReceberList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahTituloReceberList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahTituloReceber).Validate);
end;

class function TPanamahTituloReceberList.FromJSON(const AJSON: string): IPanamahTituloReceberList;
begin
  Result := TPanamahTituloReceberList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTituloReceberList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahTituloReceber;
end;

procedure TPanamahTituloReceberList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloReceberList.Add(const AItem: IPanamahTituloReceber);
begin
  FList.Add(AItem);
end;

procedure TPanamahTituloReceberList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTituloReceber;
begin
  Item := TPanamahTituloReceber.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTituloReceberList.Clear;
begin
  FList.Clear;
end;

function TPanamahTituloReceberList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTituloReceberList.GetItem(AIndex: Integer): IPanamahTituloReceber;
begin
  Result := FList.Items[AIndex] as IPanamahTituloReceber;
end;

procedure TPanamahTituloReceberList.SetItem(AIndex: Integer;
  const Value: IPanamahTituloReceber);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTituloReceberList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTituloReceberList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTituloReceber).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahTituloReceberValidator }

function TPanamahTituloReceberValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  TituloReceber: IPanamahTituloReceber;
  Validations: IPanamahValidationResultList;
begin
  TituloReceber := AModel as IPanamahTituloReceber;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(TituloReceber.Id) then
    Validations.AddFailure('TituloReceber.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(TituloReceber.LojaId) then
    Validations.AddFailure('TituloReceber.LojaId obrigatorio(a)');
  
  if ModelValueIsEmpty(TituloReceber.ClienteId) then
    Validations.AddFailure('TituloReceber.ClienteId obrigatorio(a)');
  
  if ModelValueIsEmpty(TituloReceber.Documento) then
    Validations.AddFailure('TituloReceber.Documento obrigatorio(a)');
  
  if ModelListIsEmpty(TituloReceber.Pagamentos) then
    Validations.AddFailure('TituloReceber.Pagamentos obrigatorio(a)')
  else
    Validations.Add(TituloReceber.Pagamentos.Validate);
  
  Result := Validations.GetAggregate;
end;

end.