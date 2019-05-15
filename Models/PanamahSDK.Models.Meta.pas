{$M+}
unit PanamahSDK.Models.Meta;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahMeta = interface(IPanamahModel)
    ['{081B7FB0-7736-11E9-A131-EBAF8D88186A}']
    function GetId: string;
    function GetMes: Double;
    function GetAno: Double;
    function GetLojaId: string;
    function GetSecaoId: string;
    function GetValor: Double;
    procedure SetId(const AId: string);
    procedure SetMes(const AMes: Double);
    procedure SetAno(const AAno: Double);
    procedure SetLojaId(const ALojaId: string);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetValor(const AValor: Double);
    property Id: string read GetId write SetId;
    property Mes: Double read GetMes write SetMes;
    property Ano: Double read GetAno write SetAno;
    property LojaId: string read GetLojaId write SetLojaId;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property Valor: Double read GetValor write SetValor;
  end;
  
  IPanamahMetaList = interface(IPanamahModelList)
    ['{081B7FB1-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahMeta;
    procedure SetItem(AIndex: Integer; const Value: IPanamahMeta);
    procedure Add(const AItem: IPanamahMeta);
    property Items[AIndex: Integer]: IPanamahMeta read GetItem write SetItem; default;
  end;
  
  TPanamahMeta = class(TInterfacedObject, IPanamahMeta)
  private
    FId: string;
    FMes: Double;
    FAno: Double;
    FLojaId: string;
    FSecaoId: string;
    FValor: Double;
    function GetId: string;
    function GetMes: Double;
    function GetAno: Double;
    function GetLojaId: string;
    function GetSecaoId: string;
    function GetValor: Double;
    procedure SetId(const AId: string);
    procedure SetMes(const AMes: Double);
    procedure SetAno(const AAno: Double);
    procedure SetLojaId(const ALojaId: string);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetValor(const AValor: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahMeta;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property Mes: Double read GetMes write SetMes;
    property Ano: Double read GetAno write SetAno;
    property LojaId: string read GetLojaId write SetLojaId;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property Valor: Double read GetValor write SetValor;
  end;

  TPanamahMetaList = class(TInterfacedObject, IPanamahMetaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahMeta;
    procedure SetItem(AIndex: Integer; const Value: IPanamahMeta);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahMetaList;
    constructor Create;
    procedure Add(const AItem: IPanamahMeta);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahMeta read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahMetaValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahMeta }

function TPanamahMeta.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahMeta.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahMeta.GetMes: Double;
begin
  Result := FMes;
end;

procedure TPanamahMeta.SetMes(const AMes: Double);
begin
  FMes := AMes;
end;

function TPanamahMeta.GetAno: Double;
begin
  Result := FAno;
end;

procedure TPanamahMeta.SetAno(const AAno: Double);
begin
  FAno := AAno;
end;

function TPanamahMeta.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahMeta.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahMeta.GetSecaoId: string;
begin
  Result := FSecaoId;
end;

procedure TPanamahMeta.SetSecaoId(const ASecaoId: string);
begin
  FSecaoId := ASecaoId;
end;

function TPanamahMeta.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahMeta.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

procedure TPanamahMeta.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FMes := GetFieldValueAsDouble(JSONObject, 'mes');
    FAno := GetFieldValueAsDouble(JSONObject, 'ano');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FSecaoId := GetFieldValueAsString(JSONObject, 'secaoId');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahMeta.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'mes', FMes);    
    SetFieldValue(JSONObject, 'ano', FAno);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'secaoId', FSecaoId);    
    SetFieldValue(JSONObject, 'valor', FValor);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahMeta.FromJSON(const AJSON: string): IPanamahMeta;
begin
  Result := TPanamahMeta.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahMeta.GetModelName: string;
begin
  Result := 'META';
end;

function TPanamahMeta.Clone: IPanamahModel;
begin
  Result := TPanamahMeta.FromJSON(SerializeToJSON);
end;

function TPanamahMeta.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahMetaValidator.Create;
  Result := Validator.Validate(Self as IPanamahMeta);
end;

{ TPanamahMetaList }

constructor TPanamahMetaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahMetaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahMetaList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahMeta).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahMetaList.FromJSON(const AJSON: string): IPanamahMetaList;
begin
  Result := TPanamahMetaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahMetaList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahMeta;
end;

procedure TPanamahMetaList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahMetaList.Add(const AItem: IPanamahMeta);
begin
  FList.Add(AItem);
end;

procedure TPanamahMetaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahMeta;
begin
  Item := TPanamahMeta.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahMetaList.Clear;
begin
  FList.Clear;
end;

function TPanamahMetaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahMetaList.GetItem(AIndex: Integer): IPanamahMeta;
begin
  Result := FList.Items[AIndex] as IPanamahMeta;
end;

procedure TPanamahMetaList.SetItem(AIndex: Integer;
  const Value: IPanamahMeta);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahMetaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahMetaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahMeta).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahMetaValidator }

function TPanamahMetaValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Meta: IPanamahMeta;
  Validations: IPanamahValidationResultList;
begin
  Meta := AModel as IPanamahMeta;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Meta.Id) then
    Validations.AddFailure('Meta.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Meta.LojaId) then
    Validations.AddFailure('Meta.LojaId obrigatorio(a)');
  
  if ModelValueIsEmpty(Meta.SecaoId) then
    Validations.AddFailure('Meta.SecaoId obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

end.