{$M+}
unit PanamahSDK.Models.PanamahEventoCaixa;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahEventoCaixaValoresDeclarados = interface(IModel)
    ['{00616F39-6D1F-11E9-BC68-6769AAA11E00}']
    function GetFormaPagamentoId: string;
    function GetValor: Double;
    procedure SetFormaPagamentoId(const AFormaPagamentoId: string);
    procedure SetValor(const AValor: Double);
    property FormaPagamentoId: string read GetFormaPagamentoId write SetFormaPagamentoId;
    property Valor: Double read GetValor write SetValor;
  end;
  
  IPanamahEventoCaixaValoresDeclaradosList = interface(IJSONSerializable)
    ['{00616F3A-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahEventoCaixaValoresDeclarados;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEventoCaixaValoresDeclarados);
    procedure Add(const AItem: IPanamahEventoCaixaValoresDeclarados);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahEventoCaixaValoresDeclarados read GetItem write SetItem; default;
  end;
  
  IPanamahEventoCaixa = interface(IModel)
    ['{00616F30-6D1F-11E9-BC68-6769AAA11E00}']
    function GetId: string;
    function GetLojaId: string;
    function GetNumeroCaixa: string;
    function GetFuncionarioId: variant;
    function GetDataHora: TDateTime;
    function GetTipo: TPanamahEventoCaixaTipo;
    function GetValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetNumeroCaixa(const ANumeroCaixa: string);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetTipo(const ATipo: TPanamahEventoCaixaTipo);
    procedure SetValoresDeclarados(const AValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property NumeroCaixa: string read GetNumeroCaixa write SetNumeroCaixa;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Tipo: TPanamahEventoCaixaTipo read GetTipo write SetTipo;
    property ValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList read GetValoresDeclarados write SetValoresDeclarados;
  end;
  
  IPanamahEventoCaixaList = interface(IJSONSerializable)
    ['{00616F31-6D1F-11E9-BC68-6769AAA11E00}']
    function GetItem(AIndex: Integer): IPanamahEventoCaixa;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEventoCaixa);
    procedure Add(const AItem: IPanamahEventoCaixa);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahEventoCaixa read GetItem write SetItem; default;
  end;
  
  TPanamahEventoCaixaValoresDeclarados = class(TInterfacedObject, IPanamahEventoCaixaValoresDeclarados)
  private
    FFormaPagamentoId: string;
    FValor: Double;
    function GetFormaPagamentoId: string;
    function GetValor: Double;
    procedure SetFormaPagamentoId(const AFormaPagamentoId: string);
    procedure SetValor(const AValor: Double);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEventoCaixaValoresDeclarados;
  published
    property FormaPagamentoId: string read GetFormaPagamentoId write SetFormaPagamentoId;
    property Valor: Double read GetValor write SetValor;
  end;

  TPanamahEventoCaixaValoresDeclaradosList = class(TInterfacedObject, IPanamahEventoCaixaValoresDeclaradosList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahEventoCaixaValoresDeclarados;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEventoCaixaValoresDeclarados);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEventoCaixaValoresDeclaradosList;
    constructor Create;
    procedure Add(const AItem: IPanamahEventoCaixaValoresDeclarados);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahEventoCaixaValoresDeclarados read GetItem write SetItem; default;
  end;
  
  TPanamahEventoCaixa = class(TInterfacedObject, IPanamahEventoCaixa)
  private
    FId: string;
    FLojaId: string;
    FNumeroCaixa: string;
    FFuncionarioId: variant;
    FDataHora: TDateTime;
    FTipo: TPanamahEventoCaixaTipo;
    FValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList;
    function GetId: string;
    function GetLojaId: string;
    function GetNumeroCaixa: string;
    function GetFuncionarioId: variant;
    function GetDataHora: TDateTime;
    function GetTipo: TPanamahEventoCaixaTipo;
    function GetValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetNumeroCaixa(const ANumeroCaixa: string);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetDataHora(const ADataHora: TDateTime);
    procedure SetTipo(const ATipo: TPanamahEventoCaixaTipo);
    procedure SetValoresDeclarados(const AValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEventoCaixa;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property NumeroCaixa: string read GetNumeroCaixa write SetNumeroCaixa;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property DataHora: TDateTime read GetDataHora write SetDataHora;
    property Tipo: TPanamahEventoCaixaTipo read GetTipo write SetTipo;
    property ValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList read GetValoresDeclarados write SetValoresDeclarados;
  end;

  TPanamahEventoCaixaList = class(TInterfacedObject, IPanamahEventoCaixaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahEventoCaixa;
    procedure SetItem(AIndex: Integer; const Value: IPanamahEventoCaixa);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEventoCaixaList;
    constructor Create;
    procedure Add(const AItem: IPanamahEventoCaixa);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahEventoCaixa read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahEventoCaixaValoresDeclarados }

function TPanamahEventoCaixaValoresDeclarados.GetFormaPagamentoId: string;
begin
  Result := FFormaPagamentoId;
end;

procedure TPanamahEventoCaixaValoresDeclarados.SetFormaPagamentoId(const AFormaPagamentoId: string);
begin
  FFormaPagamentoId := AFormaPagamentoId;
end;

function TPanamahEventoCaixaValoresDeclarados.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahEventoCaixaValoresDeclarados.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

procedure TPanamahEventoCaixaValoresDeclarados.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FFormaPagamentoId := GetFieldValueAsString(JSONObject, 'formaPagamentoId');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahEventoCaixaValoresDeclarados.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'formaPagamentoId', FFormaPagamentoId);    
    SetFieldValue(JSONObject, 'valor', FValor);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahEventoCaixaValoresDeclarados.FromJSON(const AJSON: string): IPanamahEventoCaixaValoresDeclarados;
begin
  Result := TPanamahEventoCaixaValoresDeclarados.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahEventoCaixaValoresDeclaradosList }

constructor TPanamahEventoCaixaValoresDeclaradosList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahEventoCaixaValoresDeclaradosList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahEventoCaixaValoresDeclaradosList.FromJSON(const AJSON: string): IPanamahEventoCaixaValoresDeclaradosList;
begin
  Result := TPanamahEventoCaixaValoresDeclaradosList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahEventoCaixaValoresDeclaradosList.Add(const AItem: IPanamahEventoCaixaValoresDeclarados);
begin
  FList.Add(AItem);
end;

procedure TPanamahEventoCaixaValoresDeclaradosList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahEventoCaixaValoresDeclarados;
begin
  Item := TPanamahEventoCaixaValoresDeclarados.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahEventoCaixaValoresDeclaradosList.Clear;
begin
  FList.Clear;
end;

function TPanamahEventoCaixaValoresDeclaradosList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahEventoCaixaValoresDeclaradosList.GetItem(AIndex: Integer): IPanamahEventoCaixaValoresDeclarados;
begin
  Result := FList.Items[AIndex] as IPanamahEventoCaixaValoresDeclarados;
end;

procedure TPanamahEventoCaixaValoresDeclaradosList.SetItem(AIndex: Integer;
  const Value: IPanamahEventoCaixaValoresDeclarados);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahEventoCaixaValoresDeclaradosList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahEventoCaixaValoresDeclaradosList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahEventoCaixaValoresDeclarados).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahEventoCaixa }

function TPanamahEventoCaixa.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahEventoCaixa.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahEventoCaixa.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahEventoCaixa.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahEventoCaixa.GetNumeroCaixa: string;
begin
  Result := FNumeroCaixa;
end;

procedure TPanamahEventoCaixa.SetNumeroCaixa(const ANumeroCaixa: string);
begin
  FNumeroCaixa := ANumeroCaixa;
end;

function TPanamahEventoCaixa.GetFuncionarioId: variant;
begin
  Result := FFuncionarioId;
end;

procedure TPanamahEventoCaixa.SetFuncionarioId(const AFuncionarioId: variant);
begin
  FFuncionarioId := AFuncionarioId;
end;

function TPanamahEventoCaixa.GetDataHora: TDateTime;
begin
  Result := FDataHora;
end;

procedure TPanamahEventoCaixa.SetDataHora(const ADataHora: TDateTime);
begin
  FDataHora := ADataHora;
end;

function TPanamahEventoCaixa.GetTipo: TPanamahEventoCaixaTipo;
begin
  Result := FTipo;
end;

procedure TPanamahEventoCaixa.SetTipo(const ATipo: TPanamahEventoCaixaTipo);
begin
  FTipo := ATipo;
end;

function TPanamahEventoCaixa.GetValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList;
begin
  Result := FValoresDeclarados;
end;

procedure TPanamahEventoCaixa.SetValoresDeclarados(const AValoresDeclarados: IPanamahEventoCaixaValoresDeclaradosList);
begin
  FValoresDeclarados := AValoresDeclarados;
end;

procedure TPanamahEventoCaixa.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FNumeroCaixa := GetFieldValueAsString(JSONObject, 'numeroCaixa');
    FFuncionarioId := GetFieldValue(JSONObject, 'funcionarioId');
    FDataHora := GetFieldValueAsDatetime(JSONObject, 'dataHora');
    FTipo := TPanamahEventoCaixaTipo(EnumConverters.Execute('PanamahEventoCaixaTipo', GetFieldValueAsString(JSONObject, 'tipo')));
    if JSONObject.Field['valoresDeclarados'] is TlkJSONlist then
      FValoresDeclarados := TPanamahEventoCaixaValoresDeclaradosList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['valoresDeclarados']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahEventoCaixa.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'numeroCaixa', FNumeroCaixa);    
    SetFieldValue(JSONObject, 'funcionarioId', FFuncionarioId);    
    SetFieldValue(JSONObject, 'dataHora', FDataHora);    
    SetFieldValue(JSONObject, 'tipo', EnumConverters.Execute('PanamahEventoCaixaTipo', Ord(FTipo)));    
    SetFieldValue(JSONObject, 'valoresDeclarados', FValoresDeclarados);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahEventoCaixa.FromJSON(const AJSON: string): IPanamahEventoCaixa;
begin
  Result := TPanamahEventoCaixa.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahEventoCaixaList }

constructor TPanamahEventoCaixaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahEventoCaixaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahEventoCaixaList.FromJSON(const AJSON: string): IPanamahEventoCaixaList;
begin
  Result := TPanamahEventoCaixaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahEventoCaixaList.Add(const AItem: IPanamahEventoCaixa);
begin
  FList.Add(AItem);
end;

procedure TPanamahEventoCaixaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahEventoCaixa;
begin
  Item := TPanamahEventoCaixa.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahEventoCaixaList.Clear;
begin
  FList.Clear;
end;

function TPanamahEventoCaixaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahEventoCaixaList.GetItem(AIndex: Integer): IPanamahEventoCaixa;
begin
  Result := FList.Items[AIndex] as IPanamahEventoCaixa;
end;

procedure TPanamahEventoCaixaList.SetItem(AIndex: Integer;
  const Value: IPanamahEventoCaixa);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahEventoCaixaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahEventoCaixaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahEventoCaixa).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.