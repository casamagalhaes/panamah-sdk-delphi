{$M+}
unit PanamahSDK.Models.Revenda;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahRevenda = interface(IPanamahModel)
    ['{D343B3A0-7043-11E9-B47F-05333FE0F816}']
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;
  
  IPanamahRevendaList = interface(IJSONSerializable)
    ['{D343B3A1-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): IPanamahRevenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahRevenda);
    procedure Add(const AItem: IPanamahRevenda);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahRevenda read GetItem write SetItem; default;
  end;
  
  TPanamahRevenda = class(TInterfacedObject, IPanamahRevenda)
  private
    FId: string;
    FNome: string;
    FFantasia: string;
    FRamo: string;
    FUf: string;
    FCidade: string;
    FBairro: string;
    function GetId: string;
    function GetNome: string;
    function GetFantasia: string;
    function GetRamo: string;
    function GetUf: string;
    function GetCidade: string;
    function GetBairro: string;
    procedure SetId(const AId: string);
    procedure SetNome(const ANome: string);
    procedure SetFantasia(const AFantasia: string);
    procedure SetRamo(const ARamo: string);
    procedure SetUf(const AUf: string);
    procedure SetCidade(const ACidade: string);
    procedure SetBairro(const ABairro: string);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahRevenda;
  published
    property Id: string read GetId write SetId;
    property Nome: string read GetNome write SetNome;
    property Fantasia: string read GetFantasia write SetFantasia;
    property Ramo: string read GetRamo write SetRamo;
    property Uf: string read GetUf write SetUf;
    property Cidade: string read GetCidade write SetCidade;
    property Bairro: string read GetBairro write SetBairro;
  end;

  TPanamahRevendaList = class(TInterfacedObject, IPanamahRevendaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahRevenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahRevenda);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahRevendaList;
    constructor Create;
    procedure Add(const AItem: IPanamahRevenda);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahRevenda read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahRevenda }

function TPanamahRevenda.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahRevenda.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahRevenda.GetNome: string;
begin
  Result := FNome;
end;

procedure TPanamahRevenda.SetNome(const ANome: string);
begin
  FNome := ANome;
end;

function TPanamahRevenda.GetFantasia: string;
begin
  Result := FFantasia;
end;

procedure TPanamahRevenda.SetFantasia(const AFantasia: string);
begin
  FFantasia := AFantasia;
end;

function TPanamahRevenda.GetRamo: string;
begin
  Result := FRamo;
end;

procedure TPanamahRevenda.SetRamo(const ARamo: string);
begin
  FRamo := ARamo;
end;

function TPanamahRevenda.GetUf: string;
begin
  Result := FUf;
end;

procedure TPanamahRevenda.SetUf(const AUf: string);
begin
  FUf := AUf;
end;

function TPanamahRevenda.GetCidade: string;
begin
  Result := FCidade;
end;

procedure TPanamahRevenda.SetCidade(const ACidade: string);
begin
  FCidade := ACidade;
end;

function TPanamahRevenda.GetBairro: string;
begin
  Result := FBairro;
end;

procedure TPanamahRevenda.SetBairro(const ABairro: string);
begin
  FBairro := ABairro;
end;

procedure TPanamahRevenda.DeserializeFromJSON(const AJSON: string);
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
    FBairro := GetFieldValueAsString(JSONObject, 'bairro');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahRevenda.SerializeToJSON: string;
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
    SetFieldValue(JSONObject, 'bairro', FBairro);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahRevenda.FromJSON(const AJSON: string): IPanamahRevenda;
begin
  Result := TPanamahRevenda.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahRevenda.GetModelName: string;
begin
  Result := 'PanamahRevenda';
end;

function TPanamahRevenda.Clone: IPanamahModel;
begin
  Result := TPanamahRevenda.FromJSON(SerializeToJSON);
end;

{ TPanamahRevendaList }

constructor TPanamahRevendaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahRevendaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahRevendaList.FromJSON(const AJSON: string): IPanamahRevendaList;
begin
  Result := TPanamahRevendaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahRevendaList.Add(const AItem: IPanamahRevenda);
begin
  FList.Add(AItem);
end;

procedure TPanamahRevendaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahRevenda;
begin
  Item := TPanamahRevenda.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahRevendaList.Clear;
begin
  FList.Clear;
end;

function TPanamahRevendaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahRevendaList.GetItem(AIndex: Integer): IPanamahRevenda;
begin
  Result := FList.Items[AIndex] as IPanamahRevenda;
end;

procedure TPanamahRevendaList.SetItem(AIndex: Integer;
  const Value: IPanamahRevenda);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahRevendaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahRevendaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahRevenda).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.