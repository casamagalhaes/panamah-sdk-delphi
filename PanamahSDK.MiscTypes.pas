{$M+}
unit PanamahSDK.MiscTypes;

interface

uses
  Classes, SysUtils, PanamahSDK.Types, PanamahSDK.Models.Loja, PanamahSDK.Enums, Variants, uLkJSON;

type

  IPanamahKeyResponse = interface(IJSONSerializable)
    ['{20D1BDAA-93B3-4428-833A-62C438EE8C74}']
    function GetChave: string;
    procedure SetChave(const AChave: string);
    property Chave: string read GetChave write SetChave;
  end;

  TPanamahKeyResponse = class(TInterfacedObject, IPanamahKeyResponse)
  private
    FChave: string;
    function GetChave: string;
    procedure SetChave(const AChave: string);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahKeyResponse;
    property Chave: string read GetChave write SetChave;
  end;

implementation

uses
  PanamahSDK.JsonUtils, PanamahSDK.ValidationUtils;

{ TPanamahKeyResponse }

class function TPanamahKeyResponse.FromJSON(const AJSON: string): IPanamahKeyResponse;
begin
  Result := TPanamahKeyResponse.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahKeyResponse.GetChave: string;
begin
  Result := FChave;
end;

procedure TPanamahKeyResponse.SetChave(const AChave: string);
begin
  FChave := AChave;
end;

procedure TPanamahKeyResponse.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FChave := GetFieldValueAsString(JSONObject, 'chave');
  finally
    JSONObject.Free;
  end;
end;

function TPanamahKeyResponse.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'chave', FChave);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

end.
