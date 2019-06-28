unit PanamahSDK.ValidationUtils;

interface

uses
  SysUtils, Classes, Variants, PanamahSDK.Types;

  function ModelValueIsEmpty(AValue: Variant): Boolean;
  function ModelDateValueIsEmpty(AValue: Variant): Boolean;
  function ModelListIsEmpty(AList: IPanamahStringValueList): Boolean; overload;
  function ModelListIsEmpty(AList: IJSONSerializableList): Boolean; overload;
  function ModelStringListEmptyIndex(AList: IPanamahStringValueList): Integer;
  function ModelHasId(AModel: IPanamahModel): Boolean;

implementation

uses
  uLkJSON, PanamahSDK.JsonUtils;

function ModelValueIsEmpty(AValue: Variant): Boolean;
begin
  Result := VarIsNull(AValue) or
              VarIsEmpty(AValue) or
                SameText(VarToStrDef(AValue, EmptyStr), EmptyStr);
end;

function ModelDateValueIsEmpty(AValue: Variant): Boolean;
begin
  Result := ModelValueIsEmpty(AValue) or (VarToDateTime(AValue) = 0);
end;

function ModelListIsEmpty(AList: IPanamahStringValueList): Boolean;
begin
  Result := not Assigned(AList) or (AList.Count = 0);
end;

function ModelListIsEmpty(AList: IJSONSerializableList): Boolean; overload;
begin
  Result := not Assigned(AList) or (AList.Count = 0);
end;

function ModelStringListEmptyIndex(AList: IPanamahStringValueList): Integer;
var
  I: Integer;
begin
  Result := -1;
  if Assigned(AList) then
    for I := 0 to AList.Count - 1 do
      if ModelValueIsEmpty(AList[I]) then
      begin
        Result := I;
        Exit;
      end;
end;

function ModelHasId(AModel: IPanamahModel): Boolean;
var
  DataJSONObject: TlkJSONobject;
begin
  DataJSONObject := TlkJSON.ParseText(AModel.SerializeToJSON) as TlkJSONobject;
  try
    Result := not ModelValueIsEmpty(GetFieldValueAsString(DataJSONObject, 'id'));
  finally
    DataJSONObject.Free;
  end;
end;

end.
