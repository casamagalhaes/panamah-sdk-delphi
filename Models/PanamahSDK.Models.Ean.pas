{$M+}
unit PanamahSDK.Models.Ean;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahEan = interface(IPanamahModel)
    ['{775A2424-7368-11E9-BBA3-6970D342FA48}']
    function GetId: string;
    function GetProdutoId: string;
    function GetTributado: Boolean;
    procedure SetId(const AId: string);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetTributado(const ATributado: Boolean);
    property Id: string read GetId write SetId;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Tributado: Boolean read GetTributado write SetTributado;
  end;
  
  IPanamahEanList = interface(IPanamahModelList)
    ['{775A2425-7368-11E9-BBA3-6970D342FA48}']
    function GetItem(AIndex: Integer): IPanamahEan;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEan);
    procedure Add(const AItem: IPanamahEan);
    property Items[AIndex: Integer]: IPanamahEan read GetItem write SetItem; default;
  end;
  
  TPanamahEan = class(TInterfacedObject, IPanamahEan)
  private
    FId: string;
    FProdutoId: string;
    FTributado: Boolean;
    function GetId: string;
    function GetProdutoId: string;
    function GetTributado: Boolean;
    procedure SetId(const AId: string);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetTributado(const ATributado: Boolean);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahEan;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Tributado: Boolean read GetTributado write SetTributado;
  end;

  TPanamahEanList = class(TInterfacedObject, IPanamahEanList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahEan;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEan);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEanList;
    constructor Create;
    procedure Add(const AItem: IPanamahEan);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahEan read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahEanValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahEan }

function TPanamahEan.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahEan.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahEan.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahEan.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahEan.GetTributado: Boolean;
begin
  Result := FTributado;
end;

procedure TPanamahEan.SetTributado(const ATributado: Boolean);
begin
  FTributado := ATributado;
end;

procedure TPanamahEan.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FTributado := GetFieldValueAsBoolean(JSONObject, 'tributado');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahEan.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'tributado', FTributado);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahEan.FromJSON(const AJSON: string): IPanamahEan;
begin
  Result := TPanamahEan.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahEan.GetModelName: string;
begin
  Result := 'PanamahEan';
end;

function TPanamahEan.Clone: IPanamahModel;
begin
  Result := TPanamahEan.FromJSON(SerializeToJSON);
end;

function TPanamahEan.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahEanValidator.Create;
  Result := Validator.Validate(Self as IPanamahEan);
end;

{ TPanamahEanList }

constructor TPanamahEanList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahEanList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahEanList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [FList[I]]), (FList[I] as IPanamahModel).Validate);
end;

class function TPanamahEanList.FromJSON(const AJSON: string): IPanamahEanList;
begin
  Result := TPanamahEanList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahEanList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahEan;
end;

procedure TPanamahEanList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahEanList.Add(const AItem: IPanamahEan);
begin
  FList.Add(AItem);
end;

procedure TPanamahEanList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahEan;
begin
  Item := TPanamahEan.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahEanList.Clear;
begin
  FList.Clear;
end;

function TPanamahEanList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahEanList.GetItem(AIndex: Integer): IPanamahEan;
begin
  Result := FList.Items[AIndex] as IPanamahEan;
end;

procedure TPanamahEanList.SetItem(AIndex: Integer;
  const Value: IPanamahEan);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahEanList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahEanList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahEan).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahEanValidator }

function TPanamahEanValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Ean: IPanamahEan;
  Validations: IPanamahValidationResultList;
begin
  Ean := AModel as IPanamahEan;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Ean.Id) then
    Validations.AddFailure('Ean.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Ean.ProdutoId) then
    Validations.AddFailure('Ean.ProdutoId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.