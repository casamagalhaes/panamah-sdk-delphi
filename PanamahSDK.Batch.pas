{$M+}
unit PanamahSDK.Batch;

interface

uses
  Classes, StrUtils, PanamahSDK.JsonUtils, uLkJSON, PanamahSDK.Types, PanamahSDK.Models.Acesso,
  PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra, PanamahSDK.Models.Ean,
  PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa, PanamahSDK.Models.FormaPagamento,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario, PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding,
  PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja, PanamahSDK.Models.Meta, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao, PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar,
  PanamahSDK.Models.TituloReceber, PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento,
  PanamahSDK.Models.Venda;

type

  IPanamahBatch = interface(IJSONSerializable)
    ['{97748D13-F5B3-48B8-AA21-19E769790589}']
    procedure SetAcessos(AAcessos: IPanamahAcessoList);
    procedure SetAssinantes(AAssinantes: IPanamahAssinanteList);
    procedure SetClientes(AClientes: IPanamahClienteList);
    procedure SetCompras(ACompras: IPanamahCompraList);
    procedure SetEans(AEans: IPanamahEanList);
    procedure SetEstoqueMovimentacoes(AEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList);
    procedure SetEventosCaixa(AEventosCaixa: IPanamahEventoCaixaList);
    procedure SetFormasPagamento(AFormasPagamento: IPanamahFormaPagamentoList);
    procedure SetFornecedores(AFornecedores: IPanamahFornecedorList);
    procedure SetFuncionarios(AFuncionarios: IPanamahFuncionarioList);
    procedure SetGrupos(AGrupos: IPanamahGrupoList);
    procedure SetHoldings(AHoldings: IPanamahHoldingList);
    procedure SetLocaisEstoque(ALocaisEstoque: IPanamahLocalEstoqueList);
    procedure SetLojas(ALojas: IPanamahLojaList);
    procedure SetMetas(AMetas: IPanamahMetaList);
    procedure SetProdutos(AProdutos: IPanamahProdutoList);
    procedure SetRevendas(ARevendas: IPanamahRevendaList);
    procedure SetSecoes(ASecoes: IPanamahSecaoList);
    procedure SetSubgrupos(ASubgrupos: IPanamahSubgrupoList);
    procedure SetTitulosPagar(ATitulosPagar: IPanamahTituloPagarList);
    procedure SetTitulosReceber(ATitulosReceber: IPanamahTituloReceberList);
    procedure SetTrocasDevolucoes(ATrocasDevolucoes: IPanamahTrocaDevolucaoList);
    procedure SetTrocasFormaPagamento(ATrocasFormaPagamento: IPanamahTrocaFormaPagamentoList);
    procedure SetVendas(AVendas: IPanamahVendaList);
    procedure Add(AAcesso: IPanamahAcesso); overload;
    procedure Add(AAssinante: IPanamahAssinante); overload;
    procedure Add(ACliente: IPanamahCliente); overload;
    procedure Add(ACompra: IPanamahCompra); overload;
    procedure Add(AEan: IPanamahEan); overload;
    procedure Add(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Add(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Add(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Add(AFornecedor: IPanamahFornecedor); overload;
    procedure Add(AFuncionario: IPanamahFuncionario); overload;
    procedure Add(AGrupo: IPanamahGrupo); overload;
    procedure Add(AHolding: IPanamahHolding); overload;
    procedure Add(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Add(ALoja: IPanamahLoja); overload;
    procedure Add(AMeta: IPanamahMeta); overload;
    procedure Add(AProduto: IPanamahProduto); overload;
    procedure Add(ARevenda: IPanamahRevenda); overload;
    procedure Add(ASecao: IPanamahSecao); overload;
    procedure Add(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Add(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Add(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Add(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Add(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Add(AVenda: IPanamahVenda); overload;
    function GetAcessos: IPanamahAcessoList;
    function GetAssinantes: IPanamahAssinanteList;
    function GetClientes: IPanamahClienteList;
    function GetCompras: IPanamahCompraList;
    function GetEans: IPanamahEanList;
    function GetEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList;
    function GetEventosCaixa: IPanamahEventoCaixaList;
    function GetFormasPagamento: IPanamahFormaPagamentoList;
    function GetFornecedores: IPanamahFornecedorList;
    function GetFuncionarios: IPanamahFuncionarioList;
    function GetGrupos: IPanamahGrupoList;
    function GetHoldings: IPanamahHoldingList;
    function GetLocaisEstoque: IPanamahLocalEstoqueList;
    function GetLojas: IPanamahLojaList;
    function GetMetas: IPanamahMetaList;
    function GetProdutos: IPanamahProdutoList;
    function GetRevendas: IPanamahRevendaList;
    function GetSecoes: IPanamahSecaoList;
    function GetSubgrupos: IPanamahSubgrupoList;
    function GetTitulosPagar: IPanamahTituloPagarList;
    function GetTitulosReceber: IPanamahTituloReceberList;
    function GetTrocasDevolucoes: IPanamahTrocaDevolucaoList;
    function GetTrocasFormaPagamento: IPanamahTrocaFormaPagamentoList;
    function GetVendas: IPanamahVendaList;
    property Acessos: IPanamahAcessoList read GetAcessos write SetAcessos;
    property Assinantes: IPanamahAssinanteList read GetAssinantes write SetAssinantes;
    property Clientes: IPanamahClienteList read GetClientes write SetClientes;
    property Compras: IPanamahCompraList read GetCompras write SetCompras;
    property Eans: IPanamahEanList read GetEans write SetEans;
    property EstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList read GetEstoqueMovimentacoes write SetEstoqueMovimentacoes;
    property EventosCaixa: IPanamahEventoCaixaList read GetEventosCaixa write SetEventosCaixa;
    property FormasPagamento: IPanamahFormaPagamentoList read GetFormasPagamento write SetFormasPagamento;
    property Fornecedores: IPanamahFornecedorList read GetFornecedores write SetFornecedores;
    property Funcionarios: IPanamahFuncionarioList read GetFuncionarios write SetFuncionarios;
    property Grupos: IPanamahGrupoList read GetGrupos write SetGrupos;
    property Holdings: IPanamahHoldingList read GetHoldings write SetHoldings;
    property LocaisEstoque: IPanamahLocalEstoqueList read GetLocaisEstoque write SetLocaisEstoque;
    property Lojas: IPanamahLojaList read GetLojas write SetLojas;
    property Metas: IPanamahMetaList read GetMetas write SetMetas;
    property Produtos: IPanamahProdutoList read GetProdutos write SetProdutos;
    property Revendas: IPanamahRevendaList read GetRevendas write SetRevendas;
    property Secoes: IPanamahSecaoList read GetSecoes write SetSecoes;
    property Subgrupos: IPanamahSubgrupoList read GetSubgrupos write SetSubgrupos;
    property TitulosPagar: IPanamahTituloPagarList read GetTitulosPagar write SetTitulosPagar;
    property TitulosReceber: IPanamahTituloReceberList read GetTitulosReceber write SetTitulosReceber;
    property TrocasDevolucoes: IPanamahTrocaDevolucaoList read GetTrocasDevolucoes write SetTrocasDevolucoes;
    property TrocasFormaPagamento: IPanamahTrocaFormaPagamentoList read GetTrocasFormaPagamento write SetTrocasFormaPagamento;
    property Vendas: IPanamahVendaList read GetVendas write SetVendas;
  end;

  TPanamahBatch = class(TInterfacedObject, IPanamahBatch)
  private
    FAcessos: IPanamahAcessoList;
    FAssinantes: IPanamahAssinanteList;
    FClientes: IPanamahClienteList;
    FCompras: IPanamahCompraList;
    FEans: IPanamahEanList;
    FEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList;
    FEventosCaixa: IPanamahEventoCaixaList;
    FFormasPagamento: IPanamahFormaPagamentoList;
    FFornecedores: IPanamahFornecedorList;
    FFuncionarios: IPanamahFuncionarioList;
    FGrupos: IPanamahGrupoList;
    FHoldings: IPanamahHoldingList;
    FLocaisEstoque: IPanamahLocalEstoqueList;
    FLojas: IPanamahLojaList;
    FMetas: IPanamahMetaList;
    FProdutos: IPanamahProdutoList;
    FRevendas: IPanamahRevendaList;
    FSecoes: IPanamahSecaoList;
    FSubgrupos: IPanamahSubgrupoList;
    FTitulosPagar: IPanamahTituloPagarList;
    FTitulosReceber: IPanamahTituloReceberList;
    FTrocasDevolucoes: IPanamahTrocaDevolucaoList;
    FTrocasFormaPagamento: IPanamahTrocaFormaPagamentoList;
    FVendas: IPanamahVendaList;
    procedure SetAcessos(AAcessos: IPanamahAcessoList);
    procedure SetAssinantes(AAssinantes: IPanamahAssinanteList);
    procedure SetClientes(AClientes: IPanamahClienteList);
    procedure SetCompras(ACompras: IPanamahCompraList);
    procedure SetEans(AEans: IPanamahEanList);
    procedure SetEstoqueMovimentacoes(AEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList);
    procedure SetEventosCaixa(AEventosCaixa: IPanamahEventoCaixaList);
    procedure SetFormasPagamento(AFormasPagamento: IPanamahFormaPagamentoList);
    procedure SetFornecedores(AFornecedores: IPanamahFornecedorList);
    procedure SetFuncionarios(AFuncionarios: IPanamahFuncionarioList);
    procedure SetGrupos(AGrupos: IPanamahGrupoList);
    procedure SetHoldings(AHoldings: IPanamahHoldingList);
    procedure SetLocaisEstoque(ALocaisEstoque: IPanamahLocalEstoqueList);
    procedure SetLojas(ALojas: IPanamahLojaList);
    procedure SetMetas(AMetas: IPanamahMetaList);
    procedure SetProdutos(AProdutos: IPanamahProdutoList);
    procedure SetRevendas(ARevendas: IPanamahRevendaList);
    procedure SetSecoes(ASecoes: IPanamahSecaoList);
    procedure SetSubgrupos(ASubgrupos: IPanamahSubgrupoList);
    procedure SetTitulosPagar(ATitulosPagar: IPanamahTituloPagarList);
    procedure SetTitulosReceber(ATitulosReceber: IPanamahTituloReceberList);
    procedure SetTrocasDevolucoes(ATrocasDevolucoes: IPanamahTrocaDevolucaoList);
    procedure SetTrocasFormaPagamento(ATrocasFormaPagamento: IPanamahTrocaFormaPagamentoList);
    procedure SetVendas(AVendas: IPanamahVendaList);
    procedure Add(AAcesso: IPanamahAcesso); overload;
    procedure Add(AAssinante: IPanamahAssinante); overload;
    procedure Add(ACliente: IPanamahCliente); overload;
    procedure Add(ACompra: IPanamahCompra); overload;
    procedure Add(AEan: IPanamahEan); overload;
    procedure Add(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao); overload;
    procedure Add(AEventoCaixa: IPanamahEventoCaixa); overload;
    procedure Add(AFormaPagamento: IPanamahFormaPagamento); overload;
    procedure Add(AFornecedor: IPanamahFornecedor); overload;
    procedure Add(AFuncionario: IPanamahFuncionario); overload;
    procedure Add(AGrupo: IPanamahGrupo); overload;
    procedure Add(AHolding: IPanamahHolding); overload;
    procedure Add(ALocalEstoque: IPanamahLocalEstoque); overload;
    procedure Add(ALoja: IPanamahLoja); overload;
    procedure Add(AMeta: IPanamahMeta); overload;
    procedure Add(AProduto: IPanamahProduto); overload;
    procedure Add(ARevenda: IPanamahRevenda); overload;
    procedure Add(ASecao: IPanamahSecao); overload;
    procedure Add(ASubgrupo: IPanamahSubgrupo); overload;
    procedure Add(ATituloPagar: IPanamahTituloPagar); overload;
    procedure Add(ATituloReceber: IPanamahTituloReceber); overload;
    procedure Add(ATrocaDevolucao: IPanamahTrocaDevolucao); overload;
    procedure Add(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento); overload;
    procedure Add(AVenda: IPanamahVenda); overload;
    function GetAcessos: IPanamahAcessoList;
    function GetAssinantes: IPanamahAssinanteList;
    function GetClientes: IPanamahClienteList;
    function GetCompras: IPanamahCompraList;
    function GetEans: IPanamahEanList;
    function GetEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList;
    function GetEventosCaixa: IPanamahEventoCaixaList;
    function GetFormasPagamento: IPanamahFormaPagamentoList;
    function GetFornecedores: IPanamahFornecedorList;
    function GetFuncionarios: IPanamahFuncionarioList;
    function GetGrupos: IPanamahGrupoList;
    function GetHoldings: IPanamahHoldingList;
    function GetLocaisEstoque: IPanamahLocalEstoqueList;
    function GetLojas: IPanamahLojaList;
    function GetMetas: IPanamahMetaList;
    function GetProdutos: IPanamahProdutoList;
    function GetRevendas: IPanamahRevendaList;
    function GetSecoes: IPanamahSecaoList;
    function GetSubgrupos: IPanamahSubgrupoList;
    function GetTitulosPagar: IPanamahTituloPagarList;
    function GetTitulosReceber: IPanamahTituloReceberList;
    function GetTrocasDevolucoes: IPanamahTrocaDevolucaoList;
    function GetTrocasFormaPagamento: IPanamahTrocaFormaPagamentoList;
    function GetVendas: IPanamahVendaList;
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    class function FromJSON(const AJSON: string): IPanamahBatch;
  published
    property Acessos: IPanamahAcessoList read GetAcessos write SetAcessos;
    property Assinantes: IPanamahAssinanteList read GetAssinantes write SetAssinantes;
    property Clientes: IPanamahClienteList read GetClientes write SetClientes;
    property Compras: IPanamahCompraList read GetCompras write SetCompras;
    property Eans: IPanamahEanList read GetEans write SetEans;
    property EstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList read GetEstoqueMovimentacoes write SetEstoqueMovimentacoes;
    property EventosCaixa: IPanamahEventoCaixaList read GetEventosCaixa write SetEventosCaixa;
    property FormasPagamento: IPanamahFormaPagamentoList read GetFormasPagamento write SetFormasPagamento;
    property Fornecedores: IPanamahFornecedorList read GetFornecedores write SetFornecedores;
    property Funcionarios: IPanamahFuncionarioList read GetFuncionarios write SetFuncionarios;
    property Grupos: IPanamahGrupoList read GetGrupos write SetGrupos;
    property Holdings: IPanamahHoldingList read GetHoldings write SetHoldings;
    property LocaisEstoque: IPanamahLocalEstoqueList read GetLocaisEstoque write SetLocaisEstoque;
    property Lojas: IPanamahLojaList read GetLojas write SetLojas;
    property Metas: IPanamahMetaList read GetMetas write SetMetas;
    property Produtos: IPanamahProdutoList read GetProdutos write SetProdutos;
    property Revendas: IPanamahRevendaList read GetRevendas write SetRevendas;
    property Secoes: IPanamahSecaoList read GetSecoes write SetSecoes;
    property Subgrupos: IPanamahSubgrupoList read GetSubgrupos write SetSubgrupos;
    property TitulosPagar: IPanamahTituloPagarList read GetTitulosPagar write SetTitulosPagar;
    property TitulosReceber: IPanamahTituloReceberList read GetTitulosReceber write SetTitulosReceber;
    property TrocasDevolucoes: IPanamahTrocaDevolucaoList read GetTrocasDevolucoes write SetTrocasDevolucoes;
    property TrocasFormaPagamento: IPanamahTrocaFormaPagamentoList read GetTrocasFormaPagamento write SetTrocasFormaPagamento;
    property Vendas: IPanamahVendaList read GetVendas write SetVendas;
  end;

implementation

{ TPanamahBatch }

procedure TPanamahBatch.Add(AAcesso: IPanamahAcesso);
begin
  if not Assigned(FAcessos) then
    FAcessos := TPanamahAcessoList.Create;
  FAcessos.Add(AAcesso);
end;

procedure TPanamahBatch.Add(AAssinante: IPanamahAssinante);
begin
  if not Assigned(FAssinantes) then
    FAssinantes := TPanamahAssinanteList.Create;
  FAssinantes.Add(AAssinante);
end;

procedure TPanamahBatch.Add(ACliente: IPanamahCliente);
begin
  if not Assigned(FClientes) then
    FClientes := TPanamahClienteList.Create;
  FClientes.Add(ACliente);
end;

procedure TPanamahBatch.Add(ACompra: IPanamahCompra);
begin
  if not Assigned(FCompras) then
    FCompras := TPanamahCompraList.Create;
  FCompras.Add(ACompra);
end;

procedure TPanamahBatch.Add(AEan: IPanamahEan);
begin
  if not Assigned(FEans) then
    FEans := TPanamahEanList.Create;
  FEans.Add(AEan);
end;

procedure TPanamahBatch.Add(AEstoqueMovimentacao: IPanamahEstoqueMovimentacao);
begin
  if not Assigned(FEstoqueMovimentacoes) then
    FEstoqueMovimentacoes := TPanamahEstoqueMovimentacaoList.Create;
  FEstoqueMovimentacoes.Add(AEstoqueMovimentacao);
end;

procedure TPanamahBatch.Add(AEventoCaixa: IPanamahEventoCaixa);
begin
  if not Assigned(FEventosCaixa) then
    FEventosCaixa := TPanamahEventoCaixaList.Create;
  FEventosCaixa.Add(AEventoCaixa);
end;

procedure TPanamahBatch.Add(AFormaPagamento: IPanamahFormaPagamento);
begin
  if not Assigned(FFormasPagamento) then
    FFormasPagamento := TPanamahFormaPagamentoList.Create;
  FFormasPagamento.Add(AFormaPagamento);
end;

procedure TPanamahBatch.Add(AFornecedor: IPanamahFornecedor);
begin
  if not Assigned(FFornecedores) then
    FFornecedores := TPanamahFornecedorList.Create;
  FFornecedores.Add(AFornecedor);
end;

procedure TPanamahBatch.Add(AFuncionario: IPanamahFuncionario);
begin
  if not Assigned(FFuncionarios) then
    FFuncionarios := TPanamahFuncionarioList.Create;
  FFuncionarios.Add(AFuncionario);
end;

procedure TPanamahBatch.Add(AGrupo: IPanamahGrupo);
begin
  if not Assigned(FGrupos) then
    FGrupos := TPanamahGrupoList.Create;
  FGrupos.Add(AGrupo);
end;

procedure TPanamahBatch.Add(AHolding: IPanamahHolding);
begin
  if not Assigned(FHoldings) then
    FHoldings := TPanamahHoldingList.Create;
  FHoldings.Add(AHolding);
end;

procedure TPanamahBatch.Add(ALocalEstoque: IPanamahLocalEstoque);
begin
  if not Assigned(FLocaisEstoque) then
    FLocaisEstoque := TPanamahLocalEstoqueList.Create;
  FLocaisEstoque.Add(ALocalEstoque);
end;

procedure TPanamahBatch.Add(ALoja: IPanamahLoja);
begin
  if not Assigned(FLojas) then
    FLojas := TPanamahLojaList.Create;
  FLojas.Add(ALoja);
end;

procedure TPanamahBatch.Add(AMeta: IPanamahMeta);
begin
  if not Assigned(FMetas) then
    FMetas := TPanamahMetaList.Create;
  FMetas.Add(AMeta);
end;

procedure TPanamahBatch.Add(AProduto: IPanamahProduto);
begin
  if not Assigned(FProdutos) then
    FProdutos := TPanamahProdutoList.Create;
  FProdutos.Add(AProduto);
end;

procedure TPanamahBatch.Add(ARevenda: IPanamahRevenda);
begin
  if not Assigned(FRevendas) then
    FRevendas := TPanamahRevendaList.Create;
  FRevendas.Add(ARevenda);
end;

procedure TPanamahBatch.Add(ASecao: IPanamahSecao);
begin
  if not Assigned(FSecoes) then
    FSecoes := TPanamahSecaoList.Create;
  FSecoes.Add(ASecao);
end;

procedure TPanamahBatch.Add(ASubgrupo: IPanamahSubgrupo);
begin
  if not Assigned(FSubgrupos) then
    FSubgrupos := TPanamahSubgrupoList.Create;
  FSubgrupos.Add(ASubgrupo);
end;

procedure TPanamahBatch.Add(ATituloPagar: IPanamahTituloPagar);
begin
  if not Assigned(FTitulosPagar) then
    FTitulosPagar := TPanamahTituloPagarList.Create;
  FTitulosPagar.Add(ATituloPagar);
end;

procedure TPanamahBatch.Add(ATituloReceber: IPanamahTituloReceber);
begin
  if not Assigned(FTitulosReceber) then
    FTitulosReceber := TPanamahTituloReceberList.Create;
  FTitulosReceber.Add(ATituloReceber);
end;

procedure TPanamahBatch.Add(ATrocaDevolucao: IPanamahTrocaDevolucao);
begin
  if not Assigned(FTrocasDevolucoes) then
    FTrocasDevolucoes := TPanamahTrocaDevolucaoList.Create;
  FTrocasDevolucoes.Add(ATrocaDevolucao);
end;

procedure TPanamahBatch.Add(ATrocaFormaPagamento: IPanamahTrocaFormaPagamento);
begin
  if not Assigned(FTrocasFormaPagamento) then
    FTrocasFormaPagamento := TPanamahTrocaFormaPagamentoList.Create;
  FTrocasFormaPagamento.Add(ATrocaFormaPagamento);
end;

procedure TPanamahBatch.Add(AVenda: IPanamahVenda);
begin
  if not Assigned(FVendas) then
    FVendas := TPanamahVendaList.Create;
  FVendas.Add(AVenda);
end;

procedure TPanamahBatch.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if JSONObject.Field['acessos'] is TlkJSONlist then
      FAcessos := TPanamahAcessoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['acessos']));
    if JSONObject.Field['assinantes'] is TlkJSONlist then
      FAssinantes := TPanamahAssinanteList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['assinantes']));
    if JSONObject.Field['clientes'] is TlkJSONlist then
      FClientes := TPanamahClienteList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['clientes']));
    if JSONObject.Field['compras'] is TlkJSONlist then
      FCompras := TPanamahCompraList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['compras']));
    if JSONObject.Field['eans'] is TlkJSONlist then
      FEans := TPanamahEanList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['eans']));
    if JSONObject.Field['estoqueMovimentacoes'] is TlkJSONlist then
      FEstoqueMovimentacoes := TPanamahEstoqueMovimentacaoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['estoqueMovimentacoes']));
    if JSONObject.Field['eventosCaixa'] is TlkJSONlist then
      FEventosCaixa := TPanamahEventoCaixaList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['eventosCaixa']));
    if JSONObject.Field['formasPagamento'] is TlkJSONlist then
      FFormasPagamento := TPanamahFormaPagamentoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['formasPagamento']));
    if JSONObject.Field['fornecedores'] is TlkJSONlist then
      FFornecedores := TPanamahFornecedorList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['fornecedores']));
    if JSONObject.Field['funcionarios'] is TlkJSONlist then
      FFuncionarios := TPanamahFuncionarioList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['funcionarios']));
    if JSONObject.Field['grupos'] is TlkJSONlist then
      FGrupos := TPanamahGrupoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['grupos']));
    if JSONObject.Field['holdings'] is TlkJSONlist then
      FHoldings := TPanamahHoldingList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['holdings']));
    if JSONObject.Field['locaisEstoque'] is TlkJSONlist then
      FLocaisEstoque := TPanamahLocalEstoqueList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['locaisEstoque']));
    if JSONObject.Field['lojas'] is TlkJSONlist then
      FLojas := TPanamahLojaList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['lojas']));
    if JSONObject.Field['metas'] is TlkJSONlist then
      FMetas := TPanamahMetaList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['metas']));
    if JSONObject.Field['produtos'] is TlkJSONlist then
      FProdutos := TPanamahProdutoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['produtos']));
    if JSONObject.Field['revendas'] is TlkJSONlist then
      FRevendas := TPanamahRevendaList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['revendas']));
    if JSONObject.Field['secoes'] is TlkJSONlist then
      FSecoes := TPanamahSecaoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['secoes']));
    if JSONObject.Field['subgrupos'] is TlkJSONlist then
      FSubgrupos := TPanamahSubgrupoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['subgrupos']));
    if JSONObject.Field['titulosPagar'] is TlkJSONlist then
      FTitulosPagar := TPanamahTituloPagarList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['titulosPagar']));
    if JSONObject.Field['titulosReceber'] is TlkJSONlist then
      FTitulosReceber := TPanamahTituloReceberList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['titulosReceber']));
    if JSONObject.Field['trocasDevolucoes'] is TlkJSONlist then
      FTrocasDevolucoes := TPanamahTrocaDevolucaoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['trocasDevolucoes']));
    if JSONObject.Field['trocasFormaPagamento'] is TlkJSONlist then
      FTrocasFormaPagamento := TPanamahTrocaFormaPagamentoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['trocasFormaPagamento']));
    if JSONObject.Field['vendas'] is TlkJSONlist then
      FVendas := TPanamahVendaList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['vendas']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahBatch.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'acessos', FAcessos);
    SetFieldValue(JSONObject, 'assinantes', FAssinantes);
    SetFieldValue(JSONObject, 'clientes', FClientes);
    SetFieldValue(JSONObject, 'compras', FCompras);
    SetFieldValue(JSONObject, 'eans', FEans);
    SetFieldValue(JSONObject, 'estoqueMovimentacoes', FEstoqueMovimentacoes);
    SetFieldValue(JSONObject, 'eventosCaixa', FEventosCaixa);
    SetFieldValue(JSONObject, 'formasPagamento', FFormasPagamento);
    SetFieldValue(JSONObject, 'fornecedores', FFornecedores);
    SetFieldValue(JSONObject, 'funcionarios', FFuncionarios);
    SetFieldValue(JSONObject, 'grupos', FGrupos);
    SetFieldValue(JSONObject, 'holdings', FHoldings);
    SetFieldValue(JSONObject, 'locaisEstoque', FLocaisEstoque);
    SetFieldValue(JSONObject, 'lojas', FLojas);
    SetFieldValue(JSONObject, 'metas', FMetas);
    SetFieldValue(JSONObject, 'produtos', FProdutos);
    SetFieldValue(JSONObject, 'revendas', FRevendas);
    SetFieldValue(JSONObject, 'secoes', FSecoes);
    SetFieldValue(JSONObject, 'subgrupos', FSubgrupos);
    SetFieldValue(JSONObject, 'titulosPagar', FTitulosPagar);
    SetFieldValue(JSONObject, 'titulosReceber', FTitulosReceber);
    SetFieldValue(JSONObject, 'trocasDevolucoes', FTrocasDevolucoes);
    SetFieldValue(JSONObject, 'trocasFormaPagamento', FTrocasFormaPagamento);
    SetFieldValue(JSONObject, 'vendas', FVendas);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahBatch.FromJSON(const AJSON: string): IPanamahBatch;
begin
  Result := TPanamahBatch.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahBatch.SetAcessos(AAcessos: IPanamahAcessoList);
begin
  FAcessos := AAcessos;
end;

procedure TPanamahBatch.SetAssinantes(AAssinantes: IPanamahAssinanteList);
begin
  FAssinantes := AAssinantes;
end;

procedure TPanamahBatch.SetClientes(AClientes: IPanamahClienteList);
begin
  FClientes := AClientes;
end;

procedure TPanamahBatch.SetCompras(ACompras: IPanamahCompraList);
begin
  FCompras := ACompras;
end;

procedure TPanamahBatch.SetEans(AEans: IPanamahEanList);
begin
  FEans := AEans;
end;

procedure TPanamahBatch.SetEstoqueMovimentacoes(AEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList);
begin
  FEstoqueMovimentacoes := AEstoqueMovimentacoes;
end;

procedure TPanamahBatch.SetEventosCaixa(AEventosCaixa: IPanamahEventoCaixaList);
begin
  FEventosCaixa := AEventosCaixa;
end;

procedure TPanamahBatch.SetFormasPagamento(AFormasPagamento: IPanamahFormaPagamentoList);
begin
  FFormasPagamento := AFormasPagamento;
end;

procedure TPanamahBatch.SetFornecedores(AFornecedores: IPanamahFornecedorList);
begin
  FFornecedores := AFornecedores;
end;

procedure TPanamahBatch.SetFuncionarios(AFuncionarios: IPanamahFuncionarioList);
begin
  FFuncionarios := AFuncionarios;
end;

procedure TPanamahBatch.SetGrupos(AGrupos: IPanamahGrupoList);
begin
  FGrupos := AGrupos;
end;

procedure TPanamahBatch.SetHoldings(AHoldings: IPanamahHoldingList);
begin
  FHoldings := AHoldings;
end;

procedure TPanamahBatch.SetLocaisEstoque(ALocaisEstoque: IPanamahLocalEstoqueList);
begin
  FLocaisEstoque := ALocaisEstoque;
end;

procedure TPanamahBatch.SetLojas(ALojas: IPanamahLojaList);
begin
  FLojas := ALojas;
end;

procedure TPanamahBatch.SetMetas(AMetas: IPanamahMetaList);
begin
  FMetas := AMetas;
end;

procedure TPanamahBatch.SetProdutos(AProdutos: IPanamahProdutoList);
begin
  FProdutos := AProdutos;
end;

procedure TPanamahBatch.SetRevendas(ARevendas: IPanamahRevendaList);
begin
  FRevendas := ARevendas;
end;

procedure TPanamahBatch.SetSecoes(ASecoes: IPanamahSecaoList);
begin
  FSecoes := ASecoes;
end;

procedure TPanamahBatch.SetSubgrupos(ASubgrupos: IPanamahSubgrupoList);
begin
  FSubgrupos := ASubgrupos;
end;

procedure TPanamahBatch.SetTitulosPagar(ATitulosPagar: IPanamahTituloPagarList);
begin
  FTitulosPagar := ATitulosPagar;
end;

procedure TPanamahBatch.SetTitulosReceber(ATitulosReceber: IPanamahTituloReceberList);
begin
  FTitulosReceber := ATitulosReceber;
end;

procedure TPanamahBatch.SetTrocasDevolucoes(ATrocasDevolucoes: IPanamahTrocaDevolucaoList);
begin
  FTrocasDevolucoes := ATrocasDevolucoes;
end;

procedure TPanamahBatch.SetTrocasFormaPagamento(ATrocasFormaPagamento: IPanamahTrocaFormaPagamentoList);
begin
  FTrocasFormaPagamento := ATrocasFormaPagamento;
end;

procedure TPanamahBatch.SetVendas(AVendas: IPanamahVendaList);
begin
  FVendas := AVendas;
end;

function TPanamahBatch.GetAcessos: IPanamahAcessoList;
begin
  Result := FAcessos;
end;

function TPanamahBatch.GetAssinantes: IPanamahAssinanteList;
begin
  Result := FAssinantes;
end;

function TPanamahBatch.GetClientes: IPanamahClienteList;
begin
  Result := FClientes;
end;

function TPanamahBatch.GetCompras: IPanamahCompraList;
begin
  Result := FCompras;
end;

function TPanamahBatch.GetEans: IPanamahEanList;
begin
  Result := FEans;
end;

function TPanamahBatch.GetEstoqueMovimentacoes: IPanamahEstoqueMovimentacaoList;
begin
  Result := FEstoqueMovimentacoes;
end;

function TPanamahBatch.GetEventosCaixa: IPanamahEventoCaixaList;
begin
  Result := FEventosCaixa;
end;

function TPanamahBatch.GetFormasPagamento: IPanamahFormaPagamentoList;
begin
  Result := FFormasPagamento;
end;

function TPanamahBatch.GetFornecedores: IPanamahFornecedorList;
begin
  Result := FFornecedores;
end;

function TPanamahBatch.GetFuncionarios: IPanamahFuncionarioList;
begin
  Result := FFuncionarios;
end;

function TPanamahBatch.GetGrupos: IPanamahGrupoList;
begin
  Result := FGrupos;
end;

function TPanamahBatch.GetHoldings: IPanamahHoldingList;
begin
  Result := FHoldings;
end;

function TPanamahBatch.GetLocaisEstoque: IPanamahLocalEstoqueList;
begin
  Result := FLocaisEstoque;
end;

function TPanamahBatch.GetLojas: IPanamahLojaList;
begin
  Result := FLojas;
end;

function TPanamahBatch.GetMetas: IPanamahMetaList;
begin
  Result := FMetas;
end;

function TPanamahBatch.GetProdutos: IPanamahProdutoList;
begin
  Result := FProdutos;
end;

function TPanamahBatch.GetRevendas: IPanamahRevendaList;
begin
  Result := FRevendas;
end;

function TPanamahBatch.GetSecoes: IPanamahSecaoList;
begin
  Result := FSecoes;
end;

function TPanamahBatch.GetSubgrupos: IPanamahSubgrupoList;
begin
  Result := FSubgrupos;
end;

function TPanamahBatch.GetTitulosPagar: IPanamahTituloPagarList;
begin
  Result := FTitulosPagar;
end;

function TPanamahBatch.GetTitulosReceber: IPanamahTituloReceberList;
begin
  Result := FTitulosReceber;
end;

function TPanamahBatch.GetTrocasDevolucoes: IPanamahTrocaDevolucaoList;
begin
  Result := FTrocasDevolucoes;
end;

function TPanamahBatch.GetTrocasFormaPagamento: IPanamahTrocaFormaPagamentoList;
begin
  Result := FTrocasFormaPagamento;
end;

function TPanamahBatch.GetVendas: IPanamahVendaList;
begin
  Result := FVendas;
end;

end.
