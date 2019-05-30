unit PanamahSDKTests.Models.Loja;

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

  TTestLojaTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingLoja;
    procedure TestSendingLojaMultitenancy;
  end;

implementation

{ TTestLojaTestCase }

function TTestLojaTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestLojaTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TTestLojaTestCase.TestSendingLoja;
var
  JSON: string;
  Loja: IPanamahLoja;
begin
  JSON := TFile.ReadAllText(GetFixturePath('loja.json'));
  Loja := TPanamahLoja.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Save(Loja);
    Flush;
  end;
end;

procedure TTestLojaTestCase.TestSendingLojaMultitenancy;
var
  JSON: string;
  Loja: IPanamahLoja;
begin
  JSON := TFile.ReadAllText(GetFixturePath('loja.json'));
  Loja := TPanamahLoja.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET')
    );
    Save(Loja, '03992843467');
    Save(Loja, '02541926375');
    Save(Loja, '00934509022');
    Flush;
  end;
end;

initialization
  RegisterTest(TTestLojaTestCase.Suite);

end.
