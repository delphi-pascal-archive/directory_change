{$I Directives.inc}

unit UFrmPrinc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, UDirChangeNotifier,
  {$WARNINGS OFF}FileCtrl{$WARNINGS ON}
  {$IFDEF EnableXPMan}, XPMan{$ENDIF};

type
  TFrmPrinc = class(TForm)
    gbParams: TGroupBox;
    EdtDir: TLabeledEdit;
    BtnStart: TButton;
    BtnStop: TButton;
    gbInfos: TGroupBox;
    lbChanges: TListBox;
    SB: TStatusBar;
    BtnParc: TButton;
    procedure BtnParcClick(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SBResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FChangeThread: TDirChangeNotifier;
    procedure SthChange(Sender: TDirChangeNotifier; const FileName,
     OtherFileName: WideString; Action: TDirChangeNotification);
    procedure ThreadTerminated(Sender: TObject);
  end;

var
  FrmPrinc: TFrmPrinc;

implementation

{$R *.dfm}

procedure TFrmPrinc.FormCreate(Sender: TObject);
var
  Buf: array[0..255] of Char;
begin
  GetWindowsDirectory(@Buf, SizeOf(Buf));
  EdtDir.Text := ExtractFileDrive(Buf);
end;

procedure TFrmPrinc.BtnParcClick(Sender: TObject);
var
  Dir: string;
begin
  if SelectDirectory('Files system watch:', '', Dir) then
    EdtDir.Text := Dir;
end;

procedure TFrmPrinc.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FChangeThread) then
    FChangeThread.Terminate;
end;

procedure TFrmPrinc.BtnStartClick(Sender: TObject);
begin
  {>> On démarre le thread avec les paramètres voulus, à savoir :
  - Le dossier à surveiller
  - Les notifications que l'on veut recevoir (ici, on les demande toutes -
    en réalité, on n'a pas vraiment besoin de la notification d'accès
    au fichier }
  FChangeThread := TDirChangeNotifier.Create(EdtDir.Text, CAllNotifications);

  {>> De quoi se tenir informé de ce qui se passe }
  FChangeThread.OnChange := SthChange;
  FChangeThread.OnTerminate := ThreadTerminated;

  BtnStart.Enabled := False;
  BtnStop.Enabled := True;
  lbChanges.Items.Clear;
  SB.Panels[1].Text := '0 element';
  SB.Panels[0].Text := 'Watch on file system changes';
end;

procedure TFrmPrinc.BtnStopClick(Sender: TObject);
begin
  FChangeThread.Terminate;
end;

procedure TFrmPrinc.SBResize(Sender: TObject);
begin
  SB.Panels[0].Width := SB.ClientWidth - 150;
end;

procedure TFrmPrinc.SthChange(Sender: TDirChangeNotifier;
 const FileName, OtherFileName: WideString; Action: TDirChangeNotification);
var
  Fmt, Line: WideString;
begin
  case Action of
    dcnFileAdd: Fmt := 'Creation file %s';
    dcnFileRemove: Fmt := 'Remove file %s';
    dcnRenameFile, dcnRenameDir: Fmt := '%s renamed to %s';
    dcnModified: Fmt := 'Modification file %s';
    dcnLastAccess: Fmt := 'Date last access file %s  modified';
    dcnLastWrite: Fmt := 'Date last write file %s modified';
    dcnCreationTime: Fmt := 'Creation time file %s modified';
  end;

  Line := FormatDateTime('"["hh":"nn":"ss","zzz"] "', Now);
  Line := Line + Format(Fmt, [FileName, OtherFileName]);
  lbChanges.Items.Insert(0, Line);

  {>> MAJ du StatusBar }
  if lbChanges.Items.Count > 1 then
    SB.Panels[1].Text := Format('%d elements', [lbChanges.Items.Count])
  else
    SB.Panels[1].Text := '1 element';
end;

procedure TFrmPrinc.ThreadTerminated(Sender: TObject);
begin
  FChangeThread := nil;
  BtnStart.Enabled := True;
  BtnStop.Enabled := False;
  SB.Panels[0].Text := 'Watch stopped';
end;

end.
