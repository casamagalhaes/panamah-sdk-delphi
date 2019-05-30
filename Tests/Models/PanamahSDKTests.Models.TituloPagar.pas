unit PanamahSDKTests.Models.TituloPagar;

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

  TTestTituloPagarTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingTituloPagar;
    procedure TestSendingTituloPagarMultitenancy;
  end;

implementation

{ TTestTituloPagarTestCase }

function TTestTituloPagarTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestTituloPagarTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TTestTituloPagarTestCase.TestSendingTituloPagar;
var
  JSON: string;
  TituloPagar: IPanamahTituloPagar;
begin
  JSON := TFile.ReadAllText(GetFixturePath('titulo-pagar.json'));
  TituloPagar := TPanamahTituloPagar.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Save(TituloPagar);
    Flush;
  end;
end;

procedure TTestTituloPagarTestCase.TestSendingTituloPagarMultitenancy;
var
  JSON: string;
  TituloPagar: IPanamahTituloPagar;
begin
  JSON := TFile.ReadAllText(GetFixturePath('titulo-pagar.json'));
  TituloPagar := TPanamahTituloPagar.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET')
    );
    Save(TituloPagar, '03992843467');
    Save(TituloPagar, '02541926375');
    Save(TituloPagar, '00934509022');
    Flush;
  end;
end;

initialization
  RegisterTest(TTestTituloPagarTestCase.Suite);

end.
