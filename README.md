## Instalação

1. Clonar o repositório https://github.com/casamagalhaes/panamah-sdk-delphi
2. Adicionar os seguintes diretórios a library path
    ```cmd
    {CAMINHO_DO_REPOSITORIO}\panamah-sdk-delphi\Lib
    {CAMINHO_DO_REPOSITORIO}\panamah-sdk-delphi\Models
    {CAMINHO_DO_REPOSITORIO}\panamah-sdk-delphi
    ```

    **Importante**: Para versões do Delphi anteriores ao 2009, também é necessário incluir a seguinte path:
    ```cmd
    {CAMINHO_DO_REPOSITORIO}\panamah-sdk-delphi\Lib\synapse
    ```

3. Utilizar as units e compilar seu projeto

## Visão geral

[Leia mais aqui](https://github.com/casamagalhaes/panamah-sdk-javascript/wiki/Visão-geral)

## Exemplo de uso

```delphi
program ConsoleApp;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  PanamahSDK.Models.Produto,
  PanamahSDK.Models.Assinante,
  PanamahSDK.Types,
  PanamahSDK;

  //Preenchendo um modelo de assinante
  function CreateAssinante: IPanamahAssinante;
  begin
    Result := TPanamahAssinante.Create;
    Result.Id := '18475929000132';
    Result.Fantasia := 'Supermercado Exemplo';
    Result.Nome := 'Supermercado Exemplo Ltda';
    Result.Bairro := 'Rua Poebla';
    Result.Cidade := 'Caucaia';
    Result.Uf := 'CE';
    Result.Ativo := True;
  end;

  //Preenchendo um modelo de produtos
  function CreateProduto: IPanamahProduto;
  var
    Item: IPanamahProdutoComposicaoItem;
    Fornecedor: IPanamahProdutoFornecedor;
  begin
    Result := TPanamahProduto.Create;
    Result.Id := '123456';
    Result.Descricao := 'Produto de exemplo';

    Result.DataInclusao := Now;
    Result.TipoComposicao := '123';
    Result.Composicao := TPanamahProdutoComposicao.Create;
    Result.Composicao.Quantidade := 2;
    Result.SecaoId := '001';
    Result.Ativo := True;

    //Criando listas de modelos
    Result.Fornecedores := TPanamahProdutoFornecedorList.Create;
    with Result.Fornecedores do
    begin
      Fornecedor := TPanamahProdutoFornecedor.Create;
      Fornecedor.Id := '001';
      Add(Fornecedor);
    end;

    Result.Composicao.Itens := TPanamahProdutoComposicaoItemList.Create;
    with Result.Composicao.Itens do
    begin
      Item := TPanamahProdutoComposicaoItem.Create;
      Item.ProdutoId := '123';
      Add(Item);

      Item := TPanamahProdutoComposicaoItem.Create;
      Item.ProdutoId := '432';
      Add(Item);
    end;
  end;

type
  TEvents = class
    procedure OnBeforeSave(AModel: IPanamahModel; var AContinue: Boolean);
    procedure OnBeforeDelete(AModel: IPanamahModel; var AContinue: Boolean);
    procedure OnError(Error: Exception);
  end;

{ TEvents }

procedure TEvents.OnBeforeDelete(AModel: IPanamahModel; var AContinue: Boolean);
begin
  WriteLn('Before delete ', AModel.ModelName);
//  AContinue := False; //Esta linha cancelaria a deleção
end;

procedure TEvents.OnBeforeSave(AModel: IPanamahModel; var AContinue: Boolean);
begin
  WriteLn('Before save ', AModel.ModelName);
//  AContinue := False; //Esta linha cancelaria o salvamento
end;

procedure TEvents.OnError(Error: Exception);
begin
  WriteLn('Error caught: ', Error.Message);
end;

var
  Assinante: IPanamahAssinante;
  Produto: IPanamahProduto;
  Events: TEvents;

begin
  with TPanamahAdmin.GetInstance do
  begin
    //Inicializando API administrativa
    Init(GetEnvironmentVariable('PANAMAH_AUTHORIZATION_TOKEN'));

    try
      Assinante := GetAssinante('18475929000132'); //Verificando se o assinante existe
    except
      on E: EPanamahSDKNotFoundException do //Caso não exista
      begin
        Assinante := CreateAssinante; //Criando o assinante
        SaveAssinante(Assinante);
      end;
    end;
  end;

  Events := TEvents.Create;
  try
    with TPanamahStream.GetInstance do
    begin
      //Setando os hooks antes de inicialização
      OnBeforeSave := Events.OnBeforeSave;
      OnBeforeDelete := Events.OnBeforeDelete;
      OnError := Events.OnError;

      //Inicializando API de Streaming
      Init(
        GetEnvironmentVariable('PANAMAH_AUTHORIZATION_TOKEN'),
        GetEnvironmentVariable('PANAMAH_SECRET'),
        '18475929000132'
      );

      //Enviando e deletando um produto
      Produto := CreateProduto;
      try
        Save(Produto);
        Delete(Produto);
      except
        on E: EPanamahSDKValidationException do
        begin
          WriteLn(E.Message); //Um erro de validação seria tratado aqui
        end;
        on E: Exception do
          raise;
        end;
      end;

      Flush; //Sempre chamar antes de finalizar a aplicação
    end;
  finally
    Events.Free;
  end;
end.
```
