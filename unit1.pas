unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, SynEdit,
  SynHighlighterPas, SynHighlighterJScript, SynHighlighterXML,
  SynEditHighlighterFoldBase, SynHighlighterHTML;

type

  { THighlighterData }

  THighlighterData = class(TComponent)
  private
    FHighlighter: TSynCustomFoldHighlighter;
    FMenuItem: TMenuItem;
    procedure SetHighlighter(AValue: TSynCustomFoldHighlighter);
    procedure SetMenuItem(AValue: TMenuItem);
  public

  published
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property Highlighter: TSynCustomFoldHighlighter read FHighlighter write SetHighlighter;
  end;

  { THighlighterSwitch }

  THighlighterSwitch = class(TComponent)
  private
    FIL: TList;
    function GetItemList: TList;
  private
    FSaveDialog: TSaveDialog;
    FSynEdit: TSynEdit;
    function GetItemCount: Integer;
    function GetItems(AnIndex: Integer): THighlighterData; overload;
    procedure SetSaveDialog(AValue: TSaveDialog);
    procedure SetSynEdit(AValue: TSynEdit);
    property ItemList: TList read GetItemList;
  public
    destructor Destroy; override;
    procedure AddItem(AnItem: TMenuItem; AHighlighter: TSynCustomFoldHighlighter);
    function GetItems(AnItem: TMenuItem): THighlighterData; overload;
    procedure Switch(AnItem: TMenuItem); overload;
    procedure Switch(AnIndex: Integer); overload;
    property ItemCount: Integer read GetItemCount;
    property Items[AnIndex: Integer]: THighlighterData read GetItems;
    property SaveDialog: TSaveDialog read FSaveDialog write SetSaveDialog;
    property SynEdit: TSynEdit read FSynEdit write SetSynEdit;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    ExitItem: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    HelpAbout: TMenuItem;
    MenuItem24: TMenuItem;
    ViewHTML: TMenuItem;
    SynHTMLSyn: TSynHTMLSyn;
    ViewXML: TMenuItem;
    SynXMLSyn: TSynXMLSyn;
    ViewPas: TMenuItem;
    ViewJS: TMenuItem;
    N1: TMenuItem;
    SynJScriptSyn: TSynJScriptSyn;
    ViewPhoto: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
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
    procedure HelpAboutClick(Sender: TObject);
    procedure NewItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure ViewSynClick(Sender: TObject);
    procedure ViewPasClick(Sender: TObject);
    procedure ViewPhotoClick(Sender: TObject);
    procedure ViewXMLClick(Sender: TObject);
  private
    FFileName: string;
    procedure SetFileName(Value: string);
  public
    HLSwitch: THighlighterSwitch;
    function Save: Boolean;
    function SaveAs: Boolean;
    property FileName: string read FFileName write SetFileName;
  end;

var
  Form1: TForm1;

implementation

uses About, FormEx;

{$R *.lfm}

{ THighlighterSwitch }

function THighlighterSwitch.GetItemList: TList;
begin
  if not Assigned(FIL) then FIL := TList.Create;
  Result := FIL
end;

function THighlighterSwitch.GetItems(AnIndex: Integer): THighlighterData;
begin
  Pointer(Result) := ItemList[AnIndex]
end;

procedure THighlighterSwitch.SetSaveDialog(AValue: TSaveDialog);
begin
  if FSaveDialog = AValue then Exit;
  if Assigned(FSaveDialog) then RemoveFreeNotification(FSaveDialog);
  FSaveDialog := AValue;
  if Assigned(AValue) then FreeNotification(AValue)
end;

function THighlighterSwitch.GetItemCount: Integer;
begin
  Result := ItemList.Count
end;

procedure THighlighterSwitch.SetSynEdit(AValue: TSynEdit);
begin
  if FSynEdit = AValue then Exit;
  if Assigned(FSynEdit) then RemoveFreeNotification(FSynEdit);
  FSynEdit := AValue;
  if Assigned(AValue) then FreeNotification(AValue);
end;

destructor THighlighterSwitch.Destroy;
begin
  FIL.Free;
  inherited Destroy;
end;

function THighlighterSwitch.GetItems(AnItem: TMenuItem): THighlighterData;
var
  i: Integer;
begin
  for i := 0 to ItemCount - 1 do
    if Items[i].MenuItem = AnItem then begin
      Result := Items[i];
      Exit
    end;
  Result := nil
end;

procedure THighlighterSwitch.AddItem(AnItem: TMenuItem;
  AHighlighter: TSynCustomFoldHighlighter);
var
  HD: THighlighterData;
begin
  HD := THighlighterData.Create(Self);
  HD.MenuItem := AnItem;
  HD.Highlighter := AHighLighter;
  ItemList.Add(HD)
end;

procedure THighlighterSwitch.Switch(AnItem: TMenuItem);
var
  i: Integer;
begin
  for i := 0 to ItemCount - 1 do
    if Items[i].MenuItem = AnItem then begin
      Switch(i);
      Exit
    end;
end;

procedure THighlighterSwitch.Switch(AnIndex: Integer);
var
  i: Integer;
begin
  if Assigned(SynEdit) then SynEdit.HighLighter := Items[AnIndex].Highlighter;
  if Assigned(SaveDialog) then SaveDialog.Filter := Items[AnIndex].Highlighter.DefaultFilter;
  for i := 0 to ItemCount - 1 do
    Items[i].MenuItem.Checked := i = AnIndex
end;

{ THighliterData }

procedure THighlighterData.SetHighlighter(AValue: TSynCustomFoldHighlighter);
begin
  if FHighlighter = AValue then Exit;
  if Assigned(FHighlighter) then RemoveFreeNotification(FHighlighter);
  FHighlighter := AValue;
  if Assigned(AValue) then FreeNotification(AValue)
end;

procedure THighlighterData.SetMenuItem(AValue: TMenuItem);
begin
  if FMenuItem = AValue then Exit;
  if Assigned(FMenuItem) then RemoveFreeNotification(FMenuItem);
  FMenuItem := AValue;
  if Assigned(AValue) then FreeNotification(AValue)
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  FormAdjust(Self);
  HLSwitch := THighlighterSwitch.Create(Self);
  HLSwitch.SynEdit := SynEdit;
  HLSwitch.SaveDialog := SaveDialog;
  with HLSwitch do begin
    AddItem(ViewJS, SynJScriptSyn);
    AddItem(ViewPas, SynPasSyn);
    AddItem(ViewXML, SynXMLSyn);
    AddItem(ViewHTML, SynHTMLSyn);
    Switch(ViewPas)
  end;
end;

procedure TForm1.HelpAboutClick(Sender: TObject);
begin
  AboutBox.ShowModal
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

procedure TForm1.ViewSynClick(Sender: TObject);
begin
  HLSwitch.Switch(Sender as TMenuItem)
end;

procedure TForm1.ViewPasClick(Sender: TObject);
begin
  SynEdit.Highlighter := SynPasSyn;
  SaveDialog.Filter := SynPasSyn.DefaultFilter;
  ViewPas.Checked := True;
  ViewJS.Checked := False;
  ViewXML.Checked := False;
end;

procedure TForm1.ViewPhotoClick(Sender: TObject);
var
  Bitmap: TBitmap;
begin
  Bitmap := GetFormImage;
  try
    SaveDialog.FileName := Name + '.bmp';
    if SaveDialog.Execute then Bitmap.SaveToFile(SaveDialog.FileName)
  finally
    Bitmap.Free
  end;
end;

procedure TForm1.ViewXMLClick(Sender: TObject);
begin
  SynEdit.Highlighter := SynXMLSyn;
  SaveDialog.Filter := SynXMLSyn.DefaultFilter;
  ViewXML.Checked := True;
  ViewPas.Checked := False;
  ViewJS.Checked := False;
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

