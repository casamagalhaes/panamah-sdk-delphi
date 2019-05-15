{$M+}
unit PanamahSDK.Models.Venda;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahVendaPagamento = interface(IPanamahModel)
    ['{081DA299-7736-11E9-A131-EBAF8D88186A}']
    function GetFormaPagamentoId: string;
    function GetSequencial: string;
    function GetValor: Double;
    procedure SetFormaPagamentoId(const AFormaPagamentoId: string);
    procedure SetSequencial(const ASequencial: string);
    procedure SetValor(const AValor: Double);
    property FormaPagamentoId: string read GetFormaPagamentoId write SetFormaPagamentoId;
    property Sequencial: string read GetSequencial write SetSequencial;
    property Valor: Double read GetValor write SetValor;
  end;
  
  IPanamahVendaPagamentoList = interface(IPanamahModelList)
    ['{081DA29A-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahVendaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVendaPagamento);
    procedure Add(const AItem: IPanamahVendaPagamento);
    property Items[AIndex: Integer]: IPanamahVendaPagamento read GetItem write SetItem; default;
  end;
  
  IPanamahVendaItem = interface(IPanamahModel)
    ['{081D7B8A-7736-11E9-A131-EBAF8D88186A}']
    function GetAcrescimo: Double;
    function GetDesconto: Double;
    function GetEfetivo: Boolean;
    function GetFuncionarioId: variant;
    function GetPreco: Double;
    function GetProdutoId: string;
    function GetCodigoRegistrado: variant;
    function GetPromocao: Boolean;
    function GetQuantidade: Double;
    function GetServico: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    function GetTipoPreco: string;
    function GetCusto: Double;
    function GetMarkup: Double;
    function GetLucro: Double;
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetivo(const AEfetivo: Boolean);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetPreco(const APreco: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetCodigoRegistrado(const ACodigoRegistrado: variant);
    procedure SetPromocao(const APromocao: Boolean);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetServico(const AServico: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
    procedure SetTipoPreco(const ATipoPreco: string);
    procedure SetCusto(const ACusto: Double);
    procedure SetMarkup(const AMarkup: Double);
    procedure SetLucro(const ALucro: Double);
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetivo: Boolean read GetEfetivo write SetEfetivo;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property Preco: Double read GetPreco write SetPreco;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property CodigoRegistrado: variant read GetCodigoRegistrado write SetCodigoRegistrado;
    property Promocao: Boolean read GetPromocao write SetPromocao;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Servico: Double read GetServico write SetServico;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Custo: Double read GetCusto write SetCusto;
    property Markup: Double read GetMarkup write SetMarkup;
    property Lucro: Double read GetLucro write SetLucro;
  end;
  
  IPanamahVendaItemList = interface(IPanamahModelList)
    ['{081D7B8B-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahVendaItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVendaItem);
    procedure Add(const AItem: IPanamahVendaItem);
    property Items[AIndex: Integer]: IPanamahVendaItem read GetItem write SetItem; default;
  end;
  
  IPanamahVenda = interface(IPanamahModel)
    ['{081D5470-7736-11E9-A131-EBAF8D88186A}']
    function GetId: string;
    function GetLojaId: string;
    function GetClienteId: variant;
    function GetFuncionarioId: variant;
    function GetData: TDateTime;
    function GetDataHoraInicio: TDateTime;
    function GetDataHoraFim: TDateTime;
    function GetDataHoraVenda: TDateTime;
    function GetDesconto: Double;
    function GetEfetiva: Boolean;
    function GetQuantidadeItens: Double;
    function GetQuantidadeItensCancelados: Double;
    function GetSequencial: string;
    function GetServico: Double;
    function GetTipoDesconto: variant;
    function GetTipoPreco: string;
    function GetValor: Double;
    function GetValorItensCancelados: Double;
    function GetAcrescimo: Double;
    function GetNumeroCaixa: variant;
    function GetItens: IpanamahVendaItemList;
    function GetPagamentos: IpanamahVendaPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetClienteId(const AClienteId: variant);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetDataHoraInicio(const ADataHoraInicio: TDateTime);
    procedure SetDataHoraFim(const ADataHoraFim: TDateTime);
    procedure SetDataHoraVenda(const ADataHoraVenda: TDateTime);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetiva(const AEfetiva: Boolean);
    procedure SetQuantidadeItens(const AQuantidadeItens: Double);
    procedure SetQuantidadeItensCancelados(const AQuantidadeItensCancelados: Double);
    procedure SetSequencial(const ASequencial: string);
    procedure SetServico(const AServico: Double);
    procedure SetTipoDesconto(const ATipoDesconto: variant);
    procedure SetTipoPreco(const ATipoPreco: string);
    procedure SetValor(const AValor: Double);
    procedure SetValorItensCancelados(const AValorItensCancelados: Double);
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetNumeroCaixa(const ANumeroCaixa: variant);
    procedure SetItens(const AItens: IpanamahVendaItemList);
    procedure SetPagamentos(const APagamentos: IpanamahVendaPagamentoList);
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property ClienteId: variant read GetClienteId write SetClienteId;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property Data: TDateTime read GetData write SetData;
    property DataHoraInicio: TDateTime read GetDataHoraInicio write SetDataHoraInicio;
    property DataHoraFim: TDateTime read GetDataHoraFim write SetDataHoraFim;
    property DataHoraVenda: TDateTime read GetDataHoraVenda write SetDataHoraVenda;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetiva: Boolean read GetEfetiva write SetEfetiva;
    property QuantidadeItens: Double read GetQuantidadeItens write SetQuantidadeItens;
    property QuantidadeItensCancelados: Double read GetQuantidadeItensCancelados write SetQuantidadeItensCancelados;
    property Sequencial: string read GetSequencial write SetSequencial;
    property Servico: Double read GetServico write SetServico;
    property TipoDesconto: variant read GetTipoDesconto write SetTipoDesconto;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Valor: Double read GetValor write SetValor;
    property ValorItensCancelados: Double read GetValorItensCancelados write SetValorItensCancelados;
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property NumeroCaixa: variant read GetNumeroCaixa write SetNumeroCaixa;
    property Itens: IpanamahVendaItemList read GetItens write SetItens;
    property Pagamentos: IpanamahVendaPagamentoList read GetPagamentos write SetPagamentos;
  end;
  
  IPanamahVendaList = interface(IPanamahModelList)
    ['{081D5471-7736-11E9-A131-EBAF8D88186A}']
    function GetItem(AIndex: Integer): IPanamahVenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVenda);
    procedure Add(const AItem: IPanamahVenda);
    property Items[AIndex: Integer]: IPanamahVenda read GetItem write SetItem; default;
  end;
  
  TPanamahVendaPagamento = class(TInterfacedObject, IPanamahVendaPagamento)
  private
    FFormaPagamentoId: string;
    FSequencial: string;
    FValor: Double;
    function GetFormaPagamentoId: string;
    function GetSequencial: string;
    function GetValor: Double;
    procedure SetFormaPagamentoId(const AFormaPagamentoId: string);
    procedure SetSequencial(const ASequencial: string);
    procedure SetValor(const AValor: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahVendaPagamento;
    function Validate: IPanamahValidationResult;
  published
    property FormaPagamentoId: string read GetFormaPagamentoId write SetFormaPagamentoId;
    property Sequencial: string read GetSequencial write SetSequencial;
    property Valor: Double read GetValor write SetValor;
  end;

  TPanamahVendaPagamentoList = class(TInterfacedObject, IPanamahVendaPagamentoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahVendaPagamento;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVendaPagamento);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahVendaPagamentoList;
    constructor Create;
    procedure Add(const AItem: IPanamahVendaPagamento);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahVendaPagamento read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  TPanamahVendaItem = class(TInterfacedObject, IPanamahVendaItem)
  private
    FAcrescimo: Double;
    FDesconto: Double;
    FEfetivo: Boolean;
    FFuncionarioId: variant;
    FPreco: Double;
    FProdutoId: string;
    FCodigoRegistrado: variant;
    FPromocao: Boolean;
    FQuantidade: Double;
    FServico: Double;
    FValorTotal: Double;
    FValorUnitario: Double;
    FTipoPreco: string;
    FCusto: Double;
    FMarkup: Double;
    FLucro: Double;
    function GetAcrescimo: Double;
    function GetDesconto: Double;
    function GetEfetivo: Boolean;
    function GetFuncionarioId: variant;
    function GetPreco: Double;
    function GetProdutoId: string;
    function GetCodigoRegistrado: variant;
    function GetPromocao: Boolean;
    function GetQuantidade: Double;
    function GetServico: Double;
    function GetValorTotal: Double;
    function GetValorUnitario: Double;
    function GetTipoPreco: string;
    function GetCusto: Double;
    function GetMarkup: Double;
    function GetLucro: Double;
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetivo(const AEfetivo: Boolean);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetPreco(const APreco: Double);
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetCodigoRegistrado(const ACodigoRegistrado: variant);
    procedure SetPromocao(const APromocao: Boolean);
    procedure SetQuantidade(const AQuantidade: Double);
    procedure SetServico(const AServico: Double);
    procedure SetValorTotal(const AValorTotal: Double);
    procedure SetValorUnitario(const AValorUnitario: Double);
    procedure SetTipoPreco(const ATipoPreco: string);
    procedure SetCusto(const ACusto: Double);
    procedure SetMarkup(const AMarkup: Double);
    procedure SetLucro(const ALucro: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahVendaItem;
    function Validate: IPanamahValidationResult;
  published
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetivo: Boolean read GetEfetivo write SetEfetivo;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property Preco: Double read GetPreco write SetPreco;
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property CodigoRegistrado: variant read GetCodigoRegistrado write SetCodigoRegistrado;
    property Promocao: Boolean read GetPromocao write SetPromocao;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Servico: Double read GetServico write SetServico;
    property ValorTotal: Double read GetValorTotal write SetValorTotal;
    property ValorUnitario: Double read GetValorUnitario write SetValorUnitario;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Custo: Double read GetCusto write SetCusto;
    property Markup: Double read GetMarkup write SetMarkup;
    property Lucro: Double read GetLucro write SetLucro;
  end;

  TPanamahVendaItemList = class(TInterfacedObject, IPanamahVendaItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahVendaItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVendaItem);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahVendaItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahVendaItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahVendaItem read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  TPanamahVenda = class(TInterfacedObject, IPanamahVenda)
  private
    FId: string;
    FLojaId: string;
    FClienteId: variant;
    FFuncionarioId: variant;
    FData: TDateTime;
    FDataHoraInicio: TDateTime;
    FDataHoraFim: TDateTime;
    FDataHoraVenda: TDateTime;
    FDesconto: Double;
    FEfetiva: Boolean;
    FQuantidadeItens: Double;
    FQuantidadeItensCancelados: Double;
    FSequencial: string;
    FServico: Double;
    FTipoDesconto: variant;
    FTipoPreco: string;
    FValor: Double;
    FValorItensCancelados: Double;
    FAcrescimo: Double;
    FNumeroCaixa: variant;
    FItens: IpanamahVendaItemList;
    FPagamentos: IpanamahVendaPagamentoList;
    function GetId: string;
    function GetLojaId: string;
    function GetClienteId: variant;
    function GetFuncionarioId: variant;
    function GetData: TDateTime;
    function GetDataHoraInicio: TDateTime;
    function GetDataHoraFim: TDateTime;
    function GetDataHoraVenda: TDateTime;
    function GetDesconto: Double;
    function GetEfetiva: Boolean;
    function GetQuantidadeItens: Double;
    function GetQuantidadeItensCancelados: Double;
    function GetSequencial: string;
    function GetServico: Double;
    function GetTipoDesconto: variant;
    function GetTipoPreco: string;
    function GetValor: Double;
    function GetValorItensCancelados: Double;
    function GetAcrescimo: Double;
    function GetNumeroCaixa: variant;
    function GetItens: IpanamahVendaItemList;
    function GetPagamentos: IpanamahVendaPagamentoList;
    procedure SetId(const AId: string);
    procedure SetLojaId(const ALojaId: string);
    procedure SetClienteId(const AClienteId: variant);
    procedure SetFuncionarioId(const AFuncionarioId: variant);
    procedure SetData(const AData: TDateTime);
    procedure SetDataHoraInicio(const ADataHoraInicio: TDateTime);
    procedure SetDataHoraFim(const ADataHoraFim: TDateTime);
    procedure SetDataHoraVenda(const ADataHoraVenda: TDateTime);
    procedure SetDesconto(const ADesconto: Double);
    procedure SetEfetiva(const AEfetiva: Boolean);
    procedure SetQuantidadeItens(const AQuantidadeItens: Double);
    procedure SetQuantidadeItensCancelados(const AQuantidadeItensCancelados: Double);
    procedure SetSequencial(const ASequencial: string);
    procedure SetServico(const AServico: Double);
    procedure SetTipoDesconto(const ATipoDesconto: variant);
    procedure SetTipoPreco(const ATipoPreco: string);
    procedure SetValor(const AValor: Double);
    procedure SetValorItensCancelados(const AValorItensCancelados: Double);
    procedure SetAcrescimo(const AAcrescimo: Double);
    procedure SetNumeroCaixa(const ANumeroCaixa: variant);
    procedure SetItens(const AItens: IpanamahVendaItemList);
    procedure SetPagamentos(const APagamentos: IpanamahVendaPagamentoList);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahVenda;
    function Validate: IPanamahValidationResult;
  published
    property Id: string read GetId write SetId;
    property LojaId: string read GetLojaId write SetLojaId;
    property ClienteId: variant read GetClienteId write SetClienteId;
    property FuncionarioId: variant read GetFuncionarioId write SetFuncionarioId;
    property Data: TDateTime read GetData write SetData;
    property DataHoraInicio: TDateTime read GetDataHoraInicio write SetDataHoraInicio;
    property DataHoraFim: TDateTime read GetDataHoraFim write SetDataHoraFim;
    property DataHoraVenda: TDateTime read GetDataHoraVenda write SetDataHoraVenda;
    property Desconto: Double read GetDesconto write SetDesconto;
    property Efetiva: Boolean read GetEfetiva write SetEfetiva;
    property QuantidadeItens: Double read GetQuantidadeItens write SetQuantidadeItens;
    property QuantidadeItensCancelados: Double read GetQuantidadeItensCancelados write SetQuantidadeItensCancelados;
    property Sequencial: string read GetSequencial write SetSequencial;
    property Servico: Double read GetServico write SetServico;
    property TipoDesconto: variant read GetTipoDesconto write SetTipoDesconto;
    property TipoPreco: string read GetTipoPreco write SetTipoPreco;
    property Valor: Double read GetValor write SetValor;
    property ValorItensCancelados: Double read GetValorItensCancelados write SetValorItensCancelados;
    property Acrescimo: Double read GetAcrescimo write SetAcrescimo;
    property NumeroCaixa: variant read GetNumeroCaixa write SetNumeroCaixa;
    property Itens: IpanamahVendaItemList read GetItens write SetItens;
    property Pagamentos: IpanamahVendaPagamentoList read GetPagamentos write SetPagamentos;
  end;

  TPanamahVendaList = class(TInterfacedObject, IPanamahVendaList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahVenda;
    procedure SetItem(AIndex: Integer; const Value: IPanamahVenda);
    function GetModel(AIndex: Integer): IPanamahModel;
    procedure SetModel(AIndex: Integer; const Value: IPanamahModel);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function Validate: IPanamahValidationResult;
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahVendaList;
    constructor Create;
    procedure Add(const AItem: IPanamahVenda);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahVenda read GetItem write SetItem; default;
    property Models[AIndex: Integer]: IPanamahModel read GetModel write SetModel;
  end;
  
  
  TPanamahVendaPagamentoValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
  TPanamahVendaItemValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
  TPanamahVendaValidator = class(TInterfacedObject, IPanamahModelValidator)
  public
    function Validate(AModel: IPanamahModel): IPanamahValidationResult;
  end;
  
implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahVendaPagamento }

function TPanamahVendaPagamento.GetFormaPagamentoId: string;
begin
  Result := FFormaPagamentoId;
end;

procedure TPanamahVendaPagamento.SetFormaPagamentoId(const AFormaPagamentoId: string);
begin
  FFormaPagamentoId := AFormaPagamentoId;
end;

function TPanamahVendaPagamento.GetSequencial: string;
begin
  Result := FSequencial;
end;

procedure TPanamahVendaPagamento.SetSequencial(const ASequencial: string);
begin
  FSequencial := ASequencial;
end;

function TPanamahVendaPagamento.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahVendaPagamento.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

procedure TPanamahVendaPagamento.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FFormaPagamentoId := GetFieldValueAsString(JSONObject, 'formaPagamentoId');
    FSequencial := GetFieldValueAsString(JSONObject, 'sequencial');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahVendaPagamento.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'formaPagamentoId', FFormaPagamentoId);    
    SetFieldValue(JSONObject, 'sequencial', FSequencial);    
    SetFieldValue(JSONObject, 'valor', FValor);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahVendaPagamento.FromJSON(const AJSON: string): IPanamahVendaPagamento;
begin
  Result := TPanamahVendaPagamento.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVendaPagamento.GetModelName: string;
begin
  Result := 'VENDA_PAGAMENTOS';
end;

function TPanamahVendaPagamento.Clone: IPanamahModel;
begin
  Result := TPanamahVendaPagamento.FromJSON(SerializeToJSON);
end;

function TPanamahVendaPagamento.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahVendaPagamentoValidator.Create;
  Result := Validator.Validate(Self as IPanamahVendaPagamento);
end;

{ TPanamahVendaPagamentoList }

constructor TPanamahVendaPagamentoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahVendaPagamentoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahVendaPagamentoList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahVendaPagamento).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahVendaPagamentoList.FromJSON(const AJSON: string): IPanamahVendaPagamentoList;
begin
  Result := TPanamahVendaPagamentoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVendaPagamentoList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahVendaPagamento;
end;

procedure TPanamahVendaPagamentoList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaPagamentoList.Add(const AItem: IPanamahVendaPagamento);
begin
  FList.Add(AItem);
end;

procedure TPanamahVendaPagamentoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahVendaPagamento;
begin
  Item := TPanamahVendaPagamento.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahVendaPagamentoList.Clear;
begin
  FList.Clear;
end;

function TPanamahVendaPagamentoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahVendaPagamentoList.GetItem(AIndex: Integer): IPanamahVendaPagamento;
begin
  Result := FList.Items[AIndex] as IPanamahVendaPagamento;
end;

procedure TPanamahVendaPagamentoList.SetItem(AIndex: Integer;
  const Value: IPanamahVendaPagamento);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaPagamentoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahVendaPagamentoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahVendaPagamento).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahVendaPagamentoValidator }

function TPanamahVendaPagamentoValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Pagamentos: IPanamahVendaPagamento;
  Validations: IPanamahValidationResultList;
begin
  Pagamentos := AModel as IPanamahVendaPagamento;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Pagamentos.FormaPagamentoId) then
    Validations.AddFailure('Pagamentos.FormaPagamentoId obrigatorio(a)');
  
  if ModelValueIsEmpty(Pagamentos.Sequencial) then
    Validations.AddFailure('Pagamentos.Sequencial obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

{ TPanamahVendaItem }

function TPanamahVendaItem.GetAcrescimo: Double;
begin
  Result := FAcrescimo;
end;

procedure TPanamahVendaItem.SetAcrescimo(const AAcrescimo: Double);
begin
  FAcrescimo := AAcrescimo;
end;

function TPanamahVendaItem.GetDesconto: Double;
begin
  Result := FDesconto;
end;

procedure TPanamahVendaItem.SetDesconto(const ADesconto: Double);
begin
  FDesconto := ADesconto;
end;

function TPanamahVendaItem.GetEfetivo: Boolean;
begin
  Result := FEfetivo;
end;

procedure TPanamahVendaItem.SetEfetivo(const AEfetivo: Boolean);
begin
  FEfetivo := AEfetivo;
end;

function TPanamahVendaItem.GetFuncionarioId: variant;
begin
  Result := FFuncionarioId;
end;

procedure TPanamahVendaItem.SetFuncionarioId(const AFuncionarioId: variant);
begin
  FFuncionarioId := AFuncionarioId;
end;

function TPanamahVendaItem.GetPreco: Double;
begin
  Result := FPreco;
end;

procedure TPanamahVendaItem.SetPreco(const APreco: Double);
begin
  FPreco := APreco;
end;

function TPanamahVendaItem.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahVendaItem.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahVendaItem.GetCodigoRegistrado: variant;
begin
  Result := FCodigoRegistrado;
end;

procedure TPanamahVendaItem.SetCodigoRegistrado(const ACodigoRegistrado: variant);
begin
  FCodigoRegistrado := ACodigoRegistrado;
end;

function TPanamahVendaItem.GetPromocao: Boolean;
begin
  Result := FPromocao;
end;

procedure TPanamahVendaItem.SetPromocao(const APromocao: Boolean);
begin
  FPromocao := APromocao;
end;

function TPanamahVendaItem.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahVendaItem.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

function TPanamahVendaItem.GetServico: Double;
begin
  Result := FServico;
end;

procedure TPanamahVendaItem.SetServico(const AServico: Double);
begin
  FServico := AServico;
end;

function TPanamahVendaItem.GetValorTotal: Double;
begin
  Result := FValorTotal;
end;

procedure TPanamahVendaItem.SetValorTotal(const AValorTotal: Double);
begin
  FValorTotal := AValorTotal;
end;

function TPanamahVendaItem.GetValorUnitario: Double;
begin
  Result := FValorUnitario;
end;

procedure TPanamahVendaItem.SetValorUnitario(const AValorUnitario: Double);
begin
  FValorUnitario := AValorUnitario;
end;

function TPanamahVendaItem.GetTipoPreco: string;
begin
  Result := FTipoPreco;
end;

procedure TPanamahVendaItem.SetTipoPreco(const ATipoPreco: string);
begin
  FTipoPreco := ATipoPreco;
end;

function TPanamahVendaItem.GetCusto: Double;
begin
  Result := FCusto;
end;

procedure TPanamahVendaItem.SetCusto(const ACusto: Double);
begin
  FCusto := ACusto;
end;

function TPanamahVendaItem.GetMarkup: Double;
begin
  Result := FMarkup;
end;

procedure TPanamahVendaItem.SetMarkup(const AMarkup: Double);
begin
  FMarkup := AMarkup;
end;

function TPanamahVendaItem.GetLucro: Double;
begin
  Result := FLucro;
end;

procedure TPanamahVendaItem.SetLucro(const ALucro: Double);
begin
  FLucro := ALucro;
end;

procedure TPanamahVendaItem.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FAcrescimo := GetFieldValueAsDouble(JSONObject, 'acrescimo');
    FDesconto := GetFieldValueAsDouble(JSONObject, 'desconto');
    FEfetivo := GetFieldValueAsBoolean(JSONObject, 'efetivo');
    FFuncionarioId := GetFieldValue(JSONObject, 'funcionarioId');
    FPreco := GetFieldValueAsDouble(JSONObject, 'preco');
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FCodigoRegistrado := GetFieldValue(JSONObject, 'codigoRegistrado');
    FPromocao := GetFieldValueAsBoolean(JSONObject, 'promocao');
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
    FServico := GetFieldValueAsDouble(JSONObject, 'servico');
    FValorTotal := GetFieldValueAsDouble(JSONObject, 'valorTotal');
    FValorUnitario := GetFieldValueAsDouble(JSONObject, 'valorUnitario');
    FTipoPreco := GetFieldValueAsString(JSONObject, 'tipoPreco');
    FCusto := GetFieldValueAsDouble(JSONObject, 'custo');
    FMarkup := GetFieldValueAsDouble(JSONObject, 'markup');
    FLucro := GetFieldValueAsDouble(JSONObject, 'lucro');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahVendaItem.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'acrescimo', FAcrescimo);    
    SetFieldValue(JSONObject, 'desconto', FDesconto);    
    SetFieldValue(JSONObject, 'efetivo', FEfetivo);    
    SetFieldValue(JSONObject, 'funcionarioId', FFuncionarioId);    
    SetFieldValue(JSONObject, 'preco', FPreco);    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'codigoRegistrado', FCodigoRegistrado);    
    SetFieldValue(JSONObject, 'promocao', FPromocao);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);    
    SetFieldValue(JSONObject, 'servico', FServico);    
    SetFieldValue(JSONObject, 'valorTotal', FValorTotal);    
    SetFieldValue(JSONObject, 'valorUnitario', FValorUnitario);    
    SetFieldValue(JSONObject, 'tipoPreco', FTipoPreco);    
    SetFieldValue(JSONObject, 'custo', FCusto);    
    SetFieldValue(JSONObject, 'markup', FMarkup);    
    SetFieldValue(JSONObject, 'lucro', FLucro);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahVendaItem.FromJSON(const AJSON: string): IPanamahVendaItem;
begin
  Result := TPanamahVendaItem.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVendaItem.GetModelName: string;
begin
  Result := 'VENDA_ITENS';
end;

function TPanamahVendaItem.Clone: IPanamahModel;
begin
  Result := TPanamahVendaItem.FromJSON(SerializeToJSON);
end;

function TPanamahVendaItem.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahVendaItemValidator.Create;
  Result := Validator.Validate(Self as IPanamahVendaItem);
end;

{ TPanamahVendaItemList }

constructor TPanamahVendaItemList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahVendaItemList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahVendaItemList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahVendaItem).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahVendaItemList.FromJSON(const AJSON: string): IPanamahVendaItemList;
begin
  Result := TPanamahVendaItemList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVendaItemList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahVendaItem;
end;

procedure TPanamahVendaItemList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaItemList.Add(const AItem: IPanamahVendaItem);
begin
  FList.Add(AItem);
end;

procedure TPanamahVendaItemList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahVendaItem;
begin
  Item := TPanamahVendaItem.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahVendaItemList.Clear;
begin
  FList.Clear;
end;

function TPanamahVendaItemList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahVendaItemList.GetItem(AIndex: Integer): IPanamahVendaItem;
begin
  Result := FList.Items[AIndex] as IPanamahVendaItem;
end;

procedure TPanamahVendaItemList.SetItem(AIndex: Integer;
  const Value: IPanamahVendaItem);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaItemList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahVendaItemList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahVendaItem).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahVendaItemValidator }

function TPanamahVendaItemValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Itens: IPanamahVendaItem;
  Validations: IPanamahValidationResultList;
begin
  Itens := AModel as IPanamahVendaItem;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Itens.ProdutoId) then
    Validations.AddFailure('Itens.ProdutoId obrigatorio(a)');
  
  if ModelValueIsEmpty(Itens.TipoPreco) then
    Validations.AddFailure('Itens.TipoPreco obrigatorio(a)');
  
  Result := Validations.GetAggregate;
end;

{ TPanamahVenda }

function TPanamahVenda.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahVenda.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahVenda.GetLojaId: string;
begin
  Result := FLojaId;
end;

procedure TPanamahVenda.SetLojaId(const ALojaId: string);
begin
  FLojaId := ALojaId;
end;

function TPanamahVenda.GetClienteId: variant;
begin
  Result := FClienteId;
end;

procedure TPanamahVenda.SetClienteId(const AClienteId: variant);
begin
  FClienteId := AClienteId;
end;

function TPanamahVenda.GetFuncionarioId: variant;
begin
  Result := FFuncionarioId;
end;

procedure TPanamahVenda.SetFuncionarioId(const AFuncionarioId: variant);
begin
  FFuncionarioId := AFuncionarioId;
end;

function TPanamahVenda.GetData: TDateTime;
begin
  Result := FData;
end;

procedure TPanamahVenda.SetData(const AData: TDateTime);
begin
  FData := AData;
end;

function TPanamahVenda.GetDataHoraInicio: TDateTime;
begin
  Result := FDataHoraInicio;
end;

procedure TPanamahVenda.SetDataHoraInicio(const ADataHoraInicio: TDateTime);
begin
  FDataHoraInicio := ADataHoraInicio;
end;

function TPanamahVenda.GetDataHoraFim: TDateTime;
begin
  Result := FDataHoraFim;
end;

procedure TPanamahVenda.SetDataHoraFim(const ADataHoraFim: TDateTime);
begin
  FDataHoraFim := ADataHoraFim;
end;

function TPanamahVenda.GetDataHoraVenda: TDateTime;
begin
  Result := FDataHoraVenda;
end;

procedure TPanamahVenda.SetDataHoraVenda(const ADataHoraVenda: TDateTime);
begin
  FDataHoraVenda := ADataHoraVenda;
end;

function TPanamahVenda.GetDesconto: Double;
begin
  Result := FDesconto;
end;

procedure TPanamahVenda.SetDesconto(const ADesconto: Double);
begin
  FDesconto := ADesconto;
end;

function TPanamahVenda.GetEfetiva: Boolean;
begin
  Result := FEfetiva;
end;

procedure TPanamahVenda.SetEfetiva(const AEfetiva: Boolean);
begin
  FEfetiva := AEfetiva;
end;

function TPanamahVenda.GetQuantidadeItens: Double;
begin
  Result := FQuantidadeItens;
end;

procedure TPanamahVenda.SetQuantidadeItens(const AQuantidadeItens: Double);
begin
  FQuantidadeItens := AQuantidadeItens;
end;

function TPanamahVenda.GetQuantidadeItensCancelados: Double;
begin
  Result := FQuantidadeItensCancelados;
end;

procedure TPanamahVenda.SetQuantidadeItensCancelados(const AQuantidadeItensCancelados: Double);
begin
  FQuantidadeItensCancelados := AQuantidadeItensCancelados;
end;

function TPanamahVenda.GetSequencial: string;
begin
  Result := FSequencial;
end;

procedure TPanamahVenda.SetSequencial(const ASequencial: string);
begin
  FSequencial := ASequencial;
end;

function TPanamahVenda.GetServico: Double;
begin
  Result := FServico;
end;

procedure TPanamahVenda.SetServico(const AServico: Double);
begin
  FServico := AServico;
end;

function TPanamahVenda.GetTipoDesconto: variant;
begin
  Result := FTipoDesconto;
end;

procedure TPanamahVenda.SetTipoDesconto(const ATipoDesconto: variant);
begin
  FTipoDesconto := ATipoDesconto;
end;

function TPanamahVenda.GetTipoPreco: string;
begin
  Result := FTipoPreco;
end;

procedure TPanamahVenda.SetTipoPreco(const ATipoPreco: string);
begin
  FTipoPreco := ATipoPreco;
end;

function TPanamahVenda.GetValor: Double;
begin
  Result := FValor;
end;

procedure TPanamahVenda.SetValor(const AValor: Double);
begin
  FValor := AValor;
end;

function TPanamahVenda.GetValorItensCancelados: Double;
begin
  Result := FValorItensCancelados;
end;

procedure TPanamahVenda.SetValorItensCancelados(const AValorItensCancelados: Double);
begin
  FValorItensCancelados := AValorItensCancelados;
end;

function TPanamahVenda.GetAcrescimo: Double;
begin
  Result := FAcrescimo;
end;

procedure TPanamahVenda.SetAcrescimo(const AAcrescimo: Double);
begin
  FAcrescimo := AAcrescimo;
end;

function TPanamahVenda.GetNumeroCaixa: variant;
begin
  Result := FNumeroCaixa;
end;

procedure TPanamahVenda.SetNumeroCaixa(const ANumeroCaixa: variant);
begin
  FNumeroCaixa := ANumeroCaixa;
end;

function TPanamahVenda.GetItens: IpanamahVendaItemList;
begin
  Result := FItens;
end;

procedure TPanamahVenda.SetItens(const AItens: IpanamahVendaItemList);
begin
  FItens := AItens;
end;

function TPanamahVenda.GetPagamentos: IpanamahVendaPagamentoList;
begin
  Result := FPagamentos;
end;

procedure TPanamahVenda.SetPagamentos(const APagamentos: IpanamahVendaPagamentoList);
begin
  FPagamentos := APagamentos;
end;

procedure TPanamahVenda.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FLojaId := GetFieldValueAsString(JSONObject, 'lojaId');
    FClienteId := GetFieldValue(JSONObject, 'clienteId');
    FFuncionarioId := GetFieldValue(JSONObject, 'funcionarioId');
    FData := GetFieldValueAsDatetime(JSONObject, 'data');
    FDataHoraInicio := GetFieldValueAsDatetime(JSONObject, 'dataHoraInicio');
    FDataHoraFim := GetFieldValueAsDatetime(JSONObject, 'dataHoraFim');
    FDataHoraVenda := GetFieldValueAsDatetime(JSONObject, 'dataHoraVenda');
    FDesconto := GetFieldValueAsDouble(JSONObject, 'desconto');
    FEfetiva := GetFieldValueAsBoolean(JSONObject, 'efetiva');
    FQuantidadeItens := GetFieldValueAsDouble(JSONObject, 'quantidadeItens');
    FQuantidadeItensCancelados := GetFieldValueAsDouble(JSONObject, 'quantidadeItensCancelados');
    FSequencial := GetFieldValueAsString(JSONObject, 'sequencial');
    FServico := GetFieldValueAsDouble(JSONObject, 'servico');
    FTipoDesconto := GetFieldValue(JSONObject, 'tipoDesconto');
    FTipoPreco := GetFieldValueAsString(JSONObject, 'tipoPreco');
    FValor := GetFieldValueAsDouble(JSONObject, 'valor');
    FValorItensCancelados := GetFieldValueAsDouble(JSONObject, 'valorItensCancelados');
    FAcrescimo := GetFieldValueAsDouble(JSONObject, 'acrescimo');
    FNumeroCaixa := GetFieldValue(JSONObject, 'numeroCaixa');
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TpanamahVendaItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
    if JSONObject.Field['pagamentos'] is TlkJSONlist then
      FPagamentos := TpanamahVendaPagamentoList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['pagamentos']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahVenda.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'lojaId', FLojaId);    
    SetFieldValue(JSONObject, 'clienteId', FClienteId);    
    SetFieldValue(JSONObject, 'funcionarioId', FFuncionarioId);    
    SetFieldValue(JSONObject, 'data', FData);    
    SetFieldValue(JSONObject, 'dataHoraInicio', FDataHoraInicio);    
    SetFieldValue(JSONObject, 'dataHoraFim', FDataHoraFim);    
    SetFieldValue(JSONObject, 'dataHoraVenda', FDataHoraVenda);    
    SetFieldValue(JSONObject, 'desconto', FDesconto);    
    SetFieldValue(JSONObject, 'efetiva', FEfetiva);    
    SetFieldValue(JSONObject, 'quantidadeItens', FQuantidadeItens);    
    SetFieldValue(JSONObject, 'quantidadeItensCancelados', FQuantidadeItensCancelados);    
    SetFieldValue(JSONObject, 'sequencial', FSequencial);    
    SetFieldValue(JSONObject, 'servico', FServico);    
    SetFieldValue(JSONObject, 'tipoDesconto', FTipoDesconto);    
    SetFieldValue(JSONObject, 'tipoPreco', FTipoPreco);    
    SetFieldValue(JSONObject, 'valor', FValor);    
    SetFieldValue(JSONObject, 'valorItensCancelados', FValorItensCancelados);    
    SetFieldValue(JSONObject, 'acrescimo', FAcrescimo);    
    SetFieldValue(JSONObject, 'numeroCaixa', FNumeroCaixa);    
    SetFieldValue(JSONObject, 'itens', FItens);    
    SetFieldValue(JSONObject, 'pagamentos', FPagamentos);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahVenda.FromJSON(const AJSON: string): IPanamahVenda;
begin
  Result := TPanamahVenda.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVenda.GetModelName: string;
begin
  Result := 'VENDA';
end;

function TPanamahVenda.Clone: IPanamahModel;
begin
  Result := TPanamahVenda.FromJSON(SerializeToJSON);
end;

function TPanamahVenda.Validate: IPanamahValidationResult;
var
  Validator: IPanamahModelValidator;
begin
  Validator := TPanamahVendaValidator.Create;
  Result := Validator.Validate(Self as IPanamahVenda);
end;

{ TPanamahVendaList }

constructor TPanamahVendaList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahVendaList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

function TPanamahVendaList.Validate: IPanamahValidationResult;
var
  I: Integer;
begin
  Result := TPanamahValidationResult.CreateSuccess;
  FList.Lock;
  try
    for I := 0 to FList.Count - 1 do
      Result.Concat(Format('[%d]', [I]), (FList[I] as IPanamahVenda).Validate);
  finally
    FList.Unlock;
  end;
end;

class function TPanamahVendaList.FromJSON(const AJSON: string): IPanamahVendaList;
begin
  Result := TPanamahVendaList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahVendaList.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := FList[AIndex] as IPanamahVenda;
end;

procedure TPanamahVendaList.SetModel(AIndex: Integer; const Value: IPanamahModel);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaList.Add(const AItem: IPanamahVenda);
begin
  FList.Add(AItem);
end;

procedure TPanamahVendaList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahVenda;
begin
  Item := TPanamahVenda.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahVendaList.Clear;
begin
  FList.Clear;
end;

function TPanamahVendaList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahVendaList.GetItem(AIndex: Integer): IPanamahVenda;
begin
  Result := FList.Items[AIndex] as IPanamahVenda;
end;

procedure TPanamahVendaList.SetItem(AIndex: Integer;
  const Value: IPanamahVenda);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahVendaList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahVendaList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahVenda).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahVendaValidator }

function TPanamahVendaValidator.Validate(AModel: IPanamahModel): IPanamahValidationResult;
var
  Venda: IPanamahVenda;
  Validations: IPanamahValidationResultList;
begin
  Venda := AModel as IPanamahVenda;
  Validations := TPanamahValidationResultList.Create;
  
  if ModelValueIsEmpty(Venda.Id) then
    Validations.AddFailure('Venda.Id obrigatorio(a)');
  
  if ModelValueIsEmpty(Venda.LojaId) then
    Validations.AddFailure('Venda.LojaId obrigatorio(a)');
  
  if ModelValueIsEmpty(Venda.Sequencial) then
    Validations.AddFailure('Venda.Sequencial obrigatorio(a)');
  
  if ModelValueIsEmpty(Venda.TipoPreco) then
    Validations.AddFailure('Venda.TipoPreco obrigatorio(a)');
  
  if ModelListIsEmpty(Venda.Itens) then
    Validations.AddFailure('Venda.Itens obrigatorio(a)')
  else
    Validations.Add(Venda.Itens.Validate);
  
  if ModelListIsEmpty(Venda.Pagamentos) then
    Validations.AddFailure('Venda.Pagamentos obrigatorio(a)')
  else
    Validations.Add(Venda.Pagamentos.Validate);
  
  Result := Validations.GetAggregate;
end;

end.