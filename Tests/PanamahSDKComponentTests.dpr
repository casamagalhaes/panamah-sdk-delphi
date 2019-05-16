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

