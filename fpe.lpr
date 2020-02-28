program fpe;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  About, Forms, Unit1, lclpatch, HeadFm, Streaming2, MasterFm;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(THeadForm, HeadForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.

