unit PanamahSDK.Types;

interface

uses
  Classes, SysUtils, StrUtils, uLkJSON, Windows, PanamahSDK.Consts, IdCoderMIME;

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
    function GetAuthorizationToken: string;
    procedure SetAuthorizationToken(const ASoftwareKey: string);
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
  end;

  IPanamahStreamConfig = interface
    ['{F5D4BA5C-5DF8-480A-9408-6EA0F41EEA0A}']
    function GetAssinanteId: string;
    function GetSecret: string;
    function GetAuthorizationToken: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    procedure SetAssinanteId(const AAssinanteId: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetSecret(const ASecret: string);
    procedure SetAuthorizationToken(const AAuthorizationToken: string);
    property AssinanteId: string read GetAssinanteId write SetAssinanteId;
    property Secret: string read GetSecret write SetSecret;
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
  end;

  IPanamahSerieQueryResponse = interface
    ['{186000E6-4A94-4901-92AD-9468B2D2B87F}']
    function GetChave: string;
    function GetDataAtivacao: TDateTime;
    procedure SetChave(const AChave: string);
    procedure SetDataAtivacao(const ADataAtivacao: TDateTime);
    property Chave: string read GetChave write SetChave;
    property DataAtivacao: TDateTime read GetDataAtivacao write SetDataAtivacao;
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

  TPanamahSerieQueryResponse = class(TInterfacedObject, IPanamahSerieQueryResponse)
  private
    FChave: string;
    FDataAtivacao: TDateTime;
    function GetChave: string;
    function GetDataAtivacao: TDateTime;
    procedure SetChave(const AChave: string);
    procedure SetDataAtivacao(const ADataAtivacao: TDateTime);
  public
    property Chave: string read GetChave write SetChave;
    property DataAtivacao: TDateTime read GetDataAtivacao write SetDataAtivacao;
    constructor Create; overload;
    constructor Create(const AJSON: string); overload;
  end;

  {Exceptions}
  EPanamahSDKConnectionRefusedException = class(Exception);
  EPanamahSDKUnprocessableEntityException = class(Exception);
  EPanamahSDKServerInternalException = class(Exception);
  EPanamahSDKBadRequestException = class(Exception);
  EPanamahSDKHTTPProtocolException = class(Exception);
  EPanamahSDKInvalidSortParamException = class(Exception);
  EPanamahSDKNotFoundException = class(Exception);
  EPanamahSDKConflictException = class(Exception);
  EPanamahSDKUnknownException = class(Exception);
  EPanamahSDKIOException = class(Exception);
  EPanamahSDKValidationException = class(Exception);

  {$IFNDEF UNICODE}
  function MatchText(const AText: string; const AValues: array of string): Boolean; overload;
  function IndexText(const AText: string; const AValues: array of string): Integer; overload;
  function StartsText(const ASubText, AText: string): Boolean; overload;
  function ContainsText(const AText, ASubText: string): Boolean;
  {$ENDIF}

  function OnlyNumbers(const AText: string): string;
  function CoalesceText(const AText, ATextIfNull: string): string;
  function DateTimeToISO8601(const AInput: TDateTime): string;
  function ISO8601ToDateTime(const AInput: string): TDateTime;
  function ConcatenatedYearMonthDayToDateTime(const AInput: string): TDateTime;
  function DecimalDotStringToDouble(const AString: string): Double;
  function TzSpecificLocalTimeToSystemTime(lpTimeZoneInformation: PTimeZoneInformation; var lpLocalTime, lpUniversalTime: TSystemTime): BOOL; stdcall;
  function NowUTC: TDateTime;
  function EncodeB64(const Text: AnsiString): AnsiString;
  function DecodeB64(const Text: AnsiString): AnsiString;

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

function ContainsText(const AText, ASubText: string): Boolean;
begin
  Result := AnsiContainsText(AText, ASubText);
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
  FList.Lock;
  try
    Result := TPanamahValidationResult.CreateSuccess;
    for I := 0 to FList.Count - 1 do
      Result.Concat(FList[I] as IPanamahValidationResult);
  finally
    FList.Unlock;
  end;
end;

function TPanamahValidationResultList.GetItem(AIndex: Integer): IPanamahValidationResult;
begin
  Result := FList[AIndex] as IPanamahValidationResult;
end;

procedure TPanamahValidationResultList.SetItem(AIndex: Integer; const Value: IPanamahValidationResult);
begin
  FList[AIndex] := Value;
end;

function CoalesceText(const AText, ATextIfNull: string): string;
begin
  Result := AText;
  if Trim(AText) = EmptyStr then
    Result := ATextIfNull;
end;

function DateTimeToISO8601(const AInput: TDateTime): string;
var
  TimeZoneInformation: TTimeZoneInformation;
  Hours: string;

begin
  GetTimeZoneInformation(TimeZoneInformation);
  Hours := Format('%.*d',[4, -1 * Trunc(TimeZoneInformation.Bias / 60) * 100]);
  if not StartsText('-', Hours) then
    Hours := Concat('+', Hours);
  Result := FormatDateTime('yyyy-mm-dd', AInput) + 'T' + FormatDateTime('hh:nn:ss', AInput);
end;

function ISO8601ToDateTime(const AInput: string): TDateTime;
var
  Day, Month, Year, Hour, Minute, Second, Millisecond: Word;
begin
  if Trim(AInput) = EmptyStr then
    Result := 0
  else
    try
      Year := StrToInt(Copy(AInput, 1, 4));
      Month := StrToInt(Copy(AInput, 6, 2));
      Day := StrToInt(Copy(AInput, 9, 2));
      Hour := StrToIntDef(Copy(AInput, 12, 2), 0);
      Minute := StrToIntDef(Copy(AInput, 15, 2), 0);
      Second := StrToIntDef(Copy(AInput, 18, 2), 0);
      Millisecond := StrToIntDef(Copy(AInput, 21, 3), 0);
      Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, Millisecond);
    except
      on E: Exception do
      begin
        raise e.Create('Falha na conversao de data');
      end;
    end;
end;

function ConcatenatedYearMonthDayToDateTime(const AInput: string): TDateTime;
var
  Day, Month, Year, Hour, Minute, Second: Word;
begin
  if Trim(AInput) = EmptyStr then
    Result := 0
  else
    try
      Year := StrToInt(Copy(AInput, 1, 4));
      Month := StrToInt(Copy(AInput, 5, 2));
      Day := StrToInt(Copy(AInput, 7, 2));
      Hour := StrToIntDef(Copy(AInput, 9, 2), 0);
      Minute := StrToIntDef(Copy(AInput, 11, 2), 0);
      Second := StrToIntDef(Copy(AInput, 13, 2), 0);
      Result := EncodeDate(Year, Month, Day) + EncodeTime(Hour, Minute, Second, 0);
    except
      on E: Exception do
      begin
        raise e.Create('Falha na conversao de data');
      end;
    end;
end;

function DecimalDotStringToDouble(const AString: string): Double;
var
  Value: string;
  FormatSettings: TFormatSettings;
begin
  Value := StringReplace(AString, '%', '', [rfIgnoreCase, rfReplaceAll]);
  Value := StringReplace(Value, '$', '', [rfIgnoreCase, rfReplaceAll]);
  Value := StringReplace(Value, ' ', '', [rfIgnoreCase, rfReplaceAll]);
  Value := StringReplace(Value, ',', '', [rfIgnoreCase, rfReplaceAll]);
  FillChar(FormatSettings, SizeOf(FormatSettings), 0);
  FormatSettings.ThousandSeparator := ',';
  FormatSettings.DecimalSeparator := '.';
  Result := StrToFloatDef(AString, 0, FormatSettings);
end;

function TzSpecificLocalTimeToSystemTime; external kernel32 name 'TzSpecificLocalTimeToSystemTime';

function NowUTC: TDateTime;
var
  TimeZoneInformation: TTimeZoneInformation;
  LocalTime, UniversalTime: TSystemTime;
begin
  GetTimeZoneInformation(TimeZoneInformation);
  DateTimeToSystemTime(Now, LocalTime);
  TzSpecificLocalTimeToSystemTime(@TimeZoneInformation, LocalTime, UniversalTime);
  Result := SystemTimeToDateTime(UniversalTime);
end;

function OnlyNumbers(const AText: string): string;
var
  I: Integer;
begin
  Result := EmptyStr;
  for I := 1 to Length(AText) do
  begin
    if {$IFDEF UNICODE}CharInSet(AText[I], ['0'..'9']){$ELSE}AText[I] in ['0'..'9']{$ENDIF} then
      Result := Result + AText[I];
  end;
end;


function EncodeB64(const Text: AnsiString): AnsiString;
var
  Encoder : TIdEncoderMime;
begin
  Encoder := TIdEncoderMime.Create(nil);
  Result := Encoder.EncodeString(Text);
  FreeAndNil(Encoder);
end;

function DecodeB64(const Text: AnsiString): AnsiString;
var
  Decoder : TIdDecoderMime;
begin
  Decoder := TIdDecoderMime.Create(nil);
  Result := Decoder.DecodeString(Text);
  FreeAndNil(Decoder)
end;

{ TPanamahSerieQueryResponse }

constructor TPanamahSerieQueryResponse.Create;
begin
  inherited Create;
end;

constructor TPanamahSerieQueryResponse.Create(const AJSON: string);
var
  JsonObject: TlkJSONobject;
begin
  inherited Create;
  JsonObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    with JsonObject.Field['assinante'] as TlkJSONobject do
    begin
      FChave := Field['chave'].Value;
      FDataAtivacao := ISO8601ToDateTime(Field['dataAtivacao'].Value);
    end;
  finally
    JsonObject.Free;
  end;
end;

function TPanamahSerieQueryResponse.GetChave: string;
begin
  Result := FChave;
end;

function TPanamahSerieQueryResponse.GetDataAtivacao: TDateTime;
begin
  Result := FDataAtivacao;
end;

procedure TPanamahSerieQueryResponse.SetChave(const AChave: string);
begin
  FChave := AChave;
end;

procedure TPanamahSerieQueryResponse.SetDataAtivacao(
  const ADataAtivacao: TDateTime);
begin
  FDataAtivacao := ADataAtivacao;
end;

end.
