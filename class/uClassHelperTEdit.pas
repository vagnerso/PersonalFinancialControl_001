unit uClassHelperTEdit;

interface

uses Vcl.StdCtrls;

type TClassHelperTEdit = class helper for TEdit
  procedure clearWithX;
  procedure textToCurrency;
end;

implementation

{ TClassHelperTEdit }

procedure TClassHelperTEdit.clearWithX;
begin
  Text := 'XXXXX';
end;

procedure TClassHelperTEdit.textToCurrency;
begin
  Text := Copy(Text, 1, 2) + '.' + Copy(Text, 4, 6);
end;

end.
