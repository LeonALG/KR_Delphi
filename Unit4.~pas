unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls, Buttons;

type
  TFormDam = class(TForm)
    Label3Str: TLabel;
    Label1Str: TLabel;
    Label2Str: TLabel;
    EditA: TEdit;
    EditH: TEdit;
    EditB: TEdit;
    MemoOut: TMemo;
    ImageCap: TImage;
    CheckBoxNL: TCheckBox;
    SpeedButtonOptions: TSpeedButton;
    CheckBoxDetailed: TCheckBox;
    LabelRound: TLabel;
    EditRound: TEdit;
    SpeedButtonRun: TSpeedButton;
    SpeedButtonValueVis: TSpeedButton;
    BitBtnClear: TBitBtn;
    SpeedButtonMainMenu: TSpeedButton;
    SaveDialogTXT: TSaveDialog;
    OpenDialogTXT: TOpenDialog;
    SpeedButtonSave: TSpeedButton;
    SpeedButtonLoad: TSpeedButton;
    ImageDamDetailed: TImage;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButtonRunClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButtonValueVisClick(Sender: TObject);
    procedure SpeedButtonOptionsClick(Sender: TObject);
    procedure BitBtnClearClick(Sender: TObject);
    procedure SpeedButtonMainMenuClick(Sender: TObject);
    procedure SpeedButtonSaveClick(Sender: TObject);
    procedure SpeedButtonLoadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormDam: TFormDam;

function FDam(x,a,b,h:extended):extended;
implementation

uses Unit2;

{$R *.dfm}

function FDam(x,a,b,h:extended):extended;
begin
  try
   FDam:=(h-x)*(x/h*(b-a)+a);
  except
   MessageBox(0,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
  end;
end;

procedure TFormDam.SpeedButtonRunClick(Sender: TObject);
var
g,b,hh,a,h,res,fx0,fx1,fx2,aA,ResNL,p:extended;
Round:integer;
begin
 ImageDamdetailed.Hide;
 ImageCap.Show;
 MemoOut.Clear;
 A:=0;
 try
 aA:=StrToFloat(EditA.Text); // Значение a
 if aA<=0 then
 begin
  MessageBox(handle,'Значение (a) не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение (a)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 hh:=StrToFloat(EditH.Text); // Значение h(Верхняя граница)
  if hh<=0 then
 begin
  MessageBox(handle,'Значение высоты (h) не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение высоты (h)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 b:=StrToFloat(EditB.Text); // Значение b
  if (b<=0) or (aA>=b) then
 begin
  MessageBox(handle,'Значение (b) не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение (b)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 Round:=StrtoInt(EditRound.Text); // Количество знаков после запятой
 except
  MessageBox(handle,'Введено некорректное значение округления','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 g:=9.8;
 p:=1000;
 try
  Res:=MetodSimO(a,hh,b,aA,h,fx0,fx1,fx2) * p * g;
 except
  MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
 end;

 if CheckboxDetailed.Checked then
 begin
  ImageDamdetailed.Show;
  ImageCap.Hide;
  MemoOut.Lines.Add(' Рассмотрим элемент сечения высоты dy, расположенный на уровне y.');
  MemoOut.Lines.Add(' Из пропорции (b-a) / 2h = (x-a) / 2y');
  MemoOut.Lines.Add(' находим среднюю шинирну этого элемента:');
  MemoOut.Lines.Add(' x = y*(b-a)/h + a');
  MemoOut.Lines.Add(' Площадь элементарной трапеции:');
  MemoOut.Lines.Add(' dS = xdy = (y*(b-a)/h + a)dy');
  MemoOut.Lines.Add(' Давление на глубине h-y: ');
  MemoOut.Lines.Add(' p = p(плотность) * g * (h-y)');
  MemoOut.Lines.Add(' Следовательно, сила, действующая на элементарную площадку:');
  MemoOut.Lines.Add(' dF = pdS = p(плотность) * g * (h-y) * (y(b-a)/h + a)dy');
  MemoOut.Lines.Add(' Интегрируем и находим выражение для значения результирующей силы:');
  MemoOut.Lines.Add(' F = pdS = p(плотность) * g * (h-y) * (y(b-a)/h + a)dy, где где нижняя граница 0, а верхняя ' +floattostr(hh));
  MemoOut.Lines.Add(' Интегрируем методом Симпсона:');
  MemoOut.Lines.Add(' FX0 = '+FloatToStrF(FX0,fffixed,8,3));
  MemoOut.Lines.Add(' FX1 = '+FloatToStrF(FX1,fffixed,8,3));
  MemoOut.Lines.Add(' FX2 = '+FloatToStrF(Fx2,fffixed,8,3));
  MemoOut.Lines.Add(' H = '+FloatToStrF(h,fffixed,8,3));
 end;
 MemoOut.Lines.Add(' Сила давления F = ' +FloatToStrF(Res,fffixed,8,Round) +' H');

 if checkboxNL.Checked then
 begin
  try
  ResNL:=p*g*hh*hh*((b+2*Aa)/6);
 except
  MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
 end;
  MemoOut.Lines.Add(' Сила давления F (с использованием метода Ньютона-Лейбница) = '+FloatToStrF(ResNL,fffixed,8,Round)+' H');
 end;
end;

procedure TFormDam.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
If MessageDlg('Закрыть окно и вернуться в главное меню?',mtInformation, [mbOk,mbNo], 0)=mrOk Then
  begin
     CanClose:=True; //Нажата Ok - закрываем форму.
      FormMainMenu.Visible:=true;
      FormDam.Visible:=false;
  end
  Else
     CanClose:=False; //Нажата Cancel - игнорируем закрытие.
end;

procedure TFormDam.FormCreate(Sender: TObject);
begin
 ImageDamdetailed.Hide;
 labelRound.Visible:=false;
 EditRound.Visible:=false;
 checkboxDetailed.Visible:=false;
 checkboxNL.Visible:=false;
 SpeedButtonValueVis.Visible:=false;
 SpeedButtonRun.Top:=104;
 BitBtnClear.Top:=104;
 MemoOut.Top:=144;
 BitBtnClear.Caption:='Очистить'+#10#13+'поля ввода';
end;

procedure TFormDam.SpeedButtonValueVisClick(Sender: TObject);
begin
 labelRound.Visible:=false;
 EditRound.Visible:=false;
 checkboxDetailed.Visible:=false;
 checkboxNL.Visible:=false;
 SpeedButtonValueVis.Visible:=false;
 SpeedButtonRun.Top:=104;
 BitBtnClear.Top:=104;
 MemoOut.Top:=144;
 FormDam.Height:=500;
end;

procedure TFormDam.SpeedButtonOptionsClick(Sender: TObject);
begin
 labelRound.Visible:=true;
 EditRound.Visible:=true;
 checkboxDetailed.Visible:=true;
 checkboxNL.Visible:=true;
 SpeedButtonValueVis.Visible:=true;
 SpeedButtonRun.Top:=200;
 BitBtnClear.Top:=200;
 MemoOut.Top:=240;
 FormDam.Height:=600;
end;

procedure TFormDam.BitBtnClearClick(Sender: TObject);
begin
 EditA.Text:='';
 EditB.Text:='';
 EditH.Text:='';
end;

procedure TFormDam.SpeedButtonMainMenuClick(Sender: TObject);
begin
 FormMainMenu.Visible:=true;
 FormDam.Visible:=false;
end;

procedure TFormDam.SpeedButtonSaveClick(Sender: TObject);
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
      for i:=0 to MemoOut.Lines.Count-1 do
        writeln(Ft,MemoOut.Lines[i]);
      CloseFile(Ft); // Закрытие текстового файла
      except
        MessageBox(handle,'Ошибка при сохранении файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

procedure TFormDam.SpeedButtonLoadClick(Sender: TObject);
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
       EditA.Text:=a;
       EditB.Text:=b;
       EditH.Text:=c;
       CloseFile(Ft); // Закрытие текстового файла
      except
       MessageBox(handle,'Ошибка при считывании файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
      end;
    end;
end;

end.
