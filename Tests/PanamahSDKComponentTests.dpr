program PanamahSDKComponentTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  DUnitTestRunner,
  DCPbase64 in '..\Lib\DCPbase64.pas',
  DCPconst in '..\Lib\DCPconst.pas',
  DCPcrypt2 in '..\Lib\DCPcrypt2.pas',
  DCPsha1 in '..\Lib\DCPsha1.pas',
  DCPsha256 in '..\Lib\DCPsha256.pas',
  MD5 in '..\Lib\MD5.pas',
  uLkJSON in '..\Lib\uLkJSON.pas',
  uSHA1 in '..\Lib\uSHA1.pas',
  PanamahSDK.Models.Acesso in '..\Models\PanamahSDK.Models.Acesso.pas',
  PanamahSDK.Models.Assinante in '..\Models\PanamahSDK.Models.Assinante.pas',
  PanamahSDK.Models.Cliente in '..\Models\PanamahSDK.Models.Cliente.pas',
  PanamahSDK.Models.Compra in '..\Models\PanamahSDK.Models.Compra.pas',
  PanamahSDK.Models.Ean in '..\Models\PanamahSDK.Models.Ean.pas',
  PanamahSDK.Models.EstoqueMovimentacao in '..\Models\PanamahSDK.Models.EstoqueMovimentacao.pas',
  PanamahSDK.Models.EventoCaixa in '..\Models\PanamahSDK.Models.EventoCaixa.pas',
  PanamahSDK.Models.FormaPagamento in '..\Models\PanamahSDK.Models.FormaPagamento.pas',
  PanamahSDK.Models.Fornecedor in '..\Models\PanamahSDK.Models.Fornecedor.pas',
  PanamahSDK.Models.Funcionario in '..\Models\PanamahSDK.Models.Funcionario.pas',
  PanamahSDK.Models.Grupo in '..\Models\PanamahSDK.Models.Grupo.pas',
  PanamahSDK.Models.Holding in '..\Models\PanamahSDK.Models.Holding.pas',
  PanamahSDK.Models.LocalEstoque in '..\Models\PanamahSDK.Models.LocalEstoque.pas',
  PanamahSDK.Models.Loja in '..\Models\PanamahSDK.Models.Loja.pas',
  PanamahSDK.Models.Meta in '..\Models\PanamahSDK.Models.Meta.pas',
  PanamahSDK.Models.Produto in '..\Models\PanamahSDK.Models.Produto.pas',
  PanamahSDK.Models.Revenda in '..\Models\PanamahSDK.Models.Revenda.pas',
  PanamahSDK.Models.Secao in '..\Models\PanamahSDK.Models.Secao.pas',
  PanamahSDK.Models.Subgrupo in '..\Models\PanamahSDK.Models.Subgrupo.pas',
  PanamahSDK.Models.TituloPagar in '..\Models\PanamahSDK.Models.TituloPagar.pas',
  PanamahSDK.Models.TituloReceber in '..\Models\PanamahSDK.Models.TituloReceber.pas',
  PanamahSDK.Models.TrocaDevolucao in '..\Models\PanamahSDK.Models.TrocaDevolucao.pas',
  PanamahSDK.Models.TrocaFormaPagamento in '..\Models\PanamahSDK.Models.TrocaFormaPagamento.pas',
  PanamahSDK.Models.Venda in '..\Models\PanamahSDK.Models.Venda.pas',
  PanamahSDK.Batch in '..\PanamahSDK.Batch.pas',
  PanamahSDK.Client in '..\PanamahSDK.Client.pas',
  PanamahSDK.Consts in '..\PanamahSDK.Consts.pas',
  PanamahSDK.Crypto in '..\PanamahSDK.Crypto.pas',
  PanamahSDK.Enums in '..\PanamahSDK.Enums.pas',
  PanamahSDK.JsonUtils in '..\PanamahSDK.JsonUtils.pas',
  PanamahSDK.NFe in '..\PanamahSDK.NFe.pas',
  PanamahSDK.Operation in '..\PanamahSDK.Operation.pas',
  PanamahSDK in '..\PanamahSDK.pas',
  PanamahSDK.PendingResources in '..\PanamahSDK.PendingResources.pas',
  PanamahSDK.Processor in '..\PanamahSDK.Processor.pas',
  PanamahSDK.Types in '..\PanamahSDK.Types.pas',
  PanamahSDK.ValidationUtils in '..\PanamahSDK.ValidationUtils.pas',
  PanamahSDK.XMLUtils in '..\PanamahSDK.XMLUtils.pas',
  PanamahSDKTests.NFe in 'NFe\PanamahSDKTests.NFe.pas',
  PanamahSDKTests.Models.Acesso in 'Models\PanamahSDKTests.Models.Acesso.pas',
  PanamahSDKTests.Models.Assinante in 'Models\PanamahSDKTests.Models.Assinante.pas',
  PanamahSDKTests.Models.Cliente in 'Models\PanamahSDKTests.Models.Cliente.pas',
  PanamahSDKTests.Models.Compra in 'Models\PanamahSDKTests.Models.Compra.pas',
  PanamahSDKTests.Models.Ean in 'Models\PanamahSDKTests.Models.Ean.pas',
  PanamahSDKTests.Models.EstoqueMovimentacao in 'Models\PanamahSDKTests.Models.EstoqueMovimentacao.pas',
  PanamahSDKTests.Models.EventoCaixa in 'Models\PanamahSDKTests.Models.EventoCaixa.pas',
  PanamahSDKTests.Models.FormaPagamento in 'Models\PanamahSDKTests.Models.FormaPagamento.pas',
  PanamahSDKTests.Models.Fornecedor in 'Models\PanamahSDKTests.Models.Fornecedor.pas',
  PanamahSDKTests.Models.Funcionario in 'Models\PanamahSDKTests.Models.Funcionario.pas',
  PanamahSDKTests.Models.Grupo in 'Models\PanamahSDKTests.Models.Grupo.pas',
  PanamahSDKTests.Models.Holding in 'Models\PanamahSDKTests.Models.Holding.pas',
  PanamahSDKTests.Models.LocalEstoque in 'Models\PanamahSDKTests.Models.LocalEstoque.pas',
  PanamahSDKTests.Models.Loja in 'Models\PanamahSDKTests.Models.Loja.pas',
  PanamahSDKTests.Models.Meta in 'Models\PanamahSDKTests.Models.Meta.pas',
  PanamahSDKTests.Models.Produto in 'Models\PanamahSDKTests.Models.Produto.pas',
  PanamahSDKTests.Models.Revenda in 'Models\PanamahSDKTests.Models.Revenda.pas',
  PanamahSDKTests.Models.Secao in 'Models\PanamahSDKTests.Models.Secao.pas',
  PanamahSDKTests.Models.Subgrupo in 'Models\PanamahSDKTests.Models.Subgrupo.pas',
  PanamahSDKTests.Models.TituloPagar in 'Models\PanamahSDKTests.Models.TituloPagar.pas',
  PanamahSDKTests.Models.TituloReceber in 'Models\PanamahSDKTests.Models.TituloReceber.pas',
  PanamahSDKTests.Models.TrocaDevolucao in 'Models\PanamahSDKTests.Models.TrocaDevolucao.pas',
  PanamahSDKTests.Models.TrocaFormaPagamento in 'Models\PanamahSDKTests.Models.TrocaFormaPagamento.pas',
  PanamahSDKTests.Models.Venda in 'Models\PanamahSDKTests.Models.Venda.pas';

{$R *.RES}

begin
  ReportMemoryLeaksOnShutdown := True;
  DUnitTestRunner.RunRegisteredTests;
end.

