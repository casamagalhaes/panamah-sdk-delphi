{$M+}
unit PanamahSDK;

interface

uses
  Classes, Windows, SysUtils, Messages, SyncObjs, PanamahSDK.Types, PanamahSDK.Client, PanamahSDK.Batch,
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
    function GetApiKey: string;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    procedure SetApiKey(const AApiKey: string);
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetBatchTTL(const ABatchTTL: Integer);
    procedure SetBatchMaxSize(const ABatchMaxSize: Integer);
  published
    constructor Create; reintroduce;
    property ApiKey: string read GetApiKey write SetApiKey;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL write SetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize write SetBatchMaxSize;
  end;

  TPanamahBatchEvent = procedure(ABatch: IPanamahBatch) of object;

  TPanamahModelEvent = procedure(AModel: IPanamahModel) of object;

  TPanamahSDKBatchProcessor = class(TThread)
  private
    FCriticalSection: TCriticalSection;
    FOnCurrentBatchExpired: TPanamahBatchEvent;
    FOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    FOnBeforeBatchSent: TPanamahBatchEvent;
    FOnBeforeObjectSent: TPanamahModelEvent;
    FClient: IPanamahClient;
    FConfig: IPanamahSDKConfig;
    FCurrentBatch: IPanamahBatch;
    function GetBatchAccumulationDirectory: string;
    function GetBatchSentDirectory: string;
    function GetCurrentBatchFilename: string;
    function IsThereAccumulatedBatches: Boolean;
    procedure AccumulateCurrentBatch;
    procedure DoOnCurrentBatchExpired;
    procedure DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
    procedure DoOnBeforeBatchSent(ABatch: IPanamahBatch);
    procedure DoOnBeforeObjectSent(AModel: IPanamahModel);
    procedure SendAccumulatedBatches;
    procedure LoadCurrentBatch;
    procedure SaveCurrentBatch;
    procedure Process;
  public
    destructor Destroy; override;
    constructor Create; reintroduce;
    procedure Start(AConfig: IPanamahSDKConfig); reintroduce;
    procedure Execute; override;
    procedure Stop;
    property OnCurrentBatchExpired: TPanamahBatchEvent read FOnCurrentBatchExpired write FOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read FOnBeforeObjectAddedToBatch write FOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read FOnBeforeBatchSent write FOnBeforeBatchSent;
    property OnBeforeObjectSent: TPanamahModelEvent read FOnBeforeObjectSent write FOnBeforeObjectSent;
    procedure Add(AModel: IPanamahModel);
    procedure Flush;
  end;

  TPanamahSDK = class
  private
    FConfig: IPanamahSDKConfig;
    FProcessor: TPanamahSDKBatchProcessor;
    function GetOnCurrentBatchExpired: TPanamahBatchEvent;
    function GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    function GetOnBeforeObjectSent: TPanamahModelEvent;
    function GetOnBeforeBatchSent: TPanamahBatchEvent;
    procedure SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
    procedure SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectSent(AEvent: TPanamahModelEvent);
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
    property OnCurrentBatchExpired: TPanamahBatchEvent read GetOnCurrentBatchExpired write SetOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read GetOnBeforeObjectAddedToBatch write SetOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read GetOnBeforeBatchSent write SetOnBeforeBatchSent;
    property OnBeforeObjectSent: TPanamahModelEvent read GetOnBeforeObjectSent write SetOnBeforeObjectSent;
  published
    class function GetInstance: TPanamahSDK;
  end;

var
  _PanamahSDKInstance: TPanamahSDK;

implementation

{ TPanamahSDK }

procedure TPanamahSDK.Init(AConfig: IPanamahSDKConfig);
begin
  FConfig := AConfig;
  FProcessor.Start(FConfig);
end;

procedure TPanamahSDK.Init(const AApiKey: string);
var
  Config: IPanamahSDKConfig;
begin
  Config := TPanamahSDKConfig.Create;
  Config.ApiKey := AApiKey;
  Init(Config);
end;

procedure TPanamahSDK.Init;
begin
  Init(GetEnvironmentVariable('PANAMAH_API_KEY'));
end;

procedure TPanamahSDK.Save(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Add(AFormaPagamento);
end;

procedure TPanamahSDK.Save(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Add(AEventoCaixa);
end;

procedure TPanamahSDK.Save(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Add(AEstoqueMovimentacao);
end;

procedure TPanamahSDK.Save(AGrupo: IPanamahGrupo);
begin
  FProcessor.Add(AGrupo);
end;

procedure TPanamahSDK.Save(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Add(AFuncionario);
end;

procedure TPanamahSDK.Save(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Add(AFornecedor);
end;

procedure TPanamahSDK.Save(AAssinante: IPanamahAssinante);
begin
  FProcessor.Add(AAssinante);
end;

procedure TPanamahSDK.Save(AAcesso: IPanamahAcesso);
begin
  FProcessor.Add(AAcesso);
end;

procedure TPanamahSDK.Save(AEan: IPanamahEan);
begin
  FProcessor.Add(AEan);
end;

procedure TPanamahSDK.Save(ACompra: IPanamahCompra);
begin
  FProcessor.Add(ACompra);
end;

procedure TPanamahSDK.Save(ACliente: IPanamahCliente);
begin
  FProcessor.Add(ACliente);
end;

procedure TPanamahSDK.Save(AHolding: IPanamahHolding);
begin
  FProcessor.Add(AHolding);
end;

procedure TPanamahSDK.Save(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Add(ATituloReceber);
end;

procedure TPanamahSDK.Save(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Add(ATituloPagar);
end;

procedure TPanamahSDK.Save(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Add(ASubgrupo);
end;

procedure TPanamahSDK.Save(AVenda: IPanamahVenda);
begin
  FProcessor.Add(AVenda);
end;

procedure TPanamahSDK.SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnBeforeBatchSent := AEvent;
end;

procedure TPanamahSDK.SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnBeforeObjectAddedToBatch := AEvent;
end;

procedure TPanamahSDK.SetOnBeforeObjectSent(AEvent: TPanamahModelEvent);
begin
  FProcessor.OnBeforeObjectSent := AEvent;
end;

procedure TPanamahSDK.SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
begin
  FProcessor.OnCurrentBatchExpired := AEvent;
end;

procedure TPanamahSDK.Save(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Add(ATrocaFormaPagamento);
end;

procedure TPanamahSDK.Save(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Add(ATrocaDevolucao);
end;

procedure TPanamahSDK.Save(AMeta: IPanamahMeta);
begin
  FProcessor.Add(AMeta);
end;

procedure TPanamahSDK.Save(ALoja: IPanamahLoja);
begin
  FProcessor.Add(ALoja);
end;

procedure TPanamahSDK.Save(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Add(ALocalEstoque);
end;

procedure TPanamahSDK.Save(ASecao: IPanamahSecao);
begin
  FProcessor.Add(ASecao);
end;

procedure TPanamahSDK.Save(ARevenda: IPanamahRevenda);
begin
  FProcessor.Add(ARevenda);
end;

procedure TPanamahSDK.Save(AProduto: IPanamahProduto);
begin
  FProcessor.Add(AProduto);
end;

constructor TPanamahSDK.Create;
begin
  inherited;
  FProcessor := TPanamahSDKBatchProcessor.Create;
end;

destructor TPanamahSDK.Destroy;
begin
  FProcessor.Stop;
  FProcessor.Free;
  inherited;
end;

procedure TPanamahSDK.Flush;
begin
  FProcessor.Flush;
end;

class procedure TPanamahSDK.Free;
begin
  if Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance.Destroy;
end;

class function TPanamahSDK.GetInstance: TPanamahSDK;
begin
  if not Assigned(_PanamahSDKInstance) then
    _PanamahSDKInstance := TPanamahSDK.Create;
  Result := _PanamahSDKInstance;
end;

function TPanamahSDK.GetOnBeforeBatchSent: TPanamahBatchEvent;
begin
  Result := FProcessor.OnBeforeBatchSent;
end;

function TPanamahSDK.GetOnBeforeObjectAddedToBatch: TPanamahModelEvent;
begin
  Result := FProcessor.OnBeforeObjectAddedToBatch;
end;

function TPanamahSDK.GetOnBeforeObjectSent: TPanamahModelEvent;
begin
  Result := FProcessor.OnBeforeObjectSent;
end;

function TPanamahSDK.GetOnCurrentBatchExpired: TPanamahBatchEvent;
begin
  Result := FProcessor.OnCurrentBatchExpired;
end;

{ TPanamahSDKConfig }

constructor TPanamahSDKConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
  FBatchMaxSize := 5 * 1024;
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

procedure TPanamahSDKConfig.SetBatchMaxSize(const ABatchMaxSize: Integer);
begin
  FBatchMaxSize := ABatchMaxSize;
end;

procedure TPanamahSDKConfig.SetBatchTTL(const ABatchTTL: Integer);
begin
  FBatchTTL := ABatchTTL;
end;

{ TPanamahSDKBatchProcessor }

procedure TPanamahSDKBatchProcessor.AccumulateCurrentBatch;
begin
  FCurrentBatch.SaveToDirectory(GetBatchAccumulationDirectory);
  FCurrentBatch.Reset;
  DeleteFile(GetCurrentBatchFilename);
end;

procedure TPanamahSDKBatchProcessor.Add(AModel: IPanamahModel);
begin
  FCriticalSection.Acquire;
  try
    DoOnBeforeObjectAddedToBatch(AModel);
    FCurrentBatch.Add(AModel.Clone);
  finally
    FCriticalSection.Release;
  end;
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
  if Assigned(FOnBeforeObjectSent) then
    for I := 0 to ABatch.Count - 1 do
      DoOnBeforeObjectSent(ABatch.Items[I]);
end;

procedure TPanamahSDKBatchProcessor.DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
begin
  if Assigned(FOnBeforeObjectAddedToBatch) then
    FOnBeforeObjectAddedToBatch(AModel);
end;

procedure TPanamahSDKBatchProcessor.DoOnBeforeObjectSent(AModel: IPanamahModel);
begin
  if Assigned(FOnBeforeObjectSent) then
    FOnBeforeObjectSent(AModel);
end;

procedure TPanamahSDKBatchProcessor.Execute;
begin
  inherited;
  LoadCurrentBatch;
  Process;
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
        if FCurrentBatch.CheckForExpiration(FConfig) then
        begin
          DoOnCurrentBatchExpired;
          AccumulateCurrentBatch;
        end;
        if CurrentBatchLastHash <> FCurrentBatch.Hash then
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
  TPanamahSDK.GetInstance;
  
finalization
  TPanamahSDK.Free;

end.
