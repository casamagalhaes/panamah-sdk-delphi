{$M+}
unit PanamahSDK.Batch;

interface

uses
  Classes, SysUtils, DateUtils, Windows, PanamahSDK.JsonUtils, uLkJSON, PanamahSDK.Types, PanamahSDK.Models.Acesso,
  PanamahSDK.Models.Assinante, PanamahSDK.Models.Cliente, PanamahSDK.Models.Compra, PanamahSDK.Models.Ean,
  PanamahSDK.Models.EstoqueMovimentacao, PanamahSDK.Models.EventoCaixa, PanamahSDK.Models.FormaPagamento,
  PanamahSDK.Models.Fornecedor, PanamahSDK.Models.Funcionario, PanamahSDK.Models.Grupo, PanamahSDK.Models.Holding,
  PanamahSDK.Models.LocalEstoque, PanamahSDK.Models.Loja, PanamahSDK.Models.Meta, PanamahSDK.Models.Produto,
  PanamahSDK.Models.Revenda, PanamahSDK.Models.Secao, PanamahSDK.Models.Subgrupo, PanamahSDK.Models.TituloPagar,
  PanamahSDK.Models.TituloReceber, PanamahSDK.Models.TrocaDevolucao, PanamahSDK.Models.TrocaFormaPagamento,
  PanamahSDK.Models.Venda;

type

  TPanamahBatchFilenameRec = record
  public
    CreatedAt: TDateTime;
    Priority: Boolean;
    class function Create(const AFilename: string): TPanamahBatchFilenameRec; static;
    class operator Implicit(AFilenameRec: TPanamahBatchFilenameRec): string;
    class operator Implicit(const AFilename: string): TPanamahBatchFilenameRec;
  end;

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
    procedure SetCreatedAt(ACreatedAt: TDateTime);
    procedure SetPriority(APriority: Boolean);
    procedure Clear;
    procedure Reset;
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
    procedure Add(AModel: IPanamahModel); overload;
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
    function GetSize: Integer;
    function GetCreatedAt: TDateTime;
    function GetPriority: Boolean;
    function CheckForExpiration(AConfig: IPanamahSDKConfig): Boolean;
    function SaveToDirectory(const ADirectory: string): string;
    function MoveToDirectory(const ASource, ADestiny: string): string;
    function GetCount: Integer;
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
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property Size: Integer read GetSize;
    property Priority: Boolean read GetPriority write SetPriority;
    property Count: Integer read GetCount;
  end;

  IPanamahBatchList = interface(IJSONSerializable)
    ['{EDEDDB56-66F5-4501-8798-8DD44B3297D5}']
    function GetItem(AIndex: Integer): IPanamahBatch;
    procedure SetItem(AIndex: Integer; const Value: IPanamahBatch);
    procedure Add(const AItem: IPanamahBatch);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahBatch read GetItem write SetItem; default;
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
    FCreatedAt: TDateTime;
    FPriority: Boolean;
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
    procedure SetCreatedAt(ACreatedAt: TDateTime);
    procedure SetPriority(APriority: Boolean);
    procedure Clear;
    procedure Reset;
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
    procedure Add(AModel: IPanamahModel); overload;
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
    function GetSize: Integer;
    function GetCreatedAt: TDateTime;
    function GetPriority: Boolean;
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    function SaveToDirectory(const ADirectory: string): string;
    function MoveToDirectory(const ASource, ADestiny: string): string;
    function CheckForExpiration(AConfig: IPanamahSDKConfig): Boolean;
    function GetCount: Integer;
    class function FromJSON(const AJSON: string): IPanamahBatch;
    class function FromFile(const AFilename: string): IPanamahBatch;
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
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property Size: Integer read GetSize;
    property Priority: Boolean read GetPriority write SetPriority;
    constructor Create; reintroduce;
  end;

  TBatchFileIterationProcedure = procedure(const ABatchFilename: string);

  TPanamahBatchList = class(TInterfacedObject, IPanamahBatchList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahBatch;
    procedure SetItem(AIndex: Integer; const Value: IPanamahBatch);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
    class function GetBatchesInDirectory(const ADirectory: string): TStrings;
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahBatchList;
    class function FromDirectory(const ADirectory: string): IPanamahBatchList;
    class function CountBatchesInDirectory(const ADirectory: string): Integer;
    constructor Create;
    procedure Add(const AItem: IPanamahBatch);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahBatch read GetItem write SetItem; default;
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

function TPanamahBatch.CheckForExpiration(AConfig: IPanamahSDKConfig): Boolean;
begin
  Result := (MilliSecondsBetween(Now, FCreatedAt) >= AConfig.BatchTTL) or (GetSize >= AConfig.BatchMaxSize);
end;

procedure TPanamahBatch.Clear;
begin
  if(Assigned(FAcessos)) then FAcessos.Clear;
  if(Assigned(FAssinantes)) then FAssinantes.Clear;
  if(Assigned(FClientes)) then FClientes.Clear;
  if(Assigned(FCompras)) then FCompras.Clear;
  if(Assigned(FEans)) then FEans.Clear;
  if(Assigned(FEstoqueMovimentacoes)) then FEstoqueMovimentacoes.Clear;
  if(Assigned(FEventosCaixa)) then FEventosCaixa.Clear;
  if(Assigned(FFormasPagamento)) then FFormasPagamento.Clear;
  if(Assigned(FFornecedores)) then FFornecedores.Clear;
  if(Assigned(FFuncionarios)) then FFuncionarios.Clear;
  if(Assigned(FGrupos)) then FGrupos.Clear;
  if(Assigned(FHoldings)) then FHoldings.Clear;
  if(Assigned(FLocaisEstoque)) then FLocaisEstoque.Clear;
  if(Assigned(FLojas)) then FLojas.Clear;
  if(Assigned(FMetas)) then FMetas.Clear;
  if(Assigned(FProdutos)) then FProdutos.Clear;
  if(Assigned(FRevendas)) then FRevendas.Clear;
  if(Assigned(FSecoes)) then FSecoes.Clear;
  if(Assigned(FSubgrupos)) then FSubgrupos.Clear;
  if(Assigned(FTitulosPagar)) then FTitulosPagar.Clear;
  if(Assigned(FTitulosReceber)) then FTitulosReceber.Clear;
  if(Assigned(FTrocasDevolucoes)) then FTrocasDevolucoes.Clear;
  if(Assigned(FTrocasFormaPagamento)) then FTrocasFormaPagamento.Clear;
  if(Assigned(FVendas)) then FVendas.Clear;
end;

constructor TPanamahBatch.Create;
begin
  inherited;
  FCreatedAt := Now;
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

function TPanamahBatch.SaveToDirectory(const ADirectory: string): string;
var
  BatchFile : TextFile;
  BatchFilename: TPanamahBatchFilenameRec;
begin
  BatchFilename.CreatedAt := FCreatedAt;
  BatchFilename.Priority := FPriority;
  ForceDirectories(ADirectory);
  AssignFile(BatchFile, Format('%s/%s.pbt', [ADirectory, string(BatchFilename)]));
  try
    Rewrite(BatchFile);
    WriteLn(BatchFile, SerializeToJSON);
  finally
    CloseFile(BatchFile);
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

class function TPanamahBatch.FromFile(const AFilename: string): IPanamahBatch;
var
  BatchFilename: TPanamahBatchFilenameRec;
  BatchFile: TStrings;
begin
  Result := TPanamahBatch.Create;
  BatchFilename := AFilename;
  Result.CreatedAt := BatchFilename.CreatedAt;
  Result.Priority := BatchFilename.Priority;
  BatchFile := TStringList.Create;
  try
    BatchFile.LoadFromFile(AFilename);
    Result.DeserializeFromJSON(BatchFile.Text);
  finally
    BatchFile.Free;
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

procedure TPanamahBatch.SetCreatedAt(ACreatedAt: TDateTime);
begin
  FCreatedAt := ACreatedAt;
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

procedure TPanamahBatch.SetPriority(APriority: Boolean);
begin
  FPriority := APriority;
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

function TPanamahBatch.GetCount: Integer;
begin
  Result := 0;
  if(Assigned(FAcessos)) then Inc(Result, FAcessos.Count);
  if(Assigned(FAssinantes)) then Inc(Result, FAssinantes.Count);
  if(Assigned(FClientes)) then Inc(Result, FClientes.Count);
  if(Assigned(FCompras)) then Inc(Result, FCompras.Count);
  if(Assigned(FEans)) then Inc(Result, FEans.Count);
  if(Assigned(FEstoqueMovimentacoes)) then Inc(Result, FEstoqueMovimentacoes.Count);
  if(Assigned(FEventosCaixa)) then Inc(Result, FEventosCaixa.Count);
  if(Assigned(FFormasPagamento)) then Inc(Result, FFormasPagamento.Count);
  if(Assigned(FFornecedores)) then Inc(Result, FFornecedores.Count);
  if(Assigned(FFuncionarios)) then Inc(Result, FFuncionarios.Count);
  if(Assigned(FGrupos)) then Inc(Result, FGrupos.Count);
  if(Assigned(FHoldings)) then Inc(Result, FHoldings.Count);
  if(Assigned(FLocaisEstoque)) then Inc(Result, FLocaisEstoque.Count);
  if(Assigned(FLojas)) then Inc(Result, FLojas.Count);
  if(Assigned(FMetas)) then Inc(Result, FMetas.Count);
  if(Assigned(FProdutos)) then Inc(Result, FProdutos.Count);
  if(Assigned(FRevendas)) then Inc(Result, FRevendas.Count);
  if(Assigned(FSecoes)) then Inc(Result, FSecoes.Count);
  if(Assigned(FSubgrupos)) then Inc(Result, FSubgrupos.Count);
  if(Assigned(FTitulosPagar)) then Inc(Result, FTitulosPagar.Count);
  if(Assigned(FTitulosReceber)) then Inc(Result, FTitulosReceber.Count);
  if(Assigned(FTrocasDevolucoes)) then Inc(Result, FTrocasDevolucoes.Count);
  if(Assigned(FTrocasFormaPagamento)) then Inc(Result, FTrocasFormaPagamento.Count);
  if(Assigned(FVendas)) then Inc(Result, FVendas.Count);
end;

function TPanamahBatch.GetCreatedAt: TDateTime;
begin
  Result := FCreatedAt;
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

function TPanamahBatch.GetPriority: Boolean;
begin
  Result := FPriority;
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

function TPanamahBatch.GetSize: Integer;
begin
  Result := Length(SerializeToJSON);
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

function TPanamahBatch.MoveToDirectory(const ASource, ADestiny: string): string;
var
  BatchFilename: TPanamahBatchFilenameRec;
  SourceFile, DestinyFile: string;
begin
  BatchFilename.CreatedAt := FCreatedAt;
  BatchFilename.Priority := FPriority;
  ForceDirectories(ADestiny);
  SourceFile := Format('%s\%s.pbt', [ASource, string(BatchFilename)]);
  DestinyFile := Format('%s\%s.pbt', [ADestiny, string(BatchFilename)]);
  MoveFile(PChar(SourceFile), PChar(DestinyFile));
  Result := DestinyFile;
end;

procedure TPanamahBatch.Reset;
begin
  Clear;
  FCreatedAt := Now;
  FPriority := False;
end;

procedure TPanamahBatch.Add(AModel: IPanamahModel);
begin
  if Supports(AModel, IPanamahAcesso) then Add(AModel as IPanamahAcesso) else
  if Supports(AModel, IPanamahAssinante) then Add(AModel as IPanamahAssinante) else
  if Supports(AModel, IPanamahCliente) then Add(AModel as IPanamahCliente) else
  if Supports(AModel, IPanamahCompra) then Add(AModel as IPanamahCompra) else
  if Supports(AModel, IPanamahEan) then Add(AModel as IPanamahEan) else
  if Supports(AModel, IPanamahEstoqueMovimentacao) then Add(AModel as IPanamahEstoqueMovimentacao) else
  if Supports(AModel, IPanamahEventoCaixa) then Add(AModel as IPanamahEventoCaixa) else
  if Supports(AModel, IPanamahFormaPagamento) then Add(AModel as IPanamahFormaPagamento) else
  if Supports(AModel, IPanamahFornecedor) then Add(AModel as IPanamahFornecedor) else
  if Supports(AModel, IPanamahFuncionario) then Add(AModel as IPanamahFuncionario) else
  if Supports(AModel, IPanamahGrupo) then Add(AModel as IPanamahGrupo) else
  if Supports(AModel, IPanamahHolding) then Add(AModel as IPanamahHolding) else
  if Supports(AModel, IPanamahLocalEstoque) then Add(AModel as IPanamahLocalEstoque) else
  if Supports(AModel, IPanamahLoja) then Add(AModel as IPanamahLoja) else
  if Supports(AModel, IPanamahMeta) then Add(AModel as IPanamahMeta) else
  if Supports(AModel, IPanamahProduto) then Add(AModel as IPanamahProduto) else
  if Supports(AModel, IPanamahRevenda) then Add(AModel as IPanamahRevenda) else
  if Supports(AModel, IPanamahSecao) then Add(AModel as IPanamahSecao) else
  if Supports(AModel, IPanamahSubgrupo) then Add(AModel as IPanamahSubgrupo) else
  if Supports(AModel, IPanamahTituloPagar) then Add(AModel as IPanamahTituloPagar) else
  if Supports(AModel, IPanamahTituloReceber) then Add(AModel as IPanamahTituloReceber) else
  if Supports(AModel, IPanamahTrocaDevolucao) then Add(AModel as IPanamahTrocaDevolucao) else
  if Supports(AModel, IPanamahTrocaFormaPagamento) then Add(AModel as IPanamahTrocaFormaPagamento) else
  if Supports(AModel, IPanamahVenda) then Add(AModel as IPanamahVenda);
end;

{ TPanamahBatchList }

constructor TPanamahBatchList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahBatchList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahBatchList.FromDirectory(const ADirectory: string): IPanamahBatchList;
var
  Batches: TStrings;
  I: Integer;
begin
  Result := TPanamahBatchList.Create;
  Batches := GetBatchesInDirectory(ADirectory);
  try
    for I := 0 to Batches.Count - 1 do
      Result.Add(TPanamahBatch.FromFile(Batches[I]));
  finally
    Batches.Free;
  end;
end;

class function TPanamahBatchList.FromJSON(const AJSON: string): IPanamahBatchList;
begin
  Result := TPanamahBatchList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahBatchList.Add(const AItem: IPanamahBatch);
begin
  FList.Add(AItem);
end;

procedure TPanamahBatchList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahBatch;
begin
  Item := TPanamahBatch.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahBatchList.Clear;
begin
  FList.Clear;
end;

function TPanamahBatchList.Count: Integer;
begin
  Result := FList.Count;
end;

class function TPanamahBatchList.CountBatchesInDirectory(const ADirectory: string): Integer;
var
  Batches: TStrings;
begin
  Batches := GetBatchesInDirectory(ADirectory);
  try
    Result := Batches.Count;
  finally
    Batches.Free;
  end;
end;

function TPanamahBatchList.GetItem(AIndex: Integer): IPanamahBatch;
begin
  Result := FList.Items[AIndex] as IPanamahBatch;
end;

class function TPanamahBatchList.GetBatchesInDirectory(const ADirectory: string): TStrings;
var
  SearchRec: TSearchRec;
begin
  ForceDirectories(ADirectory);
  Result := TStringList.Create;
  if DirectoryExists(ADirectory) then
    begin
    if FindFirst(Format('%s\*.pbt', [ADirectory]), faAnyFile, SearchRec) = 0 then
    begin
      repeat
        Result.Add(Format('%s\%s', [ADirectory, SearchRec.Name]));
      until FindNext(SearchRec) <> 0;
    end;
  end
  else
    raise PanamahSDKIOException.Create(Format('Diretório %s não existe.', [ADirectory]));
end;

procedure TPanamahBatchList.SetItem(AIndex: Integer;
  const Value: IPanamahBatch);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahBatchList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahBatchList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahBatch).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahBatchFilenameRec }

class function TPanamahBatchFilenameRec.Create(const AFilename: string): TPanamahBatchFilenameRec;
var
  Words: TStrings;
begin
  FillChar(Result, SizeOf(TPanamahBatchFilenameRec), 0);
  Words := TStringList.Create;
  try
    Words.Delimiter := '_';
    Words.DelimitedText := ChangeFileExt(ExtractFilename(AFilename), EmptyStr);
    if Words.Count >= 7 then
    begin
      Result.CreatedAt := ISO8601ToDateTime(Format('%s-%s-%sT%s:%s:%s.%s', [
        Words[0],
        Words[1],
        Words[2],
        Words[3],
        Words[4],
        Words[5],
        Words[6]
      ]));
    end;
    if Words.Count >= 8 then
      Result.Priority := SameText(Words[7], 'P');
  finally
    Words.Free;
  end;
end;

class operator TPanamahBatchFilenameRec.Implicit(AFilenameRec: TPanamahBatchFilenameRec): string;
begin
  Result := FormatDateTime('YYYY_MM_DD_HH_NN_SS_ZZZ', AFilenameRec.CreatedAt);
  if AFilenameRec.Priority then
    Result := Concat(Result, '_P');
end;

class operator TPanamahBatchFilenameRec.Implicit(const AFilename: string): TPanamahBatchFilenameRec;
begin
  Result := TPanamahBatchFilenameRec.Create(AFilename);
end;

end.
