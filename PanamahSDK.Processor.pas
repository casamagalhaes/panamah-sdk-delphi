unit PanamahSDK.Processor;

interface

uses
  Classes, Windows, SysUtils, Messages, DateUtils, SyncObjs, PanamahSDK.Enums,
  PanamahSDK.Operation, PanamahSDK.Types, PanamahSDK.Batch, PanamahSDK.Client, PanamahSDK.Consts;

type

  TPanamahBatchEvent = procedure(ABatch: IPanamahBatch) of object;

  TPanamahModelEvent = procedure(AModel: IPanamahModel) of object;

  TPanamahOperationEvent = procedure(AModel: IPanamahOperation) of object;

  TPanamahBatchProcessor = class(TThread)
  private
    FCriticalSection: TCriticalSection;
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
    procedure AccumulateCurrentBatch;
    procedure DoOnCurrentBatchExpired;
    procedure DoOnBeforeObjectAddedToBatch(AModel: IPanamahModel);
    procedure DoOnBeforeBatchSent(ABatch: IPanamahBatch);
    procedure DoOnBeforeOperationSent(AOperation: IPanamahOperation);
    procedure SendAccumulatedBatches;
    procedure LoadCurrentBatch;
    procedure SaveCurrentBatch;
    procedure ExpireCurrentBatch;
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
    procedure Save(AModel: IPanamahModel);
    procedure Delete(AModel: IPanamahModel);
    procedure Flush;
  end;

implementation

{ TPanamahBatchProcessor }

uses PanamahSDK.ValidationUtils;

procedure TPanamahBatchProcessor.AccumulateCurrentBatch;
begin
  FCurrentBatch.SaveToDirectory(GetBatchAccumulationDirectory);
  FCurrentBatch.Reset;
  DeleteFile(GetCurrentBatchFilename);
end;

procedure TPanamahBatchProcessor.Save(AModel: IPanamahModel);
var
  ValidationResult: IPanamahValidationResult;
begin
  ValidationResult := AModel.Validate;
  if ValidationResult.Valid then
    AddOperationToCurrentBatch(otUPDATE, AModel)
  else
    raise EPanamahSDKExceptionValidationFailed.Create(ValidationResult.Reasons.Text);
end;

procedure TPanamahBatchProcessor.Delete(AModel: IPanamahModel);
begin
  if ModelHasId(AModel) then
    AddOperationToCurrentBatch(otDELETE, AModel)
  else
    raise EPanamahSDKExceptionValidationFailed.Create(Format('Id obrigatorio para exclusao de %s', [AModel.ModelName]));
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
  FCriticalSection.Acquire;
  try
    DoOnBeforeObjectAddedToBatch(AModel);
    FCurrentBatch.Add(TPanamahOperation.Create(AOperationType, AModel.Clone));
    if BatchExpiredBySize(FConfig.BatchMaxSize) or
          BatchExpiredByCount(FConfig.BatchMaxCount) then
      ExpireCurrentBatch;
  finally
    FCriticalSection.Release;
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
  FCriticalSection := TCriticalSection.Create;
end;

procedure TPanamahBatchProcessor.DoOnCurrentBatchExpired;
begin
  if Assigned(FOnCurrentBatchExpired) then
    FOnCurrentBatchExpired(FCurrentBatch);
end;

destructor TPanamahBatchProcessor.Destroy;
begin
  FCriticalSection.Free;
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

procedure TPanamahBatchProcessor.Execute;
begin
  inherited;
  LoadCurrentBatch;
  Process;
end;

procedure TPanamahBatchProcessor.ExpireCurrentBatch;
begin
  DoOnCurrentBatchExpired;
  AccumulateCurrentBatch;
end;

procedure TPanamahBatchProcessor.Flush;
begin
  FCriticalSection.Acquire;
  try
    if FCurrentBatch.Count > 0 then
    begin
      AccumulateCurrentBatch;
      SendAccumulatedBatches;
    end;
  finally
    FCriticalSection.Release;
  end;
end;

procedure TPanamahBatchProcessor.LoadCurrentBatch;
var
  CurrentBatchFromFile: IPanamahBatch;
begin
  if FileExists(GetCurrentBatchFilename) then
  begin
    FCriticalSection.Acquire;
    try
      CurrentBatchFromFile := TPanamahBatch.FromFile(GetCurrentBatchFilename);
      if CurrentBatchFromFile.Count > 0 then
        FCurrentBatch := CurrentBatchFromFile.Clone;
    finally
      FCriticalSection.Release;
    end;
  end;
end;

procedure TPanamahBatchProcessor.Process;
var
  CurrentBatchLastHash: string;
begin
  while not Terminated do
  begin
    FCriticalSection.Acquire;
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
    finally
      FCriticalSection.Release;
    end;
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
  I: Integer;
begin
  AccumulatedBatches := TPanamahBatchList.FromDirectory(GetBatchAccumulationDirectory);
  for I := 0 to AccumulatedBatches.Count - 1 do
  begin
    DoOnBeforeBatchSent(AccumulatedBatches[I]);
    Response := FClient.Post('/stream/data', AccumulatedBatches[I].SerializeToJSON, nil);
    if Response.Status = 200 then
    begin
      AccumulatedBatches[I].MoveToDirectory(GetBatchAccumulationDirectory, GetBatchSentDirectory);
    end;
  end;
end;

procedure TPanamahBatchProcessor.Start(AConfig: IPanamahStreamConfig);
begin
  FConfig := AConfig;
  FClient := TPanamahStreamClient.Create(API_BASE_URL, FConfig.AuthorizationToken, FConfig.Secret, FConfig.AssinanteId);
  FCurrentBatch := TPanamahBatch.Create;
  inherited Start;
end;

procedure TPanamahBatchProcessor.Stop;
begin
  Terminate;
  WaitFor;
end;

end.
