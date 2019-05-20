unit PanamahSDKTests.Models.Assinante;

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

  TTestAssinanteTestCase = class(TPanamahTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
  published
    procedure TestSendingAssinante;
  end;

implementation

{ TTestAssinanteTestCase }

function TTestAssinanteTestCase.GetFixturePath(const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\Models\Fixtures\', AFilename);
end;

procedure TTestAssinanteTestCase.TestSendingAssinante;
var
  JSON: string;
  Assinante: IPanamahAssinante;
begin
  JSON := TFile.ReadAllText(GetFixturePath('assinante.json'));
  Assinante := TPanamahAssinante.FromJSON(JSON);
  with TPanamahAdmin.GetInstance do
  begin
    Init(GetTestVariable('AUTHORIZATION_TOKEN'));
    try
      GetAssinante(Assinante.Id);
    except
      on E: EPanamahSDKNotFoundException do
      begin
        SaveAssinante(Assinante);
      end;
    end;
  end;
end;

initialization
  RegisterTest(TTestAssinanteTestCase.Suite);

end.
