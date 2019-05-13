{$M+}
unit PanamahSDK.Models.Holding;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahHolding = interface(IPanamahModel)
    ['{8E7A9587-75CB-11E9-8B82-D97403569AFA}']
    function GetId: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;
  
  IPanamahHoldingList = interface(IPanamahModelList)
    ['{8E7A9588-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahHolding;
    procedure SetItem(AIndex: Integer; const Value: IPanamahHolding);
    procedure Add(const AItem: IPanamahHolding);
    property Items[AIndex: Integer]: IPanamahHolding read GetItem write SetItem; default;
  end;
  
  TPanamahHolding = class(TInterfacedObject, IPanamahHolding)
  private
    FId: string;
    FDescricao: string;
    function GetId: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahHolding;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

  TPanamahHoldingList = class(TInterfacedObject, IPanamahHoldingList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahHolding;
    procedure SetItem(AIndex: Integer; const Value: IPanamahHolding);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahHoldingList;
    constructor Create;
    procedure Add(const AItem: IPanamahHolding);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahHolding read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahHoldingValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahHolding }

function TPanamahHolding.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahHolding.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahHolding.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahHolding.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

procedure TPanamahHolding.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahHolding.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahHolding.FromJSON(const AJSON: string): IPanamahHolding;
begin
  Result := TPanamahHolding.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahHolding.GetModelName: string;
begin
  Result := 'HOLDING';
end;

function TPanamahHolding.Clone: IPanamahModel;
begin
  Result := TPanamahHolding.FromJSON(SerializeToJSON);
end;

function TPanamahHolding.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahHoldingValidator.Create;
  Result := Validator.Validate(Self as IPanamahHolding);
end;

{ TPanamahHoldingList }

constructor TPanamahHoldingList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahHoldingList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahHoldingList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahHolding).Validate);
end;

class function TPanamahHoldingList.FromJSON(const AJSON: string): IPanamahHoldingList;
begin
  Result := TPanamahHoldingList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahHoldingList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahHolding;
end;

procedure TPanamahHoldingList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahHoldingList.Add(const AItem: IPanamahHolding);
begin
  FList.Add(AItem);
end;

procedure TPanamahHoldingList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahHolding;
begin
  Item := TPanamahHolding.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahHoldingList.Clear;
begin
  FList.Clear;
end;

function TPanamahHoldingList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahHoldingList.GetItem(AIndex: Integer): IPanamahHolding;
begin
  Result := FList.Items[AIndex] as IPanamahHolding;
end;

procedure TPanamahHoldingList.SetItem(AIndex: Integer;
  const Value: IPanamahHolding);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahHoldingList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahHoldingList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahHolding).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahHoldingValidator }

function TPanamahHoldingValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Holding: IPanamahHolding;
  Validations: IPanamahValidationResultList;
begin
  Holding := AModel as IPanamahHolding;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Holding.Id) then
    Validations.AddFailure('Holding.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Holding.Descricao) then
    Validations.AddFailure('Holding.Descricao obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.