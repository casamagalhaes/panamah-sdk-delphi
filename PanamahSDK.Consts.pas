unit PanamahSDK.Consts;

interface

const
  UTF8_CODEPAGE = 65001;
  LATIN_CODEPAGE = 28591;
  HTTPS_PROTOCOL = 'https';
  {$IFDEF DEBUG}
  API_BASE_URL = 'https://127.0.0.1:7443';
//  API_BASE_URL = 'https://panamah.io/api/v2';
  {$ELSE}
  API_BASE_URL = 'https://127.0.0.1:7443';
  {$ENDIF}


implementation

end.
