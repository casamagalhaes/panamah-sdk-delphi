unit PanamahSDK.Types;

interface

uses
  SysUtils, StrUtils;

type

  IJSONSerializable = interface
    ['{AEE55D86-3A0E-46D0-9BCF-AEC0CFA1D71A}']
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
  end;

  IModel = interface(IJSONSerializable)
    ['{A749CFD5-4AA6-4443-ABD2-D1B55051CC2B}']
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

end.
