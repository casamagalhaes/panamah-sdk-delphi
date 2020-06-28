{$M+}
unit PanamahSDK;

interface

uses
  Classes, Windows, SysUtils, Messages, DateUtils, SyncObjs, PanamahSDK.Enums, PanamahSDK.Operation, PanamahSDK.Types,
  PanamahSDK.Client, PanamahSDK.Batch, PanamahSDK.Models.Acesso, PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente,
  PanamahSDK.Models.Compra, PanamahSDK.Models.Ean, PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa,
  PanamahSDK.Models.FormaPagamento, PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario,
  PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding, PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Meta, PanamahSDK.Models.Produto, PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao,
  PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar, PanamahSDK.Models.TituloReceber,
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda, PanamahSDK.Processor,
  PanamahSDK.NFe, PanamahSDK.Consts, PanamahSDK.PendingResources;

type

  TPanamahStreamConfig = class(TInterfacedObject, IPanamahStreamConfig)
  private
    FAssinanteId: string;
    FSecret: string;
    FAuthorizationToken: string;
    FBaseDirectory: string;
    FBatchTTL: Integer;
    FBatchMaxSize: Integer;
    FBatchMaxCount: Integer;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    function GetAssinanteId: string;
    function GetSecret: string;
    function GetAuthorizationToken: string;
    procedure SetAuthorizationToken(const AAuthorizationToken: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetAssinanteId(const AAssinanteId: string);
    procedure SetSecret(const ASecret: string);
  published
    constructor Create; reintroduce;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
    property AssinanteId: string read GetAssinanteId write SetAssinanteId;
    property Secret: string read GetSecret write SetSecret;
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
  end;

  TPanamahAdminConfig = class(TInterfacedObject, IPanamahAdminConfig)
  private
    FAuthorizationToken: string;
    function GetAuthorizationToken: string;
    procedure SetAuthorizationToken(const AAuthorizationToken: string);
  published
    constructor Create; reintroduce;
    property AuthorizationToken: string read GetAuthorizationToken write SetAuthorizationToken;
  end;

  TPanamahAdmin = class
  private
    FConfig: IPanamahAdminConfig;
    FClient: IPanamahClient;
  public
    procedure Init(AConfig: IPanamahAdminConfig); overload;
    procedure Init(const AAuthorizationToken: string); overload;
    function GetAssinante(const AAssinanteId: string): IPanamahAssinante;
    function SaveAssinante(AAssinante: IPanamahAssinante): Boolean;
    constructor Create; reintroduce;
    class function GetInstance: TPanamahAdmin;
    class procedure Free;
  end;

  TPanamahStream = class
  private
    FConfig: IPanamahStreamConfig;
    FProcessor: TPanamahBatchProcessor;
    function GetOnCurrentBatchExpired: TPanamahBatchEvent;
    function GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    function GetOnBeforeOperationtSent: TPanamahOperationEvent;
    function GetOnBeforeBatchSent: TPanamahBatchEvent;
    function GetOnBeforeSave: TPanamahCancelableModelEvent;
    function GetOnBeforeDelete: TPanamahCancelableModelEvent;
    function GetOnError: TPanamahErrorEvent;
    function GetOnAfterSave: TPanamahModelEvent;
    function GetOnAfterDelete: TPanamahModelEvent;
    function GetOnAfterSaveSync: TPanamahModelEvent;
    function GetOnAfterDeleteSync: TPanamahModelEvent;

    procedure SetOnBeforeSave(AEvent: TPanamahCancelableModelEvent);
    procedure SetOnBeforeDelete(AEvent: TPanamahCancelableModelEvent);
    procedure SetOnError(AEvent: TPanamahErrorEvent);
    procedure SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
    procedure SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
    procedure SetOnAfterSave(AEvent: TPanamahModelEvent);
    procedure SetOnAfterDelete(AEvent: TPanamahModelEvent);
    procedure SetOnAfterSaveSync(AEvent: TPanamahModelEvent);
    procedure SetOnAfterDeleteSync(AEvent: TPanamahModelEvent);
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    class procedure Free;
    class function GetInstance: TPanamahStream;
    function GetPendingResources: IPanamahPendingResourcesList;
    procedure Init; overload;
    procedure Init(AConfig: IPanamahStreamConfig); overload;
    procedure Init(const AAuthorizationToken, ASecret: string); overload;
    procedure Init(const AAuthorizationToken, ASecret, AAssinanteId: string); overload;
    procedure Flush;

    function ReadNFeDirectory(const ADirectory: string): IPanamahNFeDocumentList; overload;
    function ReadNFe(const AFilename: string): IPanamahNFeDocument; overload;
    function ReadNFe(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument; overload;
    procedure SaveNFe(ANFeDocumentList: IPanamahNFeDocumentList; AAssinanteId: Variant); overload;
    procedure SaveNFe(ANFeDocument: IPanamahNFeDocument; AAssinanteId: Variant); overload;
    procedure SaveNFe(ANFeDocumentList: IPanamahNFeDocumentList); overload;
    procedure SaveNFe(ANFeDocument: IPanamahNFeDocument); overload;

    procedure Save(APanamahModel: IPanamahModel; AAssinanteId: Variant); overload;
    procedure Save(APanamahModel: IPanamahModel); overload;
    procedure Delete(APanamahModel: IPanamahModel; AAssinanteId: Variant); overload;
    procedure Delete(APanamahModel: IPanamahModel); overload;

    property OnCurrentBatchExpired: TPanamahBatchEvent read GetOnCurrentBatchExpired write SetOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read GetOnBeforeObjectAddedToBatch write SetOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read GetOnBeforeBatchSent write SetOnBeforeBatchSent;
    property OnBeforeOperationSent: TPanamahOperationEvent read GetOnBeforeOperationtSent write SetOnBeforeOperationSent;
    property OnBeforeSave: TPanamahCancelableModelEvent read GetOnBeforeSave write SetOnBeforeSave;
    property OnBeforeDelete: TPanamahCancelableModelEvent read GetOnBeforeDelete write SetOnBeforeDelete;
    property OnError: TPanamahErrorEvent read GetOnError write SetOnError;
    property OnAfterSave: TPanamahModelEvent read GetOnAfterSave write SetOnAfterSave;
    property OnAfterDelete: TPanamahModelEvent read GetOnAfterDelete write SetOnAfterDelete;
    property OnAfterSaveSync: TPanamahModelEvent read GetOnAfterSaveSync write SetOnAfterSaveSync;
    property OnAfterDeleteSync: TPanamahModelEvent read GetOnAfterDeleteSync write SetOnAfterDeleteSync;
  end;

var
  _PanamahStreamInstance: TPanamahStream;
  _PanamahAdminInstance: TPanamahAdmin;

implementation

uses
  PanamahSDK.ValidationUtils, PanamahSDK.Log;

{ TPanamahStream }

procedure TPanamahStream.Init(AConfig: IPanamahStreamConfig);
begin
  FConfig := AConfig;
  if not {$IFDEF UNICODE}FProcessor.Started{$ELSE}not FProcessor.Suspended{$ENDIF} then
    FProcessor.Start(FConfig);
end;

procedure TPanamahStream.Init(const AAuthorizationToken, ASecret, AAssinanteId: string);
var
  Config: IPanamahStreamConfig;
begin
  TPanamahLogger.Log('PanamahStream init');
  Config := TPanamahStreamConfig.Create;
  Config.AssinanteId := AAssinanteId;
  Config.Secret := ASecret;
  Config.AuthorizationToken := AAuthorizationToken;
  Init(Config);
end;

procedure TPanamahStream.Init(const AAuthorizationToken, ASecret: string);
begin
  Init(AAuthorizationToken, ASecret, '*');
end;

function TPanamahStream.ReadNFe(ADocumentType: TPanamahNFeDocumentType; const AFilename: string): IPanamahNFeDocument;
begin
  Result := TPanamahNFeDocument.FromFile(ADocumentType, AFilename);
end;

function TPanamahStream.ReadNFeDirectory(const ADirectory: string): IPanamahNFeDocumentList;
begin
  Result := TPanamahNFeDocumentList.Create;
  Result.LoadFromDirectory(ADirectory);
end;

function TPanamahStream.ReadNFe(const AFilename: string): IPanamahNFeDocument;
begin
  Result := ReadNFe(ndtDESCONHECIDO, AFilename);
end;

procedure TPanamahStream.SaveNFe(ANFeDocumentList: IPanamahNFeDocumentList; AAssinanteId: Variant);
var
  I: Integer;
begin
  for I := 0 to ANFeDocumentList.Count - 1 do
    SaveNFe(ANFeDocumentList[I], AAssinanteId);
end;

procedure TPanamahStream.SaveNFe(ANFeDocument: IPanamahNFeDocument; AAssinanteId: Variant);
var
  I: Integer;
begin
  for I := 0 to ANFeDocument.Count - 1 do
    FProcessor.Save(ANFeDocument[I], AAssinanteId);
end;

procedure TPanamahStream.SaveNFe(ANFeDocument: IPanamahNFeDocument);
begin
  SaveNFe(ANFeDocument, FConfig.AssinanteId);
end;

procedure TPanamahStream.SaveNFe(ANFeDocumentList: IPanamahNFeDocumentList);
begin
  SaveNFe(ANFeDocumentList, FConfig.AssinanteId);
end;

procedure TPanamahStream.Init;
begin
  Init(GetEnvironmentVariable('PANAMAH_AUTHORIZATION_TOKEN'), GetEnvironmentVariable('PANAMAH_ASSINANTE_ID'), GetEnvironmentVariable('PANAMAH_SECRET'));
end;

procedure TPanamahStream.SetOnAfterDelete(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnAfterDelete := AEvent;
end;

procedure TPanamahStream.SetOnAfterDeleteSync(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnAfterDeleteSync := AEvent;
end;

procedure TPanamahStream.SetOnAfterSave(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnAfterSave := AEvent;
end;

procedure TPanamahStream.SetOnAfterSaveSync(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnAfterSaveSync := AEvent;
end;

procedure TPanamahStream.SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnBeforeBatchSent := AEvent;
end;

procedure TPanamahStream.SetOnBeforeDelete(
  AEvent: TPanamahCancelableModelEvent);
begin
  FProcessor.OnBeforeDelete := AEvent;
end;

procedure TPanamahStream.SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnBeforeObjectAddedToBatch := AEvent;
end;

procedure TPanamahStream.SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
begin
  FProcessor.OnBeforeOperationSent := AEvent;
end;

procedure TPanamahStream.SetOnBeforeSave(AEvent: TPanamahCancelableModelEvent);
begin
  FProcessor.OnBeforeSave := AEvent;
end;

procedure TPanamahStream.SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnCurrentBatchExpired := AEvent;
end;

procedure TPanamahStream.SetOnError(AEvent: TPanamahErrorEvent);
begin
  FProcessor.OnError := AEvent;
end;

procedure TPanamahStream.Save(APanamahModel: IPanamahModel; AAssinanteId: Variant);
begin
  FProcessor.Save(APanamahModel, AAssinanteId);
end;

procedure TPanamahStream.Save(APanamahModel: IPanamahModel);
begin
  Save(APanamahModel, FConfig.AssinanteId);
end;

procedure TPanamahStream.Delete(APanamahModel: IPanamahModel; AAssinanteId: Variant);
begin
  FProcessor.Delete(APanamahModel, AAssinanteId);
end;

procedure TPanamahStream.Delete(APanamahModel: IPanamahModel);
begin
  Delete(APanamahModel, FConfig.AssinanteId);
end;

constructor TPanamahStream.Create;
begin
  inherited;
  FProcessor := TPanamahBatchProcessor.Create;
end;

destructor TPanamahStream.Destroy;
begin
  FProcessor.Stop;
  FProcessor.Free;
  inherited;
end;

procedure TPanamahStream.Flush;
begin
  FProcessor.Flush;
end;

class procedure TPanamahStream.Free;
begin
  if Assigned(_PanamahStreamInstance) then
    _PanamahStreamInstance.Destroy;
end;

class function TPanamahStream.GetInstance: TPanamahStream;
begin
  if not Assigned(_PanamahStreamInstance) then
    _PanamahStreamInstance := TPanamahStream.Create;
  Result := _PanamahStreamInstance;
end;

function TPanamahStream.GetOnAfterDelete: TPanamahModelEvent;
begin
  Result := FProcessor.OnAfterDelete;
end;

function TPanamahStream.GetOnAfterDeleteSync: TPanamahModelEvent;
begin
  Result := FProcessor.OnAfterDeleteSync;
end;

function TPanamahStream.GetOnAfterSave: TPanamahModelEvent;
begin
  Result := FProcessor.OnAfterSave;
end;

function TPanamahStream.GetOnAfterSaveSync: TPanamahModelEvent;
begin
  Result := FProcessor.OnAfterSaveSync;
end;

function TPanamahStream.GetOnBeforeBatchSent: TPanamahBatchEvent;
begin
  Result := FProcessor.OnBeforeBatchSent;
end;

function TPanamahStream.GetOnBeforeDelete: TPanamahCancelableModelEvent;
begin
  Result := FProcessor.OnBeforeDelete;
end;

function TPanamahStream.GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
begin
  Result := FProcessor.OnBeforeObjectAddedToBatch;
end;

function TPanamahStream.GetOnBeforeOperationtSent: TPanamahOperationEvent;
begin
  Result := FProcessor.OnBeforeOperationSent;
end;

function TPanamahStream.GetOnBeforeSave: TPanamahCancelableModelEvent;
begin
  Result := FProcessor.OnBeforeSave;
end;

function TPanamahStream.GetOnCurrentBatchExpired: TPanamahBatchEvent;
begin
  Result := FProcessor.OnCurrentBatchExpired;
end;

function TPanamahStream.GetOnError: TPanamahErrorEvent;
begin
  Result := FProcessor.OnError;
end;

function TPanamahStream.GetPendingResources: IPanamahPendingResourcesList;
begin
  Result := FProcessor.GetPendingResources;
end;

{ TPanamahSDKConfig }

constructor TPanamahStreamConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
  FBatchMaxSize := 3 * 1024;
  FBatchMaxCount := 300;
  FBaseDirectory := GetCurrentDir + '\.panamah';
end;

function TPanamahStreamConfig.GetAssinanteId: string;
begin
  Result := FAssinanteId;
end;

function TPanamahStreamConfig.GetAuthorizationToken: string;
begin
  Result := FAuthorizationToken;
end;

function TPanamahStreamConfig.GetBaseDirectory: string;
begin
  Result := FBaseDirectory;
end;

function TPanamahStreamConfig.GetBatchMaxCount: Integer;
begin
  Result := FBatchMaxCount;
end;

function TPanamahStreamConfig.GetBatchMaxSize: Integer;
begin
  Result := FBatchMaxSize;
end;

function TPanamahStreamConfig.GetBatchTTL: Integer;
begin
  Result := FBatchTTL;
end;

function TPanamahStreamConfig.GetSecret: string;
begin
  Result := FSecret;
end;

procedure TPanamahStreamConfig.SetBaseDirectory(const ABaseDirectory: string);
begin
  FBaseDirectory := ABaseDirectory;
end;

procedure TPanamahStreamConfig.SetSecret(const ASecret: string);
begin
  FSecret := ASecret;
end;

procedure TPanamahStreamConfig.SetAssinanteId(const AAssinanteId: string);
begin
  FAssinanteId := AAssinanteId;
end;

procedure TPanamahStreamConfig.SetAuthorizationToken(const AAuthorizationToken: string);
begin
  FAuthorizationToken := AAuthorizationToken;
end;

{ TPanamahAdminConfig }

constructor TPanamahAdminConfig.Create;
begin
  inherited Create;
end;

function TPanamahAdminConfig.GetAuthorizationToken: string;
begin
  Result := FAuthorizationToken;
end;

procedure TPanamahAdminConfig.SetAuthorizationToken(const AAuthorizationToken: string);
begin
  FAuthorizationToken := AAuthorizationToken;
end;

{ TPanamahAdmin }

constructor TPanamahAdmin.Create;
begin
  inherited Create;
end;

class procedure TPanamahAdmin.Free;
begin
  if Assigned(_PanamahAdminInstance) then
    FreeAndNil(_PanamahAdminInstance);
end;

function TPanamahAdmin.GetAssinante(const AAssinanteId: string): IPanamahAssinante;
var
  Response: IPanamahResponse;
begin
  TPanamahLogger.Log(Format('Getting assinante %s', [AAssinanteId]));
  Response := FClient.Get(Format('/admin/assinantes/%s', [AAssinanteId]), nil, nil);
  TPanamahLogger.Log(Format('Assinante get response returned %d', [Response.Status]));
  case Response.Status of
    200: Result := TPanamahAssinante.FromJSON(Response.Content);
    404: raise EPanamahSDKNotFoundException.Create('Assinante não encontrado');
    else
      raise EPanamahSDKUnknownException.Create(Response.Content);
  end;
end;

function TPanamahAdmin.SaveAssinante(AAssinante: IPanamahAssinante): Boolean;
var
  Response: IPanamahResponse;
begin
  TPanamahLogger.Log('Creating assinante');
  Response := FClient.Post('/admin/assinantes', AAssinante.SerializeToJSON, nil);
  TPanamahLogger.Log(Format('Assinante create response returned %d', [Response.Status]));
  case Response.Status of
    201: Result := True;
    422: raise EPanamahSDKUnprocessableEntityException.Create(Response.Content);
    400: raise EPanamahSDKBadRequestException.Create(Response.Content);
    409: raise EPanamahSDKConflictException.Create(Response.Content);
    else
      Result := False;
  end;
end;

class function TPanamahAdmin.GetInstance: TPanamahAdmin;
begin
  if not Assigned(_PanamahAdminInstance) then
    _PanamahAdminInstance := TPanamahAdmin.Create;
  Result := _PanamahAdminInstance;
end;

procedure TPanamahAdmin.Init(const AAuthorizationToken: string);
var
  Config: IPanamahAdminConfig;
begin
  TPanamahLogger.Log('PanamahAdmin init');
  Config := TPanamahAdminConfig.Create;
  Config.AuthorizationToken := AAuthorizationToken;
  Init(Config);
end;

procedure TPanamahAdmin.Init(AConfig: IPanamahAdminConfig);
begin
  TPanamahLogger.Log('PanamahAdmin init');
  FConfig := AConfig;
  FClient := TPanamahAdminClient.Create(API_BASE_URL, FConfig.AuthorizationToken);
end;

initialization
  TPanamahStream.GetInstance;
  TPanamahAdmin.GetInstance;
  
finalization
  TPanamahStream.Free;
  TPanamahAdmin.Free;

end.
