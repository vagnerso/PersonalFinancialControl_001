unit fImport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, Vcl.ComCtrls, Vcl.StdCtrls, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Data.DB, Vcl.Grids, Vcl.DBGrids, System.JSON,
  FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TfrmImport = class(TForm)
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    pcGeneral: TPageControl;
    tabJSON: TTabSheet;
    tabImport: TTabSheet;
    mmJson: TMemo;
    mmText: TMemo;
    tabGrid: TTabSheet;
    grData: TDBGrid;
    dsGrid: TDataSource;
    pnMenu: TPanel;
    btImport: TButton;
    procedure btImportClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FMemTable: TFDMemTable;
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation

{$R *.dfm}

procedure TfrmImport.btImportClick(Sender: TObject);
var
  lJsonObject: TJsonObject;
  lJsonObjectPrefixe: TJsonObject;
  lJsonArray: TJsonArray;
  lJsonString: string;
  i: Integer;
  lPrefixeValueIpv4: string;
  lPrefixeValueIpv6: string;

begin
  mmJson.Lines.Clear;
  mmText.Lines.Clear;
  lPrefixeValueIpv4 := EmptyStr;
  lPrefixeValueIpv6 := EmptyStr;

  FMemTable.FieldDefs.Clear;
  FMemTable.FieldDefs.Add('id',TFieldType.ftInteger);
  FMemTable.FieldDefs.Add('ip',TFieldType.ftString,500);
  FMemTable.FieldDefs.Add('type',TFieldType.ftString,10);
  FMemTable.FieldDefs.Add('service',TFieldType.ftString,500);
  FMemTable.FieldDefs.Add('scope',TFieldType.ftString,500);
  FMemTable.CreateDataSet;

  dsGrid.DataSet := FMemTable;

  RESTRequest1.Execute;
  if RESTResponse1.StatusCode = 200 then
  begin
    mmJson.Text := RESTResponse1.Content;
    lJsonString := RESTResponse1.Content;
    if not(TJSONObject.ParseJSONValue(lJsonString).Null) then
    begin
      lJsonObject := TJSONObject.ParseJSONValue(lJsonString) as TJSONObject;

      if (lJsonObject <> nil) then
      begin
        lJsonArray := lJsonObject.GetValue<TJSONArray>('prefixes') as TJSONArray;

        for i := 0 to lJsonArray.Count - 1 do
        begin

          lJsonObjectPrefixe := lJsonArray.Items[i] as TJSONObject;
          lPrefixeValueIpv4 := lJsonObjectPrefixe.GetValue<string>('ipv4Prefix','');
          lPrefixeValueIpv6 := lJsonObjectPrefixe.GetValue<string>('ipv6Prefix','');

          FMemTable.Append;

          FMemTable.FieldByName('id').AsInteger := i + 1;

          if (Length(Trim(lPrefixeValueIpv4)) > 0) then
          begin
            mmText.Lines.Add('ipv4Prefix: ' + lPrefixeValueIpv4);
            FMemTable.FieldByName('type').AsString := 'Ipv4';
            FMemTable.FieldByName('ip').AsString := lPrefixeValueIpv4;
          end
          else if (Length(Trim(lPrefixeValueIpv6)) > 0) then
          begin
            mmText.Lines.Add('ipv6Prefix: ' + lPrefixeValueIpv6);
            FMemTable.FieldByName('type').AsString := 'Ipv6';
            FMemTable.FieldByName('ip').AsString := lPrefixeValueIpv6;
          end;

          FMemTable.FieldByName('service').AsString := lJsonObjectPrefixe.GetValue<string>('service','');
          FMemTable.FieldByName('scope').AsString := lJsonObjectPrefixe.GetValue<string>('scope','');
          FMemTable.Post;

        end;

        FMemTable.First;

        grData.Columns[0].Width := 80;
        grData.Columns[1].Width := 220;
        grData.Columns[2].Width := 70;
        grData.Columns[3].Width := 140;
        grData.Columns[4].Width := 140;

      end;
    end;

  end;

end;

procedure TfrmImport.FormCreate(Sender: TObject);
begin
  FMemTable := TFDMemTable.Create(nil);
end;

procedure TfrmImport.FormDestroy(Sender: TObject);
begin
  FMemTable.Free;
end;

end.
