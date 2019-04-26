{$M+}
unit PanamahSDK.Models.PanamahProduto;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, Variants, uLkJSON;

type
  IPanamahProdutoComposicaoItem = interface(IModel)
    ['{9B3ADAD7-4BFF-4342-9795-A3F6BB96C15C}']
    function GetProdutoId: Variant;
    procedure SetProdutoId(const AProdutoId: Variant);
    property ProdutoId: Variant read GetProdutoId write SetProdutoId;
  end;

  IPanamahProdutoComposicaoItemList = interface(IJSONSerializable)
    ['{73E33100-4480-4FDE-9B24-311F2D017F91}']
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;

  IPanamahProdutoComposicao = interface(IModel)
    ['{3F3AB5E7-DCCC-4947-8FE1-6DC4952719D6}']
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(AQuantidade: Double);
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
  end;

  IPanamahProduto = interface(IModel)
    ['{AF7B1CE0-69EA-43E9-8B8A-FC3FEC6F9CDD}']
    function GetDescricao: string;
    function GetFinalidade: Variant;
    function GetId: Variant;
    procedure SetDescricao(const ADescricao: string);
    procedure SetFinalidade(const AFinalidade: Variant);
    procedure SetId(const AId: Variant);
    property Descricao: string read GetDescricao write SetDescricao;
    property Finalidade: Variant read GetFinalidade write SetFinalidade;
    property Id: Variant read GetId write SetId;
  end;

  TPanamahProdutoComposicaoItem = class(TInterfacedObject, IPanamahProdutoComposicaoItem)
  private
    FProdutoId: Variant;
    function GetProdutoId: Variant;
    procedure SetProdutoId(const AProdutoId: Variant);
  public
    function ToJSON: string;
    procedure FromJSON(const AJSON: string);
  published
    property ProdutoId: Variant read GetProdutoId write SetProdutoId;
  end;

  TPanamahProdutoComposicaoItemList = class(TInterfacedObject, IPanamahProdutoComposicaoItemList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahProdutoComposicaoItem;
    procedure SetItem(AIndex: Integer; const Value: IPanamahProdutoComposicaoItem);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function ToJSON: string;
    procedure FromJSON(const AJSON: string);
    constructor Create;
    procedure Add(const AItem: IPanamahProdutoComposicaoItem);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahProdutoComposicaoItem read GetItem write SetItem; default;
  end;

  TPanamahProdutoComposicao = class(TInterfacedObject, IPanamahProdutoComposicao)
  private
    FQuantidade: Double;
    FItens: IPanamahProdutoComposicaoItemList;
    function GetItens: IPanamahProdutoComposicaoItemList;
    function GetQuantidade: Double;
    procedure SetItens(AItens: IPanamahProdutoComposicaoItemList);
    procedure SetQuantidade(AQuantidade: Double);
  public
    function ToJSON: string;
    procedure FromJSON(const AJSON: string);
  published
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Itens: IPanamahProdutoComposicaoItemList read GetItens write SetItens;
  end;

  TPanamahProduto = class(TInterfacedObject, IPanamahProduto)
  private
    FComposicao: IPanamahProdutoComposicao;
    FDescricao: string;
    FFinalidade: string;
    FId: Variant;
    function GetComposicao: IPanamahProdutoComposicao;
    function GetDescricao: string;
    function GetFinalidade: Variant;
    function GetId: Variant;
    procedure SetComposicao(AComposicao: IPanamahProdutoComposicao);
    procedure SetDescricao(const ADescricao: string);
    procedure SetFinalidade(const AFinalidade: Variant);
    procedure SetId(const AId: Variant);
  public
    function ToJSON: string;
    procedure FromJSON(const AJSON: string);
  published
    property Composicao: IPanamahProdutoComposicao read GetComposicao write SetComposicao;
    property Descricao: string read GetDescricao write SetDescricao;
    property Finalidade: Variant read GetFinalidade write SetFinalidade;
    property Id: Variant read GetId write SetId;
  end;

implementation

{ TPanamahProdutoComposicaoItem }

function TPanamahProdutoComposicaoItem.GetProdutoId: Variant;
begin
  Result := FProdutoId;
end;

procedure TPanamahProdutoComposicaoItem.SetProdutoId(const AProdutoId: Variant);
begin
  FProdutoId := AProdutoId;
end;

procedure TPanamahProdutoComposicaoItem.FromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONobject do
  begin
    try
      FProdutoId := Field['produtoId'].Value;
    finally
      Free;
    end;
  end;
end;

function TPanamahProdutoComposicaoItem.ToJSON: string;
var
  JSON: TlkJSONobject;
begin
  JSON := TlkJSONobject.Create;
  with JSON do
  begin
    try
      Field['produtoId'].Value := FProdutoId;
      Result := string(TlkJSON.GenerateText(JSON));
    finally
      Free;
    end;
  end;
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
  Item.FromJSON(TlkJSON.GenerateText(Elem));
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

procedure TPanamahProdutoComposicaoItemList.FromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahProdutoComposicaoItemList.ToJSON: string;
var
  JSON: TlkJSONlist;
  I: Integer;
begin
  JSON := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSON.Add(TlkJSON.ParseText((FList[I] as IPanamahProdutoComposicaoItem).ToJSON));
  finally
    JSON.Free;
  end;
end;

{ TPanamahProdutoComposicao }

procedure TPanamahProdutoComposicao.FromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONobject do
  begin
    try
      if Field['itens'] is TlkJSONlist then
      begin
        FItens := TPanamahProdutoComposicaoItemList.Create;
        FItens.FromJSON(TlkJSON.GenerateText(Field['itens']));
      end;
      FQuantidade := Field['quantidade'].Value;
    finally
      Free;
    end;
  end;
end;

function TPanamahProdutoComposicao.ToJSON: string;
var
  JSON: TlkJSONobject;
begin
  JSON := TlkJSONobject.Create;
  with JSON do
  begin
    try
      if Assigned(FItens) then
      begin
        Field['itens'] := TlkJSON.ParseText(FItens.ToJSON);
      end;
      Field['quantidade'].Value := FQuantidade;
      Result := TlkJSON.GenerateText(JSON);
    finally
      Free;
    end;
  end;
end;

function TPanamahProdutoComposicao.GetItens: IPanamahProdutoComposicaoItemList;
begin
  Result := FItens;
end;

function TPanamahProdutoComposicao.GetQuantidade: Double;
begin
  Result := FQuantidade;
end;

procedure TPanamahProdutoComposicao.SetItens(AItens: IPanamahProdutoComposicaoItemList);
begin
  FItens := AItens;
end;

procedure TPanamahProdutoComposicao.SetQuantidade(AQuantidade: Double);
begin
  FQuantidade := AQuantidade;
end;

{ TPanamahProduto }

procedure TPanamahProduto.FromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONobject do
  begin
    try
      FId := Field['id'].Value;
      FDescricao := Field['descricao'].Value;
//      FFinalidade := VarToStr(Field['finalidade'].Value);
//      if Field['composicao'] is TlkJSONobject then
//      begin
//        FComposicao := TPanamahProdutoComposicao.Create;
//        FComposicao.FromJSON(TlkJSON.GenerateText(Field['itens']));
//      end;
    finally
      Free;
    end;
  end;
end;

function TPanamahProduto.ToJSON: string;
var
  JSON: TlkJSONobject;
begin
  JSON := TlkJSONobject.Create;
  with JSON do
  begin
    try
      Add('id', TlkJSONstring.Generate(FId));
      Add('descricao', TlkJSONstring.Generate(FDescricao));
//      FDescricao := Field['descricao'].Value;
//      FFinalidade := Field['finalidade'].Value;
//      if Assigned(FComposicao) then
//      begin
//        Field['composicao'] := TlkJSON.ParseText(FComposicao.ToJSON);
//      end;
      Result := TlkJSON.GenerateText(JSON);
    finally
      Free;
    end;
  end;
end;

function TPanamahProduto.GetComposicao: IPanamahProdutoComposicao;
begin
  Result := FComposicao;
end;

function TPanamahProduto.GetDescricao: string;
begin
  Result := FDescricao;
end;

function TPanamahProduto.GetFinalidade: Variant;
begin
  Result := FFinalidade;
end;

function TPanamahProduto.GetId: Variant;
begin
  Result := FId;
end;

procedure TPanamahProduto.SetComposicao(AComposicao: IPanamahProdutoComposicao);
begin
  FComposicao := AComposicao;
end;

procedure TPanamahProduto.SetDescricao(const ADescricao: string);
begin
  FDescricao := ADescricao;
end;

procedure TPanamahProduto.SetFinalidade(const AFinalidade: Variant);
begin
  FFinalidade := AFinalidade;
end;

procedure TPanamahProduto.SetId(const AId: Variant);
begin
  FId := AId;
end;

end.
