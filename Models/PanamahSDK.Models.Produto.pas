{$M+}
unit PanamahSDK.Models.Produto;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.JsonUtils, PanamahSDK.Enums, Variants, uLkJSON;

type
  
  IPanamahProdutoFornecedor = interface(IPanamahModel)
    ['{D3453A44-7043-11E9-B47F-05333FE0F816}']
    function GetId: string;
    function GetPrincipal: Boolean;
    procedure SetId(const AId: string);
    procedure SetPrincipal(const APrincipal: Boolean);
    property Id: string read GetId write SetId;
    property Principal: Boolean read GetPrincipal write SetPrincipal;
  end;
  
  IPanamahProdutoFornecedorList = interface(IJSONSerializable)
    ['{D3453A45-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): IPanamahProdutoFornecedor;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoFornecedor);
    procedure Add(const AItem: IPanamahProdutoFornecedor);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProdutoFornecedor read GetItem write SetItem; default;
  end;
  
  IPanamahProdutoComposicaoItem = interface(IPanamahModel)
    ['{D3453A40-7043-11E9-B47F-05333FE0F816}']
    function GetProdutoId: string;
    function GetQuantidade: Double;
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;
  
  IPanamahProdutoComposicaoItemList = interface(IJSONSerializable)
    ['{D3453A41-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;
  
  IPanamahProdutoComposicao = interface(IPanamahModel)
    ['{D345133E-7043-11E9-B47F-05333FE0F816}']
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(const AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(const AQuantidade: Double);
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;
  
  IPanamahProdutoComposicaoList = interface(IJSONSerializable)
    ['{D345133F-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): IPanamahProdutoComposicao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicao);
    procedure Add(const AItem: IPanamahProdutoComposicao);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProdutoComposicao read GetItem write SetItem; default;
  end;
  
  IPanamahProduto = interface(IPanamahModel)
    ['{D344EC2A-7043-11E9-B47F-05333FE0F816}']
    function GetComposicao: IPanamahProdutoComposicao;
    function GetTipoComposicao: variant;
    function GetDescricao: string;
    function GetDataInclusao: TDateTime;
    function GetFinalidade: variant;
    function GetAtivo: Boolean;
    function GetGrupoId: variant;
    function GetId: string;
    function GetPesoVariavel: Boolean;
    function GetQuantidadeItensEmbalagem: Double;
    function GetSecaoId: string;
    function GetSubgrupoId: variant;
    function GetFornecedores: IPanamahProdutoFornecedorList;
    procedure SetComposicao(const AComposicao: IPanamahProdutoComposicao);
    procedure SetTipoComposicao(const ATipoComposicao: variant);
    procedure SetDescricao(const ADescricao: string);
    procedure SetDataInclusao(const ADataInclusao: TDateTime);
    procedure SetFinalidade(const AFinalidade: variant);
    procedure SetAtivo(const AAtivo: Boolean);
    procedure SetGrupoId(const AGrupoId: variant);
    procedure SetId(const AId: string);
    procedure SetPesoVariavel(const APesoVariavel: Boolean);
    procedure SetQuantidadeItensEmbalagem(const AQuantidadeItensEmbalagem: Double);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetSubgrupoId(const ASubgrupoId: variant);
    procedure SetFornecedores(const AFornecedores: IPanamahProdutoFornecedorList);
    property Composicao: IPanamahProdutoComposicao read GetComposicao write SetComposicao;
    property TipoComposicao: variant read GetTipoComposicao write SetTipoComposicao;
    property Descricao: string read GetDescricao write SetDescricao;
    property DataInclusao: TDateTime read GetDataInclusao write SetDataInclusao;
    property Finalidade: variant read GetFinalidade write SetFinalidade;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property GrupoId: variant read GetGrupoId write SetGrupoId;
    property Id: string read GetId write SetId;
    property PesoVariavel: Boolean read GetPesoVariavel write SetPesoVariavel;
    property QuantidadeItensEmbalagem: Double read GetQuantidadeItensEmbalagem write SetQuantidadeItensEmbalagem;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property SubgrupoId: variant read GetSubgrupoId write SetSubgrupoId;
    property Fornecedores: IPanamahProdutoFornecedorList read GetFornecedores write SetFornecedores;
  end;
  
  IPanamahProdutoList = interface(IJSONSerializable)
    ['{D3451330-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): IPanamahProduto;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProduto);
    procedure Add(const AItem: IPanamahProduto);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProduto read GetItem write SetItem; default;
  end;
  
  TPanamahProdutoFornecedor = class(TInterfacedObject, IPanamahProdutoFornecedor)
  private
    FId: string;
    FPrincipal: Boolean;
    function GetId: string;
    function GetPrincipal: Boolean;
    procedure SetId(const AId: string);
    procedure SetPrincipal(const APrincipal: Boolean);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahProdutoFornecedor;
  published
    property Id: string read GetId write SetId;
    property Principal: Boolean read GetPrincipal write SetPrincipal;
  end;

  TPanamahProdutoFornecedorList = class(TInterfacedObject, IPanamahProdutoFornecedorList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProdutoFornecedor;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoFornecedor);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoFornecedorList;
    constructor Create;
    procedure Add(const AItem: IPanamahProdutoFornecedor);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProdutoFornecedor read GetItem write SetItem; default;
  end;
  
  TPanamahProdutoComposicaoItem = class(TInterfacedObject, IPanamahProdutoComposicaoItem)
  private
    FProdutoId: string;
    FQuantidade: Double;
    function GetProdutoId: string;
    function GetQuantidade: Double;
    procedure SetProdutoId(const AProdutoId: string);
    procedure SetQuantidade(const AQuantidade: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicaoItem;
  published
    property ProdutoId: string read GetProdutoId write SetProdutoId;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;

  TPanamahProdutoComposicaoItemList = class(TInterfacedObject, IPanamahProdutoComposicaoItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicaoItemList;
    constructor Create;
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;
  
  TPanamahProdutoComposicao = class(TInterfacedObject, IPanamahProdutoComposicao)
  private
    FItens: IPanamahProdutoComposicaoItemList;
    FQuantidade: Double;
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(const AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(const AQuantidade: Double);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicao;
  published
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;

  TPanamahProdutoComposicaoList = class(TInterfacedObject, IPanamahProdutoComposicaoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProdutoComposicao;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicao);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoComposicaoList;
    constructor Create;
    procedure Add(const AItem: IPanamahProdutoComposicao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProdutoComposicao read GetItem write SetItem; default;
  end;
  
  TPanamahProduto = class(TInterfacedObject, IPanamahProduto)
  private
    FComposicao: IPanamahProdutoComposicao;
    FTipoComposicao: variant;
    FDescricao: string;
    FDataInclusao: TDateTime;
    FFinalidade: variant;
    FAtivo: Boolean;
    FGrupoId: variant;
    FId: string;
    FPesoVariavel: Boolean;
    FQuantidadeItensEmbalagem: Double;
    FSecaoId: string;
    FSubgrupoId: variant;
    FFornecedores: IPanamahProdutoFornecedorList;
    function GetComposicao: IPanamahProdutoComposicao;
    function GetTipoComposicao: variant;
    function GetDescricao: string;
    function GetDataInclusao: TDateTime;
    function GetFinalidade: variant;
    function GetAtivo: Boolean;
    function GetGrupoId: variant;
    function GetId: string;
    function GetPesoVariavel: Boolean;
    function GetQuantidadeItensEmbalagem: Double;
    function GetSecaoId: string;
    function GetSubgrupoId: variant;
    function GetFornecedores: IPanamahProdutoFornecedorList;
    procedure SetComposicao(const AComposicao: IPanamahProdutoComposicao);
    procedure SetTipoComposicao(const ATipoComposicao: variant);
    procedure SetDescricao(const ADescricao: string);
    procedure SetDataInclusao(const ADataInclusao: TDateTime);
    procedure SetFinalidade(const AFinalidade: variant);
    procedure SetAtivo(const AAtivo: Boolean);
    procedure SetGrupoId(const AGrupoId: variant);
    procedure SetId(const AId: string);
    procedure SetPesoVariavel(const APesoVariavel: Boolean);
    procedure SetQuantidadeItensEmbalagem(const AQuantidadeItensEmbalagem: Double);
    procedure SetSecaoId(const ASecaoId: string);
    procedure SetSubgrupoId(const ASubgrupoId: variant);
    procedure SetFornecedores(const AFornecedores: IPanamahProdutoFornecedorList);
    function GetModelName: string;    
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    function Clone: IPanamahModel;
    class function FromJSON(const AJSON: string): IPanamahProduto;
  published
    property Composicao: IPanamahProdutoComposicao read GetComposicao write SetComposicao;
    property TipoComposicao: variant read GetTipoComposicao write SetTipoComposicao;
    property Descricao: string read GetDescricao write SetDescricao;
    property DataInclusao: TDateTime read GetDataInclusao write SetDataInclusao;
    property Finalidade: variant read GetFinalidade write SetFinalidade;
    property Ativo: Boolean read GetAtivo write SetAtivo;
    property GrupoId: variant read GetGrupoId write SetGrupoId;
    property Id: string read GetId write SetId;
    property PesoVariavel: Boolean read GetPesoVariavel write SetPesoVariavel;
    property QuantidadeItensEmbalagem: Double read GetQuantidadeItensEmbalagem write SetQuantidadeItensEmbalagem;
    property SecaoId: string read GetSecaoId write SetSecaoId;
    property SubgrupoId: variant read GetSubgrupoId write SetSubgrupoId;
    property Fornecedores: IPanamahProdutoFornecedorList read GetFornecedores write SetFornecedores;
  end;

  TPanamahProdutoList = class(TInterfacedObject, IPanamahProdutoList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProduto;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProduto);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahProdutoList;
    constructor Create;
    procedure Add(const AItem: IPanamahProduto);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProduto read GetItem write SetItem; default;
  end;
  
implementation

{ TPanamahProdutoFornecedor }

function TPanamahProdutoFornecedor.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahProdutoFornecedor.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahProdutoFornecedor.GetPrincipal: Boolean;
begin
  Result := FPrincipal;
end;

procedure TPanamahProdutoFornecedor.SetPrincipal(const APrincipal: Boolean);
begin
  FPrincipal := APrincipal;
end;

procedure TPanamahProdutoFornecedor.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FId := GetFieldValueAsString(JSONObject, 'id');
    FPrincipal := GetFieldValueAsBoolean(JSONObject, 'principal');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProdutoFornecedor.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'principal', FPrincipal);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProdutoFornecedor.FromJSON(const AJSON: string): IPanamahProdutoFornecedor;
begin
  Result := TPanamahProdutoFornecedor.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProdutoFornecedor.GetModelName: string;
begin
  Result := 'PanamahProdutoFornecedor';
end;

function TPanamahProdutoFornecedor.Clone: IPanamahModel;
begin
  Result := TPanamahProdutoFornecedor.FromJSON(SerializeToJSON);
end;

{ TPanamahProdutoFornecedorList }

constructor TPanamahProdutoFornecedorList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahProdutoFornecedorList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahProdutoFornecedorList.FromJSON(const AJSON: string): IPanamahProdutoFornecedorList;
begin
  Result := TPanamahProdutoFornecedorList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahProdutoFornecedorList.Add(const AItem: IPanamahProdutoFornecedor);
begin
  FList.Add(AItem);
end;

procedure TPanamahProdutoFornecedorList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahProdutoFornecedor;
begin
  Item := TPanamahProdutoFornecedor.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahProdutoFornecedorList.Clear;
begin
  FList.Clear;
end;

function TPanamahProdutoFornecedorList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahProdutoFornecedorList.GetItem(AIndex: Integer): IPanamahProdutoFornecedor;
begin
  Result := FList.Items[AIndex] as IPanamahProdutoFornecedor;
end;

procedure TPanamahProdutoFornecedorList.SetItem(AIndex: Integer;
  const Value: IPanamahProdutoFornecedor);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahProdutoFornecedorList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoFornecedorList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahProdutoFornecedor).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahProdutoComposicaoItem }

function TPanamahProdutoComposicaoItem.GetProdutoId: string;
begin
  Result := FProdutoId;
end;

procedure TPanamahProdutoComposicaoItem.SetProdutoId(const AProdutoId: string);
begin
  FProdutoId := AProdutoId;
end;

function TPanamahProdutoComposicaoItem.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahProdutoComposicaoItem.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

procedure TPanamahProdutoComposicaoItem.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FProdutoId := GetFieldValueAsString(JSONObject, 'produtoId');
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProdutoComposicaoItem.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'produtoId', FProdutoId);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProdutoComposicaoItem.FromJSON(const AJSON: string): IPanamahProdutoComposicaoItem;
begin
  Result := TPanamahProdutoComposicaoItem.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProdutoComposicaoItem.GetModelName: string;
begin
  Result := 'PanamahProdutoComposicaoItem';
end;

function TPanamahProdutoComposicaoItem.Clone: IPanamahModel;
begin
  Result := TPanamahProdutoComposicaoItem.FromJSON(SerializeToJSON);
end;

{ TPanamahProdutoComposicaoItemList }

constructor TPanamahProdutoComposicaoItemList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahProdutoComposicaoItemList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahProdutoComposicaoItemList.FromJSON(const AJSON: string): IPanamahProdutoComposicaoItemList;
begin
  Result := TPanamahProdutoComposicaoItemList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahProdutoComposicaoItemList.Add(const AItem: IPanamahProdutoComposicaoItem);
begin
  FList.Add(AItem);
end;

procedure TPanamahProdutoComposicaoItemList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahProdutoComposicaoItem;
begin
  Item := TPanamahProdutoComposicaoItem.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahProdutoComposicaoItemList.Clear;
begin
  FList.Clear;
end;

function TPanamahProdutoComposicaoItemList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahProdutoComposicaoItemList.GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
begin
  Result := FList.Items[AIndex] as IPanamahProdutoComposicaoItem;
end;

procedure TPanamahProdutoComposicaoItemList.SetItem(AIndex: Integer;
  const Value: IPanamahProdutoComposicaoItem);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahProdutoComposicaoItemList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoComposicaoItemList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahProdutoComposicaoItem).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahProdutoComposicao }

function TPanamahProdutoComposicao.GetItens: IPanamahProdutoComposicaoItemList;
begin
  Result := FItens;
end;

procedure TPanamahProdutoComposicao.SetItens(const AItens: IPanamahProdutoComposicaoItemList);
begin
  FItens := AItens;
end;

function TPanamahProdutoComposicao.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahProdutoComposicao.SetQuantidade(const AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

procedure TPanamahProdutoComposicao.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TPanamahProdutoComposicaoItemList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
    FQuantidade := GetFieldValueAsDouble(JSONObject, 'quantidade');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProdutoComposicao.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'itens', FItens);    
    SetFieldValue(JSONObject, 'quantidade', FQuantidade);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProdutoComposicao.FromJSON(const AJSON: string): IPanamahProdutoComposicao;
begin
  Result := TPanamahProdutoComposicao.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProdutoComposicao.GetModelName: string;
begin
  Result := 'PanamahProdutoComposicao';
end;

function TPanamahProdutoComposicao.Clone: IPanamahModel;
begin
  Result := TPanamahProdutoComposicao.FromJSON(SerializeToJSON);
end;

{ TPanamahProdutoComposicaoList }

constructor TPanamahProdutoComposicaoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahProdutoComposicaoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahProdutoComposicaoList.FromJSON(const AJSON: string): IPanamahProdutoComposicaoList;
begin
  Result := TPanamahProdutoComposicaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahProdutoComposicaoList.Add(const AItem: IPanamahProdutoComposicao);
begin
  FList.Add(AItem);
end;

procedure TPanamahProdutoComposicaoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahProdutoComposicao;
begin
  Item := TPanamahProdutoComposicao.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahProdutoComposicaoList.Clear;
begin
  FList.Clear;
end;

function TPanamahProdutoComposicaoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahProdutoComposicaoList.GetItem(AIndex: Integer): IPanamahProdutoComposicao;
begin
  Result := FList.Items[AIndex] as IPanamahProdutoComposicao;
end;

procedure TPanamahProdutoComposicaoList.SetItem(AIndex: Integer;
  const Value: IPanamahProdutoComposicao);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahProdutoComposicaoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoComposicaoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahProdutoComposicao).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

{ TPanamahProduto }

function TPanamahProduto.GetComposicao: IPanamahProdutoComposicao;
begin
  Result := FComposicao;
end;

procedure TPanamahProduto.SetComposicao(const AComposicao: IPanamahProdutoComposicao);
begin
  FComposicao := AComposicao;
end;

function TPanamahProduto.GetTipoComposicao: variant;
begin
  Result := FTipoComposicao;
end;

procedure TPanamahProduto.SetTipoComposicao(const ATipoComposicao: variant);
begin
  FTipoComposicao := ATipoComposicao;
end;

function TPanamahProduto.GetDescricao: string;
begin
  Result := FDescricao;
end;

procedure TPanamahProduto.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

function TPanamahProduto.GetDataInclusao: TDateTime;
begin
  Result := FDataInclusao;
end;

procedure TPanamahProduto.SetDataInclusao(const ADataInclusao: TDateTime);
begin
  FDataInclusao := ADataInclusao;
end;

function TPanamahProduto.GetFinalidade: variant;
begin
  Result := FFinalidade;
end;

procedure TPanamahProduto.SetFinalidade(const AFinalidade: variant);
begin
  FFinalidade := AFinalidade;
end;

function TPanamahProduto.GetAtivo: Boolean;
begin
  Result := FAtivo;
end;

procedure TPanamahProduto.SetAtivo(const AAtivo: Boolean);
begin
  FAtivo := AAtivo;
end;

function TPanamahProduto.GetGrupoId: variant;
begin
  Result := FGrupoId;
end;

procedure TPanamahProduto.SetGrupoId(const AGrupoId: variant);
begin
  FGrupoId := AGrupoId;
end;

function TPanamahProduto.GetId: string;
begin
  Result := FId;
end;

procedure TPanamahProduto.SetId(const AId: string);
begin
  FId := AId;
end;

function TPanamahProduto.GetPesoVariavel: Boolean;
begin
  Result := FPesoVariavel;
end;

procedure TPanamahProduto.SetPesoVariavel(const APesoVariavel: Boolean);
begin
  FPesoVariavel := APesoVariavel;
end;

function TPanamahProduto.GetQuantidadeItensEmbalagem: Double;
begin
  Result := FQuantidadeItensEmbalagem;
end;

procedure TPanamahProduto.SetQuantidadeItensEmbalagem(const AQuantidadeItensEmbalagem: Double);
begin
  FQuantidadeItensEmbalagem := AQuantidadeItensEmbalagem;
end;

function TPanamahProduto.GetSecaoId: string;
begin
  Result := FSecaoId;
end;

procedure TPanamahProduto.SetSecaoId(const ASecaoId: string);
begin
  FSecaoId := ASecaoId;
end;

function TPanamahProduto.GetSubgrupoId: variant;
begin
  Result := FSubgrupoId;
end;

procedure TPanamahProduto.SetSubgrupoId(const ASubgrupoId: variant);
begin
  FSubgrupoId := ASubgrupoId;
end;

function TPanamahProduto.GetFornecedores: IPanamahProdutoFornecedorList;
begin
  Result := FFornecedores;
end;

procedure TPanamahProduto.SetFornecedores(const AFornecedores: IPanamahProdutoFornecedorList);
begin
  FFornecedores := AFornecedores;
end;

procedure TPanamahProduto.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if JSONObject.Field['composicao'] is TlkJSONobject then
      FComposicao := TPanamahProdutoComposicao.FromJSON(TlkJSON.GenerateText(JSONObject.Field['composicao']));
    FTipoComposicao := GetFieldValue(JSONObject, 'tipoComposicao');
    FDescricao := GetFieldValueAsString(JSONObject, 'descricao');
    FDataInclusao := GetFieldValueAsDatetime(JSONObject, 'dataInclusao');
    FFinalidade := GetFieldValue(JSONObject, 'finalidade');
    FAtivo := GetFieldValueAsBoolean(JSONObject, 'ativo');
    FGrupoId := GetFieldValue(JSONObject, 'grupoId');
    FId := GetFieldValueAsString(JSONObject, 'id');
    FPesoVariavel := GetFieldValueAsBoolean(JSONObject, 'pesoVariavel');
    FQuantidadeItensEmbalagem := GetFieldValueAsDouble(JSONObject, 'quantidadeItensEmbalagem');
    FSecaoId := GetFieldValueAsString(JSONObject, 'secaoId');
    FSubgrupoId := GetFieldValue(JSONObject, 'subgrupoId');
    if JSONObject.Field['fornecedores'] is TlkJSONlist then
      FFornecedores := TPanamahProdutoFornecedorList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['fornecedores']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahProduto.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try    
    SetFieldValue(JSONObject, 'composicao', FComposicao);    
    SetFieldValue(JSONObject, 'tipoComposicao', FTipoComposicao);    
    SetFieldValue(JSONObject, 'descricao', FDescricao);    
    SetFieldValue(JSONObject, 'dataInclusao', FDataInclusao);    
    SetFieldValue(JSONObject, 'finalidade', FFinalidade);    
    SetFieldValue(JSONObject, 'ativo', FAtivo);    
    SetFieldValue(JSONObject, 'grupoId', FGrupoId);    
    SetFieldValue(JSONObject, 'id', FId);    
    SetFieldValue(JSONObject, 'pesoVariavel', FPesoVariavel);    
    SetFieldValue(JSONObject, 'quantidadeItensEmbalagem', FQuantidadeItensEmbalagem);    
    SetFieldValue(JSONObject, 'secaoId', FSecaoId);    
    SetFieldValue(JSONObject, 'subgrupoId', FSubgrupoId);    
    SetFieldValue(JSONObject, 'fornecedores', FFornecedores);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahProduto.FromJSON(const AJSON: string): IPanamahProduto;
begin
  Result := TPanamahProduto.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahProduto.GetModelName: string;
begin
  Result := 'PanamahProduto';
end;

function TPanamahProduto.Clone: IPanamahModel;
begin
  Result := TPanamahProduto.FromJSON(SerializeToJSON);
end;

{ TPanamahProdutoList }

constructor TPanamahProdutoList.Create;
begin
  FList := TInterfaceList.Create;
end;

destructor TPanamahProdutoList.Destroy;
begin
  FreeAndNil(FList);
  inherited;
end;

class function TPanamahProdutoList.FromJSON(const AJSON: string): IPanamahProdutoList;
begin
  Result := TPanamahProdutoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

procedure TPanamahProdutoList.Add(const AItem: IPanamahProduto);
begin
  FList.Add(AItem);
end;

procedure TPanamahProdutoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
var
  Item: IPanamahProduto;
begin
  Item := TPanamahProduto.Create;
  Item.DeserializeFromJSON(TlkJSON.GenerateText(Elem));
  FList.Add(Item);
end;

procedure TPanamahProdutoList.Clear;
begin
  FList.Clear;
end;

function TPanamahProdutoList.Count: Integer;
begin
  Result := FList.Count;
end;

function TPanamahProdutoList.GetItem(AIndex: Integer): IPanamahProduto;
begin
  Result := FList.Items[AIndex] as IPanamahProduto;
end;

procedure TPanamahProdutoList.SetItem(AIndex: Integer;
  const Value: IPanamahProduto);
begin
  FList[AIndex] := Value;
end;

procedure TPanamahProdutoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahProduto).SerializeToJSON));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.