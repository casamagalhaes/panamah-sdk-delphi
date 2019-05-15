unit PanamahSDK.Client;

interface

uses
  SysUtils, StrUtils, Classes,
  {$IFDEF UNICODE}
  IdHTTP, IdSSLOpenSSL, IdSSLOpenSSLHeaders, IdCTypes, IdStack,
  {$ELSE}
  ssl_openssl, ssl_openssl_lib, httpsend, blcksock, synautil,    
  {$ENDIF}
  PanamahSDK.Types, PanamahSDK.Consts, uLkJSON, PanamahSDK.JsonUtils, EncdDecd, DateUtils;

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
    function MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse;
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
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

  TPanamahResponse = class(TInterfacedObject, IPanamahResponse)
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

  {$IFDEF UNICODE}
  TPanamahSDKIdHTTP = class(TIdCustomHTTP)
  public
    constructor Create(AOwner: TComponent);
    procedure OnStatusInfoEx(ASender: TObject; const ASslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType, AMsg: String);
    function Delete(const AURL: string; AResponseContent: TStream): string; overload;
    function Delete(const AURL: string): string; overload;
  end;
  {$ENDIF}

  TPanamahClient = class(TInterfacedObject, IPanamahClient)
  protected
    FBaseUrl: string;
  public
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; virtual;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; virtual;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; virtual;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; virtual;
    function MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse; virtual;
    constructor Create(const ABaseURL: string); virtual;
  end;

  TPanamahAdminClient = class(TPanamahClient)
  private
    FAuthorizationToken: string;
  public
    constructor Create(const ABaseURL: string; const AAuthorizationToken: string); reintroduce;
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; override;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; override;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; override;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; override;
  end;

  TPanamahStreamClient = class(TPanamahClient)
  private
    FTokens: TPanamahTokenStorage;
    FAssinanteId: string;
    FSecret: string;
    FAuthorizationToken: string;
    function CalculateKey(const AAssinanteId, ASecret: string; ATimestamp: TDateTime): string;
  public
    procedure SetCredentials(const AAuthorizationToken, ASecret, AAssinanteId: string);
    function Authenticate(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ARequestFunction: TPanamahAuthenticatedRequest): IPanamahResponse;
    function AuthenticatedGet(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedPut(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedPost(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function AuthenticatedDelete(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
    function Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; override;
    function Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; override;
    function Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse; override;
    function Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse; override;
    constructor Create(const ABaseURL, AAuthorizationToken, ASecret, AAssinanteId: string); reintroduce;
    destructor Destroy; override;
  end;

const
  DELETE_HTTP_METHOD = 'DELETE';

implementation

{ TPanamahClient }

uses PanamahSDK.Crypto;

{$IFDEF UNICODE}
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
      HTTPIOHandler.OnStatusInfoEx := HTTP.OnStatusInfoEx;
      HTTPIOHandler.SSLOptions.Method := sslvSSLv23;
      HTTPIOHandler.SSLOptions.SSLVersions := [sslvTLSv1_2, sslvTLSv1_1, sslvTLSv1];
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
              ResponseContent := HTTP.Get(ARequest.URL);
            end;
            mtPOST:
            begin
              RequestContent := TStringStream.Create(ARequest.Content);
              try
                ResponseContent := HTTP.Post(ARequest.URL, RequestContent);
              finally
                FreeAndNil(RequestContent);
              end;
            end;
            mtPUT:
            begin
              RequestContent := TStringStream.Create(ARequest.Content);
              try
                ResponseContent := HTTP.Put(ARequest.URL, RequestContent);
              finally
                FreeAndNil(RequestContent);
              end;
            end;
            mtDELETE:
            begin
              ResponseContent := HTTP.Delete(ARequest.URL);
            end;
          end;
        except
          on E: EIdHTTPProtocolException do
          begin
            if HTTP.ResponseCode = 500 then
              raise EPanamahSDKServerInternalException.Create(E.Message)
            else
            if HTTP.ResponseCode = 400 then
              raise EPanamahSDKBadRequestException.Create(E.Message)
            else
            if HTTP.ResponseCode = 404 then
            else
            if HTTP.ResponseCode = 422 then
            begin
              ResponseContent := E.ErrorMessage;
            end
            else
              raise EPanamahSDKHTTPProtocolException.Create(E.Message);
          end;
          on E: EIdSocketError do
          begin
            raise EPanamahSDKConnectionRefusedException.Create(E.Message);
          end;
        end;
      finally
        FreeAndNil(HTTPRequest);
      end;
    finally
      HTTPIOHandler.Free;
    end;
    Result := TPanamahResponse.Create(HTTP.ResponseCode, HTTP.Response.RawHeaders, ResponseContent);
  finally
    FreeAndNil(HTTP);
  end;
end;
{$ELSE}
function TPanamahClient.MakeRequest(const ARequest: IPanamahRequest): IPanamahResponse;

  function GetDocumentContent(HTTPClient: THttpSend): string;
  var
    ResponseDocument: TStrings;
  begin
    Result := EmptyStr;
    if Assigned(HTTPClient) and Assigned(HTTPClient.Document) and (HTTPClient.Document.Size > 0) then
    begin
      HTTPClient.Document.Position := 0;
      ResponseDocument := TStringList.Create;
      try
        ResponseDocument.LoadFromStream(HTTPClient.Document);
        Result := ResponseDocument.Text;
      finally
        ResponseDocument.Free;
      end;
    end;
  end;

  function GetMethodAsString(AMethod: TMethod): string;
  begin
    Result := EmptyStr;
    case AMethod of
      mtGET: Result := 'GET';
      mtPUT: Result := 'PUT';
      mtDELETE: Result := 'DELETE';
      mtPOST: Result := 'POST';
    end;
  end;

  function CreateRequestHeaders(ARequest: IPanamahRequest): TStrings;
  var
    I: Integer;
  begin
    Result := TStringList.Create;
    Result.NameValueSeparator := ':';
    Result.Values['Content-Type'] := 'application/json';
    Result.Values['Accept'] := 'application/json';
    if Assigned(ARequest.Headers) then
    begin
      for I := 0 to ARequest.Headers.Count - 1 do
        Result.Values[ARequest.Headers.Names[I]] := ARequest.Headers.Values[ARequest.Headers.Names[I]];
    end;
  end;

var
  HTTPClient: THttpSend;
  RequestHeaders: TStrings;
  Response: IPanamahResponse;
begin
  Result := nil;
  HTTPClient := THttpSend.Create;
  HTTPClient.Protocol := '1.1';
  try
    HTTPClient.Timeout := 60000;
    RequestHeaders := CreateRequestHeaders(ARequest);
    try
      HTTPClient.Headers.AddStrings(RequestHeaders);
    finally
        RequestHeaders.Free;
    end;
    if ARequest.Content <> EmptyStr then
      HTTPClient.Document.Write(Pointer(ARequest.Content)^, Length(ARequest.Content));
    HTTPClient.MimeType := CoalesceText(HTTPClient.Headers.Values['Content-Type'], 'application/json');
    HTTPClient.HTTPMethod(GetMethodAsString(ARequest.Method), ARequest.URL);    
    Response := TPanamahResponse.Create(HTTPClient.ResultCode, HTTPClient.Headers, GetDocumentContent(HTTPClient));
    case Response.Status of
      500: raise EPanamahSDKServerInternalException.Create(Response.Content);
      400: raise EPanamahSDKBadRequestException.Create(Response.Content);
      else
      begin
        if HTTPClient.Sock.LastError > 0 then
        begin
          case HTTPClient.Sock.LastError of
            10061: raise EPanamahSDKConnectionRefusedException.Create(Response.Content);
            else
              raise EPanamahSDKHTTPProtocolException.Create(Response.Content);
          end;
        end
        else
          Result := Response; 
      end;
    end;
  finally
    HTTPClient.Free;
  end;
end;
{$ENDIF}

constructor TPanamahClient.Create(const ABaseURL: string);
begin
  inherited Create;
  FBaseUrl := ABaseUrl;
end;

function TPanamahClient.Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtDELETE, AParams, AHeaders, EmptyStr, nil);
  Result := MakeRequest(Request);
end;

function TPanamahClient.Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtGET, AParams, AHeaders, EmptyStr, nil);
  Result := MakeRequest(Request);
end;

function TPanamahClient.Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPOST, nil, AHeaders, AContent, nil);
  Result := MakeRequest(Request);
end;

function TPanamahClient.Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPUT, nil, AHeaders, AContent, nil);
  Result := MakeRequest(Request);
end;

{ TPanamahStreamClient }

function TPanamahStreamClient.CalculateKey(const AAssinanteId, ASecret: string; ATimestamp: TDateTime): string;
begin
  Result := SHA1Base64(ASecret + AAssinanteId + IntToStr(DateTimeToUnix(ATimestamp)));
end;

constructor TPanamahStreamClient.Create(const ABaseURL, AAuthorizationToken, ASecret, AAssinanteId: string);
begin
  inherited Create(ABaseURL);
  SetCredentials(AAuthorizationToken, ASecret, AAssinanteId);
end;

function TPanamahStreamClient.Authenticate(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ARequestFunction: TPanamahAuthenticatedRequest): IPanamahResponse;
var
  AuthRequest: IPanamahRequest;
  AuthResponse: IPanamahResponse;
  AuthHeaders: TStrings;
  RefreshRequest: IPanamahRequest;
  RefreshResponse: IPanamahResponse;
  RefreshHeaders: TStrings;
  Timestamp: TDateTime;
begin
  if Assigned(FTokens) then
  begin
    Result := ARequestFunction(AURL, AParams, AHeaders, AContent, FTokens);
    if (Result.Status = 403) then
    begin
      RefreshHeaders := TStringList.Create;
      try
        RefreshHeaders.Values['Accept'] := 'application/json';
        RefreshHeaders.Values['Authorization'] := FTokens.RefreshToken;
        RefreshRequest := TPanamahRequest.Create(Concat(FBaseURL, '/stream/auth/refresh'), mtGET, nil, RefreshHeaders, Format('{"accessToken":"%s"}', [FTokens.AccessToken]));
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
      AuthHeaders.Values['Authorization'] := FAuthorizationToken;
      Timestamp := NowUTC;
      AuthRequest := TPanamahRequest.Create(Concat(FBaseURL, '/stream/auth'), mtPOST, nil, AuthHeaders, Format('{"assinanteId":"%s","key":"%s","ts":"%d"}', [
        FAssinanteId,
        CalculateKey(FAssinanteId, FSecret, Timestamp),
        DateTimeToUnix(Timestamp)
      ]));
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

function TPanamahStreamClient.Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, AParams, AHeaders, EmptyStr, AuthenticatedDelete);
end;

destructor TPanamahStreamClient.Destroy;
begin
  if Assigned(FTokens) then
    FreeAndNil(FTokens);
  inherited;
end;

function TPanamahStreamClient.AuthenticatedDelete(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtDELETE, AParams, AHeaders, EmptyStr, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahStreamClient.AuthenticatedGet(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtGET, AParams, AHeaders, EmptyStr, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahStreamClient.AuthenticatedPost(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPOST, nil, nil, AContent, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahStreamClient.AuthenticatedPut(const AURL: string; AParams, AHeaders: TStrings; AContent: string; ATokens: TPanamahTokenStorage): IPanamahResponse;
var
  Request: IPanamahRequest;
begin
  Request := TPanamahRequest.Create(Concat(FBaseURL, AURL), mtPUT, nil, nil, AContent, ATokens);
  Result := MakeRequest(Request);
end;

function TPanamahStreamClient.Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, AParams, AHeaders, EmptyStr, AuthenticatedGet);
end;

function TPanamahStreamClient.Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, nil, nil, AContent, AuthenticatedPost);
end;

function TPanamahStreamClient.Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
begin
  Result := Authenticate(AURL, nil, nil, AContent, AuthenticatedPut);
end;

procedure TPanamahStreamClient.SetCredentials(const AAuthorizationToken, ASecret, AAssinanteId: string);
begin
  FAuthorizationToken := AAuthorizationToken;
  FAssinanteId := AAssinanteId;
  FSecret := ASecret;
end;

{$IFDEF UNICODE}
{ TPanamahSDKIdHTTP }

constructor TPanamahSDKIdHTTP.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TPanamahSDKIdHTTP.OnStatusInfoEx(ASender: TObject; const ASslSocket: PSSL; const AWhere, Aret: TIdC_INT;
  const AType, AMsg: String);
begin
  SSL_set_tlsext_host_name(AsslSocket, Request.Host);
end;

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
{$ENDIF}

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

constructor TPanamahResponse.Create(AStatus: Integer; const AHeaders: TStrings; AContent: string);
begin
  FHeaders := TStringList.Create;
  if Assigned(AHeaders) then
    FHeaders.AddStrings(AHeaders);
  FHeaders.NameValueSeparator := ':';
  SetStatus(AStatus);
  SetContent(AContent);
end;

destructor TPanamahResponse.Destroy;
begin
  FHeaders.Free;
  inherited;
end;

function TPanamahResponse.GetContent: string;
begin
  Result := FContent;
end;

function TPanamahResponse.GetHeaders: TStrings;
begin
  Result := FHeaders;
end;

function TPanamahResponse.GetStatus: Integer;
begin
  Result := FStatus;
end;

procedure TPanamahResponse.SetContent(const Value: string);
begin
  FContent := Value;
end;

procedure TPanamahResponse.SetHeaders(Value: TStrings);
begin
  FHeaders := Value;
end;

procedure TPanamahResponse.SetStatus(Value: Integer);
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

{ TPanamahAdminClient }

constructor TPanamahAdminClient.Create(const ABaseURL, AAuthorizationToken: string);
begin
  inherited Create(ABaseURL);
  FAuthorizationToken := AAuthorizationToken;
end;

function TPanamahAdminClient.Delete(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
var
  Headers: TStrings;
begin
  Headers := TStringList.Create;
  try
    if Assigned(AHeaders) then
      Headers.AddStrings(AHeaders);
    Headers.Values['Authorization'] := FAuthorizationToken;
    Result := inherited Delete(AURL, AParams, Headers);
  finally
    Headers.Free;
  end;
end;

function TPanamahAdminClient.Get(const AURL: string; AParams, AHeaders: TStrings): IPanamahResponse;
var
  Headers: TStrings;
begin
  Headers := TStringList.Create;
  try
    if Assigned(AHeaders) then
      Headers.AddStrings(AHeaders);
    Headers.Values['Authorization'] := FAuthorizationToken;
    Result := inherited Get(AURL, AParams, Headers);
  finally
    Headers.Free;
  end;
end;

function TPanamahAdminClient.Post(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
var
  Headers: TStrings;
begin
  Headers := TStringList.Create;
  try
    if Assigned(AHeaders) then
      Headers.AddStrings(AHeaders);
    Headers.Values['Authorization'] := FAuthorizationToken;
    Result := inherited Post(AURL, AContent, Headers);
  finally
    Headers.Free;
  end;
end;

function TPanamahAdminClient.Put(const AURL, AContent: string; AHeaders: TStrings): IPanamahResponse;
var
  Headers: TStrings;
begin
  Headers := TStringList.Create;
  try
    if Assigned(AHeaders) then
      Headers.AddStrings(AHeaders);
    Headers.Values['Authorization'] := FAuthorizationToken;
    Result := inherited Put(AURL, AContent, Headers);
  finally
    Headers.Free;
  end;
end;

end.
