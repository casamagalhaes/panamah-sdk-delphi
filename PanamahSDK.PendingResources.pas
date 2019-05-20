unit PanamahSDK.PendingResources;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Client;

type
  IPanamahPendingResourcesList = interface
    ['{B9CFD6CC-3989-4CCC-A186-EFEDFE1EF619}']
    function GetModel(AIndex: Integer): IPanamahModel;
    function GetCount: Integer;
    procedure Add(AModel: IPanamahModel);
    property Models[AIndex: Integer]: IPanamahModel read GetModel; default;
    property Count: Integer read GetCount;
  end;

  TPanamahPendingResourcesList = class(TInterfacedObject, IPanamahPendingResourcesList)
  private
    FModels: TInterfaceList;
    function GetModel(AIndex: Integer): IPanamahModel;
    function GetCount: Integer;
  public
    class function Obtain(AClient: IPanamahClient): IPanamahPendingResourcesList;
    constructor Create; reintroduce;
    procedure Add(AModel: IPanamahModel);
    destructor Destroy; override;
    property Models[AIndex: Integer]: IPanamahModel read GetModel; default;
    property Count: Integer read GetCount;
  end;

implementation

uses PanamahSDK.Operation, uLkJSON, PanamahSDK.ModelUtils;

{ TPanamahPendingResourcesList }

procedure TPanamahPendingResourcesList.Add(AModel: IPanamahModel);
begin
  FModels.Add(AModel);
end;

constructor TPanamahPendingResourcesList.Create;
begin
  FModels := TInterfaceList.Create;
end;

destructor TPanamahPendingResourcesList.Destroy;
begin
  FreeAndNil(FModels);
  inherited;
end;

function TPanamahPendingResourcesList.GetCount: Integer;
begin
  Result := FModels.Count;
end;

function TPanamahPendingResourcesList.GetModel(AIndex: Integer): IPanamahModel;
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
    I: Integer;
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
            AResult.Values[JSONObject.NameOf[I]] := ConcatWithJSON(
              AResult.Values[JSONObject.NameOf[I]],
              JSONObject.Field[JSONObject.NameOf[I]]
            );
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

  function SplitByComma(const AValue: string): TStrings;
  begin
    Result := TStringList.Create;
    Result.Delimiter := ',';
    Result.DelimitedText := AValue;
  end;

var
  PendingResources, Ids: TStrings;
  I: Integer;
  X: Integer;
begin
  PendingResources := Paginate;
  try
    if PendingResources.Count > 0 then
    begin
      Result := TPanamahPendingResourcesList.Create;
      for I := 0 to PendingResources.Count - 1 do
      begin
        Ids := SplitByComma(PendingResources.Values[PendingResources.Names[I]]);
        try
          for X := 0 to Ids.Count - 1 do
          begin
            Result.Add(
              ParseJSONOfModelByDataType(PendingResources.Names[I], Format('{"id":"%s"}', [Ids[X]]))
            );
          end;
        finally
          Ids.Free;
        end;
      end;
    end;
  finally
    PendingResources.Free;
  end;
end;

end.
