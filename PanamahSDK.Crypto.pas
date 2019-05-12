unit PanamahSDK.Crypto;

interface

uses
  SysUtils, Windows;
//
//  function WideStringToUtf8(const AValue: WideString): UTF8String;
//  function PadWithZeros(const AValue: string; ASize: Integer): string;
//  function StringToBytes(const Value: string): TBytes;
//  function BytesToString(const Value: TBytes): string;
//  function UTF8StringToBytes(const Value: UTF8String): TBytes;
//  function BytesToUTF8String(const Value: TBytes): UTF8String;
  function MD5Hash(const AValue: string): string;
//  function AES256Encrypt(const AValue, AKey: string): string;
//  function AES256Decrypt(const AValue, AKey: string): string;
//  function SHA256Hash(const AValue: string): string;
//
implementation
//
uses
  MD5;
//uses
//  MD5, DCPcrypt2, DCPrijndael, DCPsha256, DCPbase64, uTPLb_CryptographicLibrary,
//  uTPLb_Codec, uTPLb_Constants;
//
//function StringToBytes(const Value: string): TBytes;
//begin
//  SetLength(Result, Length(Value)*SizeOf(WideChar));
//  if Length(Result) > 0 then
//    Move(Value[1], Result[0], Length(Result));
//end;
//
//function BytesToString(const Value: TBytes): string;
//begin
//  SetLength(Result, Length(Value) div SizeOf(WideChar));
//  if Length(Result) > 0 then
//    Move(Value[0], Result[1], Length(Value));
//end;
//
function MD5Hash(const AValue: string): string;
begin
  Result := MD5DigestToStr(MD5String(AValue));
end;
//
//function AES256Encrypt(const AValue, AKey: string): string;
//var
//  Codec: TCodec;
//  CryptographicLibrary: TCryptographicLibrary;
//  Encrypted: string;
//begin
//  Codec := TCodec.Create(nil);
//  CryptographicLibrary := TCryptographicLibrary.Create(nil);
//  try
//    Codec.CryptoLibrary  := CryptographicLibrary;
//    Codec.StreamCipherId := uTPLb_Constants.BlockCipher_ProgId;
//    Codec.BlockCipherId  := 'native.AES-256';
//    Codec.ChainModeId    := uTPLb_Constants.CBC_ProgId;
//    Codec.Password := AKey;
//    Codec.EncryptString(AValue, Encrypted, TEncoding.UTF8);
//    result := Encrypted;
//  finally
//    Codec.Free;
//    CryptographicLibrary.Free;
//  end;
//end;
//
//function AES256Decrypt(const AValue, AKey: string): string;
//var
//  Codec: TCodec;
//  CryptographicLibrary: TCryptographicLibrary;
//  Decrypted: string;
//begin
//  Codec := TCodec.Create(nil);
//  CryptographicLibrary := TCryptographicLibrary.Create(nil);
//  try
//    Codec.CryptoLibrary  := CryptographicLibrary;
//    Codec.StreamCipherId := uTPLb_Constants.BlockCipher_ProgId;
//    Codec.BlockCipherId  := 'native.AES-256';
//    Codec.ChainModeId    := uTPLb_Constants.CBC_ProgId;
//    Codec.Password := AKey;
//    Codec.DecryptString(Decrypted, AValue, TEncoding.UTF8);
//    result := Decrypted;
//  finally
//    Codec.Free;
//    CryptographicLibrary.Free;
//  end;
//end;
//
////
////function AES256Encrypt(const AValue, AKey: string): string;
////var
////  Cipher: TDCP_rijndael;
////  Data, Key: string;
//////  DataLength, Index, BlockSize, PadLength: Integer;
////begin
////  Key := AKey;
////  Data := Copy(AValue, 1, Length(AValue));
////
////  Cipher := TDCP_rijndael.Create(nil);
////  try
////    Cipher.Init(Key[1], 256, nil);
////    Cipher.CipherMode := cmCTR;
//////    DataLength := Length(Data);
//////    BlockSize := (Cipher.BlockSize div 8);
//////    PadLength := BlockSize - (DataLength mod BlockSize);
//////    for Index := 1 to PadLength do
//////      Data := Data + AnsiChar(Chr(PadLength));
////    Data := Cipher.EncryptString(Data);
////  finally
////    Cipher.Free;
////  end;
////  Data := DCPBase64.Base64EncodeStr(Data);
////  Result := Data;
////end;
//
////function AES256Encrypt(const AValue, AKey: string): string;
////var
////  Cipher: TDCP_rijndael;
////  Data, Output, Key: TBytes;
//////  DataLength, Index, BlockSize, PadLength: Integer;
////begin
////  Key := StringToBytes(AKey);
////  Data := StringToBytes(AValue);
////  Cipher := TDCP_rijndael.Create(nil);
////  try
////    Cipher.Init(Key[1], 256, nil);
//////    Cipher.CipherMode := cmCTR;
////    Cipher.EncryptCBC(Data[0], Data[0], Length(Data));
//////    DataLength := Length(Data);
//////    BlockSize := (Cipher.BlockSize div 8);
//////    PadLength := BlockSize - (DataLength mod BlockSize);
//////    for Index := 1 to PadLength do
//////      Data := Data + AnsiChar(Chr(PadLength));
//////    Data := Cipher.EncryptString(Data);
////  finally
////    Cipher.Free;
////  end;
////  Result := DCPbase64.Base64EncodeStr(BytesToString(Data));
////end;
//
////function AES256Decrypt(const AValue, AKey: string): string;
////var
////  Cipher : TDCP_rijndael;
////  Data, Output, Key: TBytes;
////begin
////  Data := StringToBytes(DCPbase64.Base64DecodeStr(AValue));
////  Key := StringToBytes(AKey);
////  Cipher := TDCP_rijndael.Create(nil);
////  try
////    Cipher.Init(Key[1], 256, nil);
////    Cipher.DecryptCBC(Data[0], Data[0], Length(Data));
////    Result := BytesToString(Data);
////  finally
////    Cipher.Burn;
////    Cipher.Free;
////  end;
////end;
//
//function SHA256Hash(const AValue: string): string;
//var
//  Hash: TDCP_sha256;
//  Digest: array[0..31] of byte;
//  I: Integer;
//begin
//  Hash:= TDCP_sha256.Create(nil);
//  try
//    Hash.Init;
//    Hash.UpdateStr(AValue);
//    Hash.Final(Digest);
//    Result:= '';
//    for I := 0 to 31 do
//      Result := Result + IntToHex(Digest[I], 2);
//    Result := LowerCase(Result);
//  finally
//    Hash.Free;
//  end;
//end;
//
//function PadWithZeros(const AValue: string; ASize: Integer): string;
//var
//  OriginalSize, I: Integer;
//begin
//  Result := AValue;
//  OriginalSize := Length(Result);
//  if ((OriginalSize mod ASize) <> 0) or (OriginalSize = 0) then
//  begin
//    SetLength(Result, ((OriginalSize div ASize) + 1) * ASize);
//    for i := OriginalSize + 1 to Length(Result) do
//      Result[i] := #0;
//  end;
//end;
//
//function WideStringToUtf8(const AValue: WideString): UTF8String;
//var
//  n: Integer;
//begin
//  n := WideCharToMultiByte(cp_UTF8, 0, PWideChar(AValue), Length(AValue), nil, 0, nil, nil);
//  Win32Check(n <> 0);
//  SetLength(Result, n);
//  n := WideCharToMultiByte(cp_UTF8, 0, PWideChar(AValue), Length(AValue), PAnsiChar(Result), n, nil, nil);
//  Win32Check(n = Length(Result));
//end;
//
//function UTF8StringToBytes(const Value: UTF8String): TBytes;
//begin
//  Result := StringToBytes(Value);
//end;
//
//function BytesToUTF8String(const Value: TBytes): UTF8String;
//begin
//  Result := BytesToString(Value);
//end;
//
end.
