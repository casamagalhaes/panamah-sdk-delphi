unit PanamahSDKTests.JSON;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, PanamahSDK.Batch;

type

  TTestJSONTestCase = class(TTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
    procedure RecreateDir(const ADirectory: string);
  published
    procedure TestDeserializeCorruptedBatch;
    procedure TestMoveBatchReplace;
    procedure TestMoveBatch;
  end;

implementation

{ TPanamahNFeDeserializerTestCase }

procedure TTestJSONTestCase.RecreateDir(const ADirectory: string);
begin
  if TDirectory.Exists(ADirectory) then
    TDirectory.Delete(ADirectory, True);
  TDirectory.CreateDirectory(ADirectory);
end;

function TTestJSONTestCase.GetFixturePath(
  const AFilename: string): string;
begin
  Result := Concat(GetCurrentDir, '\JSON\Fixtures\', AFilename);
end;

procedure TTestJSONTestCase.TestDeserializeCorruptedBatch;
var
  Batch: TPanamahBatch;
begin
  Batch := TPanamahBatch.Create;
  try
    Batch.DeserializeFromJSON(TFile.ReadAllText(GetFixturePath('2019_11_08_12_23_17_337.pbt')));
    Assert(Batch.GetCount = 0);
  finally
    Batch.Free;
  end;
end;

procedure TTestJSONTestCase.TestMoveBatch;
var
  Batch: IPanamahBatch;
begin
  Batch := TPanamahBatch.FromFile(GetFixturePath('2019_11_08_12_23_18_337.pbt'));
  RecreateDir(GetFixturePath('source'));
  RecreateDir(GetFixturePath('target'));
  TFile.Copy(GetFixturePath('2019_11_08_12_23_18_337.pbt'), GetFixturePath('source\2019_11_08_12_23_18_337.pbt'));
  Batch.MoveToDirectory(GetFixturePath('source'), GetFixturePath('target'));
  Assert(not FileExists(GetFixturePath('source\2019_11_08_12_23_18_337.pbt')));
  Assert(FileExists(GetFixturePath('target\2019_11_08_12_23_18_337.pbt')));
end;

procedure TTestJSONTestCase.TestMoveBatchReplace;
var
  Batch: IPanamahBatch;
begin
  Batch := TPanamahBatch.FromFile(GetFixturePath('2019_11_08_12_23_18_337.pbt'));
  RecreateDir(GetFixturePath('source'));
  RecreateDir(GetFixturePath('target'));
  TFile.Copy(GetFixturePath('2019_11_08_12_23_18_337.pbt'), GetFixturePath('source\2019_11_08_12_23_18_337.pbt'));
  TFile.Copy(GetFixturePath('2019_11_08_12_23_18_337.pbt'), GetFixturePath('target\2019_11_08_12_23_18_337.pbt'));
  Batch.MoveToDirectory(GetFixturePath('source'), GetFixturePath('target'));
  Assert(not FileExists(GetFixturePath('source\2019_11_08_12_23_18_337.pbt')));
  Assert(FileExists(GetFixturePath('target\2019_11_08_12_23_18_337.pbt')));
end;

initialization
  RegisterTest(TTestJSONTestCase.Suite);

end.
