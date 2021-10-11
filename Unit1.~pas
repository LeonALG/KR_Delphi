unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, jpeg;

type
  TFormSPG = class(TForm)
    MemoOutput: TMemo;
    Label1Str: TLabel;
    Label2Str: TLabel;
    Label3Str: TLabel;
    EditS: TEdit;
    EditX: TEdit;
    EditF: TEdit;
    EditRounding: TEdit;
    LabelRound: TLabel;
    BitBtnOptions: TBitBtn;
    CheckBoxDetailed: TCheckBox;
    CheckBoxNL: TCheckBox;
    SpeedButtonRun: TSpeedButton;
    CheckBoxPower: TCheckBox;
    LabeledEditTime: TLabeledEdit;
    SpeedButtonValueVis: TSpeedButton;
    BitBtnClear: TBitBtn;
    ImageCap: TImage;
    SpeedButtonMainMenu: TSpeedButton;
    OpenDialogTXT: TOpenDialog;
    SaveDialogTXT: TSaveDialog;
    SpeedButtonSave: TSpeedButton;
    SpeedButtonLoad: TSpeedButton;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButtonRunClick(Sender: TObject);
    procedure BitBtnOptionsClick(Sender: TObject);
    procedure CheckBoxPowerClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonValueVisClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure SpeedButtonMainMenuClick(Sender: TObject);
    procedure SpeedButtonLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSPG: TFormSPG;
  function FSPG(x,k:extended):extended;
implementation

uses Unit2;

{$R *.dfm}

function FSPG(x,k:extended):extended;
begin
  try
   FSPG:=k*x;
  except
   MessageBox(0,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
  end;
end;

procedure TFormSPG.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
If MessageDlg('Закрыть окно и вернуться в главное меню?',mtInformation, [mbOk,mbNo], 0)=mrOk Then
  begin
     CanClose:=True; //Нажата Ok - закрываем форму.
     FormMainMenu.Visible:=true;
     FormSPG.Visible:=false;
  end
  Else
     CanClose:=False; //Нажата Cancel - игнорируем закрытие.
end;

procedure TFormSPG.SpeedButtonRunClick(Sender: TObject);
var  a, S, h, Res, ResNL, fx0, fx1, fx2, F, x, k, Power: extended;
Round,Time:integer;
begin
 MemoOutput.Clear;

 A:=0;

 try
  S:=StrToFloat(EditS.Text)*0.01; // Считываем значение S
  if S<=0 then
 begin
  MessageBox(handle,'Значение сжатия (S) не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значения сжатия пружины (S)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
  Round:=StrToInt(EditRounding.Text); // Считываем значение A
 except
  MessageBox(handle,'Неверно введено значение округления','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 F:=StrToFloat(EditF.Text); // Считываем значение F
 except
  MessageBox(handle,'Неверно введено значение силы (F)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 x:=StrToFloat(EditX.Text)*0.01; // Считываем значение x
 if x>S then
 begin
  MessageBox(handle,'Степень сжатия пружины не может быть больше сжатия пружины (x)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение степени сжатия пружины (x)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 Time:=Strtoint(LabeledEditTime.Text);
 if Time<=0 then
 begin
  MessageBox(handle,'Время не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение времени','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 k:=F/x;
 Res:=MetodSimO(a,S,k,0,h,fx0,fx1,fx2);
 except
  MessageBox(handle,'Невозможно определить работу при введенных данных','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 if CheckboxDetailed.checked then
 begin
  MemoOutput.Lines.Add(' Сила F и перемещение S связаны по условию зависимостью F=kx, где k - постоянная(коэф. упругости)');
  MemoOutput.Lines.Add(' Будем выражать x в метрах.');
  MemoOutput.Lines.Add(' При x = '+floattostr(x));
  MemoOutput.Lines.Add(' Сила F будет = '+EditF.Text);
  MemoOutput.Lines.Add(' Таким образом: ');
  MemoOutput.Lines.Add(' k = '+floattostr(k));
  MemoOutput.Lines.Add(' F = '+floattostr(k)+'*S');
  MemoOutput.Lines.Add(' Вычислим работу через интеграл.');
  MemoOutput.Lines.Add(' A = F(x)dx, где нижняя граница 0, а верхняя ' +floattostr(S));
  MemoOutput.Lines.Add(' F(x) = '+floattostr(k)+'*S');
  MemoOutput.Lines.Add(' Интегрируем методом Симпсона:');
  MemoOutput.Lines.Add(' FX0 = '+FloatToStrF(Fx0,fffixed,8,4));
  MemoOutput.Lines.Add(' FX1 = '+FloatToStrF(Fx1,fffixed,8,4));
  MemoOutput.Lines.Add(' FX2 = '+FloatToStrF(Fx2,fffixed,8,4));
  MemoOutput.Lines.Add(' H = '+FloatToStrF(h,fffixed,8,4));
  MemoOutput.Lines.Add(' Сила сжатия пружины F= '+floattostr(F));
 end;
 MemoOutput.Lines.Add(' Работа сила F = '+FloatToStrF(Res,fffixed,8,Round)+' Дж');
 if CheckboxNL.checked then
 begin
 try
  ResNL:=k*S*S/2;
 except
  MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
 end;
  MemoOutput.Lines.Add(' Работа силы F (с использованием метода Ньютона-Лейбница) = '+FloatToStrF(ResNL,fffixed,8,Round)+' Дж');
 end;
 if CheckboxPower.checked then
 begin
  try
   Power:= Res/Time;
  except
   MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
  end;
  MemoOutput.Lines.Add(' Мощность силы F = '+FloatToStrF(Power,fffixed,8,Round)+' Вт');
 end;

end;
procedure TFormSPG.BitBtnOptionsClick(Sender: TObject);
begin
 CheckBoxDetailed.Visible:=true;
 CheckBoxNL.Visible:=true;
 CheckBoxPower.Visible:=true;
 LabelRound.Visible:=true;
 EditRounding.Visible:=true;
 if CheckBoxPower.Checked then
  LabeledEditTime.Visible:=true;
  SpeedButtonValueVis.Visible:=true;
 SpeedButtonRun.Top:=196;
 BitBtnClear.Top:=196;
 MemoOutput.Top:=236;
 FormSPG.Height:=572;
end;

procedure TFormSPG.CheckBoxPowerClick(Sender: TObject);
begin
  if CheckBoxPower.Checked then
   LabeledEditTime.Visible:=true
  else LabeledEditTime.Visible:=false;
end;

procedure TFormSPG.FormCreate(Sender: TObject);
begin
 CheckBoxDetailed.Visible:=false;
 CheckBoxNL.Visible:=false;
 CheckBoxPower.Visible:=false;
 LabelRound.Visible:=false;
 EditRounding.Visible:=false;
 LabeledEditTime.Visible:=false;
 SpeedButtonValueVis.Visible:=false;
 SpeedButtonRun.Top:=88;
 BitBtnClear.Top:=88;
 MemoOutput.Top:=128;
 BitBtnClear.Caption:='Очистить'+#10#13+'поля ввода';
end;

procedure TFormSPG.SpeedButtonValueVisClick(Sender: TObject);
begin
 CheckBoxDetailed.Visible:=false;
 CheckBoxNL.Visible:=false;
 CheckBoxPower.Visible:=false;
 LabelRound.Visible:=false;
 EditRounding.Visible:=false;
 LabeledEditTime.Visible:=false;
 SpeedButtonValueVis.Visible:=false;
 SpeedButtonRun.Top:=88;
 BitBtnClear.Top:=88;
 MemoOutput.Top:=128;
 FormSPG.Height:=464;
end;

procedure TFormSPG.BitBtnClearClick(Sender: TObject);
begin
EditX.Clear;
EditS.Clear;
EditF.Clear;
end;

procedure TFormSPG.SpeedButtonSaveClick(Sender: TObject);
var
Ft : TextFile; // Текстовой файл
FileNameT:string;
i:integer;
begin
  if SaveDialogTXT.Execute then // Выполнение стандартного диалога выбора имени
    begin
      try
      FileNameT:= SaveDialogTXT.FileName; // Возвращение имени дискового файла
      AssignFile(Ft, FileNameT); // Связывание файловой переменной Ft c именем файла
      Rewrite(Ft); // Открытие нового текстового файла
      for i:=0 to MemoOutput.Lines.Count-1 do
        writeln(Ft,MemoOutput.Lines[i]);
      CloseFile(Ft); // Закрытие текстового файла
      except
        MessageBox(handle,'Ошибка при сохранении файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

procedure TFormSPG.SpeedButtonMainMenuClick(Sender: TObject);
begin
 FormMainMenu.Visible:=true;
 FormSPG.Visible:=false;
end;

procedure TFormSPG.SpeedButtonLoadClick(Sender: TObject);
var
Ft : TextFile; // Текстовой файл
FileNameT:string;
i:integer;
a,b,c:string;
begin
  if OpenDialogTXT.Execute then // Выполнение стандартного диалога выбора имени
    begin
      try
       FileNameT:= OpenDialogTXT.FileName; // Возвращение имени дискового файла
       AssignFile(Ft, FileNameT); // Связывание файловой переменной Ft c именем файла
       Reset(Ft); // Открытие нового текстового файла
       readln(Ft,a);
       readln(Ft,b);
       readln(Ft,c);
       EditS.Text:=a;
       EditX.Text:=b;
       EditF.Text:=c;
       CloseFile(Ft); // Закрытие текстового файла
      except
       MessageBox(handle,'Ошибка при считывании файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

end.
