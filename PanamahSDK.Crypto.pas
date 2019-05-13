unit PanamahSDK.Crypto;

interface

uses
  Classes, SysUtils, Windows;

  function MD5Hash(const AValue: string): string;
  function SHA1Base64(const AValue: string): string;

implementation

uses
  MD5{$IFDEF UNICODE}, IdHash, IdHashSHA, IdGlobal, IdCoderMIME{$ELSE}, DCPsha1, EncdDecd{$ENDIF};

function MD5Hash(const AValue: string): string;
begin
  Result := MD5DigestToStr(MD5String(AValue));
end;

{$IFDEF UNICODE}
function SHA1Base64(const AValue: string): string;
var
  Hash: TIdBytes;
  SHA1: TIdHashSHA1;
begin
  SHA1 := TIdHashSHA1.Create;
  try
    Hash := SHA1.HashBytes(ToBytes(AValue));
    Result := TIdEncoderMIME.EncodeBytes(Hash);
  finally
    SHA1.Free;
  end;
end;
{$ELSE}
function SHA1Base64(const AValue: string): string;
var
  Hash: TDCP_sha1;
begin
  Hash := TDCP_sha1.Create(nil);
  try
    Hash.Init;
    Hash.UpdateStr(AValue);
    SetLength(Result, Hash.GetHashSize div 8);
    Hash.Final(Result[1]);
    Result := EncodeString(Result);
  finally
    Hash.Free;
  end;
end;  
{$ENDIF}

end.
