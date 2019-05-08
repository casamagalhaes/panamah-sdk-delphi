unit PanamahSDK.Client;

interface

uses
  SysUtils, StrUtils, Classes, IdHTTP, IdSSLOpenSSL, IdStack, PanamahSDK.Types, uLkJSON, PanamahSDK.JsonUtils;

type

  IPanamahResponse = interface
    ['{AF409221-7227-42FA-891B-1380515CE35F}']
    procedure SetHeaders(AHeaders: TStrings);
    function GetHeaders: TStrings;
    procedure SetContent(const AContent: string);
    function GetContent: string;
    procedure SetStatus(AStatus: Integer);
    function GetStatus: Integer;
    property Headers: TStrings read GetHeaders write SetHeaders;
    property Content: string read GetContent write SetContent;
    property Status: Integer read GetStatus write SetStatus;
  end;

  IPanamahRequest = interface
    ['{FB10AE9A-3BC1-42AD-8670-2D0E3126C6A3}']
    function GetMethod: TMethod;
    procedure SetMethod(AMethod: TMethod);
    function GetParams: TStrings;
    procedure SetParams(AParams: TStrings);
    function GetHeaders: TStrings;
    procedure SetHeaders(AHeaders: TStrings);
    function GetContent: string;
    procedure SetContent(const AContent: string);
    function GetURL: string;
    procedure SetURL(const AURL: string);
    property URL: string read GetURL write SetURL;
    property Method: TMethod read GetMethod write SetMethod;
    property Params: TStrings read GetParams write SetParams;
    property Headers: TStrings read GetHeaders write SetHeaders;
    property Content: string read GetContent write SetContent;
  end;

  TPanamahTokenStorage = class
  private
    FAccessToken: string;
    FRefreshToken: string;
  public
    property AccessToken: string read FAccessToken write FAccessToken;
    property RefreshToken: string read FRefreshToken write FRefreshToken;
    class function From(const AResponse: IPanamahResponse): TPanamahTokenStorage; overload;
    function Clone: TPanamahTokenStorage;
  end;

  TPanamahAuthenticatedRequest = function(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse of object;

  IPanamahClient = interface
    ['{0E22616E-90FA-4D19-9727-C54CA2BBB957}']
    function Authenticate(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ARequestFunction: TPanamahAuthenticatedRequest): IPanamahResponse;
    function MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse;
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
    procedure SetApiKey(const AApiKey: string);
  end;

  TPanamahRequest = class(TInterfacedObject, IPanamahRequest)
  private
    FOwnedObjects: TStrings;
    FMethod: TMethod;
    FContent: string;
    FHeaders: TStrings;
    FParams: TStrings;
    FURL: string;
    FTokens: TPanamahTokenStorage;
    procedure SetAuthorizationHeaders;
  public
    destructor Destroy; override;
    function GetContent: string;
    function GetHeaders: TStrings;
    function GetMethod: TMethod;
    function GetParams: TStrings;
    function GetURL: string;
    procedure SetContent(const AContent: string);
    procedure SetHeaders(AHeaders: TStrings);
    procedure SetMethod(AMethod: TMethod);
    procedure SetParams(AParams: TStrings);
    procedure SetURL(const AURL: string);
    procedure SetTokens(const ATokens: TPanamahTokenStorage);

    property URL: string read GetURL write SetURL;
    property Method: TMethod read GetMethod write SetMethod;
    property Params: TStrings read GetParams write SetParams;
    property Headers: TStrings read GetHeaders write SetHeaders;
    property Content: string read GetContent write SetContent;
    constructor Create(AURL: string; AMethod: TMethod;
      AParams, AHeaders: TStrings; AContent: string = ''; const ATokens: TPanamahTokenStorage = nil);
  end;

  TResponse = class(TInterfacedObject, IPanamahResponse)
  private
    FStatus: Integer;
    FContent: string;
    FHeaders: TStrings;
  public
    constructor Create(AStatus: Integer; const AHeaders: TStrings; AContent: string);
    destructor Destroy; override;
    function GetContent: string;
    function GetHeaders: TStrings;
    function GetStatus: Integer;
    procedure SetContent(const Value: string);
    procedure SetHeaders(Value: TStrings);
    procedure SetStatus(Value: Integer);
    property Headers: TStrings read GetHeaders write SetHeaders;
    property Content: string read GetContent write SetContent;
    property Status: Integer read GetStatus write SetStatus;
  end;

  TPanamahSDKIdHTTP = class(TIdCustomHTTP)
  public
    function Delete(const AURL: string; AResponseContent: TStream): string; overload;
    function Delete(const AURL: string): string; overload;
  end;

  TPanamahClient = class(TInterfacedObject, IPanamahClient)
  private
    FBaseURL: string;
    FTokens: TPanamahTokenStorage;
    FApiKey: string;
  public
    procedure SetApiKey(const AApiKey: string);
    function Authenticate(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ARequestFunction: TPanamahAuthenticatedRequest): IPanamahResponse;
    function AuthenticatedGet(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedPut(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedPost(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedDelete(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse;
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
    constructor Create(const ABaseURL: string; const AApiKey: string); overload;
    constructor Create(const ABaseURL: string); overload;
    destructor Destroy; override;
  end;

const
  DELETE_HTTP_METHOD = 'DELETE';

implementation

{ TPanamahClient }

function TPanamahClient.Authenticate(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ARequestFunction: TPanamahAuthenticatedRequest): IPanamahResponse;
var
  AuthRequest: IPanamahRequest;
  AuthResponse: IPanamahResponse;
  AuthHeaders: TStrings;
  RefreshRequest: IPanamahRequest;
  RefreshResponse: IPanamahResponse;
  RefreshHeaders: TStrings;
begin
  if Assigned(FTokens) then
  begin
    Result := ARequestFunction(AURL, AParams, AHeaders, AContent, FTokens);
    if (Result.Status = 401) and (FApiKey <> EmptyStr) then
    begin
      RefreshHeaders := TStringList.Create;
      try
        RefreshHeaders.Values['Accept'] := 'application/json';
        RefreshHeaders.Values['Authorization'] := FTokens.RefreshToken;
        RefreshRequest := TPanamahRequest.Create(Concat(FBaseURL, '/api/refresh'), mtGET, nil, RefreshHeaders, Format('{"accessToken": "%s", "refreshToken": "%s"}', [FTokens.AccessToken, FTokens.RefreshToken]));
        RefreshResponse := MakeRequest(RefreshRequest);
        if RefreshResponse.Status = 200 then
        begin
          FTokens := TPanamahTokenStorage.From(RefreshResponse);
          Result := ARequestFunction(AURL, AParams, AHeaders, AContent, FTokens);
        end
        else
          raise Exception.CreateFmt('Refresh falhou com código %d', [RefreshResponse.Status]);
      finally
        RefreshHeaders.Free;
      end;
    end;
  end
  else
  begin
    AuthHeaders := TStringList.Create;
    try
      AuthHeaders.Values['Content-Type'] := 'application/json';
      AuthHeaders.Values['Accept'] := 'application/json';
      AuthHeaders.Values['x-api-key'] := FApiKey;
      AuthRequest := TPanamahRequest.Create(Concat(FBaseURL, '/api/auth'), mtPOST, nil, AuthHeaders, EmptyStr);
      AuthResponse := MakeRequest(AuthRequest);
      if AuthResponse.Status = 200 then
      begin
        FTokens := TPanamahTokenStorage.From(AuthResponse);
        Result := ARequestFunction(AURL, AParams, AHeaders, AContent, FTokens);
      end
      else
        raise Exception.CreateFmt('Autenticação falhou com código %d', [AuthResponse.Status]);
    finally
      AuthHeaders.Free;
    end;
  end;
end;

function TPanamahClient.Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, AParams, AHeaders, EmptyStr, AuthenticatedDelete);
end;

destructor TPanamahClient.Destroy;
begin
  if Assigned(FTokens) then
    FreeAndNil(FTokens);
  inherited;
end;

function TPanamahClient.AuthenticatedDelete(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtDELETE, AParams, AHeaders, EmptyStr, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahClient.AuthenticatedGet(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtGET, AParams, AHeaders, EmptyStr, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahClient.AuthenticatedPost(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPOST, nil, nil, AContent, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahClient.AuthenticatedPut(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPUT, nil, nil, AContent, ATokens);
  Result := MakeRequest(Request);
end;

constructor TPanamahClient.Create(const ABaseURL: string; const AApiKey: string);
begin
  inherited Create;
  FBaseURL := ABaseURL;
  FApiKey := AApiKey;
end;

function TPanamahClient.Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, AParams, AHeaders, EmptyStr, AuthenticatedGet);
end;

function TPanamahClient.Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, nil, nil, AContent, AuthenticatedPost);
end;

function TPanamahClient.Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, nil, nil, AContent, AuthenticatedPut);
end;

procedure TPanamahClient.SetApiKey(const AApiKey: string);
begin
  FApiKey := AApiKey;
end;

function TPanamahClient.MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse;
var
  ResponseContent: string;
  HTTP: TPanamahSDKIdHTTP;
  HTTPRequest: TIdHTTPRequest;
  HTTPIOHandler: TIdSSLIOHandlerSocketOpenSSL;
  RequestContent: TStream;
begin
  HTTP := TPanamahSDKIdHTTP.Create(nil);
  try
    HTTPIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    try
      HTTPIOHandler.SSLOptions.Method := sslvTLSv1;
      HTTPIOHandler.SSLOptions.Mode := sslmClient;
      HTTPIOHandler.LargeStream := True;
      HTTPRequest := TIdHTTPRequest.Create(nil);
      try
        if StartsText(HTTPS_PROTOCOL, ARequest.URL) then
          HTTP.IOHandler := HTTPIOHandler;
        HTTP.Request := HTTPRequest;
        HTTP.ReadTimeout := 60000;
        HTTP.ConnectTimeout := 60000;
        if Assigned(ARequest.Headers) then
        begin
          HTTP.Request.CustomHeaders.AddStrings(ARequest.Headers);
          HTTP.Request.RawHeaders.AddStrings(ARequest.Headers);
          if ARequest.Headers.IndexOfName('Content-Type') > -1 then
            HTTP.Request.ContentType := ARequest.Headers.Values['Content-Type'];
          if ARequest.Headers.IndexOfName('Accept') > -1 then
            HTTP.Request.Accept := ARequest.Headers.Values['Accept'];
        end;
        if not MatchText(HTTP.Request.ContentType, ['application/xml', 'application/json']) then
          HTTP.Request.ContentType := 'application/json';
        if not MatchText(HTTP.Request.Accept, ['application/xml', 'application/json']) then
          HTTP.Request.Accept := 'application/json';
        HTTP.HandleRedirects := True;
        try
          case ARequest.Method of
            mtGET:
            begin
              {$IFDEF UNICODE}
              ResponseContent := HTTP.Get(ARequest.URL);
              {$ELSE}
              ResponseContent := Utf8ToAnsi(HTTP.Get(ARequest.URL));
              {$ENDIF}
            end;
            mtPOST:
            begin
              RequestContent := TStringStream.Create(ARequest.Content);
              try
                {$IFDEF UNICODE}
                ResponseContent := HTTP.Post(ARequest.URL, RequestContent);
                {$ELSE}
                ResponseContent := Utf8ToAnsi(HTTP.Post(ARequest.URL, RequestContent));
                {$ENDIF}
              finally
                FreeAndNil(RequestContent);
              end;
            end;
            mtPUT:
            begin
              RequestContent := TStringStream.Create(ARequest.Content);
              try
                {$IFDEF UNICODE}
                ResponseContent := HTTP.Put(ARequest.URL, RequestContent);
                {$ELSE}
                ResponseContent := Utf8ToAnsi(HTTP.Put(ARequest.URL, RequestContent));
                {$ENDIF}
              finally
                FreeAndNil(RequestContent);
              end;
            end;
            mtDELETE:
            begin
              {$IFDEF UNICODE}
              ResponseContent := HTTP.Delete(ARequest.URL);
              {$ELSE}
              ResponseContent := Utf8ToAnsi(HTTP.Delete(ARequest.URL));
              {$ENDIF}
            end;
          end;
        except
          on E: EIdHTTPProtocolException do
          begin
            if HTTP.ResponseCode = 500 then
              raise PanamahSDKServerInternalException.Create(E.Message)
            else
            if HTTP.ResponseCode = 400 then
              raise PanamahSDKBadRequestException.Create(E.Message)
            else
            if HTTP.ResponseCode = 404 then
            else
            if HTTP.ResponseCode = 422 then
            begin
              ResponseContent := E.ErrorMessage;
            end
            else
              raise PanamahSDKHTTPProtocolException.Create(E.Message);
          end;
          on E: EIdSocketError do
          begin
            raise PanamahSDKConnectionRefusedException.Create(E.Message);
          end;
        end;
      finally
        FreeAndNil(HTTPRequest);
      end;
    finally
      HTTPIOHandler.Free;
    end;
    Result := TResponse.Create(HTTP.ResponseCode, HTTP.Response.RawHeaders, ResponseContent);
  finally
    FreeAndNil(HTTP);
  end;
end;

constructor TPanamahClient.Create(const ABaseURL: string);
begin
  inherited Create;
  FBaseURL := ABaseURL;
end;

{ TSDKIdHTTP }

function TPanamahSDKIdHTTP.Delete(const AURL: string): string;
var
  Stream: TMemoryStream;
begin
  Result := EmptyStr;
  Stream := TMemoryStream.Create;
  try
    DoRequest(DELETE_HTTP_METHOD, AURL, nil, Stream, []);
    Stream.Position := 0;
    if Stream.Size > 0 then
    begin
      SetString(Result, PAnsiChar(Stream.Memory^), Stream.Size);
    end;
  finally
    FreeAndNil(Stream);
  end;
end;

function TPanamahSDKIdHTTP.Delete(const AURL: string; AResponseContent: TStream): string;
begin
  DoRequest(DELETE_HTTP_METHOD, AURL, nil, AResponseContent, []);
end;

{ TRequest }

constructor TPanamahRequest.Create(AURL: string; AMethod: TMethod; AParams, AHeaders: TStrings; AContent: string; const ATokens: TPanamahTokenStorage);
begin
  FOwnedObjects := TStringList.Create;
  SetTokens(ATokens);
  SetURL(AURL);
  SetMethod(AMethod);
  SetParams(AParams);
  SetHeaders(AHeaders);
  SetContent(AContent);
end;

destructor TPanamahRequest.Destroy;
var
  I: Integer;
begin
  for I := 0 to FOwnedObjects.Count - 1 do
    FOwnedObjects.Objects[I].Free;
  FOwnedObjects.Free;
  if Assigned(FTokens) then
    FTokens.Free;
  inherited;
end;

function TPanamahRequest.GetContent: string;
begin
  Result := FContent;
end;

function TPanamahRequest.GetHeaders: TStrings;
begin
  Result := FHeaders;
end;

function TPanamahRequest.GetMethod: TMethod;
begin
  Result := FMethod;
end;

function TPanamahRequest.GetParams: TStrings;
begin
  Result := FParams;
end;

function TPanamahRequest.GetURL: string;
begin
  Result := FURL;
end;

procedure TPanamahRequest.SetAuthorizationHeaders;
begin
  if Assigned(FTokens) then
  begin
    if not Assigned(FHeaders) then
    begin
      FHeaders := TStringList.Create;
      FHeaders.NameValueSeparator := ':';
      FOwnedObjects.AddObject('Headers', FHeaders);
    end;
    begin
      if FHeaders.IndexOf('authorization') = -1 then
        FHeaders.Values['authorization'] := FTokens.AccessToken;
    end;
  end;
end;

procedure TPanamahRequest.SetContent(const AContent: string);
begin
  inherited;
  FContent := AContent;
end;

procedure TPanamahRequest.SetHeaders(AHeaders: TStrings);
begin
  inherited;
  FHeaders := AHeaders;
  SetAuthorizationHeaders;
end;

procedure TPanamahRequest.SetMethod(AMethod: TMethod);
begin
  inherited;
  FMethod := AMethod;
end;

procedure TPanamahRequest.SetParams(AParams: TStrings);
begin
  inherited;
  FParams := AParams;
end;

procedure TPanamahRequest.SetTokens(const ATokens: TPanamahTokenStorage);
begin
  if Assigned(ATokens) then
    FTokens := ATokens.Clone;
end;

procedure TPanamahRequest.SetURL(const AURL: string);
begin
  FURL := AURL;
end;

{ TResponse }

constructor TResponse.Create(AStatus: Integer; const AHeaders: TStrings; AContent: string);
begin
  FHeaders := TStringList.Create;
  FHeaders.AddStrings(AHeaders);
  FHeaders.NameValueSeparator := ':';
  SetStatus(AStatus);
  SetContent(AContent);
end;

destructor TResponse.Destroy;
begin
  FHeaders.Free;
  inherited;
end;

function TResponse.GetContent: string;
begin
  Result := FContent;
end;

function TResponse.GetHeaders: TStrings;
begin
  Result := FHeaders;
end;

function TResponse.GetStatus: Integer;
begin
  Result := FStatus;
end;

procedure TResponse.SetContent(const Value: string);
begin
  FContent := Value;
end;

procedure TResponse.SetHeaders(Value: TStrings);
begin
  FHeaders := Value;
end;

procedure TResponse.SetStatus(Value: Integer);
begin
  FStatus := Value;
end;

{ TTokenStorage }

function TPanamahTokenStorage.Clone: TPanamahTokenStorage;
begin
  Result := TPanamahTokenStorage.Create;
  Result.AccessToken := FAccessToken;
  Result.RefreshToken := FRefreshToken;
end;

class function TPanamahTokenStorage.From(const AResponse: IPanamahResponse): TPanamahTokenStorage;
var
  JsonObject: TlkJSONobject;
begin
  JsonObject := TlkJSON.ParseText(AResponse.Content) as TlkJSONobject;
  try
    Result := TPanamahTokenStorage.Create;
    Result.AccessToken := JsonObject.Field['accessToken'].Value;
    Result.RefreshToken := JsonObject.Field['refreshToken'].Value;
  finally
    JsonObject.Free;
  end;
end;

end.
