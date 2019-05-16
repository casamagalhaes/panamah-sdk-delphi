unit PanamahSDKTests.Models.Fornecedor;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, Windows, Messages, DateUtils, SyncObjs,
  PanamahSDK.Enums, PanamahSDK.Operation, PanamahSDK.Types, PanamahSDK.Client, PanamahSDK.Batch, PanamahSDK.Models.Acesso,
  PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra, PanamahSDK.Models.Ean,
  PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa, PanamahSDK.Models.FormaPagamento,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario, PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding,
  PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja, PanamahSDK.Models.Meta, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao, PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar,
  PanamahSDK.Models.TituloReceber, PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento,
  PanamahSDK.Models.Venda, PanamahSDK.NFe, PanamahSDK.Consts, PanamahSDK;

type

  TTestFornecedorTestCase = class(TTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure OnError(Error: Exception);
  published
    procedure TestSendingFornecedor;
  end;

const
  AUTHORIZATION_TOKEN = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbkNsYXNzIjoiU09GVFdBUkUiLCJzb2Z0d2FyZSI6eyJwYXJ0bmVySWQiOiI' +
                        '1OTI3OTJhZC00MDk4LTQxZDgtYWM3My1hYTc2ZjM4ZTI1MWMiLCJpZCI6ImIwMWUyN2I3LTVkMjYtNGE0ZS05ZWU3LTJjN2FkN2RiZjQ' +
                        'xMiIsImRlc2NyIjoiVkFSRUpPTUlOSSIsInN0cmVhbU5hbWUiOiJjbS12YXJlam9taW5pLWRhdGEiLCJzZWNyZXQiOiJkOGE2Y2IyNjM' +
                        'xODI0OTNjODFhY2JlOTA0N2ExZDViNCJ9LCJpYXQiOjE1NTc3NzYyODh9.4rM_5KuwWqoHAPNDR8YfD5OBhp7C4FhAv7mgud-Ff9o';
  SECRET = 'd8a6cb263182493c81acbe9047a1d5b4';
  ASSINANTE_ID = '03992843467';

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
    Init(AUTHORIZATION_TOKEN, SECRET, ASSINANTE_ID);
    Save(Fornecedor);
    Flush;
  end;
end;

initialization
  RegisterTest(TTestFornecedorTestCase.Suite);

end.
