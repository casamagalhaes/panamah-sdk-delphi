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
  PendingResources: IPanamahPendingResourcesList;
  I: Integer;
begin
  with TPanamahStream.GetInstance do
  begin
    OnError := Self.OnError;
    Init(
      GetTestVariable('AUTHORIZATION_TOKEN'),
      GetTestVariable('SECRET'),
      GetTestVariable('ASSINANTE_ID')
    );
    PendingResources := GetPendingResources;
    Assert(PendingResources.Count > 0);
    for I := 0 to PendingResources.Count - 1 do
      Assert(Pos('"id"', PendingResources[I].SerializeToJSON) > 0);
  end;
end;

initialization
  RegisterTest(TPendingResourcesTestCase.Suite);

end.