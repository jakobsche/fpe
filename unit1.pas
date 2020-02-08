unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, LazHelpHTML,
  ExtCtrls, ComCtrls, SynEdit, SynHighlighterPas, SynHighlighterJScript,
  SynHighlighterXML, SynHighlighterHTML, SynHighlighterMulti,
  SynEditHighlighter, SynHighlighterCpp, SynCompletion, SynHighlighterLFM,
  SynHighlighterAny, PrintersDlgs, SynEditTypes, SynMakeSyn;

type

  { THighlighterData }

  THighlighterData = class(TComponent)
  private
    FHighlighter: TSynCustomHighLighter;
    FMenuItem: TMenuItem;
    procedure SetHighlighter(AValue: TSynCustomHighLighter);
    procedure SetMenuItem(AValue: TMenuItem);
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
  public

  published
    property MenuItem: TMenuItem read FMenuItem write SetMenuItem;
    property Highlighter: TSynCustomHighLighter read FHighlighter write SetHighlighter;
  end;

  { THighlighterSwitch }

  THighlighterSwitch = class(TComponent)
  private
    FIL: TList;
    FItemIndex: Integer;
    function GetItemList: TList;
    procedure ReadItems(Reader: TReader);
    procedure WriteItems(Writer: TWriter);
  private
    FSaveDialog: TSaveDialog;
    FSynEdit: TSynEdit;
    function GetItemCount: Integer;
    function GetItems(AnIndex: Integer): THighlighterData; overload;
    procedure SetSaveDialog(AValue: TSaveDialog);
    procedure SetSynEdit(AValue: TSynEdit);
    property ItemList: TList read GetItemList;
  protected
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure DefineProperties(Filer: TFiler); override;
  public
    destructor Destroy; override;
    procedure AddItem(AnItem: TMenuItem; AHighlighter: TSynCustomHighLighter);
    function GetItems(AnItem: TMenuItem): THighlighterData; overload;
    procedure Switch(AnItem: TMenuItem); overload;
    procedure Switch(AnIndex: Integer); overload;
    property ItemCount: Integer read GetItemCount;
    property Items[AnIndex: Integer]: THighlighterData read GetItems;
  published
    property ItemIndex: Integer read FItemIndex write FItemIndex;
    property SaveDialog: TSaveDialog read FSaveDialog write SetSaveDialog;
    property SynEdit: TSynEdit read FSynEdit write SetSynEdit;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    FontDialog: TFontDialog;
    HTMLBrowserHelpViewer: THTMLBrowserHelpViewer;
    HTMLHelpDatabase: THTMLHelpDatabase;
    MainMenu: TMainMenu;
    HelpMenu: TMenuItem;
    MenuItem1: TMenuItem;
    ViewMakefile: TMenuItem;
    ViewFreePascal: TMenuItem;
    PrintDialog: TPrintDialog;
    StatusBar: TStatusBar;
    SynCompletion: TSynCompletion;
    SynFreePascalSyn: TSynFreePascalSyn;
    SynLFmSyn: TSynLFMSyn;
    ViewLFm: TMenuItem;
    N1: TMenuItem;
    MenuItem10: TMenuItem;
    FileExit: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    EditCut: TMenuItem;
    EditCopy: TMenuItem;
    EditPaste: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    HelpLicense: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    FileMenu: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    HelpAbout: TMenuItem;
    PrinterSetupDialog: TPrinterSetupDialog;
    ViewMenu: TMenuItem;
    FileClose: TMenuItem;
    FormsMenu: TMenuItem;
    FormsNew: TMenuItem;
    FormsTile: TMenuItem;
    FormsCascade: TMenuItem;
    FormsAdjust: TMenuItem;
    MenuItem31: TMenuItem;
    FormsHide: TMenuItem;
    FormsShow: TMenuItem;
    SynCppSyn: TSynCppSyn;
    SynMultiSyn: TSynMultiSyn;
    ViewMulti: TMenuItem;
    ViewCpp: TMenuItem;
    ViewText: TMenuItem;
    ViewHTML: TMenuItem;
    SynHTMLSyn: TSynHTMLSyn;
    ViewXML: TMenuItem;
    SynXMLSyn: TSynXMLSyn;
    ViewPas: TMenuItem;
    ViewJS: TMenuItem;
    SynJScriptSyn: TSynJScriptSyn;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    EditMenu: TMenuItem;
    MenuItem6: TMenuItem;
    NewItem: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    SaveAsItem: TMenuItem;
    MenuItem7: TMenuItem;
    FilePrint: TMenuItem;
    FilePrinterSetup: TMenuItem;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    SynEdit: TSynEdit;
    SynPasSyn: TSynPasSyn;
    procedure EditCopyClick(Sender: TObject);
    procedure EditCutClick(Sender: TObject);
    procedure EditPasteClick(Sender: TObject);
    procedure FileExitClick(Sender: TObject);
    procedure FileCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure FormsAdjustClick(Sender: TObject);
    procedure FormsCascadeClick(Sender: TObject);
    procedure FormsNewClick(Sender: TObject);
    procedure FormsShowClick(Sender: TObject);
    procedure FormsTileClick(Sender: TObject);
    procedure HelpAboutClick(Sender: TObject);
    procedure FilePrintClick(Sender: TObject);
    procedure FilePrinterSetupClick(Sender: TObject);
    procedure HelpLicenseClick(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure FormsHideClick(Sender: TObject);
    procedure NewItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure SynEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure ViewSynClick(Sender: TObject);
  private
    FFileName: string;
    procedure SetFileName(Value: string);
  public
    HLSwitch: THighlighterSwitch;
    SynMakeSyn: TSynMakefileSyn;
    function GetConfigFileName: string;
    procedure OpenFile(AFileName: string);
    function Save: Boolean;
    function SaveAs: Boolean;
    function GuessHighlighter: TSynCustomHighLighter;
    procedure PrintTestPage;
  published
    property FileName: string read FFileName write SetFileName;
  end;

var
  Form1: TForm1;

implementation

uses About, FormEx, HeadFm, LCLIntf, Patch, Printers, Types;

{$R *.lfm}

{ THighlighterSwitch }

function THighlighterSwitch.GetItemList: TList;
begin
  if not Assigned(FIL) then FIL := TList.Create;
  Result := FIL
end;

procedure THighlighterSwitch.ReadItems(Reader: TReader);
begin
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    ItemList.Add(Reader.ReadComponent(THighlighterData.Create(Self)));
  Reader.ReadListEnd;
end;

procedure THighlighterSwitch.WriteItems(Writer: TWriter);
var
  i: Integer;
begin
  Writer.WriteListBegin;
  for i := 0 to ItemCount - 1 do  Writer.WriteComponent(Items[i]);
  Writer.WriteListEnd;
end;

function THighlighterSwitch.GetItems(AnIndex: Integer): THighlighterData;
begin
  Pointer(Result) := ItemList[AnIndex]
end;

procedure THighlighterSwitch.SetSaveDialog(AValue: TSaveDialog);
begin
  if FSaveDialog = AValue then Exit;
  FSaveDialog := AValue;
  if Assigned(AValue) then AValue.FreeNotification(Self)
end;

function THighlighterSwitch.GetItemCount: Integer;
begin
  Result := ItemList.Count
end;

procedure THighlighterSwitch.SetSynEdit(AValue: TSynEdit);
begin
  if FSynEdit = AValue then Exit;
  FSynEdit := AValue;
  if Assigned(AValue) then AValue.FreeNotification(Self);
end;

procedure THighlighterSwitch.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Assigned(AComponent) then
    case Operation of
      opRemove: if AComponent = FSynEdit then FSynEdit := nil
          else if AComponent = FSaveDialog then FSaveDialog := nil;
    end;
end;

procedure THighlighterSwitch.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('Items', @ReadItems, @WriteItems, ItemCount > 0)
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
  AHighlighter: TSynCustomHighLighter);
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
  if Assigned(Items[AnIndex].Highlighter) then
    if Assigned(SaveDialog) then SaveDialog.Filter := Items[AnIndex].Highlighter.DefaultFilter;
  for i := 0 to ItemCount - 1 do
    if i = AnIndex then begin
      Items[i].MenuItem.Checked := True;
      ItemIndex := i
    end
    else Items[i].MenuItem.Checked := False;
end;

{ THighliterData }

procedure THighlighterData.SetHighlighter(AValue: TSynCustomHighLighter);
begin
  if FHighlighter = AValue then Exit;
  FHighlighter := AValue;
  if Assigned(AValue) then FreeNotification(AValue)
end;

procedure THighlighterData.SetMenuItem(AValue: TMenuItem);
begin
  if FMenuItem = AValue then Exit;
  FMenuItem := AValue;
  if Assigned(AValue) then FreeNotification(AValue)
end;

procedure THighlighterData.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if AComponent <> nil then
    case Operation of
      opRemove:
        if AComponent = FHighlighter then FHighLighter := nil
        else if AComponent = FMenuItem then FMenuItem := nil;
    end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  i, SlaveIndex: Integer;
  F: TForm1;
begin
  SynMakeSyn := TSynMakefileSyn.Create(Self);
  FormAdjust(Self);
  HLSwitch := THighlighterSwitch.Create(Self);
  HLSwitch.SynEdit := SynEdit;
  HLSwitch.SaveDialog := SaveDialog;
  with HLSwitch do begin
    AddItem(ViewJS, SynJScriptSyn);
    AddItem(ViewPas, SynPasSyn);
    AddItem(ViewXML, SynXMLSyn);
    AddItem(ViewHTML, SynHTMLSyn);
    AddItem(ViewMulti, SynMultiSyn);
    AddItem(ViewCpp, SynCppSyn);
    AddItem(ViewText, nil);
    AddItem(ViewLFm, SynLFmSyn);
    AddItem(ViewFreePascal, SynFreePascalSyn);
    AddItem(ViewMakefile, SynMakeSyn);
    Switch(ViewFreePascal)
  end;
  with HTMLHelpDataBase do begin
    {$ifdef Darwin}
      BaseURL := 'file://' + ExtractFilePath(Application.ExeName) + 'help'
    {$else}
      {$ifndef Unix}
        BaseURL := ExtractFilePath(Application.ExeName) + 'help'
      {$endif}
    {$endif}
  end;
  SlaveIndex := HeadForm.AddSlave(Sender as TForm1);
  if SlaveIndex = 0 then begin
    if Application.ParamCount > 0 then
      if FileExists(Application.Params[1]) then begin
        SynEdit.Lines.LoadFromFile(Application.Params[1]);
        FileName := Application.Params[1]
      end;
    for i := 2 to Application.ParamCount do
      if FileExists(Application.Params[i]) then begin
        F := TForm1.Create(Application);
        F.SynEdit.Lines.LoadFromFile(Application.Params[i]);
        F.FileName := Application.Params[i];
        HeadForm.AddSlave(F)
      end;
  end;
  HeadForm.SendToBack;
  HeadForm.Hide
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  HeadForm.RemoveSlave(Sender as TForm1);
  {ShowMessageFmt('Formulare: %d', [MasterForm.SlaveCount])}
end;

procedure TForm1.FormDropFiles(Sender: TObject; const FileNames: array of String
  );
var
  i: Integer;
begin
  if Save then SynEdit.Lines.LoadFromFile(Filenames[Low(Filenames)]);
  for i := Low(FileNames) + 1 to High(FileNames) do
    TForm1.Create(Application).SynEdit.Lines.LoadFromFile(FileNames[i]);
end;

procedure TForm1.FormsAdjustClick(Sender: TObject);
begin
  HeadForm.AdjustSlaves
end;

procedure TForm1.FormsCascadeClick(Sender: TObject);
begin
  HeadForm.CascadeSlaves
end;

procedure TForm1.FormsNewClick(Sender: TObject);
begin
  TForm1.Create(Application)
end;

procedure TForm1.FormsShowClick(Sender: TObject);
begin
  HeadForm.SlaveSelDlg.Execute
end;

procedure TForm1.FormsTileClick(Sender: TObject);
begin
  HeadForm.TileSlaves
end;

procedure TForm1.HelpAboutClick(Sender: TObject);
begin
  AboutBox.ShowModal
end;

procedure TForm1.FilePrintClick(Sender: TObject);
begin
  if PrintDialog.Execute then begin
    PrintTestPage
  end;
end;

procedure TForm1.FilePrinterSetupClick(Sender: TObject);
begin
  PrinterSetupDialog.Execute
end;

procedure TForm1.HelpLicenseClick(Sender: TObject);
begin
  OpenDocument(ExtractFilePath(Application.ExeName) + 'LICENSE')
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  if FontDialog.Execute then SynEdit.Font := FontDialog.Font;
end;

procedure TForm1.FormsHideClick(Sender: TObject);
begin
  Hide
end;

procedure TForm1.FileExitClick(Sender: TObject);
begin
  HeadForm.Close
end;

procedure TForm1.FileCloseClick(Sender: TObject);
begin
  Close
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction := caFree
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

procedure TForm1.SynEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

end;

procedure TForm1.SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges
  );
const
  Counter: Integer = 0;
var
  P: TPoint;
begin
  if scModified in Changes then
    if (Sender as TSynEdit).Modified then StatusBar.Panels[0].Text := 'Geändert'
    else StatusBar.Panels[0].Text := '';
  P := Point(Counter, Counter div 2);
  StatusBar.Panels[1].Text := Format('%d:%d', [P.X, P.Y]);
  Inc(Counter)
end;

procedure TForm1.ViewSynClick(Sender: TObject);
begin
  HLSwitch.Switch(Sender as TMenuItem)
end;

procedure TForm1.SetFileName(Value: string);
begin
  FFileName := Value;
  if Value <> '' then Caption := Value
  else Caption := 'Free Pascal Editor'
end;

function TForm1.GetConfigFileName: string;
begin
  Result := BuildFileName(Application.EnvironmentVariable['HOME'], '.config/fpe');
  ForceDirectories(Result);
  Result := ChangeFileExt(BuildFileName(Result, Name), '.cfg');
end;

procedure TForm1.OpenFile(AFileName: string);
begin
  ShowMessage(AFileName)
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

function TForm1.GuessHighlighter: TSynCustomHighLighter;
begin
  Result := nil;
end;

procedure TForm1.PrintTestPage;
const
  TestText = 'Hallo, Drucker!';
var
  TW, TH, X, Y: Integer;
begin
  Printer.BeginDoc;
  Printer.BeginPage;
  TH := Printer.Canvas.TextHeight(TestText);
  TW := Printer.Canvas.TextWidth(TestText);
  X := (Printer.PageWidth - TW) div 2;
  Y := (Printer.PageHeight - TH) div 2;
  Printer.Canvas.TextOut(X, Y, TestText);
  Printer.EndPage;
  Printer.EndDoc
end;

initialization

end.

