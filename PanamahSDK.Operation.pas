{$M+}
unit PanamahSDK.Operation;

interface

uses
  Classes, SysUtils, uLkJSON, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants;

type

  IPanamahOperation = interface(IJSONSerializable)
    ['{2686F170-9BB1-4F78-8EA5-D10E7EE5F15A}']
    function GetOperationType: TPanamahOperationType;
    function GetData: IPanamahModel;
    function GetDataType: string;
    function GetId: Variant;
    function GetDataId: Variant;
    function GetHash: string;
    function GetAssinanteId: Variant;
    function Clone: IPanamahOperation;
    function Equals(AAnotherOperation: IPanamahOperation): Boolean;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(const ADataType: string);
    procedure SetId(Id: Variant);
    procedure SetAssinanteId(AAssinanteId: Variant);
    property DataType: string read GetDataType write SetDataType;
    property OperationType: TPanamahOperationType read GetOperationType write SetOperationType;
    property Data: IPanamahModel read GetData write SetData;
    property Id: Variant read GetId write SetId;
    property AssinanteId: Variant read GetAssinanteId write SetAssinanteId;
  end;

  IPanamahOperationList = interface(IJSONSerializable)
    ['{66CD67F1-487E-429B-B957-5782F20A5C81}']
    function GetItem(AIndex: Integer): IPanamahOperation;
    procedure SetItem(AIndex: Integer; const Value: IPanamahOperation);
    procedure Add(const AItem: IPanamahOperation);
    procedure Clear;
    function Count: Integer;
    function Exists(AItem: IPanamahOperation): Boolean;
    function IndexOf(AItem: IPanamahOperation): Integer;
    procedure Remove(AItem: IPanamahOperation);
    property Items[AIndex: Integer]: IPanamahOperation read GetItem write SetItem; default;
  end;

  TPanamahDataIdOperation = class(TInterfacedObject, IJSONSerializable)
  private
    FId: string;
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    property Id: string read FId write FId;
    constructor Create(const AId: string); reintroduce;
  end;

  TPanamahOperation = class(TInterfacedObject, IPanamahOperation)
  private
    FOperationType: TPanamahOperationType;
    FData: IPanamahModel;
    FDataType: string;
    FId: Variant;
    FAssinanteId: Variant;
    function GetOperationType: TPanamahOperationType;
    function GetData: IPanamahModel;
    function GetDataType: string;
    function GetId: Variant;
    function GetAssinanteId: Variant;
    procedure SetOperationType(AOperationType: TPanamahOperationType);
    procedure SetData(AData: IPanamahModel);
    procedure SetDataType(const ADataType: string);
    procedure SetId(AId: Variant);
    procedure SetAssinanteId(AAssinanteId: Variant);
  public
    function GetHash: string;
    function GetDataId: Variant;
    function SerializeToJSON: string;
    function Clone: IPanamahOperation;
    function Equals(AAnotherOperation: IPanamahOperation): Boolean; reintroduce;
    procedure DeserializeFromJSON(const AJSON: string);
    constructor Create(AOperationType: TPanamahOperationType; AModel: IPanamahModel; AAssinanteId: Variant); reintroduce; overload;
    constructor Create; reintroduce; overload;
    class function FromJSON(const AJSON: string): IPanamahOperation;
    class function SameId(A, B: IPanamahOperation): Boolean;
    class function SameOperationType(A, B: IPanamahOperation): Boolean;
    class function SameAssinanteId(A, B: IPanamahOperation): Boolean;
    class function SameDataType(A, B: IPanamahOperation): Boolean;
  published
    property OperationType: TPanamahOperationType read GetOperationType write SetOperationType;
    property Data: IPanamahModel read GetData write SetData;
    property DataType: string read GetDataType write SetDataType;
    property Id: Variant read GetId write SetId;
    property AssinanteId: Variant read GetAssinanteId write SetAssinanteId;
  end;

  TPanamahOperationList = class(TInterfacedObject, IPanamahOperationList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahOperation;
    procedure SetItem(AIndex: Integer; const Value: IPanamahOperation);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function IndexOf(AItem: IPanamahOperation; AThreadLocked: Boolean): Integer; overload;
    function IndexOf(AItem: IPanamahOperation): Integer; overload;
    function Exists(AItem: IPanamahOperation): Boolean;
    procedure Remove(AItem: IPanamahOperation);
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahOperationList;
    constructor Create;
    procedure Add(const AItem: IPanamahOperation);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahOperation read GetItem write SetItem; default;
  end;

  function GetDataTypeByModel(AModel: IPanamahModel): string;

implementation

uses
  PanamahSDK.Crypto, PanamahSDK.ModelUtils, PanamahSDK.ValidationUtils;

{ TPanamahOperation }

constructor TPanamahOperation.Create(AOperationType: TPanamahOperationType; AModel: IPanamahModel; AAssinanteId: Variant);
begin
  inherited Create;
  FOperationType := AOperationType;
  FData := AModel;
  FDataType := GetDataTypeByModel(FData);
  FAssinanteId := AAssinanteId;
end;

function TPanamahOperation.Clone: IPanamahOperation;
begin
  Result := TPanamahOperation.FromJSON(SerializeToJSON);
end;

constructor TPanamahOperation.Create;
begin
  inherited Create;
end;

procedure TPanamahOperation.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAssinanteId := GetFieldValueAsString(JSONObject, 'assinanteId');
    if SameText(GetFieldValueAsString(JSONObject, 'op'), 'update') then
      FOperationType := otUPDATE
    else
    if SameText(GetFieldValueAsString(JSONObject, 'op'), 'delete') then
      FOperationType := otDELETE;
    FDataType := GetFieldValueAsString(JSONObject, 'tipo');
    FId := GetFieldValueAsString(JSONObject, 'id');
    if JSONObject.Field['data'] is TlkJSONobject then
      FData := ParseJSONOfModelByDataType(FDataType, TlkJSON.GenerateText(JSONObject.Field['data']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahOperation.Equals(AAnotherOperation: IPanamahOperation): Boolean;
begin
  Result := TPanamahOperation.SameId(Self, AAnotherOperation) and
              TPanamahOperation.SameOperationType(Self, AAnotherOperation) and
                 TPanamahOperation.SameDataType(Self, AAnotherOperation) and
                     TPanamahOperation.SameAssinanteId(Self, AAnotherOperation);
end;

class function TPanamahOperation.FromJSON(const AJSON: string): IPanamahOperation;
begin
  Result := TPanamahOperation.Create;
  Result.DeserializeFromJSON(AJSON);
end;

class function TPanamahOperation.SameId(A, B: IPanamahOperation): Boolean;
var
  ADataId, BDataId: Variant;
begin
  ADataId := A.GetDataId;
  BDataId := B.GetDataId;
  Result := SameText(A.Id, B.Id) or
              SameText(ADataId, BDataId) or
                SameText(A.Id, BDataId) or
                   SameText(ADataId, B.Id);
end;

class function TPanamahOperation.SameOperationType(A, B: IPanamahOperation): Boolean;
begin
  Result := A.OperationType = B.OperationType;
end;

class function TPanamahOperation.SameAssinanteId(A, B: IPanamahOperation): Boolean;
begin
  Result := VarToStrDef(A.AssinanteId, EmptyStr) = VarToStrDef(B.AssinanteId, EmptyStr);
end;

class function TPanamahOperation.SameDataType(A, B: IPanamahOperation): Boolean;
begin
  Result := SameText(A.DataType, B.DataType);
end;

function TPanamahOperation.SerializeToJSON: string;

  procedure SetDataToId(AJSONObject: TlkJSONobject);
  var
    DataJSONObject: TlkJSONobject;
    Id: IJSONSerializable;
  begin
    DataJSONObject := TlkJSON.ParseText(FData.SerializeToJSON) as TlkJSONobject;
    try
      if DataJSONObject.Field['id'] <> nil then
      begin
        Id := TPanamahDataIdOperation.Create(GetFieldValueAsString(DataJSONObject, 'id'));
        SetFieldValue(AJSONObject, 'data', Id);
      end
      else
        SetFieldValue(AJSONObject, 'data', FData);
    finally
      DataJSONObject.Free;
    end;
  end;

var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    if not ModelValueIsEmpty(FAssinanteId) then
      SetFieldValue(JSONObject, 'assinanteId', FAssinanteId);
    case FOperationType of
      otUPDATE:
      begin
        SetFieldValue(JSONObject, 'op', 'update', [sfoKEEPCASE]);
        SetFieldValue(JSONObject, 'data', FData);
      end;
      otDELETE:
      begin
        SetFieldValue(JSONObject, 'op', 'delete', [sfoKEEPCASE]);
        SetDataToId(JSONObject);
      end;
    end;
    SetFieldValue(JSONObject, 'tipo', GetDataTypeByModel(FData));
    SetFieldValue(JSONObject, 'id', FId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

function TPanamahOperation.GetAssinanteId: Variant;
begin
  Result := FAssinanteId;
end;

function TPanamahOperation.GetData: IPanamahModel;
begin
  Result := FData;
end;

function TPanamahOperation.GetDataId: Variant;
var
  DataJSONObject: TlkJSONobject;
begin
  Result := varEmpty;
  if Assigned(FData) then
  begin
    DataJSONObject := TlkJSON.ParseText(FData.SerializeToJSON) as TlkJSONobject;
    try
      if DataJSONObject.Field['id'] <> nil then
        Result := GetFieldValueAsString(DataJSONObject, 'id');
    finally
      DataJSONObject.Free;
    end;
  end;
end;

function TPanamahOperation.GetDataType: string;
begin
  Result := FDataType;
end;

function TPanamahOperation.GetHash: string;
begin
  Result := SHA1Base64(SerializeToJSON);
end;

function TPanamahOperation.GetId: Variant;
begin
  Result := FId;
end;

function TPanamahOperation.GetOperationType: TPanamahOperationType;
begin
  Result := FOperationType;
end;

procedure TPanamahOperation.SetAssinanteId(AAssinanteId: Variant);
begin
  FAssinanteId := AAssinanteId;
end;

procedure TPanamahOperation.SetData(AData: IPanamahModel);
begin
  FData := AData;
end;

procedure TPanamahOperation.SetDataType(const ADataType: string);
begin
  FDataType := ADataType;
end;

procedure TPanamahOperation.SetId(AId: Variant);
begin
  FId := AId;
end;

procedure TPanamahOperation.SetOperationType(AOperationType: TPanamahOperationType);
begin
  FOperationType := AOperationType;
end;

function GetDataTypeByModel(AModel: IPanamahModel): string;
begin
  Result := AModel.ModelName;
end;

{ TPanamahHoldingList }

constructor TPanamahOperationList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahOperationList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahOperationList.Exists(AItem: IPanamahOperation): Boolean;
begin
  Result := IndexOf(AItem) > -1;
end;

class function TPanamahOperationList.FromJSON(const AJSON: string): IPanamahOperationList;
begin
  Result := TPanamahOperationList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahOperationList.Add(const AItem: IPanamahOperation);
begin
  FList.Add(AItem);
end;

procedure TPanamahOperationList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahOperation;
begin
  Item := TPanamahOperation.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahOperationList.Clear;
begin
  FList.Clear;
end;

function TPanamahOperationList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahOperationList.GetItem(AIndex: Integer): IPanamahOperation;
begin
  Result := FList.Items[AIndex] as IPanamahOperation;
end;

function TPanamahOperationList.IndexOf(AItem: IPanamahOperation; AThreadLocked: Boolean): Integer;
var
  I: Integer;
begin
  if not AThreadLocked then
    FList.Lock;
  try
    Result := -1;
    for I := 0 to FList.Count - 1 do
      if AItem.Equals(FList[I] as IPanamahOperation) then
      begin
        Result := I;
        Exit;
      end;
  finally
    if not AThreadLocked then
      FList.Unlock;
  end;
end;

function TPanamahOperationList.IndexOf(AItem: IPanamahOperation): Integer;
begin
  Result := IndexOf(AItem, False);
end;

procedure TPanamahOperationList.Remove(AItem: IPanamahOperation);
var
  Index: Integer;
begin
  FList.Lock;
  Index := IndexOf(AItem, True);
  try
    if Index > -1 then
      FList.Remove(FList[Index]);
  finally
    FList.Unlock;
  end;
end;

procedure TPanamahOperationList.SetItem(AIndex: Integer;
  const Value: IPanamahOperation);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahOperationList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahOperationList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahOperation).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahDataIdOperation }

constructor TPanamahDataIdOperation.Create(const AId: string);
begin
  inherited Create;
  FId := AId;
end;

procedure TPanamahDataIdOperation.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahDataIdOperation.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'id', FId);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.
