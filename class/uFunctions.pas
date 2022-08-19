unit uFunctions;

interface

uses
  Vcl.Forms, System.SysUtils;

type TFunctions=class
  private

  public

  class function DataBasePath: string;
  class function ApplicationPath: string;
  class function AppName: string;
  class function AppNameExec: string;
  class function GenerateUUID: String;
  class function AppVersion: string;
end;

implementation

{ TFunctions }

class function TFunctions.GenerateUUID: String;
var
  uid: TGuid;
  res: HResult;
begin

  Result := EmptyStr;

  res := CreateGuid(uid);
  if res = S_OK then
    Result := GuidToString(uid);

  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

class function TFunctions.ApplicationPath: string;
begin
  Result := ExtractFilePath(Application.ExeName) + '\';
end;

class function TFunctions.AppName: string;
begin
  Result := Application.Title;
end;

class function TFunctions.AppNameExec: string;
begin
  Result := Application.ExeName;
end;

class function TFunctions.AppVersion: string;
begin
  Result := '1.1.1';
end;

class function TFunctions.DataBasePath: string;
begin
  Result := ExtractFilePath(Application.ExeName) + '\database\';
end;

end.
