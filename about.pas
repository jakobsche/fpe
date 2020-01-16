unit About;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Buttons;

type

  { TAboutBox }

  TAboutBox = class(TForm)
    BitBtn1: TBitBtn;
  private

  public

  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.lfm}

end.

