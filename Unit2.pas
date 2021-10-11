unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TFormMainMenu = class(TForm)
    ButtonSPG: TButton;
    ButtonGas: TButton;
    ButtonDam: TButton;
    LabelMainMenu: TLabel;
    LabelSelection: TLabel;
    LabelSimpson: TLabel;
    ImageCap: TImage;
    Label1Str: TLabel;
    Label2Str: TLabel;
    Label3Str: TLabel;
    LabelH: TLabel;
    LabelR: TLabel;
    LabelB: TLabel;
    LabelKRed: TLabel;
    LabelChange: TLabel;
    LabelSGSPG: TLabel;
    LabelSSPG: TLabel;
    LabelHSPG: TLabel;
    TimerTime: TTimer;
    LabelTime: TLabel;
    LabelData: TLabel;
    LabelDam: TLabel;
    procedure ButtonSPGClick(Sender: TObject);
    procedure ButtonDamClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonGasClick(Sender: TObject);
    procedure ButtonGasMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageCapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ButtonSPGMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure TimerTimeTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonDamMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMainMenu: TFormMainMenu;
function MetodSim(a,b,e,high:extended):extended;
function MetodSimO(a,b,high,aA:extended;var h,fx0,fx1,fx2:extended):extended;
implementation

uses Unit1, Unit3, Unit4;

{$R *.dfm}

function MetodSim(a,b,e,high:extended):extended;
var n, i: integer;
    h, k1, s1, s2: extended;
 begin
 try
n:=2;
s2:=  F(a,High);
repeat
s1:=s2; // Запоминаем текущий интеграл
h:=(B-a)/n;
k1:=a;
for i:=1 to n-1 do
 begin
  k1:=k1+h;
  if i mod 2 = 0 then s2:=s2+2*  F(k1,High)
  else s2:=s2+4*  F(k1,High);
 end;
s2:=(s2+  F(a,High)+  F(B,High))*h/3; //Конечное значение интеграла
n:=n*2;
 //НЕ ЗАБЫТЬ УБРАТЬ! MemoOut.Lines.Add(' S1 = '+FloatToStrF(s1,fffixed,8,6));
 //MemoOut.Lines.Add(' S2 = '+FloatToStrF(s2,fffixed,8,6)+' Дж');
  //MemoOut.Lines.Add(' Разность S1 и S2 '+FloatToStrF(abs(s1-s2),fffixed,8,6));
until abs(s1-s2)<=e
  except
   MessageBox(0,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
   exit;
  end;
  try
   result:=s2;
  except
   MessageBox(0,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
   exit;
  end;
end;

function MetodSimO(a,b,high,aA:extended;var h,fx0,fx1,fx2:extended):extended;
var
SumFX,x0,x1,x2:extended;
Res:extended;
begin
try
  X0:=a;
  X1:=(a+B)/2;
  X2:=B;
  h:=(B-a)/2;

  if  Assigned(FormGas) then
   begin
   if FormGas.Visible=true then
    begin
     FX0:=F(x0,High);
     FX1:=F(x1,High);
     FX2:=F(x2,High);
    end;
   end;

  if  Assigned(FormSPG) then
   begin
   if FormSPG.Visible=true then
    begin
     FX0:=FSPG(x0,High);
     FX1:=FSPG(x1,High);
     FX2:=FSPG(x2,High);
    end;
   end;

   if  Assigned(FormDam) then
   begin
   if FormDam.Visible=true then
    begin
     FX0:=FDam(x0,Aa,High,b);
     FX1:=FDam(x1,Aa,High,b);
     FX2:=FDam(x2,Aa,High,b);
    end;
   end;

  SUMFX:=FX0+4*FX1+FX2;
  Res:=(h/3)*SUMFX;
  Result:=Res;
  except
   showmessage('Невозможно произвести вычисления при введенных данных');
   exit;
  end;
end;

procedure TFormMainMenu.ButtonSPGClick(Sender: TObject);
begin
if (not Assigned(FormSPG)) then   // проверка существования Формы (если нет, то
       FormSPG:=TFormSPG.Create(Self);    // создание Формы)
   FormSPG.Visible:=true;
   FormSPG.Height:=476;
   FormMainMenu.Visible:=false;
end;

procedure TFormMainMenu.ButtonGasClick(Sender: TObject);
begin
 if (not Assigned(FormGas)) then   // проверка существования Формы (если нет, то
       FormGas:=TFormGas.Create(Self);    // создание Формы)
   FormGas.Visible:=true; // (или Form2.ShowModal) показ Формы
   FormGas.Height:=535;
   FormMainMenu.Visible:=false;
end;

procedure TFormMainMenu.ButtonDamClick(Sender: TObject);
begin
  if (not Assigned(FormDam)) then   // проверка существования Формы (если нет, то
       FormDam:=TFormDam.Create(Self);    // создание Формы)
   FormDam.Visible:=true; // (или Form2.ShowModal) показ Формы
   FormDam.Height:=500;
   FormMainMenu.Visible:=false;
end;

procedure TFormMainMenu.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
If MessageDlg('Закрыть приложение и все открытые окна?',mtInformation, [mbOk,mbNo], 0)=mrOk Then
     CanClose:=True //Нажата Ok - закрываем форму.
  Else
     CanClose:=False; //Нажата Cancel - игнорируем закрытие.
end;

procedure TFormMainMenu.ButtonGasMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  labelTime.Top:=236;
  labelData.Top:=208;
  label1Str.Caption:='Цилиндр высотой               и радиусом              , наполненный газом под атмосферным давлением (103,3 кПа), ';
  label2Str.Caption:='закрыт поршнем. Считая газ идеальным, определить работу, затрачиваемую на изотермическое сжатие газа';
  label3Str.Caption:='при перемещении поршня на расстояние               внутри цилиндра.';
  label1Str.show;
  label2Str.show;
  label3Str.show;
  labelH.show;
  labelR.show;
  labelB.show;
  labelKRed.show;
  labelChange.show;
  labelSSPG.Hide;
  labelHSPG.Hide;
  labelSGSPG.Hide;
  labelDam.hide;
end;

procedure TFormMainMenu.ImageCapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  labelTime.Top:=320;
  labelData.Top:=292;
  label1Str.Hide;
  label2Str.Hide;
  label3Str.Hide;
  labelH.Hide;
  labelR.Hide;
  labelB.Hide;
  labelDam.hide;
  labelKRed.Hide;
  labelChange.Hide;
  labelSSPG.Hide;
  labelHSPG.Hide;
  labelSGSPG.Hide;
end;

procedure TFormMainMenu.ButtonSPGMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  labelTime.Top:=236;
  labelData.Top:=208;
  labelH.Hide;
  labelR.Hide;
  labelB.Hide;
  labelDam.hide;
  labelSSPG.Show;
  labelHSPG.Show;
  labelSGSPG.Show;
  label1Str.Caption:='Сжатие S винтовой пружины пропорционально приложенной силе F.';
  label2Str.Caption:='Вычислить работу силы F  при сжатии пружины на           ,';
  label3Str.Caption:='если для сжатия ее на          нужна сила в        .';
  label1Str.show;
  label2Str.show;
  label3Str.show;
  labelKRed.show;
  labelChange.show;
end;

procedure TFormMainMenu.TimerTimeTimer(Sender: TObject);
begin
labelTime.caption:='Время ' + TimetoStr(Time);
end;

procedure TFormMainMenu.FormCreate(Sender: TObject);
begin
  labelTime.Caption:='Время '+ TimetoStr(Time);
  labelData.Caption:='Дата ' + DateToStr(Date);
  labelTime.Top:=320;
  labelData.Top:=292;
  label1Str.Hide;
  label2Str.Hide;
  label3Str.Hide;
  labelH.Hide;
  labelR.Hide;
  labelB.Hide;
  labelDam.hide;
  labelKRed.Hide;
  labelChange.Hide;
  labelSSPG.Hide;
  labelHSPG.Hide;
  labelSGSPG.Hide;
end;

procedure TFormMainMenu.ButtonDamMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
 labelTime.Top:=236;
  labelData.Top:=208;
  labelH.Hide;
  labelR.Hide;
  labelB.Hide;
  labelSSPG.Hide;
  labelHSPG.Hide;
  labelSGSPG.Hide;
  label1Str.Caption:='Вычислить силу, с которой вода давит на плотину, сечение которой имеет форму равнобочной трапеции.';
  label2Str.Caption:='Плотность воды (p = 1000 кг/м^3). Ускорение свободного падения (g = 9.8 м/c^2).';
  labelDam.left:=8;
  labelDam.show;
  label1Str.show;
  label2Str.show;
  label3Str.hide;
  labelKRed.show;
  labelChange.show;
end;

end.
