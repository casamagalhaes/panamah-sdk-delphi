unit PanamahSDKTests.Models.Fornecedor;

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

  TTestFornecedorTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingFornecedor;
    procedure TestSendingFornecedorMultitenancy;
  end;

implementation

{ TTestFornecedorTestCase }

function TTestFornecedorTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestFornecedorTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TTestFornecedorTestCase.TestSendingFornecedor;
var
  JSON: string;
  Fornecedor: IPanamahFornecedor;
begin
  JSON := TFile.ReadAllText(GetFixturePath('fornecedor.json'));
  Fornecedor := TPanamahFornecedor.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Save(Fornecedor);
    Flush;
  end;
end;

procedure TTestFornecedorTestCase.TestSendingFornecedorMultitenancy;
var
  JSON: string;
  Fornecedor: IPanamahFornecedor;
begin
  JSON := TFile.ReadAllText(GetFixturePath('fornecedor.json'));
  Fornecedor := TPanamahFornecedor.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      '*'
    );
    Save(Fornecedor, '03992843467');
    Save(Fornecedor, '02541926375');
    Save(Fornecedor, '00934509022');
    Flush;
  end;
end;

initialization
  RegisterTest(TTestFornecedorTestCase.Suite);

end.
