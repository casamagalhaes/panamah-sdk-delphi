{$M+}
unit PanamahSDK.Models.TrocaFormaPagamento;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahTrocaFormaPagamento = interface(IPanamahModel)
    ['{081C6A15-7736-11E9-A131-EBAF8D88186A}']
    function GetAutorizadorId: variant;
    function GetData: TDateTime;
    function GetFormaPagamentoDestinoId: string;
    function GetFormaPagamentoOrigemId: string;
    function GetId: string;
    function GetLojaId: string;
    function GetVendaId: variant;
    function GetOperadorId: variant;
    function GetSequencialPagamento: string;
    function GetValor: Double;
    function GetValorContraValeOuTroco: Double;
    procedure SetAutorizadorId(const AAutorizadorId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetFormaPagamentoDestinoId(const AFormaPagamentoDestinoId: string);
    procedure SetFormaPagamentoOrigemId(const AFormaPagamentoOrigemId: string);
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetVendaId(const AVendaId: variant);
    procedure SetOperadorId(const AOperadorId: variant);
    procedure SetSequencialPagamento(const ASequencialPagamento: string);
    procedure SetValor(const AValor: Double);
    procedure SetValorContraValeOuTroco(const AValorContraValeOuTroco: Double);
    property AutorizadorId: variant read GetAutorizadorId write SetAutorizadorId;
    property Data: TDateTime read GetData write SetData;
    property FormaPagamentoDestinoId: string read GetFormaPagamentoDestinoId write SetFormaPagamentoDestinoId;
    property FormaPagamentoOrigemId: string read GetFormaPagamentoOrigemId write SetFormaPagamentoOrigemId;
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property VendaId: variant read GetVendaId write SetVendaId;
    property OperadorId: variant read GetOperadorId write SetOperadorId;
    property SequencialPagamento: string read GetSequencialPagamento write SetSequencialPagamento;
    property Valor: Double read GetValor write SetValor;
    property ValorContraValeOuTroco: Double read GetValorContraValeOuTroco write SetValorContraValeOuTroco;
  end;
  
  IPanamahTrocaFormaPagamentoList = interface(IPanamahModelList)
    ['{081C6A16-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahTrocaFormaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaFormaPagamento);
    procedure Add(const AItem: IPanamahTrocaFormaPagamento);
    property Items[AIndex: Integer]: IPanamahTrocaFormaPagamento read GetItem write SetItem; default;
  end;
  
  TPanamahTrocaFormaPagamento = class(TInterfacedObject, IPanamahTrocaFormaPagamento)
  private
    FAutorizadorId: variant;
    FData: TDateTime;
    FFormaPagamentoDestinoId: string;
    FFormaPagamentoOrigemId: string;
    FId: string;
    FLojaId: string;
    FVendaId: variant;
    FOperadorId: variant;
    FSequencialPagamento: string;
    FValor: Double;
    FValorContraValeOuTroco: Double;
    function GetAutorizadorId: variant;
    function GetData: TDateTime;
    function GetFormaPagamentoDestinoId: string;
    function GetFormaPagamentoOrigemId: string;
    function GetId: string;
    function GetLojaId: string;
    function GetVendaId: variant;
    function GetOperadorId: variant;
    function GetSequencialPagamento: string;
    function GetValor: Double;
    function GetValorContraValeOuTroco: Double;
    procedure SetAutorizadorId(const AAutorizadorId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetFormaPagamentoDestinoId(const AFormaPagamentoDestinoId: string);
    procedure SetFormaPagamentoOrigemId(const AFormaPagamentoOrigemId: string);
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetVendaId(const AVendaId: variant);
    procedure SetOperadorId(const AOperadorId: variant);
    procedure SetSequencialPagamento(const ASequencialPagamento: string);
    procedure SetValor(const AValor: Double);
    procedure SetValorContraValeOuTroco(const AValorContraValeOuTroco: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahTrocaFormaPagamento;
    function Validate: IPanamahValidationResult;
  published
    property AutorizadorId: variant read GetAutorizadorId write SetAutorizadorId;
    property Data: TDateTime read GetData write SetData;
    property FormaPagamentoDestinoId: string read GetFormaPagamentoDestinoId write SetFormaPagamentoDestinoId;
    property FormaPagamentoOrigemId: string read GetFormaPagamentoOrigemId write SetFormaPagamentoOrigemId;
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property VendaId: variant read GetVendaId write SetVendaId;
    property OperadorId: variant read GetOperadorId write SetOperadorId;
    property SequencialPagamento: string read GetSequencialPagamento write SetSequencialPagamento;
    property Valor: Double read GetValor write SetValor;
    property ValorContraValeOuTroco: Double read GetValorContraValeOuTroco write SetValorContraValeOuTroco;
  end;

  TPanamahTrocaFormaPagamentoList = class(TInterfacedObject, IPanamahTrocaFormaPagamentoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahTrocaFormaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahTrocaFormaPagamento);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahTrocaFormaPagamentoList;
    constructor Create;
    procedure Add(const AItem: IPanamahTrocaFormaPagamento);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahTrocaFormaPagamento read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahTrocaFormaPagamentoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahTrocaFormaPagamento }

function TPanamahTrocaFormaPagamento.GetAutorizadorId: variant;
begin
  Result := FAutorizadorId;
end;

procedure TPanamahTrocaFormaPagamento.SetAutorizadorId(const AAutorizadorId: variant);
begin
  FAutorizadorId := AAutorizadorId;
end;

function TPanamahTrocaFormaPagamento.GetData: TDateTime;
begin
  Result := FData;
end;

procedure TPanamahTrocaFormaPagamento.SetData(const AData: TDateTime);
begin
  FData := AData;
end;

function TPanamahTrocaFormaPagamento.GetFormaPagamentoDestinoId: string;
begin
  Result := FFormaPagamentoDestinoId;
end;

procedure TPanamahTrocaFormaPagamento.SetFormaPagamentoDestinoId(const AFormaPagamentoDestinoId: string);
begin
  FFormaPagamentoDestinoId := AFormaPagamentoDestinoId;
end;

function TPanamahTrocaFormaPagamento.GetFormaPagamentoOrigemId: string;
begin
  Result := FFormaPagamentoOrigemId;
end;

procedure TPanamahTrocaFormaPagamento.SetFormaPagamentoOrigemId(const AFormaPagamentoOrigemId: string);
begin
  FFormaPagamentoOrigemId := AFormaPagamentoOrigemId;
end;

function TPanamahTrocaFormaPagamento.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahTrocaFormaPagamento.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahTrocaFormaPagamento.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahTrocaFormaPagamento.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahTrocaFormaPagamento.GetVendaId: variant;
begin
  Result := FVendaId;
end;

procedure TPanamahTrocaFormaPagamento.SetVendaId(const AVendaId: variant);
begin
  FVendaId := AVendaId;
end;

function TPanamahTrocaFormaPagamento.GetOperadorId: variant;
begin
  Result := FOperadorId;
end;

procedure TPanamahTrocaFormaPagamento.SetOperadorId(const AOperadorId: variant);
begin
  FOperadorId := AOperadorId;
end;

function TPanamahTrocaFormaPagamento.GetSequencialPagamento: string;
begin
  Result := FSequencialPagamento;
end;

procedure TPanamahTrocaFormaPagamento.SetSequencialPagamento(const ASequencialPagamento: string);
begin
  FSequencialPagamento := ASequencialPagamento;
end;

function TPanamahTrocaFormaPagamento.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahTrocaFormaPagamento.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

function TPanamahTrocaFormaPagamento.GetValorContraValeOuTroco: Double;
begin
  Result := FValorContraValeOuTroco;
end;

procedure TPanamahTrocaFormaPagamento.SetValorContraValeOuTroco(const AValorContraValeOuTroco: Double);
begin
  FValorContraValeOuTroco := AValorContraValeOuTroco;
end;

procedure TPanamahTrocaFormaPagamento.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAutorizadorId := GetFieldValue(JSONObject, 'autorizadorId');
    FData := GetFieldValueAsDatetime(JSONObject, 'data');
    FFormaPagamentoDestinoId := GetFieldValueAsString(JSONObject, 'formaPagamentoDestinoId');
    FFormaPagamentoOrigemId := GetFieldValueAsString(JSONObject, 'formaPagamentoOrigemId');
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FVendaId := GetFieldValue(JSONObject, 'vendaId');
    FOperadorId := GetFieldValue(JSONObject, 'operadorId');
    FSequencialPagamento := GetFieldValueAsString(JSONObject, 'sequencialPagamento');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
    FValorContraValeOuTroco := GetFieldValueAsDouble(JSONObject, 'valorContraValeOuTroco');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahTrocaFormaPagamento.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'autorizadorId', FAutorizadorId);    
    SetFieldValue(JSONObject, 'data', FData);    
    SetFieldValue(JSONObject, 'formaPagamentoDestinoId', FFormaPagamentoDestinoId);    
    SetFieldValue(JSONObject, 'formaPagamentoOrigemId', FFormaPagamentoOrigemId);    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'vendaId', FVendaId);    
    SetFieldValue(JSONObject, 'operadorId', FOperadorId);    
    SetFieldValue(JSONObject, 'sequencialPagamento', FSequencialPagamento);    
    SetFieldValue(JSONObject, 'valor', FValor);    
    SetFieldValue(JSONObject, 'valorContraValeOuTroco', FValorContraValeOuTroco);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahTrocaFormaPagamento.FromJSON(const AJSON: string): IPanamahTrocaFormaPagamento;
begin
  Result := TPanamahTrocaFormaPagamento.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaFormaPagamento.GetModelName: string;
begin
  Result := 'TROCA_FORMA_PAGAMENTO';
end;

function TPanamahTrocaFormaPagamento.Clone: IPanamahModel;
begin
  Result := TPanamahTrocaFormaPagamento.FromJSON(SerializeToJSON);
end;

function TPanamahTrocaFormaPagamento.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahTrocaFormaPagamentoValidator.Create;
  Result := Validator.Validate(Self as IPanamahTrocaFormaPagamento);
end;

{ TPanamahTrocaFormaPagamentoList }

constructor TPanamahTrocaFormaPagamentoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahTrocaFormaPagamentoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahTrocaFormaPagamentoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahTrocaFormaPagamento).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahTrocaFormaPagamentoList.FromJSON(const AJSON: string): IPanamahTrocaFormaPagamentoList;
begin
  Result := TPanamahTrocaFormaPagamentoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahTrocaFormaPagamentoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahTrocaFormaPagamento;
end;

procedure TPanamahTrocaFormaPagamentoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaFormaPagamentoList.Add(const AItem: IPanamahTrocaFormaPagamento);
begin
  FList.Add(AItem);
end;

procedure TPanamahTrocaFormaPagamentoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahTrocaFormaPagamento;
begin
  Item := TPanamahTrocaFormaPagamento.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahTrocaFormaPagamentoList.Clear;
begin
  FList.Clear;
end;

function TPanamahTrocaFormaPagamentoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahTrocaFormaPagamentoList.GetItem(AIndex: Integer): IPanamahTrocaFormaPagamento;
begin
  Result := FList.Items[AIndex] as IPanamahTrocaFormaPagamento;
end;

procedure TPanamahTrocaFormaPagamentoList.SetItem(AIndex: Integer;
  const Value: IPanamahTrocaFormaPagamento);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahTrocaFormaPagamentoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahTrocaFormaPagamentoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahTrocaFormaPagamento).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahTrocaFormaPagamentoValidator }

function TPanamahTrocaFormaPagamentoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  TrocaFormaPagamento: IPanamahTrocaFormaPagamento;
  Validations: IPanamahValidationResultList;
begin
  TrocaFormaPagamento := AModel as IPanamahTrocaFormaPagamento;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(TrocaFormaPagamento.FormaPagamentoDestinoId) then
    Validations.AddFailure('TrocaFormaPagamento.FormaPagamentoDestinoId obrigatorio(a)');
  
  if ModelValueIsEmpty(TrocaFormaPagamento.FormaPagamentoOrigemId) then
    Validations.AddFailure('TrocaFormaPagamento.FormaPagamentoOrigemId obrigatorio(a)');
  
  if ModelValueIsEmpty(TrocaFormaPagamento.Id) then
    Validations.AddFailure('TrocaFormaPagamento.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(TrocaFormaPagamento.LojaId) then
    Validations.AddFailure('TrocaFormaPagamento.LojaId obrigatorio(a)');
  
  if ModelValueIsEmpty(TrocaFormaPagamento.SequencialPagamento) then
    Validations.AddFailure('TrocaFormaPagamento.SequencialPagamento obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.