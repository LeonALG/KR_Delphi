program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FormSPG},
  Unit2 in 'Unit2.pas' {FormMainMenu},
  Unit3 in 'Unit3.pas' {FormGas},
  Unit4 in 'Unit4.pas' {FormDam};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMainMenu, FormMainMenu);
  Application.Run;
end.
