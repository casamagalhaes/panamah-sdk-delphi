unit PanamahSDK.JsonUtils;

interface

uses
  Classes, DateUtils, SysUtils, Variants, PanamahSDK.Types, uLkJSON;

  function GetFieldValue(AJSONObject: TlkJSONbase; const AName: string; const ADefault: Variant): Variant; overload;
  function GetFieldValue(AJSONObject: TlkJSONbase; const AName: string): Variant; overload;
  function GetFieldValueAsString(AJSONObject: TlkJSONbase; const AName, ADefault: string): string; overload;
  function GetFieldValueAsString(AJSONObject: TlkJSONbase; const AName: string): string; overload;
  function GetFieldValueAsInteger(AJSONObject: TlkJSONbase; const AName: string; ADefault: Integer): Integer; overload;
  function GetFieldValueAsInteger(AJSONObject: TlkJSONbase; const AName: string): Integer; overload;
  function GetFieldValueAsBoolean(AJSONObject: TlkJSONbase; const AName: string; ADefault: Boolean): Boolean; overload;
  function GetFieldValueAsBoolean(AJSONObject: TlkJSONbase; const AName: string): Boolean; overload;
  function GetFieldValueAsDouble(AJSONObject: TlkJSONbase; const AName: string; ADefault: Double): Double; overload;
  function GetFieldValueAsDouble(AJSONObject: TlkJSONbase; const AName: string): Double; overload;
  function GetFieldValueAsDateTime(AJSONObject: TlkJSONbase; const AName: string; ADefault: TDateTime): Double; overload;
  function GetFieldValueAsDateTime(AJSONObject: TlkJSONbase; const AName: string): TDateTime; overload;
  procedure SetFieldValue(AJSONObject: TlkJSONobject; const AName: string; AValue: Variant); overload;
  procedure SetFieldValue(AJSONObject: TlkJSONobject; const AName: string; AValue: IJSONSerializable); overload;

implementation

function GetFieldValue(AJSONObject: TlkJSONbase; const AName: string; const ADefault: Variant): Variant; overload;
begin
  Result := ADefault;
  if AJSONObject.Field[AName] <> nil then
    Result := AJSONObject.Field[AName].Value;
end;

function GetFieldValue(AJSONObject: TlkJSONbase; const AName: string): Variant; overload;
begin
  Result := GetFieldValue(AJSONObject, AName, Unassigned);
end;

function GetFieldValueAsString(AJSONObject: TlkJSONbase; const AName, ADefault: string): string; overload;
var
  FieldValue: Variant;
begin
  FieldValue := GetFieldValue(AJSONObject, AName);
  if VarIsNull(FieldValue) then
    Result := EmptyStr
  else
  if FieldValue = Unassigned then
    Result := ADefault
  else
    Result := VarToStr(FieldValue);
end;

function GetFieldValueAsString(AJSONObject: TlkJSONbase; const AName: string): string; overload;
begin
  Result := GetFieldValueAsString(AJSONObject, AName, EmptyStr);
end;

function GetFieldValueAsInteger(AJSONObject: TlkJSONbase; const AName: string; ADefault: Integer): Integer; overload;
begin
  Result := GetFieldValue(AJSONObject, AName);
  if Result = Unassigned then
    Result := ADefault
  else
    Result := StrToIntDef(VarToStr(Result), ADefault);
end;

function GetFieldValueAsInteger(AJSONObject: TlkJSONbase; const AName: string): Integer; overload;
begin
  Result := GetFieldValueAsInteger(AJSONObject, AName, 0);
end;

function GetFieldValueAsBoolean(AJSONObject: TlkJSONbase; const AName: string; ADefault: Boolean): Boolean; overload;
begin
  Result := GetFieldValue(AJSONObject, AName);
  if Result = Unassigned then
    Result := ADefault
  else
    Result := StrToBoolDef(VarToStr(Result), ADefault);
end;

function GetFieldValueAsBoolean(AJSONObject: TlkJSONbase; const AName: string): Boolean; overload;
begin
  Result := GetFieldValueAsBoolean(AJSONObject, AName, False);
end;

function GetFieldValueAsDouble(AJSONObject: TlkJSONbase; const AName: string; ADefault: Double): Double; overload;
begin
  Result := GetFieldValue(AJSONObject, AName);
  if Result = Unassigned then
    Result := ADefault
  else
    Result := StrToFloatDef(VarToStr(Result), ADefault);
end;

function GetFieldValueAsDouble(AJSONObject: TlkJSONbase; const AName: string): Double; overload;
begin
  Result := GetFieldValueAsDouble(AJSONObject, AName, 0);
end;

function GetFieldValueAsDateTime(AJSONObject: TlkJSONbase; const AName: string; ADefault: TDateTime): Double; overload;
var
  FieldValue: Variant;
begin
  FieldValue := GetFieldValue(AJSONObject, AName);
  if FieldValue = Unassigned then
    Result := ADefault
  else
  begin
    case VarType(FieldValue) of
      varDate: Result := VarToDateTime(FieldValue);
      varDouble: Result := FieldValue;
      else
        Result := ISO8601ToDateTime(FieldValue);
    end;
  end;
end;

function GetFieldValueAsDateTime(AJSONObject: TlkJSONbase; const AName: string): TDateTime; overload;
begin
  Result := GetFieldValueAsDateTime(AJSONObject, AName, 0);
end;

procedure SetFieldValue(AJSONObject: TlkJSONobject; const AName: string; AValue: Variant); overload;
begin
  case varType(AValue) of
    varSmallint, varInteger, varInt64, varDouble, varCurrency, varShortInt, varWord, varLongWord:
      AJSONObject.Add(AName, TlkJSONnumber.Generate(AValue));
    varDate:
      if AValue <> Unassigned then
        AJSONObject.Add(AName, TlkJSONstring.Generate(DateTimeToISO8601(VarToDateTime(AValue))));
    varString, {$IFDEF VER130}varUString,{$ENDIF} varOleStr, varStrArg:
      if AValue <> Unassigned then
        AJSONObject.Add(AName, TlkJSONstring.Generate(UpperCase(VarToStr(AValue))));
    varBoolean:
      AJSONObject.Add(AName, TlkJSONboolean.Generate(AValue <> 0));
    varNull:
      AJSONObject.Add(AName, TlkJSONnull.Create);
    else
      if AValue <> Unassigned then
         AJSONObject.Add(AName, TlkJSONstring.Generate(UpperCase(VarToStr(AValue))));
  end;
end;

procedure SetFieldValue(AJSONObject: TlkJSONobject; const AName: string; AValue: IJSONSerializable); overload;
begin
  if AValue <> nil then
    AJSONObject.Add(AName, TlkJSON.ParseText(AValue.SerializeToJSON));
end;

end.
