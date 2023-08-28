unit uFunctions;

interface

uses
  Vcl.Forms,
  System.SysUtils, Vcl.StdCtrls, Vcl.Dialogs, Data.DB, fMessage, uEnumTypes,
  Vcl.ExtCtrls, System.UITypes;

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
  class procedure CenterPanel(AForm: TForm; APanel: TPanel);
  class procedure SetButtonColors(ASender: TObject; AButtonColor, AFontColor: TColor);
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
    TFrmMessage.ShowMessageBox(mtError, '', 'Aten��o, valor incorreto para esta fun��o. S�o permitidos apenas os valores 0 e 1');
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

class procedure TFunctions.SetButtonColors(ASender: TObject; AButtonColor, AFontColor: TColor);
begin
  TPanel(ASender).Color := AButtonColor;
  TPanel(ASender).Font.Color := AFontColor;
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
  Result := ExtractFilePath(Application.ExeName) + 'database\';
end;

class procedure TFunctions.FormatDataSetDecimalFields(ADataSet: TDataSet; AMask: String);
var
  I: Integer;
begin
  for I := 0 to ADataSet.FieldCount-1 do
  begin
    if (ADataSet.Fields[I].DataType = ftFloat) then
    begin
      TFloatField(ADataSet.Fields[I]).DisplayFormat:= AMask;
    end else
    if (ADataSet.Fields[I].DataType = ftCurrency) then
    begin
      TCurrencyField(ADataSet.Fields[I]).DisplayFormat:= AMask;
    end;
  end;
end;

class procedure TFunctions.CenterPanel(AForm: TForm; APanel: TPanel);
begin
  APanel.Left := (AForm.ClientWidth div 2) - (APanel.Width div 2);
  APanel.Top := (AForm.ClientHeight div 2) - (APanel.Height div 2);

  APanel.Update;
  AForm.Update;
end;

end.
