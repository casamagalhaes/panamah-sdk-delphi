{$M+}
unit PanamahSDK;

interface

uses
  Classes, Windows, SysUtils, Messages, DateUtils, SyncObjs, PanamahSDK.Enums, PanamahSDK.Operation, PanamahSDK.Types, PanamahSDK.Client, PanamahSDK.Batch,
  PanamahSDK.Models.Acesso, PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra,
  PanamahSDK.Models.Ean, PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa,
  PanamahSDK.Models.FormaPagamento, PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario,
  PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding, PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Meta, PanamahSDK.Models.Produto, PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao,
  PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar, PanamahSDK.Models.TituloReceber,
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda;

type

  TPanamahSDKConfig = class(TInterfacedObject, IPanamahSDKConfig)
  private
    FApiKey: string;
    FBaseDirectory: string;
    FBatchTTL: Integer;
    FBatchMaxSize: Integer;
    FBatchMaxCount: Integer;
    function GetApiKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    procedure SetApiKey(const AApiKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
  published
    constructor Create; reintroduce;
    property ApiKey: string read GetApiKey write SetApiKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
  end;

  TPanamahBatchEvent = procedure(ABatch: IPanamahBatch) of object;

  TPanamahModelEvent = procedure(AModel: IPanamahModel) of object;

  TPanamahOperationEvent = procedure(AModel: IPanamahOperation) of object;

  TPanamahSDKBatchProcessor = class(TThread)
  private
    FCriticalSection: TCriticalSection;
    FOnCurrentBatchExpired: TPanamahBatchEvent;
    FOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    FOnBeforeBatchSent: TPanamahBatchEvent;
    FOnBeforeOperationSent: TPanamahOperationEvent;
    FClient: IPanamahClient;
    FConfig: IPanamahSDKConfig;
    FCurrentBatch: IPanamahBatch;
    function GetBatchAccumulationDirectory: string;
    function GetBatchSentDirectory: string;
    function GetCurrentBatchFilename: string;
    function IsThereAccumulatedBatches: Boolean;
    function CurrentBatchExpiredByTime(ABatchTTL: Integer): Boolean;
    function BatchExpiredBySize(AMaxSize: Integer): Boolean;
    function BatchExpiredByCount(AMaxCount: Integer): Boolean;
    procedure AccumulateCurrentBatch;
    procedure DoOnCurrentBatchExpired;
    procedure DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
    procedure DoOnBeforeBatchSent(ABatch: IPanamahBatch);
    procedure DoOnBeforeOperationSent(AOperation: IPanamahOperation);
    procedure SendAccumulatedBatches;
    procedure LoadCurrentBatch;
    procedure SaveCurrentBatch;
    procedure ExpireCurrentBatch;
    procedure Process;
    procedure AddOperationToCurrentBatch(AOperationType: TPanamahOperationType; AModel: IPanamahModel);
  public
    destructor Destroy; override;
    constructor Create; reintroduce;
    procedure Start(AConfig: IPanamahSDKConfig); reintroduce;
    procedure Execute; override;
    procedure Stop;
    property OnCurrentBatchExpired: TPanamahBatchEvent read FOnCurrentBatchExpired write FOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read FOnBeforeObjectAddedToBatch write FOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read FOnBeforeBatchSent write FOnBeforeBatchSent;
    property OnBeforeOperationSent: TPanamahOperationEvent read FOnBeforeOperationSent write FOnBeforeOperationSent;
    procedure Save(AModel: IPanamahModel);
    procedure Delete(AModel: IPanamahModel);
    procedure Flush;
  end;

  TPanamahStream = class
  private
    FConfig: IPanamahSDKConfig;
    FProcessor: TPanamahSDKBatchProcessor;
    function GetOnCurrentBatchExpired: TPanamahBatchEvent;
    function GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    function GetOnBeforeOperationtSent: TPanamahOperationEvent;
    function GetOnBeforeBatchSent: TPanamahBatchEvent;
    procedure SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
    procedure SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
  public
    class procedure Free;
    procedure Init; overload;
    procedure Init(AConfig: IPanamahSDKConfig); overload;
    procedure Init(const AApiKey: string); overload;
    procedure Flush;
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Save(AAcesso: IPanamahAcesso); overload;
    procedure Save(AAssinante: IPanamahAssinante); overload;
    procedure Save(ACliente: IPanamahCliente); overload;
    procedure Save(ACompra: IPanamahCompra); overload;
    procedure Save(AEan: IPanamahEan); overload;
    procedure Save(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Save(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Save(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Save(AFornecedor: IPanamahFornecedor); overload;
    procedure Save(AFuncionario: IPanamahFuncionario); overload;
    procedure Save(AGrupo: IPanamahGrupo); overload;
    procedure Save(AHolding: IPanamahHolding); overload;
    procedure Save(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Save(ALoja: IPanamahLoja); overload;
    procedure Save(AMeta: IPanamahMeta); overload;
    procedure Save(AProduto: IPanamahProduto); overload;
    procedure Save(ARevenda: IPanamahRevenda); overload;
    procedure Save(ASecao: IPanamahSecao); overload;
    procedure Save(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Save(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Save(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Save(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Save(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Save(AVenda: IPanamahVenda); overload;
    procedure Delete(AAcesso: IPanamahAcesso); overload;
    procedure Delete(AAssinante: IPanamahAssinante); overload;
    procedure Delete(ACliente: IPanamahCliente); overload;
    procedure Delete(ACompra: IPanamahCompra); overload;
    procedure Delete(AEan: IPanamahEan); overload;
    procedure Delete(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Delete(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Delete(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Delete(AFornecedor: IPanamahFornecedor); overload;
    procedure Delete(AFuncionario: IPanamahFuncionario); overload;
    procedure Delete(AGrupo: IPanamahGrupo); overload;
    procedure Delete(AHolding: IPanamahHolding); overload;
    procedure Delete(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Delete(ALoja: IPanamahLoja); overload;
    procedure Delete(AMeta: IPanamahMeta); overload;
    procedure Delete(AProduto: IPanamahProduto); overload;
    procedure Delete(ARevenda: IPanamahRevenda); overload;
    procedure Delete(ASecao: IPanamahSecao); overload;
    procedure Delete(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Delete(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Delete(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Delete(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Delete(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Delete(AVenda: IPanamahVenda); overload;
    property OnCurrentBatchExpired: TPanamahBatchEvent read GetOnCurrentBatchExpired write SetOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read GetOnBeforeObjectAddedToBatch write SetOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read GetOnBeforeBatchSent write SetOnBeforeBatchSent;
    property OnBeforeOperationSent: TPanamahOperationEvent read GetOnBeforeOperationtSent write SetOnBeforeOperationSent;
  published
    class function GetInstance: TPanamahStream;
  end;

var
  _PanamahSDKInstance: TPanamahStream;

implementation

{ TPanamahSDK }

procedure TPanamahStream.Init(AConfig: IPanamahSDKConfig);
begin
  FConfig := AConfig;
  FProcessor.Start(FConfig);
end;

procedure TPanamahStream.Init(const AApiKey: string);
var
  Config: IPanamahSDKConfig;
begin
  Config := TPanamahSDKConfig.Create;
  Config.ApiKey := AApiKey;
  Init(Config);
end;

procedure TPanamahStream.Init;
begin
  Init(GetEnvironmentVariable('PANAMAH_API_KEY'));
end;

procedure TPanamahStream.SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnBeforeBatchSent := AEvent;
end;

procedure TPanamahStream.SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnBeforeObjectAddedToBatch := AEvent;
end;

procedure TPanamahStream.SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
begin
  FProcessor.OnBeforeOperationSent := AEvent;
end;

procedure TPanamahStream.SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnCurrentBatchExpired := AEvent;
end;

procedure TPanamahStream.Save(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Save(AFormaPagamento);
end;

procedure TPanamahStream.Save(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Save(AEventoCaixa);
end;

procedure TPanamahStream.Save(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Save(AEstoqueMovimentacao);
end;

procedure TPanamahStream.Save(AGrupo: IPanamahGrupo);
begin
  FProcessor.Save(AGrupo);
end;

procedure TPanamahStream.Save(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Save(AFuncionario);
end;

procedure TPanamahStream.Save(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Save(AFornecedor);
end;

procedure TPanamahStream.Save(AAssinante: IPanamahAssinante);
begin
  FProcessor.Save(AAssinante);
end;

procedure TPanamahStream.Save(AAcesso: IPanamahAcesso);
begin
  FProcessor.Save(AAcesso);
end;

procedure TPanamahStream.Save(AEan: IPanamahEan);
begin
  FProcessor.Save(AEan);
end;

procedure TPanamahStream.Save(ACompra: IPanamahCompra);
begin
  FProcessor.Save(ACompra);
end;

procedure TPanamahStream.Save(ACliente: IPanamahCliente);
begin
  FProcessor.Save(ACliente);
end;

procedure TPanamahStream.Save(AHolding: IPanamahHolding);
begin
  FProcessor.Save(AHolding);
end;

procedure TPanamahStream.Save(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Save(ATituloReceber);
end;

procedure TPanamahStream.Save(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Save(ATituloPagar);
end;

procedure TPanamahStream.Save(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Save(ASubgrupo);
end;

procedure TPanamahStream.Save(AVenda: IPanamahVenda);
begin
  FProcessor.Save(AVenda);
end;

procedure TPanamahStream.Save(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Save(ATrocaFormaPagamento);
end;

procedure TPanamahStream.Save(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Save(ATrocaDevolucao);
end;

procedure TPanamahStream.Save(AMeta: IPanamahMeta);
begin
  FProcessor.Save(AMeta);
end;

procedure TPanamahStream.Save(ALoja: IPanamahLoja);
begin
  FProcessor.Save(ALoja);
end;

procedure TPanamahStream.Save(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Save(ALocalEstoque);
end;

procedure TPanamahStream.Save(ASecao: IPanamahSecao);
begin
  FProcessor.Save(ASecao);
end;

procedure TPanamahStream.Save(ARevenda: IPanamahRevenda);
begin
  FProcessor.Save(ARevenda);
end;

procedure TPanamahStream.Save(AProduto: IPanamahProduto);
begin
  FProcessor.Save(AProduto);
end;

procedure TPanamahStream.Delete(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Delete(AFormaPagamento);
end;

procedure TPanamahStream.Delete(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Delete(AEventoCaixa);
end;

procedure TPanamahStream.Delete(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Delete(AEstoqueMovimentacao);
end;

procedure TPanamahStream.Delete(AGrupo: IPanamahGrupo);
begin
  FProcessor.Delete(AGrupo);
end;

procedure TPanamahStream.Delete(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Delete(AFuncionario);
end;

procedure TPanamahStream.Delete(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Delete(AFornecedor);
end;

procedure TPanamahStream.Delete(AAssinante: IPanamahAssinante);
begin
  FProcessor.Delete(AAssinante);
end;

procedure TPanamahStream.Delete(AAcesso: IPanamahAcesso);
begin
  FProcessor.Delete(AAcesso);
end;

procedure TPanamahStream.Delete(AEan: IPanamahEan);
begin
  FProcessor.Delete(AEan);
end;

procedure TPanamahStream.Delete(ACompra: IPanamahCompra);
begin
  FProcessor.Delete(ACompra);
end;

procedure TPanamahStream.Delete(ACliente: IPanamahCliente);
begin
  FProcessor.Delete(ACliente);
end;

procedure TPanamahStream.Delete(AHolding: IPanamahHolding);
begin
  FProcessor.Delete(AHolding);
end;

procedure TPanamahStream.Delete(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Delete(ATituloReceber);
end;

procedure TPanamahStream.Delete(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Delete(ATituloPagar);
end;

procedure TPanamahStream.Delete(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Delete(ASubgrupo);
end;

procedure TPanamahStream.Delete(AVenda: IPanamahVenda);
begin
  FProcessor.Delete(AVenda);
end;

procedure TPanamahStream.Delete(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Delete(ATrocaFormaPagamento);
end;

procedure TPanamahStream.Delete(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Delete(ATrocaDevolucao);
end;

procedure TPanamahStream.Delete(AMeta: IPanamahMeta);
begin
  FProcessor.Delete(AMeta);
end;

procedure TPanamahStream.Delete(ALoja: IPanamahLoja);
begin
  FProcessor.Delete(ALoja);
end;

procedure TPanamahStream.Delete(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Delete(ALocalEstoque);
end;

procedure TPanamahStream.Delete(ASecao: IPanamahSecao);
begin
  FProcessor.Delete(ASecao);
end;

procedure TPanamahStream.Delete(ARevenda: IPanamahRevenda);
begin
  FProcessor.Delete(ARevenda);
end;

procedure TPanamahStream.Delete(AProduto: IPanamahProduto);
begin
  FProcessor.Delete(AProduto);
end;

constructor TPanamahStream.Create;
begin
  inherited;
  FProcessor := TPanamahSDKBatchProcessor.Create;
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
  if Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance.Destroy;
end;

class function TPanamahStream.GetInstance: TPanamahStream;
begin
  if not Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance := TPanamahStream.Create;
  Result := _PanamahSDKInstance;
end;

function TPanamahStream.GetOnBeforeBatchSent: TPanamahBatchEvent;
begin
  Result := FProcessor.OnBeforeBatchSent;
end;

function TPanamahStream.GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
begin
  Result := FProcessor.OnBeforeObjectAddedToBatch;
end;

function TPanamahStream.GetOnBeforeOperationtSent: TPanamahOperationEvent;
begin
  Result := FProcessor.OnBeforeOperationSent;
end;

function TPanamahStream.GetOnCurrentBatchExpired: TPanamahBatchEvent;
begin
  Result := FProcessor.OnCurrentBatchExpired;
end;

{ TPanamahSDKConfig }

constructor TPanamahSDKConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
  FBatchMaxSize := 5 * 1024;
  FBatchMaxCount := 500;
  FBaseDirectory := GetCurrentDir + '\.panamah';
end;

function TPanamahSDKConfig.GetApiKey: string;
begin
  Result := FApiKey;
end;

function TPanamahSDKConfig.GetBaseDirectory: string;
begin
  Result := FBaseDirectory;
end;

function TPanamahSDKConfig.GetBatchMaxCount: Integer;
begin
  Result := FBatchMaxCount;
end;

function TPanamahSDKConfig.GetBatchMaxSize: Integer;
begin
  Result := FBatchMaxSize;
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

{ TPanamahSDKBatchProcessor }

procedure TPanamahSDKBatchProcessor.AccumulateCurrentBatch;
begin
  FCurrentBatch.SaveToDirectory(GetBatchAccumulationDirectory);
  FCurrentBatch.Reset;
  DeleteFile(GetCurrentBatchFilename);
end;

procedure TPanamahSDKBatchProcessor.Save(AModel: IPanamahModel);
begin
  AddOperationToCurrentBatch(otUPDATE, AModel);
end;

procedure TPanamahSDKBatchProcessor.Delete(AModel: IPanamahModel);
begin
  AddOperationToCurrentBatch(otDELETE, AModel);
end;

function TPanamahSDKBatchProcessor.GetBatchAccumulationDirectory: string;
begin
  Result := (FConfig.BaseDirectory + '\acumulados');
end;

function TPanamahSDKBatchProcessor.GetBatchSentDirectory: string;
begin
  Result := (FConfig.BaseDirectory + '\enviados');
end;

function TPanamahSDKBatchProcessor.GetCurrentBatchFilename: string;
begin
  Result := (FConfig.BaseDirectory + '\current.pbt');
end;

function TPanamahSDKBatchProcessor.IsThereAccumulatedBatches: Boolean;
begin
  Result := TPanamahBatchList.CountBatchesInDirectory(GetBatchAccumulationDirectory) > 0;
end;

procedure TPanamahSDKBatchProcessor.AddOperationToCurrentBatch(AOperationType: TPanamahOperationType;
  AModel: IPanamahModel);
begin
  FCriticalSection.Acquire;
  try
    DoOnBeforeObjectAddedToBatch(AModel);
    FCurrentBatch.Add(TPanamahOperation.Create(AOperationType, AModel.Clone));
    if BatchExpiredBySize(FConfig.BatchMaxSize) or
          BatchExpiredByCount(FConfig.BatchMaxCount) then
      ExpireCurrentBatch;
  finally
    FCriticalSection.Release;
  end;
end;

function TPanamahSDKBatchProcessor.BatchExpiredByCount(AMaxCount: Integer): Boolean;
begin
  Result := FCurrentBatch.Count >= AMaxCount;
end;

function TPanamahSDKBatchProcessor.BatchExpiredBySize(AMaxSize: Integer): Boolean;
begin
  Result := FCurrentBatch.Size > AMaxSize;
end;

function TPanamahSDKBatchProcessor.CurrentBatchExpiredByTime(ABatchTTL: Integer): Boolean;
begin
  Result := MilliSecondsBetween(Now, FCurrentBatch.CreatedAt) >= ABatchTTL;
end;

constructor TPanamahSDKBatchProcessor.Create;
begin
  inherited Create(True);
  FCriticalSection := TCriticalSection.Create;
end;

procedure TPanamahSDKBatchProcessor.DoOnCurrentBatchExpired;
begin
  if Assigned(FOnCurrentBatchExpired) then
    FOnCurrentBatchExpired(FCurrentBatch);
end;

destructor TPanamahSDKBatchProcessor.Destroy;
begin
  FCriticalSection.Free;
  inherited;
end;

procedure TPanamahSDKBatchProcessor.DoOnBeforeBatchSent(ABatch: IPanamahBatch);
var
  I: Integer;
begin
  if Assigned(FOnBeforeBatchSent) then
    FOnBeforeBatchSent(ABatch);
  if Assigned(FOnBeforeOperationSent) then
    for I := 0 to ABatch.Count - 1 do
      DoOnBeforeOperationSent(ABatch.Items[I]);
end;

procedure TPanamahSDKBatchProcessor.DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
begin
  if Assigned(FOnBeforeObjectAddedToBatch) then
    FOnBeforeObjectAddedToBatch(AModel);
end;

procedure TPanamahSDKBatchProcessor.DoOnBeforeOperationSent(AOperation: IPanamahOperation);
begin
  if Assigned(FOnBeforeOperationSent) then
    FOnBeforeOperationSent(AOperation);
end;

procedure TPanamahSDKBatchProcessor.Execute;
begin
  inherited;
  LoadCurrentBatch;
  Process;
end;

procedure TPanamahSDKBatchProcessor.ExpireCurrentBatch;
begin
  DoOnCurrentBatchExpired;
  AccumulateCurrentBatch;
end;

procedure TPanamahSDKBatchProcessor.Flush;
begin
  FCriticalSection.Acquire;
  try
    if FCurrentBatch.Count > 0 then
    begin
      AccumulateCurrentBatch;
      SendAccumulatedBatches;
    end;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TPanamahSDKBatchProcessor.LoadCurrentBatch;
var
  CurrentBatchFromFile: IPanamahBatch;
begin
  if FileExists(GetCurrentBatchFilename) then
  begin
    FCriticalSection.Acquire;
    try
      CurrentBatchFromFile := TPanamahBatch.FromFile(GetCurrentBatchFilename);
      if CurrentBatchFromFile.Count > 0 then
        FCurrentBatch := CurrentBatchFromFile.Clone;
    finally
      FCriticalSection.Release;
    end;
  end;
end;

procedure TPanamahSDKBatchProcessor.Process;
var
  CurrentBatchLastHash: string;
begin
  while not Terminated do
  begin
    FCriticalSection.Acquire;
    try
      if IsThereAccumulatedBatches then
      begin
        SendAccumulatedBatches;
      end
      else if FCurrentBatch.Count > 0 then
      begin
        if CurrentBatchExpiredByTime(FConfig.BatchTTL) then
          ExpireCurrentBatch
        else
        if FCurrentBatch.Hash <> CurrentBatchLastHash then
        begin
          SaveCurrentBatch;
          CurrentBatchLastHash := FCurrentBatch.Hash;
        end;
      end;
    finally
      FCriticalSection.Release;
    end;
  end;
end;

procedure TPanamahSDKBatchProcessor.SaveCurrentBatch;
begin
  if FCurrentBatch.Count > 0 then
    FCurrentBatch.SaveToFile(GetCurrentBatchFilename);
end;

procedure TPanamahSDKBatchProcessor.SendAccumulatedBatches;
var
  AccumulatedBatches: IPanamahBatchList;
  Response: IPanamahResponse;
  I: Integer;
begin
  AccumulatedBatches := TPanamahBatchList.FromDirectory(GetBatchAccumulationDirectory);
  for I := 0 to AccumulatedBatches.Count - 1 do
  begin
    DoOnBeforeBatchSent(AccumulatedBatches[I]);
    Response := FClient.Post('/record', AccumulatedBatches[I].SerializeToJSON, nil);
    if Response.Status = 200 then
    begin
      AccumulatedBatches[I].MoveToDirectory(GetBatchAccumulationDirectory, GetBatchSentDirectory);
    end;
  end;
end;

procedure TPanamahSDKBatchProcessor.Start(AConfig: IPanamahSDKConfig);
begin
  FConfig := AConfig;
  FClient := TPanamahClient.Create('https://172.16.33.109:7443', FConfig.ApiKey);
  FCurrentBatch := TPanamahBatch.Create;
  inherited Start;
end;

procedure TPanamahSDKBatchProcessor.Stop;
begin
  Terminate;
  WaitFor;
end;

initialization
  TPanamahStream.GetInstance;
  
finalization
  TPanamahStream.Free;

end.
