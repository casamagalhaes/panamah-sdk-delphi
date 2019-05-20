unit PanamahSDK.ModelUtils;

interface

uses
  Classes, SysUtils, PanamahSDK.Types;

  function ParseJSONOfModelByDataType(const ADataType, AJSON: string): IPanamahModel;
  function GetModelFromInterfaceList(AList: TInterfaceList; AIndex: Integer): IPanamahModel;
  function GetAsModel(AInstance: IInterface): IPanamahModel;

implementation

uses
  PanamahSDK.Models.Acesso, PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra,
  PanamahSDK.Models.Ean, PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa,
  PanamahSDK.Models.FormaPagamento, PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario,
  PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding, PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja,
  PanamahSDK.Models.Meta, PanamahSDK.Models.Produto, PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao,
  PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar, PanamahSDK.Models.TituloReceber,
  PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento, PanamahSDK.Models.Venda;

function ParseJSONOfModelByDataType(const ADataType, AJSON: string): IPanamahModel;
begin
  if SameText(ADataType, 'ACESSO') then Result := TPanamahAcesso.FromJSON(AJSON) else
  if SameText(ADataType, 'ASSINANTE') then Result := TPanamahAssinante.FromJSON(AJSON) else
  if SameText(ADataType, 'CLIENTE') then Result := TPanamahCliente.FromJSON(AJSON) else
  if SameText(ADataType, 'COMPRA') then Result := TPanamahCompra.FromJSON(AJSON) else
  if SameText(ADataType, 'EAN') then Result := TPanamahEan.FromJSON(AJSON) else
  if SameText(ADataType, 'ESTOQUE_MOVIMENTACAO') then Result := TPanamahEstoqueMovimentacao.FromJSON(AJSON) else
  if SameText(ADataType, 'EVENTO_CAIXA') then Result := TPanamahEventoCaixa.FromJSON(AJSON) else
  if SameText(ADataType, 'FORMA_PAGAMENTO') then Result := TPanamahFormaPagamento.FromJSON(AJSON) else
  if SameText(ADataType, 'FORNECEDOR') then Result := TPanamahFornecedor.FromJSON(AJSON) else
  if SameText(ADataType, 'FUNCIONARIO') then Result := TPanamahFuncionario.FromJSON(AJSON) else
  if SameText(ADataType, 'GRUPO') then Result := TPanamahGrupo.FromJSON(AJSON) else
  if SameText(ADataType, 'HOLDING') then Result := TPanamahHolding.FromJSON(AJSON) else
  if SameText(ADataType, 'LOCAL_ESTOQUE') then Result := TPanamahLocalEstoque.FromJSON(AJSON) else
  if SameText(ADataType, 'LOJA') then Result := TPanamahLoja.FromJSON(AJSON) else
  if SameText(ADataType, 'META') then Result := TPanamahMeta.FromJSON(AJSON) else
  if SameText(ADataType, 'PRODUTO') then Result := TPanamahProduto.FromJSON(AJSON) else
  if SameText(ADataType, 'REVENDA') then Result := TPanamahRevenda.FromJSON(AJSON) else
  if SameText(ADataType, 'SECAO') then Result := TPanamahSecao.FromJSON(AJSON) else
  if SameText(ADataType, 'SUBGRUPO') then Result := TPanamahSubgrupo.FromJSON(AJSON) else
  if SameText(ADataType, 'TITULO_PAGAR') then Result := TPanamahTituloPagar.FromJSON(AJSON) else
  if SameText(ADataType, 'TITULO_RECEBER') then Result := TPanamahTituloReceber.FromJSON(AJSON) else
  if SameText(ADataType, 'TROCA_DEVOLUCAO') then Result := TPanamahTrocaDevolucao.FromJSON(AJSON) else
  if SameText(ADataType, 'TROCA_FORMA_PAGAMENTO') then Result := TPanamahTrocaFormaPagamento.FromJSON(AJSON) else
  if SameText(ADataType, 'VENDA') then Result := TPanamahVenda.FromJSON(AJSON);
end;

function GetModelFromInterfaceList(AList: TInterfaceList; AIndex: Integer): IPanamahModel;
begin
  Result := GetAsModel(AList[AIndex]);
end;

function GetAsModel(AInstance: IInterface): IPanamahModel;
begin
  if Supports(AInstance, IPanamahAcesso, Result) then Exit else
  if Supports(AInstance, IPanamahAssinante, Result) then Exit else
  if Supports(AInstance, IPanamahCliente, Result) then Exit else
  if Supports(AInstance, IPanamahCompra, Result) then Exit else
  if Supports(AInstance, IPanamahEan, Result) then Exit else
  if Supports(AInstance, IPanamahEstoqueMovimentacao, Result) then Exit else
  if Supports(AInstance, IPanamahEventoCaixa, Result) then Exit else
  if Supports(AInstance, IPanamahFormaPagamento, Result) then Exit else
  if Supports(AInstance, IPanamahFornecedor, Result) then Exit else
  if Supports(AInstance, IPanamahFuncionario, Result) then Exit else
  if Supports(AInstance, IPanamahGrupo, Result) then Exit else
  if Supports(AInstance, IPanamahHolding, Result) then Exit else
  if Supports(AInstance, IPanamahLocalEstoque, Result) then Exit else
  if Supports(AInstance, IPanamahLoja, Result) then Exit else
  if Supports(AInstance, IPanamahMeta, Result) then Exit else
  if Supports(AInstance, IPanamahProduto, Result) then Exit else
  if Supports(AInstance, IPanamahRevenda, Result) then Exit else
  if Supports(AInstance, IPanamahSecao, Result) then Exit else
  if Supports(AInstance, IPanamahSubgrupo, Result) then Exit else
  if Supports(AInstance, IPanamahTituloPagar, Result) then Exit else
  if Supports(AInstance, IPanamahTituloReceber, Result) then Exit else
  if Supports(AInstance, IPanamahTrocaDevolucao, Result) then Exit else
  if Supports(AInstance, IPanamahTrocaFormaPagamento, Result) then Exit else
  if Supports(AInstance, IPanamahVenda, Result) then Exit;
end;

end.
