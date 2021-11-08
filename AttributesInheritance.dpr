program AttributesInheritance;

uses
  Vcl.Forms,
  fInterfaceAttributes in 'fInterfaceAttributes.pas' {frmTest},
  uClasses in 'uClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTest, frmTest);
  Application.Run;
end.
