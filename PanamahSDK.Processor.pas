unit PanamahSDK.Processor;

interface

uses
  Classes, Windows, SysUtils, Messages, DateUtils, SyncObjs, PanamahSDK.Enums,
  PanamahSDK.Operation, PanamahSDK.Types, PanamahSDK.Batch, PanamahSDK.Client,
  PanamahSDK.Consts, uLkJSON, ActiveX;

type

  TPanamahCancelableModelEvent = procedure(AModel: IPanamahModel;
    var AContinue: Boolean) of object;

  TPanamahErrorEvent = procedure(AError: Exception) of object;

  TPanamahBatchEvent = procedure(ABatch: IPanamahBatch) of object;

  TPanamahModelEvent = procedure(AModel: IPanamahModel) of object;

  TPanamahOperationEvent = procedure(AModel: IPanamahOperation) of object;

  TPanamahBatchProcessor = class(TThread)
  private
    FOnBeforeSave: TPanamahCancelableModelEvent;
    FOnBeforeDelete: TPanamahCancelableModelEvent;
    FOnError: TPanamahErrorEvent;
    FOnCurrentBatchExpired: TPanamahBatchEvent;
    FOnBeforeObjectAddedToBatch: TPanamahModelEvent;
    FOnBeforeBatchSent: TPanamahBatchEvent;
    FOnBeforeOperationSent: TPanamahOperationEvent;
    FClient: IPanamahClient;
    FConfig: IPanamahStreamConfig;
    FCurrentBatch: IPanamahBatch;
    function GetBatchAccumulationDirectory: string;
    function GetBatchSentDirectory: string;
    function GetCurrentBatchFilename: string;
    function IsThereAccumulatedBatches: Boolean;
    function CurrentBatchExpiredByTime(ABatchTTL: Integer): Boolean;
    function BatchExpiredBySize(AMaxSize: Integer): Boolean;
    function BatchExpiredByCount(AMaxCount: Integer): Boolean;
    procedure DoOnBeforeSave(AModel: IPanamahModel; var AContinue: Boolean);
    procedure DoOnBeforeDelete(AModel: IPanamahModel; var AContinue: Boolean);
    procedure DoOnError(AError: Exception);
    procedure AccumulateCurrentBatch;
    procedure DoOnCurrentBatchExpired;
    procedure DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
    procedure DoOnBeforeBatchSent(ABatch: IPanamahBatch);
    procedure DoOnBeforeOperationSent(AOperation: IPanamahOperation);
    procedure SendAccumulatedBatches;
    procedure LoadCurrentBatch;
    procedure SaveCurrentBatch;
    procedure ExpireCurrentBatch;
    procedure CreateBatchWithFailedOperations(ASourceBatch: IPanamahBatch; AFailedOperations: IPanamahOperationList);
    procedure Process;
    procedure AddOperationToCurrentBatch(AOperationType: TPanamahOperationType; AModel: IPanamahModel);
  public
    destructor Destroy; override;
    constructor Create; reintroduce;
    procedure Start(AConfig: IPanamahStreamConfig); reintroduce;
    procedure Execute; override;
    procedure Stop;
    property OnCurrentBatchExpired: TPanamahBatchEvent read FOnCurrentBatchExpired write FOnCurrentBatchExpired;
    property OnBeforeObjectAddedToBatch: TPanamahModelEvent read FOnBeforeObjectAddedToBatch write FOnBeforeObjectAddedToBatch;
    property OnBeforeBatchSent: TPanamahBatchEvent read FOnBeforeBatchSent write FOnBeforeBatchSent;
    property OnBeforeOperationSent: TPanamahOperationEvent read FOnBeforeOperationSent write FOnBeforeOperationSent;
    property OnBeforeSave: TPanamahCancelableModelEvent read FOnBeforeSave write FOnBeforeSave;
    property OnBeforeDelete: TPanamahCancelableModelEvent read FOnBeforeDelete write FOnBeforeDelete;
    property OnError: TPanamahErrorEvent read FOnError write FOnError;
    procedure Save(AModel: IPanamahModel);
    procedure Delete(AModel: IPanamahModel);
    procedure Flush;
  end;

  IPanamahCountedOperations = interface(IJSONSerializable)
    ['{6410783B-0596-422A-ABF4-827696C6BDDD}']
    function GetTotal: Integer;
    function GetItens: IPanamahOperationList;
    procedure SetTotal(ATotal: Integer);
    procedure SetItens(AItens: IPanamahOperationList);
    property Total: Integer read GetTotal write SetTotal;
    property Itens: IPanamahOperationList read GetItens write SetItens;
  end;

  IPanamahBatchResponse = interface(IJSONSerializable)
    ['{12404D7B-9274-4F3D-BF35-2C17EAFB2C03}']
    function GetSucessos: IPanamahCountedOperations;
    function GetFalhas: IPanamahCountedOperations;
    procedure SetSucessos(ASucessos: IPanamahCountedOperations);
    procedure SetFalhas(AFalhas: IPanamahCountedOperations);
    property Sucessos: IPanamahCountedOperations read GetSucessos write SetSucessos;
    property Falhas: IPanamahCountedOperations read GetFalhas write SetFalhas;
  end;

  TPanamahCountedOperations = class(TInterfacedObject, IPanamahCountedOperations)
  private
    FTotal: Integer;
    FItens: IPanamahOperationList;
    function GetTotal: Integer;
    function GetItens: IPanamahOperationList;
    procedure SetTotal(ATotal: Integer);
    procedure SetItens(AItens: IPanamahOperationList);
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    class function FromJSON(const AJSON: string): IPanamahCountedOperations;
    property Total: Integer read GetTotal write SetTotal;
    property Itens: IPanamahOperationList read GetItens write SetItens;
  end;

  TPanamahBatchResponse = class(TInterfacedObject, IPanamahBatchResponse)
  private
    FSucessos: IPanamahCountedOperations;
    FFalhas: IPanamahCountedOperations;
    function GetSucessos: IPanamahCountedOperations;
    function GetFalhas: IPanamahCountedOperations;
    procedure SetSucessos(ASucessos: IPanamahCountedOperations);
    procedure SetFalhas(AFalhas: IPanamahCountedOperations);
  public
    procedure DeserializeFromJSON(const AJSON: string);
    function SerializeToJSON: string;
    class function FromJSON(const AJSON: string): IPanamahBatchResponse;
    property Sucessos: IPanamahCountedOperations read GetSucessos write SetSucessos;
    property Falhas: IPanamahCountedOperations read GetFalhas write SetFalhas;
  end;

implementation

uses
  PanamahSDK.ValidationUtils, PanamahSDK.JsonUtils;

{ TPanamahBatchProcessor }

procedure TPanamahBatchProcessor.AccumulateCurrentBatch;
begin
  FCurrentBatch.SaveToDirectory(GetBatchAccumulationDirectory);
  FCurrentBatch.Reset;
  DeleteFile(GetCurrentBatchFilename);
end;

procedure TPanamahBatchProcessor.Save(AModel: IPanamahModel);
var
  ValidationResult: IPanamahValidationResult;
  KeepExecuting: Boolean;
begin
  KeepExecuting := True;
  DoOnBeforeSave(AModel, KeepExecuting);
  if KeepExecuting then
  begin
    ValidationResult := AModel.Validate;
    if ValidationResult.Valid then
      AddOperationToCurrentBatch(otUPDATE, AModel)
    else
      raise EPanamahSDKExceptionValidationFailed.Create(ValidationResult.Reasons.Text);
  end;
end;

procedure TPanamahBatchProcessor.Delete(AModel: IPanamahModel);
var
  KeepExecuting: Boolean;
begin
  KeepExecuting := True;
  DoOnBeforeDelete(AModel, KeepExecuting);
  if KeepExecuting then
  begin
    if ModelHasId(AModel) then
      AddOperationToCurrentBatch(otDELETE, AModel)
    else
      raise EPanamahSDKExceptionValidationFailed.Create(Format('Id obrigatorio para exclusao de %s', [AModel.ModelName]));
  end;
end;

function TPanamahBatchProcessor.GetBatchAccumulationDirectory: string;
begin
  Result := (FConfig.BaseDirectory + '\accumulated');
end;

function TPanamahBatchProcessor.GetBatchSentDirectory: string;
begin
  Result := (FConfig.BaseDirectory + '\sent');
end;

function TPanamahBatchProcessor.GetCurrentBatchFilename: string;
begin
  Result := (FConfig.BaseDirectory + '\current.pbt');
end;

function TPanamahBatchProcessor.IsThereAccumulatedBatches: Boolean;
begin
  Result := TPanamahBatchList.CountBatchesInDirectory(GetBatchAccumulationDirectory) > 0;
end;

procedure TPanamahBatchProcessor.AddOperationToCurrentBatch(AOperationType: TPanamahOperationType;
  AModel: IPanamahModel);
begin
  DoOnBeforeObjectAddedToBatch(AModel);
  FCurrentBatch.Add(TPanamahOperation.Create(AOperationType, AModel.Clone));
  if BatchExpiredBySize(FConfig.BatchMaxSize) or
        BatchExpiredByCount(FConfig.BatchMaxCount) then
  begin
    ExpireCurrentBatch;
  end;
end;

function TPanamahBatchProcessor.BatchExpiredByCount(AMaxCount: Integer): Boolean;
begin
  Result := FCurrentBatch.Count >= AMaxCount;
end;

function TPanamahBatchProcessor.BatchExpiredBySize(AMaxSize: Integer): Boolean;
begin
  Result := FCurrentBatch.Size > AMaxSize;
end;

function TPanamahBatchProcessor.CurrentBatchExpiredByTime(ABatchTTL: Integer): Boolean;
begin
  Result := MilliSecondsBetween(Now, FCurrentBatch.CreatedAt) >= ABatchTTL;
end;

constructor TPanamahBatchProcessor.Create;
begin
  inherited Create(True);
end;

procedure TPanamahBatchProcessor.CreateBatchWithFailedOperations(
  ASourceBatch: IPanamahBatch; AFailedOperations: IPanamahOperationList);
var
  I, X: Integer;
  BatchOperation, FailedOperation: IPanamahOperation;
  PriorityBatch: IPanamahBatch;
begin
  PriorityBatch := TPanamahBatch.Create;
  PriorityBatch.Priority := True;
  for I := 0 to AFailedOperations.Count - 1 do
  begin
    FailedOperation := AFailedOperations[I];
    for X := 0 to ASourceBatch.Count - 1 do
    begin
      BatchOperation := ASourceBatch.Items[I];
      if BatchOperation.Equals(FailedOperation) then
        PriorityBatch.Add(BatchOperation.Clone);
    end;
  end;
  PriorityBatch.SaveToDirectory(GetBatchAccumulationDirectory);
  ASourceBatch.MoveToDirectory(GetBatchAccumulationDirectory, GetBatchSentDirectory);
end;

procedure TPanamahBatchProcessor.DoOnCurrentBatchExpired;
begin
  if Assigned(FOnCurrentBatchExpired) then
    FOnCurrentBatchExpired(FCurrentBatch);
end;

procedure TPanamahBatchProcessor.DoOnError(AError: Exception);
begin
  if Assigned(FOnError) then
    FOnError(AError);
end;

destructor TPanamahBatchProcessor.Destroy;
begin
  inherited;
end;

procedure TPanamahBatchProcessor.DoOnBeforeBatchSent(ABatch: IPanamahBatch);
var
  I: Integer;
begin
  if Assigned(FOnBeforeBatchSent) then
    FOnBeforeBatchSent(ABatch);
  if Assigned(FOnBeforeOperationSent) then
    for I := 0 to ABatch.Count - 1 do
      DoOnBeforeOperationSent(ABatch.Items[I]);
end;

procedure TPanamahBatchProcessor.DoOnBeforeDelete(AModel: IPanamahModel; var AContinue: Boolean);
begin
  if Assigned(FOnBeforeDelete) then
    FOnBeforeDelete(AModel, AContinue);
end;

procedure TPanamahBatchProcessor.DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
begin
  if Assigned(FOnBeforeObjectAddedToBatch) then
    FOnBeforeObjectAddedToBatch(AModel);
end;

procedure TPanamahBatchProcessor.DoOnBeforeOperationSent(AOperation: IPanamahOperation);
begin
  if Assigned(FOnBeforeOperationSent) then
    FOnBeforeOperationSent(AOperation);
end;

procedure TPanamahBatchProcessor.DoOnBeforeSave(AModel: IPanamahModel; var AContinue: Boolean);
begin
  if Assigned(FOnBeforeSave) then
    FOnBeforeSave(AModel, AContinue);
end;

procedure TPanamahBatchProcessor.Execute;
begin
  inherited;
  CoInitialize(nil);
  try
    LoadCurrentBatch;
    Process;
  finally
    CoUninitialize;
  end;
end;

procedure TPanamahBatchProcessor.ExpireCurrentBatch;
begin
  DoOnCurrentBatchExpired;
  AccumulateCurrentBatch;
end;

procedure TPanamahBatchProcessor.Flush;
begin
  if FCurrentBatch.Count > 0 then
  begin
    AccumulateCurrentBatch;
    SendAccumulatedBatches;
  end;
end;

procedure TPanamahBatchProcessor.LoadCurrentBatch;
var
  CurrentBatchFromFile: IPanamahBatch;
begin
  if FileExists(GetCurrentBatchFilename) then
  begin
    CurrentBatchFromFile := TPanamahBatch.FromFile(GetCurrentBatchFilename);
    if CurrentBatchFromFile.Count > 0 then
      FCurrentBatch := CurrentBatchFromFile.Clone;
  end;
end;

procedure TPanamahBatchProcessor.Process;
var
  CurrentBatchLastHash: string;
begin
  while not Terminated do
  begin
    try
      if IsThereAccumulatedBatches then
      begin
        SendAccumulatedBatches;
      end
      else if FCurrentBatch.Count > 0 then
      begin
        if CurrentBatchExpiredByTime(FConfig.BatchTTL) then
          ExpireCurrentBatch
        else
        if FCurrentBatch.Hash <> CurrentBatchLastHash then
        begin
          SaveCurrentBatch;
          CurrentBatchLastHash := FCurrentBatch.Hash;
        end;
      end;
    except
      on E: Exception do
        DoOnError(E);
    end;
    Sleep(500);
  end;
end;

procedure TPanamahBatchProcessor.SaveCurrentBatch;
begin
  if FCurrentBatch.Count > 0 then
    FCurrentBatch.SaveToFile(GetCurrentBatchFilename);
end;

procedure TPanamahBatchProcessor.SendAccumulatedBatches;
var
  AccumulatedBatches: IPanamahBatchList;
  Response: IPanamahResponse;
  BatchResponse: IPanamahBatchResponse;
  I: Integer;
begin
  AccumulatedBatches := TPanamahBatchList.FromDirectory(GetBatchAccumulationDirectory);
  for I := 0 to AccumulatedBatches.Count - 1 do
  begin
    DoOnBeforeBatchSent(AccumulatedBatches[I].Clone);
    Response := FClient.Post('/stream/data', AccumulatedBatches[I].SerializeToJSON, nil);
    if Response.Status = 200 then
    begin
      BatchResponse := TPanamahBatchResponse.FromJSON(Response.Content);
      if Assigned(BatchResponse.Falhas) and
          (BatchResponse.Falhas.Total > 0) then
      begin
        CreateBatchWithFailedOperations(AccumulatedBatches[I], BatchResponse.Falhas.Itens);
        Break;
      end
      else
      begin
        AccumulatedBatches[I].MoveToDirectory(GetBatchAccumulationDirectory, GetBatchSentDirectory);
      end;
    end;
  end;
end;

procedure TPanamahBatchProcessor.Start(AConfig: IPanamahStreamConfig);
begin
  FConfig := AConfig;
  FClient := TPanamahStreamClient.Create(API_BASE_URL, FConfig.AuthorizationToken, FConfig.Secret, FConfig.AssinanteId);
  FCurrentBatch := TPanamahBatch.Create;
  inherited {$IFDEF UNICODE}Start{$ELSE}Resume{$ENDIF};
end;

procedure TPanamahBatchProcessor.Stop;
begin
  Terminate;
  WaitFor;
end;

{ TPanamahBatchResponse }

procedure TPanamahBatchResponse.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    if JSONObject.Field['falhas'] is TlkJSONobject then
      FFalhas := TPanamahCountedOperations.FromJSON(TlkJSON.GenerateText(JSONObject.Field['falhas']));
    if JSONObject.Field['sucessos'] is TlkJSONobject then
      FSucessos := TPanamahCountedOperations.FromJSON(TlkJSON.GenerateText(JSONObject.Field['sucessos']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahBatchResponse.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'falhas', FFalhas);
    SetFieldValue(JSONObject, 'sucessos', FSucessos);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahBatchResponse.FromJSON(const AJSON: string): IPanamahBatchResponse;
begin
  Result := TPanamahBatchResponse.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahBatchResponse.GetFalhas: IPanamahCountedOperations;
begin
  Result := FFalhas;
end;

function TPanamahBatchResponse.GetSucessos: IPanamahCountedOperations;
begin
  Result := FSucessos;
end;

procedure TPanamahBatchResponse.SetFalhas(AFalhas: IPanamahCountedOperations);
begin
  FFalhas := AFalhas;
end;

procedure TPanamahBatchResponse.SetSucessos(ASucessos: IPanamahCountedOperations);
begin
  FSucessos := ASucessos;
end;

{ TPanamahCountedOperations }

procedure TPanamahCountedOperations.DeserializeFromJSON(const AJSON: string);
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSON.ParseText(AJSON) as TlkJSONobject;
  try
    FTotal := GetFieldValueAsInteger(JSONObject, 'total');
    if JSONObject.Field['itens'] is TlkJSONlist then
      FItens := TPanamahOperationList.FromJSON(TlkJSON.GenerateText(JSONObject.Field['itens']));
  finally
    JSONObject.Free;
  end;
end;

function TPanamahCountedOperations.SerializeToJSON: string;
var
  JSONObject: TlkJSONobject;
begin
  JSONObject := TlkJSONobject.Create;
  try
    SetFieldValue(JSONObject, 'total', FTotal);
    SetFieldValue(JSONObject, 'itens', FItens);
    Result := TlkJSON.GenerateText(JSONObject);
  finally
    JSONObject.Free;
  end;
end;

class function TPanamahCountedOperations.FromJSON(const AJSON: string): IPanamahCountedOperations;
begin
  Result := TPanamahCountedOperations.Create;
  Result.DeserializeFromJSON(AJSON);
end;

function TPanamahCountedOperations.GetItens: IPanamahOperationList;
begin
  Result := FItens;
end;

function TPanamahCountedOperations.GetTotal: Integer;
begin
  Result := FTotal;
end;

procedure TPanamahCountedOperations.SetItens(AItens: IPanamahOperationList);
begin
  FItens := AItens;
end;

procedure TPanamahCountedOperations.SetTotal(ATotal: Integer);
begin
  FTotal := ATotal;
end;

end.
