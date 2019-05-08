unit PanamahSDK.Types;

interface

uses
  Classes, SysUtils, StrUtils, uLkJSON;

type

  IJSONSerializable = interface
    ['{AEE55D86-3A0E-46D0-9BCF-AEC0CFA1D71A}']
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
  end;

  IPanamahModel = interface(IJSONSerializable)
    ['{A749CFD5-4AA6-4443-ABD2-D1B55051CC2B}']
    function GetModelName: string;
    function Clone: IPanamahModel;
    property ModelName: string read GetModelName;
  end;

  PString = ^string;

  PPanamahModel = ^IPanamahModel;

  IPanamahModelList = interface
    ['{027630A2-754E-483E-A2DF-5D9A167E3366}']
    function GetItem(AIndex: Integer): IPanamahModel;
    procedure SetItem(AIndex: Integer; const Value: IPanamahModel);
    procedure Add(const AItem: IPanamahModel);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahModel read GetItem write SetItem; default;
  end;

  TPanamahModelList = class(TInterfacedObject, IPanamahModelList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahModel;
    procedure SetItem(AIndex: Integer; const Value: IPanamahModel);
  public
    constructor Create;
    procedure Add(const AItem: IPanamahModel);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahModel read GetItem write SetItem; default;
  end;

  IPanamahSDKConfig = interface
    ['{F5D4BA5C-5DF8-480A-9408-6EA0F41EEA0A}']
    function GetApiKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    procedure SetApiKey(const AApiKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetBatchTTL(const ABatchTTL: Integer);
    procedure SetBatchMaxSize(const ABatchMaxSize: Integer);
    property ApiKey: string read GetApiKey write SetApiKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL write SetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize write SetBatchMaxSize;
  end;

  TMethod = (mtGET, mtPOST, mtPUT, mtDELETE);

  {Exceptions}
  PanamahSDKConnectionRefusedException = class(Exception);
  PanamahSDKUnprocessableEntityException = class(Exception);
  PanamahSDKServerInternalException = class(Exception);
  PanamahSDKBadRequestException = class(Exception);
  PanamahSDKHTTPProtocolException = class(Exception);
  PanamahSDKInvalidSortParamException = class(Exception);
  PanamahSDKNotFoundException = class(Exception);
  PanamahSDKUnknownException = class(Exception);
  PanamahSDKIOException = class(Exception);

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

{ TPanamahModelList }

procedure TPanamahModelList.Add(const AItem: IPanamahModel);
begin
  FList.Add(AItem);
end;

procedure TPanamahModelList.Clear;
begin
  FList.Clear;
end;

function TPanamahModelList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahModelList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahModelList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TPanamahModelList.GetItem(AIndex: Integer): IPanamahModel;
begin
  Result := IPanamahModel(FList[AIndex]);
end;

procedure TPanamahModelList.SetItem(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

end.
