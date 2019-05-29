unit PanamahSDKTests.Models.TrocaFormaPagamento;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, Windows, Messages, DateUtils, SyncObjs, PanamahSDKTestCase,
  PanamahSDK.Enums, PanamahSDK.Operation, PanamahSDK.Types, PanamahSDK.Client, PanamahSDK.Batch, PanamahSDK.Models.Acesso,
  PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra, PanamahSDK.Models.Ean,
  PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa, PanamahSDK.Models.FormaPagamento,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario, PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding,
  PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja, PanamahSDK.Models.Meta, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao, PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar,
  PanamahSDK.Models.TituloReceber, PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento,
  PanamahSDK.Models.Venda, PanamahSDK.NFe, PanamahSDK.Consts, PanamahSDK;

type

  TTestTrocaFormaPagamentoTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingTrocaFormaPagamento;
    procedure TestSendingTrocaFormaPagamentoMultitenancy;
  end;

implementation

{ TTestTrocaFormaPagamentoTestCase }

function TTestTrocaFormaPagamentoTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestTrocaFormaPagamentoTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TTestTrocaFormaPagamentoTestCase.TestSendingTrocaFormaPagamento;
var
  JSON: string;
  TrocaFormaPagamento: IPanamahTrocaFormaPagamento;
begin
  JSON := TFile.ReadAllText(GetFixturePath('troca-forma-pagamento.json'));
  TrocaFormaPagamento := TPanamahTrocaFormaPagamento.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Save(TrocaFormaPagamento);
    Flush;
  end;
end;

procedure TTestTrocaFormaPagamentoTestCase.TestSendingTrocaFormaPagamentoMultitenancy;
var
  JSON: string;
  TrocaFormaPagamento: IPanamahTrocaFormaPagamento;
begin
  JSON := TFile.ReadAllText(GetFixturePath('troca-forma-pagamento.json'));
  TrocaFormaPagamento := TPanamahTrocaFormaPagamento.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      '*'
    );
    Save(TrocaFormaPagamento, '03992843467');
    Save(TrocaFormaPagamento, '02541926375');
    Save(TrocaFormaPagamento, '00934509022');
    Flush;
  end;
end;

initialization
  RegisterTest(TTestTrocaFormaPagamentoTestCase.Suite);

end.
