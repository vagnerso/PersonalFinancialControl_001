unit uFunctions;

interface

uses
  Vcl.Forms,
  System.SysUtils, Vcl.StdCtrls, Vcl.Dialogs, Data.DB;

type TFunctions=class
  private

  public

  class function DataBasePath: string;
  class function ApplicationPath: string;
  class function AppName: string;
  class function AppNameExec: string;
  class function GenerateUUID: String;
  class function AppVersion: string;
  class procedure clearFormFields(AForm: TForm);
  class function IntegerToBoolean(AValue: Int8): Boolean;
  class procedure FormatDataSetDecimalFields(ADataSet: TDataSet; AMask: String);
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

class function TFunctions.IntegerToBoolean(AValue: Int8): Boolean;
begin
  Result := False;

  if not (AValue in [0,1] ) then
  begin
    showmessage('Atenção, valor incorreto para esta função. São permitidos apenas os valores 0 e 1');
    Abort;
  end;

  if (AValue = 0) then
  begin
    Result := False;
  end
  else if (AValue = 1) then
  begin
    Result := True;
  end;
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

class procedure TFunctions.clearFormFields(AForm: TForm);
var
  i: Integer;
begin

  for i := 0 to AForm.ComponentCount - 1 do
  begin
    if AForm.Components[i] is TEdit then
    begin
      TEdit(AForm.Components[i]).Text := EmptyStr;
    end;
  end;

end;

class function TFunctions.DataBasePath: string;
begin
  Result := ExtractFilePath(Application.ExeName) + '\database\';
end;

class procedure TFunctions.FormatDataSetDecimalFields(ADataSet: TDataSet; AMask: String);
var
  I: Integer;
begin
  for I := 0 to ADataSet.FieldCount-1 do
  begin
    if (ADataSet.Fields[I].DataType = ftFloat) then
    begin
      TFloatField(ADataSet.FieldByName('R$ Valor')).DisplayFormat:= AMask;
    end else
    if (ADataSet.Fields[I].DataType = ftCurrency) then
    begin
      TCurrencyField(ADataSet.FieldByName('R$ Valor')).DisplayFormat:= AMask;
    end;
  end;
end;

end.
