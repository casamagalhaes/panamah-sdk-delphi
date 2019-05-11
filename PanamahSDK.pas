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
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda, PanamahSDK.Processor;

type

  TPanamahStreamConfig = class(TInterfacedObject, IPanamahStreamConfig)
  private
    FSoftwareKey: string;
    FBaseDirectory: string;
    FBatchTTL: Integer;
    FBatchMaxSize: Integer;
    FBatchMaxCount: Integer;
    function GetBaseDirectory: string;
    function GetBatchTTL: Integer;
    function GetBatchMaxSize: Integer;
    function GetBatchMaxCount: Integer;
    function GetSoftwareKey: string;
    procedure SetBaseDirectory(const ABaseDirectory: string);
    procedure SetSoftwareKey(const ASoftwareKey: string);
  published
    constructor Create; reintroduce;
    property BaseDirectory: string read GetBaseDirectory write SetBaseDirectory;
    property BatchTTL: Integer read GetBatchTTL;
    property BatchMaxSize: Integer read GetBatchMaxSize;
    property BatchMaxCount: Integer read GetBatchMaxCount;
    property SoftwareKey: string read GetSoftwareKey write SetSoftwareKey;
  end;

  TPanamahAdminConfig = class(TInterfacedObject, IPanamahAdminConfig)
  private
    FSoftwareKey: string;
    function GetSoftwareKey: string;
    procedure SetSoftwareKey(const ASoftwareKey: string);
  published
    constructor Create; reintroduce;
    property SoftwareKey: string read GetSoftwareKey write SetSoftwareKey;
  end;

  TPanamahAdmin = class
  private
    FConfig: IPanamahAdminConfig;
    FClient: IPanamahClient;
  public
    procedure Init(AConfig: IPanamahAdminConfig); overload;
    procedure Init(const ASoftwareKey: string); overload;
    constructor Create; reintroduce;
    destructor Destroy; override;
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
    procedure SetOnCurrentBatchExpired(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeObjectAddedToBatch(AEvent: TPanamahModelEvent);
    procedure SetOnBeforeBatchSent(AEvent: TPanamahBatchEvent);
    procedure SetOnBeforeOperationSent(AEvent: TPanamahOperationEvent);
  public
    class procedure Free;
    procedure Init; overload;
    procedure Init(AConfig: IPanamahStreamConfig); overload;
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
    class function GetInstance: TPanamahStream;
  end;

var
  _PanamahStreamInstance: TPanamahStream;
  _PanamahAdminInstance: TPanamahAdmin;

implementation

uses
  PanamahSDK.ValidationUtils;

{ TPanamahStream }

procedure TPanamahStream.Init(AConfig: IPanamahStreamConfig);
begin
  FConfig := AConfig;
  FProcessor.Start(FConfig);
end;

procedure TPanamahStream.Init(const AApiKey: string);
var
  Config: IPanamahStreamConfig;
begin
  Config := TPanamahStreamConfig.Create;
  Config.SoftwareKey := AApiKey;
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

constructor TPanamahStreamConfig.Create;
begin
  inherited Create;
  FBatchTTL := 5 * 60 * 1000;
  FBatchMaxSize := 5 * 1024;
  FBatchMaxCount := 500;
  FBaseDirectory := GetCurrentDir + '\.panamah';
end;

function TPanamahStreamConfig.GetSoftwareKey: string;
begin
  Result := FSoftwareKey;
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

procedure TPanamahStreamConfig.SetBaseDirectory(const ABaseDirectory: string);
begin
  FBaseDirectory := ABaseDirectory;
end;

procedure TPanamahStreamConfig.SetSoftwareKey(const ASoftwareKey: string);
begin
  FSoftwareKey := ASoftwareKey;
end;

{ TPanamahAdminConfig }

constructor TPanamahAdminConfig.Create;
begin
  inherited Create;
end;

function TPanamahAdminConfig.GetSoftwareKey: string;
begin
  Result := FSoftwareKey;
end;

procedure TPanamahAdminConfig.SetSoftwareKey(const ASoftwareKey: string);
begin
  FSoftwareKey := ASoftwareKey;
end;

{ TPanamahAdmin }

constructor TPanamahAdmin.Create;
begin
  inherited Create;
//  FClient := TPanamahAdminClient.Create('https://172.16.33.109:7443', FConfig.SoftwareKey, '');
end;

destructor TPanamahAdmin.Destroy;
begin

  inherited;
end;

class procedure TPanamahAdmin.Free;
begin
  if Assigned(_PanamahAdminInstance) then
    FreeAndNil(_PanamahAdminInstance);
end;

class function TPanamahAdmin.GetInstance: TPanamahAdmin;
begin
  if not Assigned(_PanamahAdminInstance) then
    _PanamahAdminInstance := TPanamahAdmin.Create;
  Result := _PanamahAdminInstance;
end;

procedure TPanamahAdmin.Init(const ASoftwareKey: string);
var
  Config: IPanamahAdminConfig;
begin
  Config := TPanamahAdminConfig.Create;
  Config.SoftwareKey := ASoftwareKey;
  Init(Config);
end;

procedure TPanamahAdmin.Init(AConfig: IPanamahAdminConfig);
begin
  FConfig := AConfig;
end;

initialization
  TPanamahStream.GetInstance;
  
finalization
  TPanamahStream.Free;

end.
