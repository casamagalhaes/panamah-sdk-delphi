unit PanamahSDK.PendingResources;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Client;

type
  IPanamahPendingResources = interface
    ['{B9CFD6CC-3989-4CCC-A186-EFEDFE1EF619}']
    function GetModel(AIndex: Integer): IPanamahModel;
    function GetCount: Integer;
    function GetAssinanteId: string;
    procedure SetAssinanteId(const AAssinanteId: string);
    procedure Add(AModel: IPanamahModel);
    property Models[AIndex: Integer]: IPanamahModel read GetModel; default;
    property AssinanteId: string read GetAssinanteId write SetAssinanteId;
    property Count: Integer read GetCount;
  end;

  IPanamahPendingResourcesList = interface
    ['{B9CFD6CC-3989-4CCC-A186-EFEDFE1EF619}']
    function GetPendingResourcesByIndex(AIndex: Integer): IPanamahPendingResources;
    function GetPendingResourcesByAssinanteId(const AAssinanteId: string): IPanamahPendingResources;
    function GetCount: Integer;
    procedure Add(AModel: IPanamahPendingResources);
    property Values[const AAssinanteId: string]: IPanamahPendingResources read GetPendingResourcesByAssinanteId; default;
    property PendingResources[AIndex: Integer]: IPanamahPendingResources read GetPendingResourcesByIndex;
    property Count: Integer read GetCount;
  end;

  TPanamahPendingResources = class(TInterfacedObject, IPanamahPendingResources)
  private
    FModels: TInterfaceList;
    FAssinanteId: string;
    function GetModel(AIndex: Integer): IPanamahModel;
    function GetCount: Integer;
    function GetAssinanteId: string;
    procedure SetAssinanteId(const AAssinanteId: string);
  public
    constructor Create; reintroduce;
    procedure Add(AModel: IPanamahModel);
    destructor Destroy; override;
    property Models[AIndex: Integer]: IPanamahModel read GetModel; default;
    property Count: Integer read GetCount;
  end;

  TPanamahPendingResourcesList = class(TInterfacedObject, IPanamahPendingResourcesList)
  private
    FPendingResources: TInterfaceList;
    function GetPendingResourcesByAssinanteId(const AAssinanteId: string): IPanamahPendingResources;
    function GetPendingResourcesByIndex(AIndex: Integer): IPanamahPendingResources;
    function GetCount: Integer;
  public
    constructor Create; reintroduce;
    destructor Destroy; override;
    procedure Add(AModel: IPanamahPendingResources);
    class function Obtain(AClient: IPanamahClient): IPanamahPendingResourcesList;
    property Values[const AAssinanteId: string]: IPanamahPendingResources read GetPendingResourcesByAssinanteId; default;
    property PendingResources[AIndex: Integer]: IPanamahPendingResources read GetPendingResourcesByIndex;
  end;


implementation

uses PanamahSDK.Operation, uLkJSON, PanamahSDK.ModelUtils;

{ TPanamahPendingResourcesList }

procedure TPanamahPendingResources.Add(AModel: IPanamahModel);
begin
  FModels.Add(AModel);
end;

constructor TPanamahPendingResources.Create;
begin
  FModels := TInterfaceList.Create;
end;

destructor TPanamahPendingResources.Destroy;
begin
  FreeAndNil(FModels);
  inherited;
end;

function TPanamahPendingResources.GetAssinanteId: string;
begin
  Result := FAssinanteId;
end;

function TPanamahPendingResources.GetCount: Integer;
begin
  Result := FModels.Count;
end;

function TPanamahPendingResources.GetModel(AIndex: Integer): IPanamahModel;
begin
  Result := GetModelFromInterfaceList(FModels, AIndex);
end;

class function TPanamahPendingResourcesList.Obtain(AClient: IPanamahClient): IPanamahPendingResourcesList;

  function ConcatWithJSON(AItems: string; AField: TlkJSONbase): string;
  var
    I: Integer;
    anJSON: TlkJSONbase;
    Values: TStrings;
  begin
    Values := TStringList.Create;
    try
      Values.Delimiter := ',';
      Values.DelimitedText := AItems;
      with AField as TlkJSONlist do
      begin
        for I := 0 to Count - 1 do
        begin
          anJSON := Child[I];
          if Assigned(anJSON) then
            Values.Add(anJSON.Value);
        end;
      end;
      Result := Values.DelimitedText;
      if Result[Length(Result)] = ',' then
        Result := Copy(Result, 1, Length(Result) - 1);
    finally
      Values.Free;
    end;
  end;

  function Paginate(AStart: Integer = 0; ACount: Integer = 1000; AResult: TStrings = nil): TStrings;
  var
    Response: IPanamahResponse;
    JSONObject: TlkJSONobject;
    I, X: Integer;
    AssinanteId, ModelName: string;
  begin
    Result := nil;
    if not Assigned(AResult) then
      AResult := TStringList.Create;
    Response := AClient.Get(Format('/stream/pending-resources?start=%d&count=%d', [AStart, ACount]), nil, nil);
    if Response.Status = 200 then
    begin
      JSONObject := TlkJSON.ParseText(Response.Content) as TlkJSONobject;
      try
        if JSONObject.Count > 0 then
        begin
          for I := 0 to JSONObject.Count - 1 do
          begin
            AssinanteId := JSONObject.NameOf[I];
            with JSONObject.Field[AssinanteId] as TlkJSONobject do
            begin
              for X := 0 to Count - 1 do
              begin
                ModelName := NameOf[X];
                AResult.Values[AssinanteId + ';' + ModelName] := ConcatWithJSON(
                  AResult.Values[AssinanteId + ';' + ModelName],
                  Field[ModelName]
                );
              end;
            end;
          end;
          Result := Paginate(AStart + ACount, ACount, AResult);
        end
        else
        begin
          Result := AResult;
        end;
      finally
        JSONObject.Free;
      end;
    end;
  end;

  function SplitByDelimiter(const AValue: string; ADelimiter: Char): TStrings;
  begin
    Result := TStringList.Create;
    Result.Delimiter := ADelimiter;
    Result.DelimitedText := AValue;
  end;

var
  RawPendingResources, Ids, Keys: TStrings;
  AssinanteId, ModelName, LastAssinanteId: string;
  Item: IPanamahPendingResources;
  I, X: Integer;
begin
  RawPendingResources := Paginate;
  try
    if RawPendingResources.Count > 0 then
    begin
      Result := TPanamahPendingResourcesList.Create;
      for I := 0 to RawPendingResources.Count - 1 do
      begin
        Keys := SplitByDelimiter(RawPendingResources.Names[I], ';');
        try
          AssinanteId := Keys[0];
          ModelName := Keys[1];

          if AssinanteId <> LastAssinanteId then
          begin
            Item := TPanamahPendingResources.Create;
            Item.AssinanteId := AssinanteId;
            Result.Add(Item);
          end;
          LastAssinanteId := AssinanteId;

          Ids := SplitByDelimiter(RawPendingResources.Values[RawPendingResources.Names[I]], ',');
          try
            for X := 0 to Ids.Count - 1 do
              Item.Add(ParseJSONOfModelByDataType(ModelName, Format('{"id":"%s"}', [Ids[X]])));
          finally
            Ids.Free;
          end;
        finally
          Keys.Free;
        end;
      end;
    end;
  finally
    RawPendingResources.Free;
  end;
end;

procedure TPanamahPendingResources.SetAssinanteId(const AAssinanteId: string);
begin
  FAssinanteId := AAssinanteId;
end;

{ TPanamahPendingResourcesList }

procedure TPanamahPendingResourcesList.Add(AModel: IPanamahPendingResources);
begin
  FPendingResources.Add(AModel);
end;

constructor TPanamahPendingResourcesList.Create;
begin
  FPendingResources := TInterfaceList.Create;
end;

destructor TPanamahPendingResourcesList.Destroy;
begin
  FreeAndNil(FPendingResources);
  inherited;
end;

function TPanamahPendingResourcesList.GetCount: Integer;
begin
  Result := FPendingResources.Count;
end;

function TPanamahPendingResourcesList.GetPendingResourcesByAssinanteId(
  const AAssinanteId: string): IPanamahPendingResources;
var
  I: Integer;
  PendingResources: IPanamahPendingResources;
begin
  Result := nil;
  for I := 0 to FPendingResources.Count - 1 do
  begin
    PendingResources := GetPendingResourcesByIndex(I);
    if PendingResources.AssinanteId = AAssinanteId then
    begin
      Result := PendingResources;
      Exit;
    end;
  end;
end;

function TPanamahPendingResourcesList.GetPendingResourcesByIndex(AIndex: Integer): IPanamahPendingResources;
begin
  Result := FPendingResources[AIndex] as IPanamahPendingResources;
end;

end.
