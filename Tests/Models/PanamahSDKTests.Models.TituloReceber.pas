unit PanamahSDKTests.Models.TituloReceber;

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

  TTestTituloReceberTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingTituloReceber;
    procedure TestSendingTituloReceberMultitenancy;
  end;

implementation

{ TTestTituloReceberTestCase }

function TTestTituloReceberTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestTituloReceberTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TTestTituloReceberTestCase.TestSendingTituloReceber;
var
  JSON: string;
  TituloReceber: IPanamahTituloReceber;
begin
  JSON := TFile.ReadAllText(GetFixturePath('titulo-receber.json'));
  TituloReceber := TPanamahTituloReceber.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Save(TituloReceber);
    Flush;
  end;
end;

procedure TTestTituloReceberTestCase.TestSendingTituloReceberMultitenancy;
var
  JSON: string;
  TituloReceber: IPanamahTituloReceber;
begin
  JSON := TFile.ReadAllText(GetFixturePath('titulo-receber.json'));
  TituloReceber := TPanamahTituloReceber.FromJSON(JSON);
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET')
    );
    Save(TituloReceber, '03992843467');
    Save(TituloReceber, '02541926375');
    Save(TituloReceber, '00934509022');
    Flush;
  end;
end;

initialization
  RegisterTest(TTestTituloReceberTestCase.Suite);

end.
