{$M+}
unit PanamahSDK.Models.Holding;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahHolding = interface(IModel)
    ['{0F1D3421-6DAE-11E9-88EA-EB5361679635}']
    function GetId: string;
    function GetDescricao: string;
    procedure SetId(const AId: string);
    procedure SetDescricao(const ADescricao: string);
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;
  
  IPanamahHoldingList = interface(IJSONSerializable)
    ['{0F1D3422-6DAE-11E9-88EA-EB5361679635}']
    function GetItem(AIndex: Integer): IPanamahHolding;
    procedure SetItem(AIndex: Integer; const Value: IPanamahHolding);
    procedure Add(const AItem: IPanamahHolding);
    procedure Clear;
    function Count: Integer;
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
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahHolding;
  published
    property Id: string read GetId write SetId;
    property Descricao: string read GetDescricao write SetDescricao;
  end;

  TPanamahHoldingList = class(TInterfacedObject, IPanamahHoldingList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahHolding;
    procedure SetItem(AIndex: Integer; const Value: IPanamahHolding);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahHoldingList;
    constructor Create;
    procedure Add(const AItem: IPanamahHolding);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahHolding read GetItem write SetItem; default;
  end;
  
implementation

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

class function TPanamahHoldingList.FromJSON(const AJSON: string): IPanamahHoldingList;
begin
  Result := TPanamahHoldingList.Create;
  Result.DeserializeFromJSON(AJSON);
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

end.