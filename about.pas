unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons, StdCtrls;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    FacebookBtn: TBitBtn;
    MediumBtn: TBitBtn;
    PatreonBtn: TBitBtn;
    ContributorsBtn: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    VersionLabel: TLabel;
    Label3: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ContributorsBtnClick(Sender: TObject);
    procedure FacebookBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MediumBtnClick(Sender: TObject);
    procedure PatreonBtnClick(Sender: TObject);
  private

  public

  end;

var
  AboutBox: TAboutBox;

implementation

uses FormEx, LCLIntf, Global;

{$R *.lfm}

{ TAboutBox }

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  FormAdjust(Self);
  VersionLabel.Caption := Format('Version %s', [Version])
end;

procedure TAboutBox.MediumBtnClick(Sender: TObject);
begin
  OpenDocument('https://medium.com/@jakobsche')
end;

procedure TAboutBox.PatreonBtnClick(Sender: TObject);
begin
  OpenDocument('https://patreon.com/raspberrypirad')
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

procedure TAboutBox.FacebookBtnClick(Sender: TObject);
begin
  OpenDocument('https://facebook.com/raspberrypirad')
end;

end.

