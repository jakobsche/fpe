unit HeadFm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, XMLPropStorage,
  MasterFm, BinPropStorage;

type

  { THeadForm }

  THeadForm = class(TMasterForm)
    procedure FormCreate(Sender: TObject);
  private

  public
    BPS: TAppPropStorage;
  end;

var
  HeadForm: THeadForm;

implementation

uses Streaming2, FileUtil, Unit1;

{$R *.lfm}

{ THeadForm }

procedure THeadForm.FormCreate(Sender: TObject);
begin
  BPS := TAppPropStorage.Create(Self);
  SaveDesktop := True;
  SessionProperties := 'SlaveForms';
  TForm1.Create(Self);
  ShowMessageFmt('%d Slaves', [SlaveCount]);
end;

initialization

RegisterForStreaming(THeadForm);

end.

