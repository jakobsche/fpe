unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, SynEdit,
  SynHighlighterPas;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem10: TMenuItem;
    ExitItem: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    NewItem: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    SaveAsItem: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SynEdit: TSynEdit;
    SynPasSyn: TSynPasSyn;
    procedure EditCopyClick(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure ExitItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure NewItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
  private
    FFileName: string;
    procedure SetFileName(Value: string);
  public
    function Save: Boolean;
    function SaveAs: Boolean;
    property FileName: string read FFileName write SetFileName;
  end;

var
  Form1: TForm1;

implementation

uses FormEx;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FormAdjust(Self)
end;

procedure TForm1.ExitItemClick(Sender: TObject);
begin
  Close
end;

procedure TForm1.EditCopyClick(Sender: TObject);
begin
  SynEdit.CopyToClipboard
end;

procedure TForm1.EditCutClick(Sender: TObject);
begin
  SynEdit.CutToClipboard
end;

procedure TForm1.EditPasteClick(Sender: TObject);
begin
  SynEdit.PasteFromClipboard
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  x: string;
begin
  if SynEdit.Modified then begin
    if FileName = '' then x := 'Die Datei'
    else x := FileName;
    case MessageDlg(Format('%s wurde noch nicht gespeichert. Soll sie jetzt gespeichert werden?', [x]),
      mtConfirmation, mbYesNoCancel, 0) of
      mrYes: CanClose := Save;
      mrNo: CanClose := True ;
      mrCancel: CanClose := False;
    end
  end
  else CanClose := True
end;

procedure TForm1.NewItemClick(Sender: TObject);
var
  x: string;
begin
  if SynEdit.Modified then begin
    if FileName = '' then x := 'Die Datei'
    else x := FileName;
    case MessageDlg(Format('%s wurde noch nicht gespeihert. Soll die Datei jetzt gespeichert werden?', [x]),
      mtConfirmation, mbYesNoCancel, 0) of
      mrYes:
        if Save then begin
          SynEdit.Clear;
          FileName := '';
        end;
      mrNo: begin
          SynEdit.Clear;
          FileName := ''
        end;
    end
  end
  else begin
    SynEdit.Clear;
    FileName := ''
  end;
end;

procedure TForm1.OpenItemClick(Sender: TObject);
var
  x: string;
begin
  if SynEdit.Modified then begin
    if FileName = '' then x := 'Die Datei'
    else x := FileName;
    case MessageDlg(Format('%s wurde noch nicht gespeihert. Soll die Datei jetzt gespeichert werden?', [x]),
      mtConfirmation, mbYesNoCancel, 0) of
      mrYes:
        if Save then
          if OpenDialog.Execute then begin
            SynEdit.Lines.LoadFromFile(OpenDialog.FileName);
            FileName := OpenDialog.FileName
          end;
      mrNo:
        if OpenDialog.Execute then begin
          SynEdit.Lines.LoadFromFile(OpenDialog.FileName);
          FileName := OpenDialog.FileName
        end;
    end;
  end
  else begin
      if OpenDialog.Execute then begin
        SynEdit.Lines.LoadFromFile(OpenDialog.FileName);
        FileName := OpenDialog.FileName
      end;
  end;
end;

procedure TForm1.SaveAsItemClick(Sender: TObject);
begin
  SaveAs
end;

procedure TForm1.SaveItemClick(Sender: TObject);
begin
  Save
end;

procedure TForm1.SetFileName(Value: string);
begin
  FFileName := Value;
  if Value <> '' then Caption := Value
  else Caption := 'Free Pascal Editor'
end;

function TForm1.Save: Boolean;
begin
  Result := not SynEdit.Modified;
  if SynEdit.Modified then
    if FileName = '' then Result := SaveAs
    else begin
      SynEdit.Lines.SaveToFile(FileName);
      SynEdit.Modified := False;
      Result := True
    end
end;

function TForm1.SaveAs: Boolean;
begin
  Result := False;
  if SaveDialog.Execute then begin
    SynEdit.Lines.SaveToFile(SaveDialog.FileName);
    FileName := SaveDialog.FileName;
    SynEdit.Modified := False;
    Result := True
  end
end;

end.

