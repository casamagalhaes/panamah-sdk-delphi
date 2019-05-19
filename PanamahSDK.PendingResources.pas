unit PanamahSDK.PendingResources;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Client;

type

  IPanamahPendingResourcesList = interface
    ['{2F5E0741-402B-4AF7-80B9-C73C88CE4B1E}']
    procedure SetModels(AModels: IPanamahModelList);
    function GetModels: IPanamahModelList;
    property Models: IPanamahModelList read GetModels write SetModels;
  end;

  TPanamahPendingResourcesList = class(TInterfacedObject, IPanamahPendingResourcesList)
  private
    FModels: IPanamahModelList;
    function GetModels: IPanamahModelList;
    procedure SetModels(AModels: IPanamahModelList);
  public
    class function Obtain(AClient: IPanamahClient): IPanamahPendingResourcesList;
    property Models: IPanamahModelList read GetModels write SetModels;
  end;

implementation

uses PanamahSDK.Operation, uLkJSON;

{ TPanamahPendingResourcesList }

function TPanamahPendingResourcesList.GetModels: IPanamahModelList;
begin
  Result := FModels;
end;

procedure TPanamahPendingResourcesList.SetModels(AModels: IPanamahModelList);
begin
  FModels := AModels;
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
      Values.LineBreak := ',';
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
      Result := Values.Text;
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
      if JSONObject.Count > 0 then
      begin
        try
          for I := 0 to JSONObject.Count - 1 do
            AResult.Values[JSONObject.NameOf[I]] := ConcatWithJSON(
              AResult.Values[JSONObject.NameOf[I]],
              JSONObject.Field[JSONObject.NameOf[I]]
            );
          Result := Paginate(AStart + ACount, ACount, AResult);
        finally
          JSONObject.Free;
        end;
      end
      else
      begin
        Result := AResult;
      end;
    end;
  end;

  function SplitByComma(const AValue: string): TStrings;
  begin
    Result := TStringList.Create;
    Result.LineBreak := ',';
    Result.DelimitedText := AValue;
  end;

var
  PendingResources, Ids: TStrings;
  I: Integer;
  X: Integer;
begin
  PendingResources := Paginate();
  try
    if PendingResources.Count > 0 then
    begin
      Result := TPanamahPendingResourcesList.Create;
      Result.Models := TPanamahModelList.Create;
      for I := 0 to PendingResources.Count - 1 do
      begin
        Ids := SplitByComma(PendingResources.Values[PendingResources.Names[I]]);
        try
          for X := 0 to Ids.Count - 1 do
          begin
            TPanamahModelList(Result.Models).AddModel(
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
