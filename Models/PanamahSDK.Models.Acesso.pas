{$M+}
unit PanamahSDK.Models.Acesso;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahAcesso = interface(IPanamahModel)
    ['{8E7B0ABA-75CB-11E9-8B82-D97403569AFA}']
    function GetId: string;
    function GetFuncionarioIds: IpanamahStringValueList;
    procedure SetId(const AId: string);
    procedure SetFuncionarioIds(const AFuncionarioIds: IpanamahStringValueList);
    property Id: string read GetId write SetId;
    property FuncionarioIds: IpanamahStringValueList read GetFuncionarioIds write SetFuncionarioIds;
  end;
  
  IPanamahAcessoList = interface(IPanamahModelList)
    ['{8E7B0ABB-75CB-11E9-8B82-D97403569AFA}']
    function GetItem(AIndex: Integer): IPanamahAcesso;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAcesso);
    procedure Add(const AItem: IPanamahAcesso);
    property Items[AIndex: Integer]: IPanamahAcesso read GetItem write SetItem; default;
  end;
  
  TPanamahAcesso = class(TInterfacedObject, IPanamahAcesso)
  private
    FId: string;
    FFuncionarioIds: IpanamahStringValueList;
    function GetId: string;
    function GetFuncionarioIds: IpanamahStringValueList;
    procedure SetId(const AId: string);
    procedure SetFuncionarioIds(const AFuncionarioIds: IpanamahStringValueList);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahAcesso;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property FuncionarioIds: IpanamahStringValueList read GetFuncionarioIds write SetFuncionarioIds;
  end;

  TPanamahAcessoList = class(TInterfacedObject, IPanamahAcessoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahAcesso;
    procedure SetItem(AIndex: Integer; const Value: IPanamahAcesso);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahAcessoList;
    constructor Create;
    procedure Add(const AItem: IPanamahAcesso);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahAcesso read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahAcessoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahAcesso }

function TPanamahAcesso.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahAcesso.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahAcesso.GetFuncionarioIds: IpanamahStringValueList;
begin
  Result := FFuncionarioIds;
end;

procedure TPanamahAcesso.SetFuncionarioIds(const AFuncionarioIds: IpanamahStringValueList);
begin
  FFuncionarioIds := AFuncionarioIds;
end;

procedure TPanamahAcesso.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    if JSONObject.Field['funcionarioIds'] is TlkJSONlist then
      FFuncionarioIds := TpanamahStringValueList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['funcionarioIds']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahAcesso.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'funcionarioIds', FFuncionarioIds);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahAcesso.FromJSON(const AJSON: string): IPanamahAcesso;
begin
  Result := TPanamahAcesso.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahAcesso.GetModelName: string;
begin
  Result := 'ACESSO';
end;

function TPanamahAcesso.Clone: IPanamahModel;
begin
  Result := TPanamahAcesso.FromJSON(SerializeToJSON);
end;

function TPanamahAcesso.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahAcessoValidator.Create;
  Result := Validator.Validate(Self as IPanamahAcesso);
end;

{ TPanamahAcessoList }

constructor TPanamahAcessoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahAcessoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahAcessoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahAcesso).Validate);
end;

class function TPanamahAcessoList.FromJSON(const AJSON: string): IPanamahAcessoList;
begin
  Result := TPanamahAcessoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahAcessoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahAcesso;
end;

procedure TPanamahAcessoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahAcessoList.Add(const AItem: IPanamahAcesso);
begin
  FList.Add(AItem);
end;

procedure TPanamahAcessoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahAcesso;
begin
  Item := TPanamahAcesso.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahAcessoList.Clear;
begin
  FList.Clear;
end;

function TPanamahAcessoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahAcessoList.GetItem(AIndex: Integer): IPanamahAcesso;
begin
  Result := FList.Items[AIndex] as IPanamahAcesso;
end;

procedure TPanamahAcessoList.SetItem(AIndex: Integer;
  const Value: IPanamahAcesso);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahAcessoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahAcessoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahAcesso).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahAcessoValidator }

function TPanamahAcessoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Acesso: IPanamahAcesso;
  Validations: IPanamahValidationResultList;
begin
  Acesso := AModel as IPanamahAcesso;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Acesso.Id) then
    Validations.AddFailure('Acesso.Id obrigatorio(a)');
  
  if ModelListIsEmpty(Acesso.FuncionarioIds) then
    Validations.AddFailure('Acesso.FuncionarioIds obrigatorio(a)')
  else
  if ModelStringListEmptyIndex(Acesso.FuncionarioIds) > -1 then
    Validations.AddFailure(Format('Acesso.FuncionarioIds[%d] esta vazio ou invalido', [ModelStringListEmptyIndex(Acesso.FuncionarioIds)]));
  
  Result := Validations.GetAggregate;
end;

end.