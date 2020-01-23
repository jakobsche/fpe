unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls,
  LazHelpHTML;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    ContributorsBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ContributorsBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  AboutBox: TAboutBox;

implementation

uses FormEx, LCLIntf;

{$R *.lfm}

{ TAboutBox }

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  FormAdjust(Self)
end;

procedure TAboutBox.BitBtn2Click(Sender: TObject);
begin
  OpenDocument('mailto:messages@jakobsche.de');
end;

procedure TAboutBox.BitBtn3Click(Sender: TObject);
begin
  OpenDocument('https://t.me/jakobsche')
end;

procedure TAboutBox.BitBtn4Click(Sender: TObject);
begin
  OpenDocument('https://github.com/jakobsche/fpe')
end;

procedure TAboutBox.ContributorsBtnClick(Sender: TObject);
begin
  ContributorsBtn.ShowHelp
end;

end.

