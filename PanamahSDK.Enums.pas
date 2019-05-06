unit PanamahSDK.Enums;

interface

uses
  SysUtils, Classes, PanamahSDK.Types, uLkJSON;

type

  EnumException = class(Exception);

  TConverterStrToEnum = function(const AValue: string): Integer;
  TConverterEnumToStr = function(const AValue: Integer): string;

  TEnumConverters = class(TStringList)
  public
    procedure Register(const AEnumName: string; AConverterStrToEnum: TConverterStrToEnum; AConverterEnumToStr: TConverterEnumToStr = nil);
    function Execute(const AEnumName, AValue: string): Integer; overload;
    function Execute(const AEnumName: string; AValue: Integer): string; overload;
    function IndexOfName(const Name: string): Integer; override;
  end;

const
  STR_TO_ENUM = '_StrToEnum';
  ENUM_TO_STR = '_EnumToStr';

var
  EnumConverters: TEnumConverters;

type
  
  TPanamahSoftwareAtivo = (saMILENIO, saSYSPDV, saVAREJOFACIL, saSYSPDVWEB, saEASYASSIST, saSYSPDV_APP, saCOLETOR);
  TPanamahSoftwareContratoManutencao = (scmMILENIO, scmSYSPDV, scmVAREJOFACIL, scmSYSPDVWEB, scmEASYASSIST, scmSYSPDV_APP, scmCOLETOR);
  TPanamahEventoCaixaTipo = (ectABERTURA, ectFECHAMENTO, ectENTRADA_OPERADOR, ectSAIDA_OPERADOR);
  
  IPanamahSoftwareAtivoList = interface(IJSONSerializable)
    ['{D3436581-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): TPanamahSoftwareAtivo;
    procedure SetItem(AIndex: Integer; const Value: TPanamahSoftwareAtivo);
    procedure Add(const AItem: TPanamahSoftwareAtivo);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: TPanamahSoftwareAtivo read GetItem write SetItem; default;
  end;
  
  IPanamahSoftwareContratoManutencaoList = interface(IJSONSerializable)
    ['{D3436582-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): TPanamahSoftwareContratoManutencao;
    procedure SetItem(AIndex: Integer; const Value: TPanamahSoftwareContratoManutencao);
    procedure Add(const AItem: TPanamahSoftwareContratoManutencao);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: TPanamahSoftwareContratoManutencao read GetItem write SetItem; default;
  end;
  
  IPanamahEventoCaixaTipoList = interface(IJSONSerializable)
    ['{D345FD91-7043-11E9-B47F-05333FE0F816}']
    function GetItem(AIndex: Integer): TPanamahEventoCaixaTipo;
    procedure SetItem(AIndex: Integer; const Value: TPanamahEventoCaixaTipo);
    procedure Add(const AItem: TPanamahEventoCaixaTipo);
    procedure Clear;
    function Count: Integer;
    property Items[AIndex: Integer]: TPanamahEventoCaixaTipo read GetItem write SetItem; default;
  end;
  
  TPanamahSoftwareAtivoList = class(TInterfacedObject, IPanamahSoftwareAtivoList)
  private
    FList: TStrings;
    function GetItem(AIndex: Integer): TPanamahSoftwareAtivo;
    procedure SetItem(AIndex: Integer; const Value: TPanamahSoftwareAtivo);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSoftwareAtivoList;
    constructor Create;
    procedure Add(const AItem: TPanamahSoftwareAtivo);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: TPanamahSoftwareAtivo read GetItem write SetItem; default;
  end;
  
  TPanamahSoftwareContratoManutencaoList = class(TInterfacedObject, IPanamahSoftwareContratoManutencaoList)
  private
    FList: TStrings;
    function GetItem(AIndex: Integer): TPanamahSoftwareContratoManutencao;
    procedure SetItem(AIndex: Integer; const Value: TPanamahSoftwareContratoManutencao);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahSoftwareContratoManutencaoList;
    constructor Create;
    procedure Add(const AItem: TPanamahSoftwareContratoManutencao);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: TPanamahSoftwareContratoManutencao read GetItem write SetItem; default;
  end;
  
  TPanamahEventoCaixaTipoList = class(TInterfacedObject, IPanamahEventoCaixaTipoList)
  private
    FList: TStrings;
    function GetItem(AIndex: Integer): TPanamahEventoCaixaTipo;
    procedure SetItem(AIndex: Integer; const Value: TPanamahEventoCaixaTipo);
    procedure AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer; var Continue: Boolean);
  public
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
    class function FromJSON(const AJSON: string): IPanamahEventoCaixaTipoList;
    constructor Create;
    procedure Add(const AItem: TPanamahEventoCaixaTipo);
    procedure Clear;
    function Count: Integer;
    destructor Destroy; override;
    property Items[AIndex: Integer]: TPanamahEventoCaixaTipo read GetItem write SetItem; default;
  end;
  

implementation

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

{Converters}

function Converter_PanamahSoftwareAtivo_StrToEnum(const AValue: string): Integer;
begin
  if SameText(AValue, 'MILENIO') then Result := Integer(saMILENIO) else
  if SameText(AValue, 'SYSPDV') then Result := Integer(saSYSPDV) else
  if SameText(AValue, 'VAREJOFACIL') then Result := Integer(saVAREJOFACIL) else
  if SameText(AValue, 'SYSPDVWEB') then Result := Integer(saSYSPDVWEB) else
  if SameText(AValue, 'EASYASSIST') then Result := Integer(saEASYASSIST) else
  if SameText(AValue, 'SYSPDV_APP') then Result := Integer(saSYSPDV_APP) else
  if SameText(AValue, 'COLETOR') then Result := Integer(saCOLETOR) else
  raise EnumException.CreateFmt('Valor %s incorreto para PanamahSoftwareAtivo.', [AValue]);
end;

function Converter_PanamahSoftwareAtivo_EnumToStr(const AValue: Integer): string; overload;
begin
  if Integer(saMILENIO) = AValue then Result := 'MILENIO' else
  if Integer(saSYSPDV) = AValue then Result := 'SYSPDV' else
  if Integer(saVAREJOFACIL) = AValue then Result := 'VAREJOFACIL' else
  if Integer(saSYSPDVWEB) = AValue then Result := 'SYSPDVWEB' else
  if Integer(saEASYASSIST) = AValue then Result := 'EASYASSIST' else
  if Integer(saSYSPDV_APP) = AValue then Result := 'SYSPDV_APP' else
  if Integer(saCOLETOR) = AValue then Result := 'COLETOR' else
  raise EnumException.CreateFmt('Valor %d incorreto para PanamahSoftwareAtivo.', [AValue]);
end;
function Converter_PanamahSoftwareContratoManutencao_StrToEnum(const AValue: string): Integer;
begin
  if SameText(AValue, 'MILENIO') then Result := Integer(scmMILENIO) else
  if SameText(AValue, 'SYSPDV') then Result := Integer(scmSYSPDV) else
  if SameText(AValue, 'VAREJOFACIL') then Result := Integer(scmVAREJOFACIL) else
  if SameText(AValue, 'SYSPDVWEB') then Result := Integer(scmSYSPDVWEB) else
  if SameText(AValue, 'EASYASSIST') then Result := Integer(scmEASYASSIST) else
  if SameText(AValue, 'SYSPDV_APP') then Result := Integer(scmSYSPDV_APP) else
  if SameText(AValue, 'COLETOR') then Result := Integer(scmCOLETOR) else
  raise EnumException.CreateFmt('Valor %s incorreto para PanamahSoftwareContratoManutencao.', [AValue]);
end;

function Converter_PanamahSoftwareContratoManutencao_EnumToStr(const AValue: Integer): string; overload;
begin
  if Integer(scmMILENIO) = AValue then Result := 'MILENIO' else
  if Integer(scmSYSPDV) = AValue then Result := 'SYSPDV' else
  if Integer(scmVAREJOFACIL) = AValue then Result := 'VAREJOFACIL' else
  if Integer(scmSYSPDVWEB) = AValue then Result := 'SYSPDVWEB' else
  if Integer(scmEASYASSIST) = AValue then Result := 'EASYASSIST' else
  if Integer(scmSYSPDV_APP) = AValue then Result := 'SYSPDV_APP' else
  if Integer(scmCOLETOR) = AValue then Result := 'COLETOR' else
  raise EnumException.CreateFmt('Valor %d incorreto para PanamahSoftwareContratoManutencao.', [AValue]);
end;
function Converter_PanamahEventoCaixaTipo_StrToEnum(const AValue: string): Integer;
begin
  if SameText(AValue, 'ABERTURA') then Result := Integer(ectABERTURA) else
  if SameText(AValue, 'FECHAMENTO') then Result := Integer(ectFECHAMENTO) else
  if SameText(AValue, 'ENTRADA_OPERADOR') then Result := Integer(ectENTRADA_OPERADOR) else
  if SameText(AValue, 'SAIDA_OPERADOR') then Result := Integer(ectSAIDA_OPERADOR) else
  raise EnumException.CreateFmt('Valor %s incorreto para PanamahEventoCaixaTipo.', [AValue]);
end;

function Converter_PanamahEventoCaixaTipo_EnumToStr(const AValue: Integer): string; overload;
begin
  if Integer(ectABERTURA) = AValue then Result := 'ABERTURA' else
  if Integer(ectFECHAMENTO) = AValue then Result := 'FECHAMENTO' else
  if Integer(ectENTRADA_OPERADOR) = AValue then Result := 'ENTRADA_OPERADOR' else
  if Integer(ectSAIDA_OPERADOR) = AValue then Result := 'SAIDA_OPERADOR' else
  raise EnumException.CreateFmt('Valor %d incorreto para PanamahEventoCaixaTipo.', [AValue]);
end;

{Lists}

{ TPanamahSoftwareAtivoList }

procedure TPanamahSoftwareAtivoList.Add(const AItem: TPanamahSoftwareAtivo);
begin
  FList.Add(EnumConverters.Execute('PanamahSoftwareAtivo', Ord(AItem)));
end;

procedure TPanamahSoftwareAtivoList.Clear;
begin
  FList.Clear;
end;

function TPanamahSoftwareAtivoList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahSoftwareAtivoList.Create;
begin
  FList := TStringList.Create;
end;

destructor TPanamahSoftwareAtivoList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TPanamahSoftwareAtivoList.GetItem(AIndex: Integer): TPanamahSoftwareAtivo;
begin
  Result := TPanamahSoftwareAtivo(EnumConverters.Execute('PanamahSoftwareAtivo', FList[AIndex]));
end;

procedure TPanamahSoftwareAtivoList.SetItem(AIndex: Integer; const Value: TPanamahSoftwareAtivo);
begin
  FList[AIndex] := EnumConverters.Execute('PanamahSoftwareAtivo', Ord(Value));
end;

procedure TPanamahSoftwareAtivoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
begin
  FList.Add(Elem.Value);
end;

procedure TPanamahSoftwareAtivoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahSoftwareAtivoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSONstring.Generate(FList[I]));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahSoftwareAtivoList.FromJSON(const AJSON: string): IPanamahSoftwareAtivoList;
begin
  Result := TPanamahSoftwareAtivoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahSoftwareContratoManutencaoList }

procedure TPanamahSoftwareContratoManutencaoList.Add(const AItem: TPanamahSoftwareContratoManutencao);
begin
  FList.Add(EnumConverters.Execute('PanamahSoftwareContratoManutencao', Ord(AItem)));
end;

procedure TPanamahSoftwareContratoManutencaoList.Clear;
begin
  FList.Clear;
end;

function TPanamahSoftwareContratoManutencaoList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahSoftwareContratoManutencaoList.Create;
begin
  FList := TStringList.Create;
end;

destructor TPanamahSoftwareContratoManutencaoList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TPanamahSoftwareContratoManutencaoList.GetItem(AIndex: Integer): TPanamahSoftwareContratoManutencao;
begin
  Result := TPanamahSoftwareContratoManutencao(EnumConverters.Execute('PanamahSoftwareContratoManutencao', FList[AIndex]));
end;

procedure TPanamahSoftwareContratoManutencaoList.SetItem(AIndex: Integer; const Value: TPanamahSoftwareContratoManutencao);
begin
  FList[AIndex] := EnumConverters.Execute('PanamahSoftwareContratoManutencao', Ord(Value));
end;

procedure TPanamahSoftwareContratoManutencaoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
begin
  FList.Add(Elem.Value);
end;

procedure TPanamahSoftwareContratoManutencaoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahSoftwareContratoManutencaoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSONstring.Generate(FList[I]));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahSoftwareContratoManutencaoList.FromJSON(const AJSON: string): IPanamahSoftwareContratoManutencaoList;
begin
  Result := TPanamahSoftwareContratoManutencaoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

{ TPanamahEventoCaixaTipoList }

procedure TPanamahEventoCaixaTipoList.Add(const AItem: TPanamahEventoCaixaTipo);
begin
  FList.Add(EnumConverters.Execute('PanamahEventoCaixaTipo', Ord(AItem)));
end;

procedure TPanamahEventoCaixaTipoList.Clear;
begin
  FList.Clear;
end;

function TPanamahEventoCaixaTipoList.Count: Integer;
begin
  Result := FList.Count;
end;

constructor TPanamahEventoCaixaTipoList.Create;
begin
  FList := TStringList.Create;
end;

destructor TPanamahEventoCaixaTipoList.Destroy;
begin
  FList.Free;
  inherited;
end;

function TPanamahEventoCaixaTipoList.GetItem(AIndex: Integer): TPanamahEventoCaixaTipo;
begin
  Result := TPanamahEventoCaixaTipo(EnumConverters.Execute('PanamahEventoCaixaTipo', FList[AIndex]));
end;

procedure TPanamahEventoCaixaTipoList.SetItem(AIndex: Integer; const Value: TPanamahEventoCaixaTipo);
begin
  FList[AIndex] := EnumConverters.Execute('PanamahEventoCaixaTipo', Ord(Value));
end;

procedure TPanamahEventoCaixaTipoList.AddJSONObjectToList(ElName: string; Elem: TlkJSONbase; Data: pointer;
  var Continue: Boolean);
begin
  FList.Add(Elem.Value);
end;

procedure TPanamahEventoCaixaTipoList.DeserializeFromJSON(const AJSON: string);
begin
  with TlkJSON.ParseText(AJSON) as TlkJSONlist do
  begin
    ForEach(AddJSONObjectToList, nil);
    Free;
  end;
end;

function TPanamahEventoCaixaTipoList.SerializeToJSON: string;
var
  JSONObject: TlkJSONlist;
  I: Integer;
begin
  JSONObject := TlkJSONlist.Create;
  try
    for I := 0 to FList.Count - 1 do
      JSONObject.Add(TlkJSONstring.Generate(FList[I]));
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahEventoCaixaTipoList.FromJSON(const AJSON: string): IPanamahEventoCaixaTipoList;
begin
  Result := TPanamahEventoCaixaTipoList.Create;
  Result.DeserializeFromJSON(AJSON);
end;

initialization
  EnumConverters := TEnumConverters.Create;
  EnumConverters.Register('PanamahSoftwareAtivo', @Converter_PanamahSoftwareAtivo_StrToEnum, @Converter_PanamahSoftwareAtivo_EnumToStr);
  EnumConverters.Register('PanamahSoftwareContratoManutencao', @Converter_PanamahSoftwareContratoManutencao_StrToEnum, @Converter_PanamahSoftwareContratoManutencao_EnumToStr);
  EnumConverters.Register('PanamahEventoCaixaTipo', @Converter_PanamahEventoCaixaTipo_StrToEnum, @Converter_PanamahEventoCaixaTipo_EnumToStr);

finalization
  FreeAndNil(EnumConverters);

end.