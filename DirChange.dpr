program DirChange;

uses
  Forms,
  UFrmPrinc in 'UFrmPrinc.pas' {FrmPrinc},
  UDirChangeNotifier in 'UDirChangeNotifier.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmPrinc, FrmPrinc);
  Application.Run;
end.
