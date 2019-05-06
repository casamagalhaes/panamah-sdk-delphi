{$M+}
unit PanamahSDK;

interface

uses
  Classes, Windows, SysUtils, Messages, SyncObjs, PanamahSDK.Types, PanamahSDK.Client, PanamahSDK.Batch, PanamahSDK.Models.Acesso,
  PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra, PanamahSDK.Models.Ean,
  PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa, PanamahSDK.Models.FormaPagamento,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario, PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding,
  PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja, PanamahSDK.Models.Meta, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao, PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar,
  PanamahSDK.Models.TituloReceber, PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento,
  PanamahSDK.Models.Venda;

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

  TBatchExpiredEvent = procedure(ABatch: IPanamahBatch) of object;
  TBeforeObjectAddedToBatchEvent = procedure(AObject: IPanamahModel) of object;

  TPanamahSDKBatchProcessor = class(TThread)
  private
    FCriticalSection: TCriticalSection;
    FOnCurrentBatchExpired: TBatchExpiredEvent;
    FOnBeforeObjectAddedToBatch: TBeforeObjectAddedToBatchEvent;
    FClient: IPanamahClient;
    FConfig: IPanamahSDKConfig;
    FCurrentBatch: IPanamahBatch;
    procedure SetOnCurrentBatchExpired(const Value: TBatchExpiredEvent);
    procedure DoOnCurrentBatchExpired;
    procedure DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
  protected
    procedure Execute; override;
    property OnCurrentBatchExpired: TBatchExpiredEvent read FOnCurrentBatchExpired write SetOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TBeforeObjectAddedToBatchEvent read FOnBeforeObjectAddedToBatch write FOnBeforeObjectAddedToBatch;
    procedure Add(AModel: IPanamahModel);
    constructor Create(AConfig: IPanamahSDKConfig); reintroduce;
    destructor Destroy; override;
  end;

  TPanamahSDK = class
  private
    FConfig: IPanamahSDKConfig;
    FProcessor: TPanamahSDKBatchProcessor;
  public
    class procedure Free;
    procedure Init; overload;
    procedure Init(AConfig: IPanamahSDKConfig); overload;
    procedure Flush;
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Send(AAcesso: IPanamahAcesso); overload;
    procedure Send(AAssinante: IPanamahAssinante); overload;
    procedure Send(ACliente: IPanamahCliente); overload;
    procedure Send(ACompra: IPanamahCompra); overload;
    procedure Send(AEan: IPanamahEan); overload;
    procedure Send(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Send(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Send(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Send(AFornecedor: IPanamahFornecedor); overload;
    procedure Send(AFuncionario: IPanamahFuncionario); overload;
    procedure Send(AGrupo: IPanamahGrupo); overload;
    procedure Send(AHolding: IPanamahHolding); overload;
    procedure Send(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Send(ALoja: IPanamahLoja); overload;
    procedure Send(AMeta: IPanamahMeta); overload;
    procedure Send(AProduto: IPanamahProduto); overload;
    procedure Send(ARevenda: IPanamahRevenda); overload;
    procedure Send(ASecao: IPanamahSecao); overload;
    procedure Send(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Send(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Send(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Send(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Send(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Send(AVenda: IPanamahVenda); overload;
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
  FProcessor := TPanamahSDKBatchProcessor.Create(FConfig);
  FProcessor.Start;
end;

procedure TPanamahSDK.Init;
var
  Config: IPanamahSDKConfig;
begin
  Config := TPanamahSDKConfig.Create;
  Config.ApiKey := GetEnvironmentVariable('PANAMAH_API_KEY');
  Init(Config);
end;

procedure TPanamahSDK.Send(AFormaPagamento: IPanamahFormaPagamento);
begin
  FProcessor.Add(AFormaPagamento);
end;

procedure TPanamahSDK.Send(AEventoCaixa: IPanamahEventoCaixa);
begin
  FProcessor.Add(AEventoCaixa);
end;

procedure TPanamahSDK.Send(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  FProcessor.Add(AEstoqueMovimentacao);
end;

procedure TPanamahSDK.Send(AGrupo: IPanamahGrupo);
begin
  FProcessor.Add(AGrupo);
end;

procedure TPanamahSDK.Send(AFuncionario: IPanamahFuncionario);
begin
  FProcessor.Add(AFuncionario);
end;

procedure TPanamahSDK.Send(AFornecedor: IPanamahFornecedor);
begin
  FProcessor.Add(AFornecedor);
end;

procedure TPanamahSDK.Send(AAssinante: IPanamahAssinante);
begin
  FProcessor.Add(AAssinante);
end;

procedure TPanamahSDK.Send(AAcesso: IPanamahAcesso);
begin
  FProcessor.Add(AAcesso);
end;

procedure TPanamahSDK.Send(AEan: IPanamahEan);
begin
  FProcessor.Add(AEan);
end;

procedure TPanamahSDK.Send(ACompra: IPanamahCompra);
begin
  FProcessor.Add(ACompra);
end;

procedure TPanamahSDK.Send(ACliente: IPanamahCliente);
begin
  FProcessor.Add(ACliente);
end;

procedure TPanamahSDK.Send(AHolding: IPanamahHolding);
begin
  FProcessor.Add(AHolding);
end;

procedure TPanamahSDK.Send(ATituloReceber: IPanamahTituloReceber);
begin
  FProcessor.Add(ATituloReceber);
end;

procedure TPanamahSDK.Send(ATituloPagar: IPanamahTituloPagar);
begin
  FProcessor.Add(ATituloPagar);
end;

procedure TPanamahSDK.Send(ASubgrupo: IPanamahSubgrupo);
begin
  FProcessor.Add(ASubgrupo);
end;

procedure TPanamahSDK.Send(AVenda: IPanamahVenda);
begin
  FProcessor.Add(AVenda);
end;

procedure TPanamahSDK.Send(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  FProcessor.Add(ATrocaFormaPagamento);
end;

procedure TPanamahSDK.Send(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  FProcessor.Add(ATrocaDevolucao);
end;

procedure TPanamahSDK.Send(AMeta: IPanamahMeta);
begin
  FProcessor.Add(AMeta);
end;

procedure TPanamahSDK.Send(ALoja: IPanamahLoja);
begin
  FProcessor.Add(ALoja);
end;

procedure TPanamahSDK.Send(ALocalEstoque: IPanamahLocalEstoque);
begin
  FProcessor.Add(ALocalEstoque);
end;

procedure TPanamahSDK.Send(ASecao: IPanamahSecao);
begin
  FProcessor.Add(ASecao);
end;

procedure TPanamahSDK.Send(ARevenda: IPanamahRevenda);
begin
  FProcessor.Add(ARevenda);
end;

procedure TPanamahSDK.Send(AProduto: IPanamahProduto);
begin
  FProcessor.Add(AProduto);
end;

constructor TPanamahSDK.Create;
begin
  inherited;
end;

destructor TPanamahSDK.Destroy;
begin
  FProcessor.Terminate;
  FProcessor.Free;
  inherited;
end;

procedure TPanamahSDK.Flush;
begin
  //
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

procedure TPanamahSDKBatchProcessor.Add(AModel: IPanamahModel);
begin
  FCriticalSection.Acquire;
  try
    FCurrentBatch.Add(AModel.Clone);
  finally
    FCriticalSection.Release;
  end;
end;

constructor TPanamahSDKBatchProcessor.Create(AConfig: IPanamahSDKConfig);
begin
  inherited Create(True);
  FConfig := AConfig;
  FCurrentBatch := TPanamahBatch.Create;
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

procedure TPanamahSDKBatchProcessor.DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
begin
  if Assigned(FOnBeforeObjectAddedToBatch) then
    FOnBeforeObjectAddedToBatch(AModel);
end;

procedure TPanamahSDKBatchProcessor.Execute;
begin
  inherited;
  while not Terminated do
  begin
    FCriticalSection.Acquire;
    try
      if FCurrentBatch.CheckForExpiration(FConfig) then
      begin
        Synchronize(DoOnCurrentBatchExpired);
        FCurrentBatch.SaveToDirectory(FConfig.BaseDirectory + '\acumulados');
        FCurrentBatch.Reset;
      end;
    finally
      FCriticalSection.Release;
    end;
    Sleep(1000);
  end;
end;

procedure TPanamahSDKBatchProcessor.SetOnCurrentBatchExpired(const Value: TBatchExpiredEvent);
begin
  FOnCurrentBatchExpired := Value;
end;

initialization
  TPanamahSDK.GetInstance;
  
finalization
  TPanamahSDK.Free;

end.
