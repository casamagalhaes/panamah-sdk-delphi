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
  PanamahSDK.Models.Venda, PanamahSDK.Operation, Variants;

type

  IPanamahBatch = interface(IJSONSerializable)
    ['{97748D13-F5B3-48B8-AA21-19E769790589}']
    procedure SetCreatedAt(ACreatedAt: TDateTime);
    procedure SetPriority(APriority: Boolean);
    procedure SaveToFile(const AFilename: string);
    procedure Clear;
    procedure Reset;
    procedure Add(AOperation: IPanamahOperation); overload;
    procedure RemoveFromDirectory(const ADirectory: string);
    function GetSize: Integer;
    function GetCreatedAt: TDateTime;
    function GetPriority: Boolean;
    function Clone: IPanamahBatch;
    function SaveToDirectory(const ADirectory: string): string;
    function MoveToDirectory(const ASource, ADestiny: string): string;
    function GetCount: Integer;
    function GetHash: string;
    function GetAssinantes: TStrings;
    function GetItem(AIndex: Integer): IPanamahOperation;
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property Size: Integer read GetSize;
    property Priority: Boolean read GetPriority write SetPriority;
    property Count: Integer read GetCount;
    property Hash: string read GetHash;
    property Items[AIndex: Integer]: IPanamahOperation read GetItem;
    property Assinantes: TStrings read GetAssinantes;
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
    FOperationList: IPanamahOperationList;
    FCreatedAt: TDateTime;
    FPriority: Boolean;
    FAssinantes: TStrings;
    procedure SetCreatedAt(ACreatedAt: TDateTime);
    procedure SetPriority(APriority: Boolean);
    procedure SaveToFile(const AFilename: string);
    procedure Clear;
    procedure Reset;
    function GetSize: Integer;
    function GetCreatedAt: TDateTime;
    function GetPriority: Boolean;
    function Clone: IPanamahBatch;
    function GetItem(AIndex: Integer): IPanamahOperation;
    function GetAssinantes: TStrings;
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    function SaveToDirectory(const ADirectory: string): string;
    function MoveToDirectory(const ASource, ADestiny: string): string;
    function GetCount: Integer;
    function GetHash: string;
    class function FromJSON(const AJSON: string): IPanamahBatch;
    class function FromFile(const AFilename: string): IPanamahBatch;
    procedure Add(AOperation: IPanamahOperation); overload;
    procedure RemoveFromDirectory(const ADirectory: string);
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahOperation read GetItem;
  published
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
    property Size: Integer read GetSize;
    property Priority: Boolean read GetPriority write SetPriority;
    property Assinantes: TStrings read GetAssinantes;
    constructor Create; reintroduce;
  end;

  TPanamahBatchList = class(TInterfacedObject, IPanamahBatchList)
  private
    FList: TInterfaceList;
    function GetItem(AIndex: Integer): IPanamahBatch;
    procedure SetItem(AIndex: Integer; const Value: IPanamahBatch);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
    class function GetBatchesInDirectory(const ADirectory, AAssinanteId: string): TStrings; overload;
    class function GetBatchesInDirectory(const ADirectory: string): TStrings; overload;
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahBatchList;
    class function FromDirectory(const ADirectory: string): IPanamahBatchList;
    class function CountBatchesInDirectory(const ADirectory: string; const AssinanteId: Variant): Integer;
    constructor Create;
    procedure Add(const AItem: IPanamahBatch);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: IPanamahBatch read GetItem write SetItem; default;
  end;

  TPanamahBatchFilename = class
  private
    FCreatedAt: TDateTime;
    FPriority: Boolean;
  public
    property CreatedAt: TDateTime read FCreatedAt write FCreatedAt;
    property Priority: Boolean read FPriority write FPriority;
    class function FromFilename(const AFilename: string): TPanamahBatchFilename;
    function ToString: string; reintroduce;
  end;

implementation

{ TPanamahBatch }

uses
  PanamahSDK.Crypto;

procedure TPanamahBatch.Clear;
begin
  FOperationList.Clear;
end;

function TPanamahBatch.Clone: IPanamahBatch;
begin
  Result := TPanamahBatch.Create;
  Result.DeserializeFromJSON(SerializeToJSON);
end;

constructor TPanamahBatch.Create;
begin
  inherited;
  FCreatedAt := Now;
  FOperationList := TPanamahOperationList.Create;
  FAssinantes := TStringList.Create;
end;

procedure TPanamahBatch.DeserializeFromJSON(const AJSON: string);
var
  I: Integer;
  AssinanteId: Variant;
begin
  FOperationList.DeserializeFromJSON(AJSON);
  for I := 0 to FOperationList.Count - 1 do
  begin
    AssinanteId := FOperationList[I].AssinanteId;
    if (VarToStrDef(AssinanteId, EmptyStr) <> EmptyStr) and (FAssinantes.IndexOf(AssinanteId) = -1) then
      FAssinantes.Add(FOperationList[I].AssinanteId);
  end;
end;

destructor TPanamahBatch.Destroy;
begin
  FAssinantes.Free;
  inherited;
end;

function TPanamahBatch.SaveToDirectory(const ADirectory: string): string;
var
  BatchFilename: TPanamahBatchFilename;
begin
  BatchFilename := TPanamahBatchFilename.Create;
  try
    BatchFilename.CreatedAt := FCreatedAt;
    BatchFilename.Priority := FPriority;
    ForceDirectories(ADirectory);
    SaveToFile(Format('%s/%s.pbt', [ADirectory, BatchFilename.ToString]));
  finally
    BatchFilename.Free;
  end;
end;

procedure TPanamahBatch.SaveToFile(const AFilename: string);
var
  BatchFile : TextFile;
begin
  AssignFile(BatchFile, AFilename);
  try
    Rewrite(BatchFile);
    WriteLn(BatchFile, SerializeToJSON);
  finally
    CloseFile(BatchFile);
  end;
end;

function TPanamahBatch.SerializeToJSON: string;
begin
  Result := FOperationList.SerializeToJSON;
end;

procedure TPanamahBatch.SetCreatedAt(ACreatedAt: TDateTime);
begin
  FCreatedAt := ACreatedAt;
end;

procedure TPanamahBatch.SetPriority(APriority: Boolean);
begin
  FPriority := APriority;
end;

class function TPanamahBatch.FromFile(const AFilename: string): IPanamahBatch;
var
  BatchFilename: TPanamahBatchFilename;
  BatchFile: TStrings;
begin
  Result := TPanamahBatch.Create;
  BatchFilename := TPanamahBatchFilename.FromFilename(AFilename);
  try
    Result.CreatedAt := BatchFilename.CreatedAt;
    Result.Priority := BatchFilename.Priority;
    BatchFile := TStringList.Create;
    try
      BatchFile.LoadFromFile(AFilename);
      Result.DeserializeFromJSON(BatchFile.Text);
    finally
      BatchFile.Free;
    end;
  finally
    BatchFilename.Free;
  end;
end;

class function TPanamahBatch.FromJSON(const AJSON: string): IPanamahBatch;
begin
  Result := TPanamahBatch.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahBatch.GetAssinantes: TStrings;
begin
  Result := FAssinantes;
end;

function TPanamahBatch.GetCount: Integer;
begin
  Result := FOperationList.Count;
end;

function TPanamahBatch.GetCreatedAt: TDateTime;
begin
  Result := FCreatedAt;
end;

function TPanamahBatch.GetHash: string;
begin
  Result := MD5Hash(SerializeToJson);
end;

function TPanamahBatch.GetItem(AIndex: Integer): IPanamahOperation;
begin
  Result := FOperationList[AIndex];
end;

function TPanamahBatch.GetPriority: Boolean;
begin
  Result := FPriority;
end;

function TPanamahBatch.GetSize: Integer;
begin
  Result := Length(SerializeToJSON);
end;

function TPanamahBatch.MoveToDirectory(const ASource, ADestiny: string): string;
var
  BatchFilename: TPanamahBatchFilename;
  SourceFile, DestinyFile: string;
begin
  BatchFilename := TPanamahBatchFilename.Create;
  try
    BatchFilename.CreatedAt := FCreatedAt;
    BatchFilename.Priority := FPriority;
    ForceDirectories(ADestiny);
    SourceFile := Format('%s\%s.pbt', [ASource, BatchFilename.ToString]);
    DestinyFile := Format('%s\%s.pbt', [ADestiny, BatchFilename.ToString]);
    if FileExists(PChar(DestinyFile)) then
      DeleteFile(PWideChar(SourceFile))
    else
      MoveFile(PChar(SourceFile), PChar(DestinyFile));
    Result := DestinyFile;
  finally
    BatchFilename.Free;
  end;
end;

procedure TPanamahBatch.RemoveFromDirectory(const ADirectory: string);
var
  BatchFilename: TPanamahBatchFilename;
  FilenameString: string;
begin
  BatchFilename := TPanamahBatchFilename.Create;
  try
    BatchFilename.CreatedAt := FCreatedAt;
    BatchFilename.Priority := FPriority;
    FilenameString := Format('%s\%s.pbt', [ADirectory, BatchFilename.ToString]);
    try
      DeleteFile(PChar(FilenameString));
    except
    end;
  finally
    BatchFilename.Free;
  end;
end;

procedure TPanamahBatch.Reset;
begin
  Clear;
  FCreatedAt := Now;
  FPriority := False;
end;

procedure TPanamahBatch.Add(AOperation: IPanamahOperation);
begin
  if FOperationList.Exists(AOperation) then
    FOperationList.Remove(AOperation);
  FOperationList.Add(AOperation);
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

class function TPanamahBatchList.CountBatchesInDirectory(const ADirectory: string; const AssinanteId: Variant): Integer;
var
  Batches: TStrings;
begin
  Batches := GetBatchesInDirectory(ADirectory, AssinanteId);
  try
    Result := Batches.Count;
  finally
    Batches.Free;
  end;
end;

class function TPanamahBatchList.GetBatchesInDirectory(const ADirectory: string): TStrings;
begin
  Result := GetBatchesInDirectory(ADirectory, EmptyStr);
end;

function TPanamahBatchList.GetItem(AIndex: Integer): IPanamahBatch;
begin
  Result := FList.Items[AIndex] as IPanamahBatch;
end;

class function TPanamahBatchList.GetBatchesInDirectory(const ADirectory, AAssinanteId: string): TStrings;
var
  SearchRec: TSearchRec;
  BatchFilename: string;
  Batch: IPanamahBatch;
begin
  ForceDirectories(ADirectory);
  Result := TStringList.Create;
  TStringList(Result).Sorted := True;
  if DirectoryExists(ADirectory) then
    begin
    if FindFirst(Format('%s\*.pbt', [ADirectory]), faAnyFile, SearchRec) = 0 then
    begin
      repeat
      begin
        BatchFilename := Format('%s\%s', [ADirectory, SearchRec.Name]);
        if not SameText(AAssinanteId, EmptyStr) then
        begin
          Batch := TPanamahBatch.FromFile(BatchFilename);
          if (Batch.Assinantes.Count = 1) and SameText(Batch.Assinantes[0], AAssinanteId) then
          begin
            Result.Add(BatchFilename);
          end;
        end
        else
          Result.Add(BatchFilename);
      end
      until FindNext(SearchRec) <> 0;
    end;
  end
  else
    raise EPanamahSDKIOException.Create(Format('Diret�rio %s n�o existe.', [ADirectory]));
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
  FList.Lock;
  try
    JSONObject := TlkJSONlist.Create;
    try
      for I := 0 to FList.Count - 1 do
        JSONObject.Add(TlkJSON.ParseText((FList[I] as IPanamahBatch).SerializeToJSON));
      Result := TlkJSON.GenerateText(JSONObject);
    finally
      JSONObject.Free;
    end;
  finally
    FList.Unlock;
  end;
end;

{ TPanamahBatchFilename }

class function TPanamahBatchFilename.FromFilename(const AFilename: string): TPanamahBatchFilename;
var
  Words: TStrings;
  Offset: Integer;
begin
  Result := TPanamahBatchFilename.Create;
  Words := TStringList.Create;
  try
    Words.Delimiter := '_';
    Words.DelimitedText := ChangeFileExt(ExtractFilename(AFilename), EmptyStr);
    if Words.Count >= 8 then
      Result.Priority := SameText(Words[0], '0');
    Offset := 0;
    if Result.Priority then
      Offset := 1;
    if Words.Count >= 7 then
    begin
      Result.CreatedAt := ISO8601ToDateTime(Format('%s-%s-%sT%s:%s:%s.%s', [
        Words[Offset + 0],
        Words[Offset + 1],
        Words[Offset + 2],
        Words[Offset + 3],
        Words[Offset + 4],
        Words[Offset + 5],
        Words[Offset + 6]
      ]));
    end;
  finally
    Words.Free;
  end;
end;

function TPanamahBatchFilename.ToString: string;
begin
  Result := FormatDateTime('YYYY_MM_DD_HH_NN_SS_ZZZ', CreatedAt);
  if Priority then
    Result := Concat('0_', Result);
end;

end.
