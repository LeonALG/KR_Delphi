unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, jpeg, ComCtrls;

type
  TFormGas = class(TForm)
    LabelConditions1Line: TLabel;
    LabelConditions2Line: TLabel;
    LabelAccurancy: TLabel;
    LabelConditions3Line: TLabel;
    EditH: TEdit;
    EditR: TEdit;
    EditB: TEdit;
    EditRound: TEdit;
    MemoOUT: TMemo;
    EditE: TEdit;
    CheckBoxAccuracy: TCheckBox;
    CheckBoxDetailed: TCheckBox;
    CheckBoxNL: TCheckBox;
    CheckBoxRound: TCheckBox;
    BitBtnOptionsValueVis: TBitBtn;
    BitBtnOptions: TBitBtn;
    BitBtnRun: TBitBtn;
    BitBtnSave: TBitBtn;
    BitBtnMainMenu: TBitBtn;
    ImageMyPicture: TImage;
    SaveDialogTXT: TSaveDialog;
    OpenDialogTXT: TOpenDialog;
    BitBtnLoad: TBitBtn;
    BitBtnClear: TBitBtn;
    procedure CheckBoxAccuracyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtnOptionsValueVisClick(Sender: TObject);
    procedure BitBtnOptionsClick(Sender: TObject);
    procedure BitBtnRunClick(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtnMainMenuClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtnLoadClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGas: TFormGas;
function F(x,High:extended):extended;
implementation

uses Unit2;

{$R *.dfm}

function F(x,High:extended):extended;
begin
  try
   F:=1/(x-High);
  except
   MessageBox(0,'������� ������������ ������','������!',MB_OK+MB_ICONERROR);
  end;
end;

procedure TFormGas.BitBtnRunClick(Sender: TObject);
var
a, B, R, h, p1, Res, xi, fx0, fx1, fx2, S, ResNL, High, e, ResAcc: extended;
Accuracy:integer;
begin
 MemoOut.Clear;
 Self.ActiveControl := nil;
 p1:=1.033*100000;
 A:=0; //������ ������� ���������

 try
 High:=StrToFloat(EditH.Text); // �������� H
 if (High<=0) then
 begin
  MessageBox(handle,'�������� ������ �� ����� ���� ������������� ��� ��������� ����','������!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'������� ������� �������� ������ (H)','������!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 R:=StrToFloat(EditR.Text); // �������� R
 if R<=0 then
 begin
  MessageBox(handle,'�������� ������� �� ����� ���� ������������� ��� ��������� ����','������!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'������� ������� �������� ������� (R)','������!',MB_OK+MB_ICONERROR);
 exit;
 end;

 try
 B:=StrToFloat(EditB.Text); // ������� ������� ��������� (h)
 if (B<=0) or (B>=High) then
  begin
    MessageBox(handle,'1)�������� ���������� �� ����� ���� ������������� ��� ��������� ����. 2)���������� �� ����� ���� ������ ������','������!',MB_OK+MB_ICONERROR);
    exit;
  end;
 except
  MessageBox(handle,'������� ������� �������� ���������� (h)','������!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
  e:=StrToFloat(EditE.Text); // ��������
   if (E<=0) or (E>=1) then
  begin
    MessageBox(handle,'������� ������� �������� ��������. ���������� ��������:(0<E<1)','������!',MB_OK+MB_ICONERROR);
    exit;
  end;
 except
  MessageBox(handle,'������� ������� �������� ��������','������!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 if checkboxRound.checked then
  Accuracy:=StrToint(EditRound.Text)
 else
 begin
  MessageBox(handle,'����� ����� �������� �� ������. �������� �������� ����� � ������� "�������������� ���������"','����������',MB_OK+MB_ICONINFORMATION);
  Accuracy:=0;
 end;
 except
  MessageBox(handle,'������� ������������ �������� ����������','������!',MB_OK+MB_ICONERROR);
  exit;
 end;

 if CheckBoxAccuracy.Checked then
  if (B>2.5) then
   if (B>High*0.4) and (e<0.0000001) or (B>20) then
  begin
    MessageBox(handle,'��� ��������� ��������� �������� � ���������� ����� ������������� ������� �������������� ��������, ��� ����� �������� � �������. ������������� ��������� �������� �������� ��� ����������.','������!',MB_OK+MB_ICONERROR);
    exit;
  end;

 try
 S:=pi*R*R;
 xi:=-p1*High*S;
 if CheckBoxAccuracy.Checked then
  begin
    ResAcc:=MetodSim(a,b,e,high);
  end
 else
  begin
    if (High < B*10) then
     MessageBox(handle,'��� �������� ��������� ��������� ����� ���� � ������������. ������������� ������������ ����� � �������� ��������� (������ �������������� ���������).','��������!',MB_OK+MB_ICONINFORMATION);
    Res:=MetodSimO(a,b,high,0,h,fx0,fx1,fx2);
  end;
 except
  MessageBox(handle,'������� ������������ ������','������!',MB_OK+MB_ICONERROR);
 end;

 if checkboxDetailed.Checked then
 begin
  MemoOut.Lines.Add(' ��������� ��������� ���� pV = const, ��� p - ��������, V - �����.');
  MemoOut.Lines.Add(' �� ��������� ��������� ���������� ���� p*V = p1*v1 (����� �����-��������)');
  MemoOut.Lines.Add(' � ��������� ���������:');
  MemoOut.Lines.Add(' p = p1 = 103,3���');
  MemoOut.Lines.Add(' V = V1 = H*S, ��� S = Pi*R^2 - ������� ������');
  MemoOut.Lines.Add(' �������� ���������� �� ������ p = p1*V1/V');
  MemoOut.Lines.Add(' ��� ���� ����� ���� V = (H-x)*S, ����� x - �������� ������, ������������ �� ���� �� h.');
  MemoOut.Lines.Add(' �������������:');
  MemoOut.Lines.Add(' p = p1*V1/V = p1*H*S /(H-x)*S = p1*H/(H-x)');
  MemoOut.Lines.Add(' ����, ����������� �� ������� F=p*S');
  MemoOut.Lines.Add(' ���������� � ������� ������ ��������� �������� � ������������� ������, � ����������, �������:');
 if not checkboxAccuracy.checked then
  begin
    MemoOut.Lines.Add(' ����������� ������� ��������:');
    MemoOut.Lines.Add(' FX0 = '+FloatToStrF(FX0,fffixed,8,3));
    MemoOut.Lines.Add(' FX1 = '+FloatToStrF(FX1,fffixed,8,3));
    MemoOut.Lines.Add(' FX2 = '+FloatToStrF(FX2,fffixed,8,3));
    MemoOut.Lines.Add(' H = '+FloatToStrF(h,fffixed,8,3));
  end;
 end;

 if checkboxAccuracy.Checked then
  MemoOut.Lines.Add(' ������ ���� = '+FloatToStrF(ResAcc*xi,fffixed,8,Accuracy)+' ��')
 else MemoOut.Lines.Add(' ������ ���� = '+FloatToStrF(Res*xi,fffixed,8,Accuracy)+' ��');

 if CheckboxNL.checked then
 begin
 try
  ResNL:=p1*High*S*ln(High/(High-B));
 except
  MessageBox(handle,'������� ������������ ������','������!',MB_OK+MB_ICONERROR);
 end;
  MemoOut.Lines.Add(' ������ ���� (� �������������� ������ �������-��������) = '+FloatToStrF(ResNL,fffixed,8,Accuracy)+' ��');
 end;
end;

procedure TFormGas.CheckBoxAccuracyClick(Sender: TObject);
begin
 if checkboxAccuracy.Checked then
  begin
   EditE.Visible:=true;
   labelAccurancy.Visible:=true;
  end else
  begin
   EditE.Visible:=false;
   labelAccurancy.Visible:=false;
 end;
end;

procedure TFormGas.FormCreate(Sender: TObject);
begin
 EditE.Visible:=false;
 labelAccurancy.Visible:=false;
 checkboxAccuracy.Visible:=false;
 checkboxDetailed.Visible:=false;
 checkboxNL.Visible:=false;
 bitbtnOptionsValueVis.Visible:=false;
 checkboxRound.Visible:=false;
 EditRound.visible:=false;
 checkboxRound.checked:=true;
 BitBtnRun.Top:=120;
 BitBtnClear.Top:=120;
 MemoOut.Top:=160;
 BitBtnClear.Caption:='��������'+#10#13+'���� �����';
end;

procedure TFormGas.BitBtnOptionsValueVisClick(Sender: TObject);
begin
 checkboxAccuracy.Visible:=false;
 checkboxDetailed.Visible:=false;
 checkboxNL.Visible:=false;
 bitbtnOptionsValueVis.Visible:=false;
 EditE.Visible:=false;
 labelAccurancy.Visible:=false;
 checkboxRound.Visible:=false;
 EditRound.visible:=false;
 BitBtnRun.Top:=120;
 BitBtnClear.Top:=120;
 MemoOut.Top:=160;
 FormGas.Height:=535;
end;

procedure TFormGas.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 If MessageDlg('������� ���� � ��������� � ������� ����?',mtInformation, [mbOk,mbNo], 0)=mrOk Then
  begin
     CanClose:=True; //������ Ok - ��������� �����.
      FormMainMenu.Visible:=true;
      formGas.Visible:=false;
  end
  Else
     CanClose:=False; //������ Cancel - ���������� ��������.
end;

procedure TFormGas.BitBtnOptionsClick(Sender: TObject);
begin
 if CheckboxAccuracy.checked then
  begin
  labelAccurancy.Visible:=true;
  EditE.Visible:=true;
  end;
 checkboxAccuracy.Visible:=true;
 checkboxDetailed.Visible:=true;
 checkboxNL.Visible:=true;
 bitbtnOptionsValueVis.Visible:=true;
 checkboxRound.Visible:=true;
 EditRound.visible:=true;
 BitBtnRun.Top:=264;
 BitBtnClear.Top:=264;
 MemoOut.Top:=304;
 FormGas.Height:=679;
end;

procedure TFormGas.BitBtnSaveClick(Sender: TObject);
var
Ft : TextFile; // ��������� ����
FileNameT:string;
i:integer;
begin
  if SaveDialogTXT.Execute then // ���������� ������������ ������� ������ �����
    begin
      try
      FileNameT:= SaveDialogTXT.FileName; // ����������� ����� ��������� �����
      AssignFile(Ft, FileNameT); // ���������� �������� ���������� Ft c ������ �����
      Rewrite(Ft); // �������� ������ ���������� �����
      for i:=0 to MemoOUT.Lines.Count-1 do
        writeln(Ft,MemoOUT.Lines[i]);
      CloseFile(Ft); // �������� ���������� �����
      except
        MessageBox(handle,'������ ��� ���������� �����.','������!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

procedure TFormGas.BitBtnMainMenuClick(Sender: TObject);
begin
 FormMainMenu.Visible:=true;
 FormGas.Visible:=false;
end;

procedure TFormGas.BitBtnLoadClick(Sender: TObject);
var
Ft : TextFile; // ��������� ����
FileNameT:string;
i:integer;
a,b,c:string;
begin
  if OpenDialogTXT.Execute then // ���������� ������������ ������� ������ �����
    begin
      try
       FileNameT:= OpenDialogTXT.FileName; // ����������� ����� ��������� �����
       AssignFile(Ft, FileNameT); // ���������� �������� ���������� Ft c ������ �����
       Reset(Ft); // �������� ������ ���������� �����
       readln(Ft,a);
       readln(Ft,b);
       readln(Ft,c);
       EditH.Text:=a;
       EditR.Text:=b;
       EditB.Text:=c;
       CloseFile(Ft); // �������� ���������� �����
      except
       MessageBox(handle,'������ ��� ���������� �����.','������!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

procedure TFormGas.BitBtnClearClick(Sender: TObject);
begin
EditR.Text:='';
EditB.Text:='';
EditH.Text:='';
end;

end.
