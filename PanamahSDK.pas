{$M+}
unit PanamahSDK;

interface

uses
  Classes, SysUtils, PanamahSDK.Client;

type

  IPanamahSDKConfig = interface
    ['{F5D4BA5C-5DF8-480A-9408-6EA0F41EEA0A}']
    function GetApiKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    procedure SetApiKey(const AApiKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetBatchTTL(const ABatchTTL: Integer);
    property ApiKey: string read GetApiKey write SetApiKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL write SetBatchTTL;
  end;

  TPanamahSDKConfig = class(TInterfacedObject, IPanamahSDKConfig)
  private
    FApiKey: string;
    FBaseDirectory: string;
    FBatchTTL: Integer;
    function GetApiKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    procedure SetApiKey(const AApiKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetBatchTTL(const ABatchTTL: Integer);
  published
    constructor Create; reintroduce;
    property ApiKey: string read GetApiKey write SetApiKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL write SetBatchTTL;
  end;

  TPanamahSDK = class
  private
    FConfig: IPanamahSDKConfig;
    FClient: IClient;
  public
    class procedure Free;
    procedure Configure; overload;
    procedure Configure(AConfig: IPanamahSDKConfig); overload;
    constructor Create; reintroduce;
  published
    class function GetInstance: TPanamahSDK;
  end;

  var _PanamahSDKInstance: TPanamahSDK;

implementation

{ TPanamahSDK }

procedure TPanamahSDK.Configure(AConfig: IPanamahSDKConfig);
begin
  FConfig := AConfig;
  FClient.SetApiKey(FConfig.ApiKey);
end;

procedure TPanamahSDK.Configure;
var
  Config: IPanamahSDKConfig;
begin
  Config := TPanamahSDKConfig.Create;
  Config.ApiKey := GetEnvironmentVariable('PANAMAH_API_KEY');
  Configure(Config);
end;

constructor TPanamahSDK.Create;
begin
  inherited;
  FClient := TClient.Create('/v2/gateway/data', GetEnvironmentVariable('PANAMAH_API_KEY'));
end;

class procedure TPanamahSDK.Free;
begin
  if Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance.Free;
end;

class function TPanamahSDK.GetInstance: TPanamahSDK;
begin
  if not Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance := TPanamahSDK.Create;
  Result := _PanamahSDKInstance;
end;

{ TPanamahSDKConfig }

constructor TPanamahSDKConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
end;

function TPanamahSDKConfig.GetApiKey: string;
begin
  Result := FApiKey;
end;

function TPanamahSDKConfig.GetBaseDirectory: string;
begin
  Result := FBaseDirectory;
end;

function TPanamahSDKConfig.GetBatchTTL: Integer;
begin
  Result := FBatchTTL;
end;

procedure TPanamahSDKConfig.SetApiKey(const AApiKey: string);
begin
  FApiKey := AApiKey;
end;

procedure TPanamahSDKConfig.SetBaseDirectory(const ABaseDirectory: string);
begin
  FBaseDirectory := ABaseDirectory;
end;

procedure TPanamahSDKConfig.SetBatchTTL(const ABatchTTL: Integer);
begin
  FBatchTTL := ABatchTTL;
end;

initialization
  TPanamahSDK.GetInstance;
  
finalization
  TPanamahSDK.Free;

end.
