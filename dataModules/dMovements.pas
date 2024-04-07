unit dMovements;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxClass, frxDBSet, dConnection,
  frxExportBaseDialog, frxExportPDF, frxExportHTML;

type
  TdtmMovements = class(TDataModule)
    qryMovementsReport: TFDQuery;
    frxReportMovements: TfrxReport;
    frxDBDatasetMovements: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmMovements: TdtmMovements;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
