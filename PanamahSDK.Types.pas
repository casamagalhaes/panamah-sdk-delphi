unit PanamahSDK.Types;

interface

uses
  SysUtils;

type

  IJSONSerializable = interface
    ['{AEE55D86-3A0E-46D0-9BCF-AEC0CFA1D71A}']
    function SerializeToJSON: string;
    procedure DeserializeFromJSON(const AJSON: string);
  end;

  IModel = interface(IJSONSerializable)
    ['{A749CFD5-4AA6-4443-ABD2-D1B55051CC2B}']
  end;

implementation

end.
