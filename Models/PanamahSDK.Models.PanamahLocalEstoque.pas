{$M+}
unit PanamahSDK.Models.PanamahLocalEstoque;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahLocalEstoque = interface(IModel)
    ['{00631CE0-6D1F-11E9-BC68-6769AAA11E00}']
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
  
  IPanamahLocalEstoqueList = interface(IJSONSerializable)
    ['{00631CE1-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahLocalEstoque;
    procedure SetItem(AIndex: Integer; const Value: IPanamahLocalEstoque);
    procedure Add(const AItem: IPanamahLocalEstoque);
    procedure Clear;
    function Count: Integer;
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
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahLocalEstoque;
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
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahLocalEstoqueList;
    constructor Create;
    procedure Add(const AItem: IPanamahLocalEstoque);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahLocalEstoque read GetItem write SetItem; default;
  end;
  
implementation

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

class function TPanamahLocalEstoqueList.FromJSON(const AJSON: string): IPanamahLocalEstoqueList;
begin
  Result := TPanamahLocalEstoqueList.Create;
  Result.DeserializeFromJSON(AJSON);
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

end.