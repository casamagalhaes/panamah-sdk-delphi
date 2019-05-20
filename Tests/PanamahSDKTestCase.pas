unit PanamahSDKTestCase;

interface

uses
  Math, SysUtils, Classes, TestFramework, IOUtils, Windows, Messages, DateUtils, SyncObjs;

type

  TPanamahTestCase = class(TTestCase)
  public
    function GetTestVariable(const AVariable: string): string;
  end;

implementation

{ TPanamahTestCase }

function TPanamahTestCase.GetTestVariable(const AVariable: string): string;
var
  Variables: TStrings;
  VariableFile: string;
begin
  Result := GetEnvironmentVariable(AVariable);
  VariableFile := GetCurrentDir + '\test.env';
  if FileExists(VariableFile) then
  begin
    Variables := TStringList.Create;
    try
      Variables.NameValueSeparator := ':';
      Variables.LoadFromFile(VariableFile);
      Result := Variables.Values[AVariable];
    finally
      Variables.Free;
    end;
  end;
end;

end.
