unit PanamahSDKTests.PendingResources;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, Windows, Messages, DateUtils, SyncObjs, PanamahSDKTestCase,
  PanamahSDK, PanamahSDK.PendingResources;

type

  TPendingResourcesTestCase = class(TPanamahTestCase)
  private
    procedure OnError(Error: Exception);
  published
    procedure TestGettingPendingResources;
  end;

implementation

{ TPendingResourcesTestCase }

procedure TPendingResourcesTestCase.OnError(Error: Exception);
begin
  Assert(False, Error.Message);
end;

procedure TPendingResourcesTestCase.TestGettingPendingResources;
var
  Result: IPanamahPendingResourcesList;
  Item: IPanamahPendingResources;
  I, X: Integer;
begin
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    Result := GetPendingResources;
    Assert(Result.Count > 0);
    for I := 0 to Result.Count - 1 do
    begin
      Item := Result.PendingResources[I];
      for X := 0 to Item.Count - 1 do
      begin
        Assert(Pos('"id"', Item[I].SerializeToJSON) > 0);
      end;
    end;
  end;
end;

initialization
  RegisterTest(TPendingResourcesTestCase.Suite);

end.