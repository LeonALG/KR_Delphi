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
   MessageBox(0,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
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
 A:=0; //Нижняя граница интеграла

 try
 High:=StrToFloat(EditH.Text); // Значение H
 if (High<=0) then
 begin
  MessageBox(handle,'Значение высоты не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение Высоты (H)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 R:=StrToFloat(EditR.Text); // Значение R
 if R<=0 then
 begin
  MessageBox(handle,'Значение радиуса не может быть отрицательным или равняться нулю','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;
 except
  MessageBox(handle,'Неверно введено значение радиуса (R)','ОШИБКА!',MB_OK+MB_ICONERROR);
 exit;
 end;

 try
 B:=StrToFloat(EditB.Text); // Верхняя граница интеграла (h)
 if (B<=0) or (B>=High) then
  begin
    MessageBox(handle,'1)Значение расстояния не может быть отрицательным или равняться нулю. 2)Расстояние не может быть больше высоты','ОШИБКА!',MB_OK+MB_ICONERROR);
    exit;
  end;
 except
  MessageBox(handle,'Неверно введено значение расстояния (h)','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
  e:=StrToFloat(EditE.Text); // Точность
   if (E<=0) or (E>=1) then
  begin
    MessageBox(handle,'Неверно введено значение точности. Допустимое значение:(0<E<1)','ОШИБКА!',MB_OK+MB_ICONERROR);
    exit;
  end;
 except
  MessageBox(handle,'Неверно введено значение точности','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 try
 if checkboxRound.checked then
  Accuracy:=StrToint(EditRound.Text)
 else
 begin
  MessageBox(handle,'Ответ будет округлен до целого. Изменить значение можно в разделе "Дополнительные настройки"','Информация',MB_OK+MB_ICONINFORMATION);
  Accuracy:=0;
 end;
 except
  MessageBox(handle,'Введено некорректное значение округления','ОШИБКА!',MB_OK+MB_ICONERROR);
  exit;
 end;

 if CheckBoxAccuracy.Checked then
  if (B>2.5) then
   if (B>High*0.4) and (e<0.0000001) or (B>20) then
  begin
    MessageBox(handle,'При введенных значениях точности и расстояния будут задействованы большие вычислительные мощности, что может привести к ошибкам. Рекомендуется уменьшить значение точности или расстояния.','ОШИБКА!',MB_OK+MB_ICONERROR);
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
     MessageBox(handle,'При заданных значениях результат может быть с погрешностью. Рекомендуется использовать метод с заданной точностью (раздел Дополнительные настройки).','Внимание!',MB_OK+MB_ICONINFORMATION);
    Res:=MetodSimO(a,b,high,0,h,fx0,fx1,fx2);
  end;
 except
  MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
 end;

 if checkboxDetailed.Checked then
 begin
  MemoOut.Lines.Add(' Уравнение состояния газа pV = const, где p - давление, V - объем.');
  MemoOut.Lines.Add(' Из уравнения состояния идеального газа p*V = p1*v1 (Закон Бойля-Мариотта)');
  MemoOut.Lines.Add(' В начальном состоянии:');
  MemoOut.Lines.Add(' p = p1 = 103,3кПа');
  MemoOut.Lines.Add(' V = V1 = H*S, где S = Pi*R^2 - площадь поршня');
  MemoOut.Lines.Add(' Давление изменяется по закону p = p1*V1/V');
  MemoOut.Lines.Add(' При этом объем газа V = (H-x)*S, здесь x - смещение поршня, изменяющееся от нуля до h.');
  MemoOut.Lines.Add(' Следовательно:');
  MemoOut.Lines.Add(' p = p1*V1/V = p1*H*S /(H-x)*S = p1*H/(H-x)');
  MemoOut.Lines.Add(' Сила, действующая на поршень F=p*S');
  MemoOut.Lines.Add(' Подставляю в формулу работы выражения давления и дифференциала объема, и интегрируя, получим:');
 if not checkboxAccuracy.checked then
  begin
    MemoOut.Lines.Add(' Интегрируем методом Симпсона:');
    MemoOut.Lines.Add(' FX0 = '+FloatToStrF(FX0,fffixed,8,3));
    MemoOut.Lines.Add(' FX1 = '+FloatToStrF(FX1,fffixed,8,3));
    MemoOut.Lines.Add(' FX2 = '+FloatToStrF(FX2,fffixed,8,3));
    MemoOut.Lines.Add(' H = '+FloatToStrF(h,fffixed,8,3));
  end;
 end;

 if checkboxAccuracy.Checked then
  MemoOut.Lines.Add(' Работа силы = '+FloatToStrF(ResAcc*xi,fffixed,8,Accuracy)+' Дж')
 else MemoOut.Lines.Add(' Работа силы = '+FloatToStrF(Res*xi,fffixed,8,Accuracy)+' Дж');

 if CheckboxNL.checked then
 begin
 try
  ResNL:=p1*High*S*ln(High/(High-B));
 except
  MessageBox(handle,'Введены некорректные данные','ОШИБКА!',MB_OK+MB_ICONERROR);
 end;
  MemoOut.Lines.Add(' Работа силы (с использованием метода Ньютона-Лейбница) = '+FloatToStrF(ResNL,fffixed,8,Accuracy)+' Дж');
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
 BitBtnClear.Caption:='Очистить'+#10#13+'поля ввода';
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
 If MessageDlg('Закрыть окно и вернуться в главное меню?',mtInformation, [mbOk,mbNo], 0)=mrOk Then
  begin
     CanClose:=True; //Нажата Ok - закрываем форму.
      FormMainMenu.Visible:=true;
      formGas.Visible:=false;
  end
  Else
     CanClose:=False; //Нажата Cancel - игнорируем закрытие.
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
      for i:=0 to MemoOUT.Lines.Count-1 do
        writeln(Ft,MemoOUT.Lines[i]);
      CloseFile(Ft); // Закрытие текстового файла
      except
        MessageBox(handle,'Ошибка при сохранении файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
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
       EditH.Text:=a;
       EditR.Text:=b;
       EditB.Text:=c;
       CloseFile(Ft); // Закрытие текстового файла
      except
       MessageBox(handle,'Ошибка при считывании файла.','ОШИБКА!',MB_OK+MB_ICONERROR);
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
