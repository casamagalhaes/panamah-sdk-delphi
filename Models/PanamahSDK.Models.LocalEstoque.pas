{$M+}
unit PanamahSDK.Models.LocalEstoque;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahLocalEstoque = interface(IPanamahModel)
    ['{8E7D54A3-75CB-11E9-8B82-D97403569AFA}']
    function GetId: string;
    function GetLojaId: string;
    function GetDescricao: string;
    function GetDisponivelParaVenda: Boolean;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetDisponivelParaVenda(const ADisponivelParaVenda: Boolean);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property Descricao: string read GetDescricao write SetDescricao;
    property DisponivelParaVenda: Boolean read GetDisponivelParaVenda write SetDisponivelParaVenda;
  end;
  
  IPanamahLocalEstoqueList = interface(IPanamahModelList)
    ['{8E7D54A4-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahLocalEstoque;
    procedure SetItem(AIndex: Integer; const Value: IPanamahLocalEstoque);
    procedure Add(const AItem: IPanamahLocalEstoque);
    property Items[AIndex: Integer]: IPanamahLocalEstoque read GetItem write SetItem; default;
  end;
  
  TPanamahLocalEstoque = class(TInterfacedObject, IPanamahLocalEstoque)
  private
    FId: string;
    FLojaId: string;
    FDescricao: string;
    FDisponivelParaVenda: Boolean;
    function GetId: string;
    function GetLojaId: string;
    function GetDescricao: string;
    function GetDisponivelParaVenda: Boolean;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetDescricao(const ADescricao: string);
    procedure SetDisponivelParaVenda(const ADisponivelParaVenda: Boolean);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahLocalEstoque;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property Descricao: string read GetDescricao write SetDescricao;
    property DisponivelParaVenda: Boolean read GetDisponivelParaVenda write SetDisponivelParaVenda;
  end;

  TPanamahLocalEstoqueList = class(TInterfacedObject, IPanamahLocalEstoqueList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahLocalEstoque;
    procedure SetItem(AIndex: Integer; const Value: IPanamahLocalEstoque);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahLocalEstoqueList;
    constructor Create;
    procedure Add(const AItem: IPanamahLocalEstoque);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahLocalEstoque read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahLocalEstoqueValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahLocalEstoque }

function TPanamahLocalEstoque.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahLocalEstoque.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahLocalEstoque.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahLocalEstoque.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahLocalEstoque.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahLocalEstoque.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

function TPanamahLocalEstoque.GetDisponivelParaVenda: Boolean;
begin
  Result := FDisponivelParaVenda;
end;

procedure TPanamahLocalEstoque.SetDisponivelParaVenda(const ADisponivelParaVenda: Boolean);
begin
  FDisponivelParaVenda := ADisponivelParaVenda;
end;

procedure TPanamahLocalEstoque.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FDisponivelParaVenda := GetFieldValueAsBoolean(JSONObject, 'disponivelParaVenda');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahLocalEstoque.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);    
    SetFieldValue(JSONObject, 'disponivelParaVenda', FDisponivelParaVenda);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahLocalEstoque.FromJSON(const AJSON: string): IPanamahLocalEstoque;
begin
  Result := TPanamahLocalEstoque.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahLocalEstoque.GetModelName: string;
begin
  Result := 'LOCAL_ESTOQUE';
end;

function TPanamahLocalEstoque.Clone: IPanamahModel;
begin
  Result := TPanamahLocalEstoque.FromJSON(SerializeToJSON);
end;

function TPanamahLocalEstoque.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahLocalEstoqueValidator.Create;
  Result := Validator.Validate(Self as IPanamahLocalEstoque);
end;

{ TPanamahLocalEstoqueList }

constructor TPanamahLocalEstoqueList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahLocalEstoqueList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahLocalEstoqueList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahLocalEstoque).Validate);
end;

class function TPanamahLocalEstoqueList.FromJSON(const AJSON: string): IPanamahLocalEstoqueList;
begin
  Result := TPanamahLocalEstoqueList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahLocalEstoqueList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahLocalEstoque;
end;

procedure TPanamahLocalEstoqueList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahLocalEstoqueList.Add(const AItem: IPanamahLocalEstoque);
begin
  FList.Add(AItem);
end;

procedure TPanamahLocalEstoqueList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahLocalEstoque;
begin
  Item := TPanamahLocalEstoque.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahLocalEstoqueList.Clear;
begin
  FList.Clear;
end;

function TPanamahLocalEstoqueList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahLocalEstoqueList.GetItem(AIndex: Integer): IPanamahLocalEstoque;
begin
  Result := FList.Items[AIndex] as IPanamahLocalEstoque;
end;

procedure TPanamahLocalEstoqueList.SetItem(AIndex: Integer;
  const Value: IPanamahLocalEstoque);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahLocalEstoqueList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahLocalEstoqueList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahLocalEstoque).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahLocalEstoqueValidator }

function TPanamahLocalEstoqueValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  LocalEstoque: IPanamahLocalEstoque;
  Validations: IPanamahValidationResultList;
begin
  LocalEstoque := AModel as IPanamahLocalEstoque;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(LocalEstoque.Id) then
    Validations.AddFailure('LocalEstoque.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(LocalEstoque.LojaId) then
    Validations.AddFailure('LocalEstoque.LojaId obrigatorio(a)');
  
  if ModelValueIsEmpty(LocalEstoque.Descricao) then
    Validations.AddFailure('LocalEstoque.Descricao obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.