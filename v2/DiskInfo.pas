unit DiskInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, sFrameAdapter, StdCtrls, sCheckBox, ComCtrls, sTrackBar,
  FileCtrl, sLabel, acProgressBar, sHintManager, ExtCtrls //,
  //MSI_Common, MSI_Disk, ExtCtrls
  ;

type
  TFrameIn = class(TFrame)
    sFrameAdapter1: TsFrameAdapter;
    sProgressBar1: TsProgressBar;
    sLabelFX1: TsLabelFX;
    DriveComboBox1: TDriveComboBox;
    Timer1: TTimer;
    pass1timer: TTimer;
    sHintManager1: TsHintManager;
    procedure DriveComboBox1Change(Sender: TObject);
    procedure pass1timerTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TFrameIn;
  str: string[1];

implementation

uses Main;

{$R *.dfm}

function DConvert (DCB1:char):byte;
begin

end;

procedure TFrameIn.DriveComboBox1Change(Sender: TObject);
begin
form1.Memo1.Lines[0]:=DriveComboBox1.Drive;

//ShowMessage(inttostr(DiskFree(3) ));

{
ShowMessage(
  inttostr(
    DiskFree( ord(DriveComboBox1.Drive)-96 )
  )+' - '+DriveComboBox1.Drive+' - '+inttostr(ord(DriveComboBox1.Drive)-99)
);
}
end;

procedure TFrameIn.pass1timerTimer(Sender: TObject);
begin
str:=form1.Memo1.Lines[0];
//DriveComboBox1.Drive:=str[1];
pass1timer.Enabled:=false;
pass1timer.Free;
end;

procedure TFrameIn.Timer1Timer(Sender: TObject);
begin
//MiTeC_Disk1.Drive:=DriveComboBox1.Drive+':';

sProgressBar1.Max:=DiskSize( ord(DriveComboBox1.Drive)-96 ) div 1024 div 1024;
sProgressBar1.Position:=DiskFree( ord(DriveComboBox1.Drive)-96 ) div 1024 div 1024;


sLabelFX1.Caption:='�������� �� '+UpCase(DriveComboBox1.Drive)+':\ '+inttostr(DiskFree( ord(DriveComboBox1.Drive)-96 )div 1024 div 1024)+' ��';

{case MiTeC_Disk1.MediaType of
dtUnknown:sLabelFX1.Caption:='Unknown disk type!';
dtNotExists:sLabelFX1.Caption:='Disk not in drive!';
dtRemovable:sLabelFX1.Caption:='flash drive';
dtCDROM: sLabelFX1.Caption:='It''s CD or DVD.';
end;
}

if DiskFree( ord(DriveComboBox1.Drive)-96 )=0 then sLabelFX1.Caption:=UpCase(DriveComboBox1.Drive)+':\ - ��� CD ��� DVD.';
if DiskFree( ord(DriveComboBox1.Drive)-96 )=-1 then sLabelFX1.Caption:='���������� '+UpCase(DriveComboBox1.Drive)+':\ - ������!';



form1.TrayIcon1.Hint:='Info Utility v.5.1'+#13+sLabelFX1.Caption;
end;

end.
