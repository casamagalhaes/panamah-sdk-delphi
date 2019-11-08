unit PanamahSDKTests.JSON;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, PanamahSDK.Batch;

type

  TTestJSONTestCase = class(TTestCase)
  private
    function GetFixturePath(const AFilename: string): string;
  published
    procedure TestDeserializeCorruptedBatch;
  end;

implementation

{ TPanamahNFeDeserializerTestCase }

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

initialization
  RegisterTest(TTestJSONTestCase.Suite);

end.
