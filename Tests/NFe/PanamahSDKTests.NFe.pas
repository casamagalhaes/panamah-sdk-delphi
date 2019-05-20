unit PanamahSDKTests.NFe;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, PanamahSDK.Types,
  PanamahSDK.NFe, PanamahSDK.Models.Loja, PanamahSDK.Models.Fornecedor,
  PanamahSDK.Models.Cliente, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Venda;

type

  TTestNFeDeserializerTestCase = class(TTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
  published
    procedure TestDeserializeLojaFromEmit;
    procedure TestDeserializeClienteFromDest;
    procedure TestDeserializeFornecedorFromEmit;
    procedure TestDeserializeLojaFromDest;
    procedure TestDeserializeProdutosFromProd;
    procedure TextDeserializeVendaFromNFe;
  end;

implementation

{ TPanamahNFeDeserializerTestCase }

function TTestNFeDeserializerTestCase.GetFixturePath(
  const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\NFe\Fixtures\', AFilename);
end;

procedure TTestNFeDeserializerTestCase.TestDeserializeClienteFromDest;
var
  Cliente: IPanamahCliente;
begin
  Cliente := TPanamahNFeDeserializer.DeserializeClienteFromDest(TFile.ReadAllText(GetFixturePath('NFe13190507128945000132655081000000901000000040.xml')));
  Assert(Cliente.Id = '01954049390', 'Id lido incorretamente do xml');
  Assert(Cliente.Nome = 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL', 'Descricao lido incorretamente do xml');
  Assert(Cliente.NumeroDocumento = '01954049390', 'NumeroDocumento lido incorretamente do xml');
  Assert(Cliente.Uf = 'AM', 'Uf lido incorretamente do xml');
  Assert(Cliente.Bairro = 'Flores', 'Bairro lido incorretamente do xml');
  Assert(Cliente.Cidade = 'Manaus', 'Cidade lido incorretamente do xml');
end;

procedure TTestNFeDeserializerTestCase.TestDeserializeFornecedorFromEmit;
var
  Fornecedor: IPanamahFornecedor;
begin
  Fornecedor := TPanamahNFeDeserializer.DeserializeFornecedorFromEmit(TFile.ReadAllText(GetFixturePath('NFe13190507128945000132652340000000129000000104.xml')));
  Assert(Fornecedor.Id = '07128945000132', 'Id lido incorretamente do xml');
  Assert(Fornecedor.Nome = 'Casa Magalhaes Automacao Ltda.', 'Descricao lido incorretamente do xml');
  Assert(Fornecedor.NumeroDocumento = '07128945000132', 'NumeroDocumento lido incorretamente do xml');
  Assert(Fornecedor.Uf = 'AM', 'Uf lido incorretamente do xml');
  Assert(Fornecedor.Bairro = 'Flores', 'Bairro lido incorretamente do xml');
  Assert(Fornecedor.Cidade = 'Manaus', 'Cidade lido incorretamente do xml');
end;

procedure TTestNFeDeserializerTestCase.TestDeserializeLojaFromDest;
var
  Loja: IPanamahLoja;
begin
  Loja := TPanamahNFeDeserializer.DeserializeLojaFromDest(TFile.ReadAllText(GetFixturePath('NFe13190507128945000132655081000000901000000040.xml')));
  Assert(Loja.Id = '01954049390', 'Id lido incorretamente do xml');
  Assert(Loja.Descricao = 'NF-E EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL', 'Descricao lido incorretamente do xml');
  Assert(Loja.NumeroDocumento = '01954049390', 'NumeroDocumento lido incorretamente do xml');
  Assert(Loja.Uf = 'AM', 'Uf lido incorretamente do xml');
  Assert(Loja.Logradouro = 'Souza Campos', 'Logradouro lido incorretamente do xml');
  Assert(Loja.Numero = '800', 'Numero lido incorretamente do xml');
  Assert(Loja.Complemento = EmptyStr, 'Complemento lido incorretamente do xml');
  Assert(Loja.Bairro = 'Flores', 'Bairro lido incorretamente do xml');
  Assert(Loja.Cep = EmptyStr, 'Cep lido incorretamente do xml');
  Assert(Loja.Cidade = 'Manaus', 'Cidade lido incorretamente do xml');
end;

procedure TTestNFeDeserializerTestCase.TestDeserializeLojaFromEmit;
var
  Loja: IPanamahLoja;
begin
  Loja := TPanamahNFeDeserializer.DeserializeLojaFromEmit(TFile.ReadAllText(GetFixturePath('NFe13190507128945000132652340000000129000000104.xml')));
  Assert(Loja.Id = '07128945000132', 'Id lido incorretamente do xml');
  Assert(Loja.Descricao = 'Casa Magalhaes Automacao Ltda.', 'Descricao lido incorretamente do xml');
  Assert(Loja.NumeroDocumento = '07128945000132', 'NumeroDocumento lido incorretamente do xml');
  Assert(Loja.Uf = 'AM', 'Uf lido incorretamente do xml');
  Assert(Loja.Logradouro = 'Souza Campos', 'Logradouro lido incorretamente do xml');
  Assert(Loja.Numero = '800', 'Numero lido incorretamente do xml');
  Assert(Loja.Complemento = 'BLOCO 1 SALA 01', 'Complemento lido incorretamente do xml');
  Assert(Loja.Bairro = 'Flores', 'Bairro lido incorretamente do xml');
  Assert(Loja.Cep = '69028302', 'Cep lido incorretamente do xml');
  Assert(Loja.Cidade = 'Manaus', 'Cidade lido incorretamente do xml');
end;

procedure TTestNFeDeserializerTestCase.TestDeserializeProdutosFromProd;
var
  Produtos: IPanamahProdutoList;
begin
  Produtos := TPanamahNFeDeserializer.DeserializeProdutosFromProd(TFile.ReadAllText(
    GetFixturePath('NFe13190507128945000132650340000000111000000099.xml'))
  );
  Assert(Produtos.Count = 6, 'Número incorreto de produtos lidos do xml');

  Assert(Produtos[0].Id = '00000075', 'Id do produto 0 lido incorretamente do xml');
  Assert(Produtos[0].Descricao = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL', 'Descrição do produto 0 lido incorretamente do xml');

  Assert(Produtos[1].Id = '00000005', 'Id do produto 1 lido incorretamente do xml');
  Assert(Produtos[1].Descricao = 'Celular Moto G 6', 'Descrição do produto 1 lido incorretamente do xml');

  Assert(Produtos[2].Id = '00000005', 'Id do produto 2 lido incorretamente do xml');
  Assert(Produtos[2].Descricao = 'Celular Moto G 6', 'Descrição do produto 2 lido incorretamente do xml');

  Assert(Produtos[3].Id = '00000075', 'Id do produto 3 lido incorretamente do xml');
  Assert(Produtos[3].Descricao = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL', 'Descrição do produto 3 lido incorretamente do xml');

  Assert(Produtos[4].Id = '00000075', 'Id do produto 4 lido incorretamente do xml');
  Assert(Produtos[4].Descricao = 'NOTA FISCAL EMITIDA EM AMBIENTE DE HOMOLOGACAO - SEM VALOR FISCAL', 'Descrição do produto 4 lido incorretamente do xml');

  Assert(Produtos[5].Id = '00000005', 'Id do produto 5 lido incorretamente do xml');
  Assert(Produtos[5].Descricao = 'Celular Moto G 6', 'Descrição do produto 5 lido incorretamente do xml');
end;

procedure TTestNFeDeserializerTestCase.TextDeserializeVendaFromNFe;
var
  Venda: IPanamahVenda;
begin
  Venda := TPanamahNFeDeserializer.DeserializeVendaFromNFe(TFile.ReadAllText(
    GetFixturePath('NFe13190507128945000132650340000000111000000099.xml'))
  );

  Assert(Venda.Id = 'NFe13190507128945000132650340000000111000000099', 'Id não lido corretamente do xml');
  Assert(Venda.Valor = 2564.00, 'Valor não lido corretamente do xml');
  Assert(Venda.QuantidadeItens = 6, 'Quantidade de itens não lida corretamente do xml');
  Assert(Venda.Data = ISO8601ToDateTime('2019-05-03T18:54:23-03:00'), 'Data não lida corretamente do xml');

  Assert(Venda.Itens[0].ProdutoId = '00000075', 'Id do produto 0 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[0].Quantidade, 1), 'Quantidade do produto 0 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[0].Preco, 12), 'Preco do produto 0 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[0].ValorTotal, 12), 'Valor Total do produto 0 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[0].Desconto, 0.45), 'Desconto do produto 0 lido incorretamente do xml');

  Assert(Venda.Itens[1].ProdutoId = '00000005', 'Id do produto 1 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[1].Quantidade, 1), 'Quantidade do produto 1 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[1].Preco, 580), 'Preco do produto 1 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[1].ValorTotal, 580), 'Valor Total do produto 1 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[1].Desconto, 21.75), 'Desconto do produto 1 lido incorretamente do xml');

  Assert(Venda.Itens[2].ProdutoId = '00000005', 'Id do produto 2 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[2].Quantidade, 1), 'Quantidade do produto 2 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[2].Preco, 580), 'Preco do produto 2 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[2].ValorTotal, 580), 'Valor Total do produto 2 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[2].Desconto, 21.75), 'Desconto do produto 2 lido incorretamente do xml');

  Assert(Venda.Itens[3].ProdutoId = '00000075', 'Id do produto 3 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[3].Quantidade, 1), 'Quantidade do produto 3 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[3].Preco, 12), 'Preco do produto 3 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[3].ValorTotal, 12), 'Valor Total do produto 3 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[3].Desconto, 0.45), 'Desconto do produto 3 lido incorretamente do xml');

  Assert(Venda.Itens[4].ProdutoId = '00000075', 'Id do produto 4 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[4].Quantidade, 75), 'Quantidade do produto 4 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[4].Preco, 900), 'Preco do produto 4 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[4].ValorTotal, 67500), 'Valor Total do produto 4 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[4].Desconto, 33.75), 'Desconto do produto 4 lido incorretamente do xml');

  Assert(Venda.Itens[5].ProdutoId = '00000005', 'Id do produto 5 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[5].Quantidade, 1), 'Quantidade do produto 5 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[5].Preco, 580), 'Preco do produto 5 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[5].ValorTotal, 580), 'Valor Total do produto 5 lido incorretamente do xml');
  Assert(SameValue(Venda.Itens[5].Desconto, 21.85), 'Desconto do produto 5 lido incorretamente do xml');
end;

initialization
  RegisterTest(TTestNFeDeserializerTestCase.Suite);

end.
