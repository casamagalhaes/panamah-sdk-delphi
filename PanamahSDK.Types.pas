unit PanamahSDK.Types;

interface

uses
  Classes, SysUtils, StrUtils, uLkJSON;

type

  IPanamahValidationResult = interface
    ['{2443A865-EFEE-4B6E-9FB8-69B6191C8D8F}']
    function GetValid: Boolean;
    function GetReasons: TStrings;
    procedure Concat(AResult: IPanamahValidationResult); overload;
    procedure Concat(const AReasonPrefix: string; AResult: IPanamahValidationResult); overload;
    property Valid: Boolean read GetValid;
    property Reasons: TStrings read GetReasons;
  end;

  IPanamahValidationResultList = interface
    ['{A2B3F57A-BFD1-4DEE-AA8D-07E0D184DD71}']
    function GetItem(AIndex: Integer): IPanamahValidationResult;
    procedure SetItem(AIndex: Integer; const Value: IPanamahValidationResult);
    procedure Add(const AItem: IPanamahValidationResult);
    procedure AddFailure(const AMessage: string);
    procedure Clear;
    function Count: Integer;
    function GetAggregate: IPanamahValidationResult;
    property Items[AIndex: Integer]: IPanamahValidationResult read GetItem write SetItem; default;
  end;

  IJSONSerializable = interface
    ['{AEE55D86-3A0E-46D0-9BCF-AEC0CFA1D71A}']
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
  end;

  IPanamahModel = interface(IJSONSerializable)
    ['{A749CFD5-4AA6-4443-ABD2-D1B55051CC2B}']
    function GetModelName: string;
    function Clone: IPanamahModel;
    function Validate: IPanamahValidationResult;
    property ModelName: string read GetModelName;
  end;

  IJSONSerializableList = interface(IJSONSerializable)
    ['{A3DB8008-D227-42C3-96A7-EFDC1D64829A}']
    function Count: Integer;
  end;

  IPanamahModelList = interface(IJSONSerializableList)
    ['{40DE7A1C-95C0-48BA-8343-E3C891209B37}']
    function Validate: IPanamahValidationResult;
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure Clear;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel; default;
  end;

  PString = ^string;

  PPanamahModel = ^IPanamahModel;

  IPanamahModelValidator = interface
    ['{3535F595-6CD0-4FE9-9B16-12E961504A84}']
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;

  IPanamahAdminConfig = interface
    ['{E795306E-4613-408C-977A-409932CE7267}']
    function GetSoftwareKey: string;
    procedure SetSoftwareKey(const ASoftwareKey: string);
    property SoftwareKey: string read GetSoftwareKey write SetSoftwareKey;
  end;

  IPanamahStreamConfig = interface
    ['{F5D4BA5C-5DF8-480A-9408-6EA0F41EEA0A}']
    function GetSoftwareKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    procedure SetSoftwareKey(const ASoftwareKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    property SoftwareKey: string read GetSoftwareKey write SetSoftwareKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
  end;

  TMethod = (mtGET, mtPOST, mtPUT, mtDELETE);

  IPanamahStringValueList = interface(IJSONSerializable)
    ['{6011B746-B54A-447C-924E-FB647D2C5335}']
    function GetItem(AIndex: Integer): string;
    procedure SetItem(AIndex: Integer; const Value: string);
    procedure Add(const AItem: string);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: string read GetItem write SetItem; default;
    function IndexOf(const Value: string): Integer;
  end;

  TPanamahStringValueList = class(TInterfacedObject, IPanamahStringValueList)
  private
    FList: TStrings;
    function GetItem(AIndex: Integer): string;
    procedure SetItem(AIndex: Integer; const Value: string);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahStringValueList;
    constructor Create;
    procedure Add(const AItem: string);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: string read GetItem write SetItem; default;
    function IndexOf(const Value: string): Integer;
  end;

  TPanamahValidationResult = class(TInterfacedObject, IPanamahValidationResult)
  private
    FReasons: TStrings;
    FValid: Boolean;
  public
    function GetReasons: TStrings;
    function GetValid: Boolean;
    procedure Concat(AResult: IPanamahValidationResult); overload;
    procedure Concat(const AReasonPrefix: string; AResult: IPanamahValidationResult); overload;
    property Reasons: TStrings read GetReasons;
    property Valid: Boolean read GetValid;
    class function CreateSuccess: IPanamahValidationResult;
    class function CreateFailure(AReasons: TStrings): IPanamahValidationResult; overload;
    class function CreateFailure(const AReason: string): IPanamahValidationResult; overload;
    constructor Create(AValid: Boolean; AReasons: TStrings); overload;
    destructor Destroy; override;
  end;

  TPanamahValidationResultList = class(TInterfacedObject, IPanamahValidationResultList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahValidationResult;
    procedure SetItem(AIndex: Integer; const Value: IPanamahValidationResult);
  public
    constructor Create;
    procedure Add(const AItem: IPanamahValidationResult);
    procedure AddFailure(const AMessage: string);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    function GetAggregate: IPanamahValidationResult;
    property Items[AIndex: Integer]: IPanamahValidationResult read GetItem write SetItem; default;
  end;

  {Exceptions}
  EPanamahSDKConnectionRefusedException = class(Exception);
  EPanamahSDKUnprocessableEntityException = class(Exception);
  EPanamahSDKServerInternalException = class(Exception);
  EPanamahSDKBadRequestException = class(Exception);
  EPanamahSDKHTTPProtocolException = class(Exception);
  EPanamahSDKInvalidSortParamException = class(Exception);
  EPanamahSDKNotFoundException = class(Exception);
  EPanamahSDKUnknownException = class(Exception);
  EPanamahSDKIOException = class(Exception);
  EPanamahSDKExceptionValidationFailed = class(Exception);

  {$IFNDEF UNICODE}
  function MatchText(const AText: string; const AValues: array of string): Boolean; overload;
  function IndexText(const AText: string; const AValues: array of string): Integer; overload;
  function StartsText(const ASubText, AText: string): Boolean; overload;
  {$ENDIF}

const
  CURRENT_TIMEZONE = -(3 * 3600);
  UTF8_CODEPAGE = 65001;
  LATIN_CODEPAGE = 28591;
  HTTPS_PROTOCOL = 'https';

implementation

uses
  PanamahSDK.JsonUtils;

{$IFNDEF UNICODE} 
function MatchText(const AText: string; const AValues: array of string): Boolean;
begin
  Result := AnsiMatchText(AText, AValues);
end;

function IndexText(const AText: string; const AValues: array of string): Integer;
begin
  Result := AnsiIndexText(AText, AValues);
end;

function StartsText(const ASubText, AText: string): Boolean;
begin
  Result := AnsiStartsText(ASubText, AText);
end;
{$ENDIF}

{ TPanamahStringValueList }

procedure TPanamahStringValueList.Add(const AItem: string);
begin
  FList.Add(AItem);
end;

procedure TPanamahStringValueList.Clear;
begin
  FList.Clear;
end;

function TPanamahStringValueList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahStringValueList.Create;
begin
  FList := TStringList.Create;
end;

destructor TPanamahStringValueList.Destroy;
begin
  FList.Destroy;
  inherited;
end;

function TPanamahStringValueList.GetItem(AIndex: Integer): string;
begin
  Result := FList[AIndex];
end;

function TPanamahStringValueList.IndexOf(const Value: string): Integer;
begin
  Result := FList.IndexOf(Value);
end;

procedure TPanamahStringValueList.SetItem(AIndex: Integer; const Value: string);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahStringValueList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

class function TPanamahStringValueList.FromJSON(const AJSON: string): IPanamahStringValueList;
begin
  Result := TPanamahStringValueList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahStringValueList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSONstring.Generate(FList[I]));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

procedure TPanamahStringValueList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
begin
  FList.Add(Elem.Value);
end;


{ TPanamahValidationResult }

procedure TPanamahValidationResult.Concat(AResult: IPanamahValidationResult);
begin
  FValid := FValid and AResult.Valid;
  FReasons.AddStrings(AResult.Reasons);
end;

procedure TPanamahValidationResult.Concat(const AReasonPrefix: string; AResult: IPanamahValidationResult);
var
  I: Integer;
begin
  Concat(AResult);
  for I := 0 to FReasons.Count - 1 do
    FReasons[I] := AReasonPrefix + FReasons[I];
end;

constructor TPanamahValidationResult.Create(AValid: Boolean; AReasons: TStrings);
begin
  inherited Create;
  FValid := AValid;
  FReasons := TStringList.Create;
  if Assigned(AReasons) then
    FReasons.AddStrings(AReasons);
end;

class function TPanamahValidationResult.CreateFailure(const AReason: string): IPanamahValidationResult;
var
  Reasons: TStrings;
begin
  Reasons := TStringList.Create;
  try
    Reasons.Add(AReason);
    Result := CreateFailure(Reasons);
  finally
    Reasons.Free;
  end;
end;

class function TPanamahValidationResult.CreateFailure(AReasons: TStrings): IPanamahValidationResult;
begin
  Result := TPanamahValidationResult.Create(False, AReasons);
end;

class function TPanamahValidationResult.CreateSuccess: IPanamahValidationResult;
begin
  Result := TPanamahValidationResult.Create(True, nil);
end;

destructor TPanamahValidationResult.Destroy;
begin
  if Assigned(FReasons) then
    FReasons.Free;
  inherited Destroy;
end;

function TPanamahValidationResult.GetReasons: TStrings;
begin
  Result := FReasons;
end;

function TPanamahValidationResult.GetValid: Boolean;
begin
  Result := FValid;
end;

{ TPanamahValidationResultList }

procedure TPanamahValidationResultList.Add(const AItem: IPanamahValidationResult);
begin
  FList.Add(AItem);
end;

procedure TPanamahValidationResultList.AddFailure(const AMessage: string);
var
  Failure: IPanamahValidationResult;
begin
  Failure := TPanamahValidationResult.CreateFailure(AMessage);
  FList.Add(Failure);
end;

procedure TPanamahValidationResultList.Clear;
begin
  FList.Clear;
end;

function TPanamahValidationResultList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahValidationResultList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahValidationResultList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahValidationResultList.GetAggregate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  for I := 0 to FList.Count - 1 do
    Result.Concat(FList[I] as IPanamahValidationResult);
end;

function TPanamahValidationResultList.GetItem(AIndex: Integer): IPanamahValidationResult;
begin
  Result := FList[AIndex] as IPanamahValidationResult;
end;

procedure TPanamahValidationResultList.SetItem(AIndex: Integer; const Value: IPanamahValidationResult);
begin
  FList[AIndex] := Value;
end;

end.
