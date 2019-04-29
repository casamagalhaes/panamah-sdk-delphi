unit PanamahSDK.Enums;

interface

uses
  SysUtils, Classes;

type

  EnumException = class(Exception);

  TConverterStrToEnum = function(const AValue: string): Integer;
  TConverterEnumToStr = function(const AValue: Integer): string;

  TEnumConverters = class(TStringList)
  private
    const
      STR_TO_ENUM = '_StrToEnum';
      ENUM_TO_STR = '_EnumToStr';
  public
    procedure Register(const AEnumName: string; AConverterStrToEnum: TConverterStrToEnum; AConverterEnumToStr: TConverterEnumToStr = nil);
    function Execute(const AEnumName, AValue: string): Integer; overload;
    function Execute(const AEnumName: string; AValue: Integer): string; overload;
    function IndexOfName(const Name: string): Integer; override;
  end;

var
  EnumConverters: TEnumConverters;

type

  TTipoEventoCaixa = (tecABERTURA, tecFECHAMENTO, tecENTRADA_OPERADOR, tecSAIDA_OPERADOR);

implementation

  function Converter_TipoEventoCaixa_StrToEnum(const AValue: string): Integer;
  begin
    if SameText(AValue, 'ABERTURA') then Result := Integer(tecABERTURA) else
    if SameText(AValue, 'FECHAMENTO') then Result := Integer(tecFECHAMENTO) else
    if SameText(AValue, 'ENTRADA_OPERADOR') then Result := Integer(tecENTRADA_OPERADOR) else
    if SameText(AValue, 'SAIDA_OPERADOR') then Result := Integer(tecSAIDA_OPERADOR) else
    raise EnumException.CreateFmt('Valor %s incorreto para TipoEventoCaixa.', [AValue]);
  end;

  function Converter_TipoEventoCaixa_EnumToStr(const AValue: Integer): string; overload;
  begin
    if Integer(tecABERTURA) = AValue then Result := 'ABERTURA' else
    if Integer(tecFECHAMENTO) = AValue then Result := 'FECHAMENTO' else
    if Integer(tecENTRADA_OPERADOR) = AValue then Result := 'ENTRADA_OPERADOR' else
    if Integer(tecSAIDA_OPERADOR) = AValue then Result := 'SAIDA_OPERADOR' else
    raise EnumException.CreateFmt('Valor %d incorreto para TipoEventoCaixa.', [AValue]);
  end;

  { TEnumConversors }

  function TEnumConverters.Execute(const AEnumName, AValue: string): Integer;
  var
    Converter: TConverterStrToEnum;
  begin
    Converter := TConverterStrToEnum(StrToInt(Self.Values[AEnumName + STR_TO_ENUM]));
    Result := Converter(AValue);
  end;

  function TEnumConverters.Execute(const AEnumName: string; AValue: Integer): string;
  var
    Converter: TConverterEnumToStr;
  begin
    Converter := TConverterEnumToStr(StrToInt(Self.Values[AEnumName + ENUM_TO_STR]));
    Result := Converter(AValue);
  end;

  function TEnumConverters.IndexOfName(const Name: string): Integer;
  begin
    Result := inherited IndexOfName(Name);
    if Result = -1 then
      Result := inherited IndexOfName(Name + STR_TO_ENUM);
    if Result = -1 then
      Result := inherited IndexOfName(Name + ENUM_TO_STR);
  end;

  procedure TEnumConverters.Register(const AEnumName: string;
    AConverterStrToEnum: TConverterStrToEnum; AConverterEnumToStr: TConverterEnumToStr);
  begin
    Self.Values[AEnumName + STR_TO_ENUM] := IntToStr(Integer(@AConverterStrToEnum));
    Self.Values[AEnumName + ENUM_TO_STR] := IntToStr(Integer(@AConverterEnumToStr));
  end;

initialization
  EnumConverters := TEnumConverters.Create;
  EnumConverters.Register('TipoEventoCaixa', @Converter_TipoEventoCaixa_StrToEnum, @Converter_TipoEventoCaixa_EnumToStr);

finalization
  FreeAndNil(EnumConverters);

end.
