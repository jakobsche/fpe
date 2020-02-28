unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, LazHelpHTML,
  ComCtrls, SynEdit, SynHighlighterPas, SynHighlighterJScript,
  SynHighlighterXML, SynHighlighterHTML, SynHighlighterMulti,
  SynEditHighlighter, SynHighlighterCpp, SynCompletion, SynHighlighterLFM,
  PrintersDlgs, SynEditTypes, SynHighlighterMakefile;

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
    procedure SetItemIndex(AValue: Integer);
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
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
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
    HelpContents: TMenuItem;
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
    procedure HelpContentsClick(Sender: TObject);
    procedure NewItemClick(Sender: TObject);
    procedure OpenItemClick(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure SaveItemClick(Sender: TObject);
    procedure SynEditStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure ViewSynClick(Sender: TObject);
    procedure XMLPropStorageRestoreProperties(Sender: TObject);
    procedure XMLPropStorageRestoringProperties(Sender: TObject);
  private
    FFileName: string;
    procedure SetFileName(Value: string);
  public
    SynHighlighterMakefile: TSynMakefileSyn;
    function GetConfigFileName: string;
    procedure OpenFile(AFileName: string);
    function Save: Boolean;
    function SaveAs: Boolean;
    function GuessHighlighter: TSynCustomHighLighter;
    procedure PrintTestPage;
  published
    HLSwitch: THighlighterSwitch;
    property FileName: string read FFileName write SetFileName;
  end;

var
  Form1: TForm1;

implementation

uses About, FormEx, HeadFm, HelpIntfs, LazHelpIntf, LCLIntf, Patch, Printers,
  Streaming2, Types;

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

procedure THighlighterSwitch.SetItemIndex(AValue: Integer);
begin
  if FItemIndex=AValue then Exit;
  {Switch(AValue);}
  FItemIndex:=AValue;
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
  SynHighlighterMakefile := TSynMakefileSyn.Create(Self);
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
    AddItem(ViewMakefile, SynHighlighterMakefile);
    Switch(ViewFreePascal)
  end;
  with HTMLHelpDataBase do begin
    {$ifdef Darwin}
      BaseURL := 'file://' + ExtractFilePath(Application.ExeName) + 'help'
    {$else}
      {$ifndef UNIX}
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
  TForm1.Create(HeadForm).Name := '';
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
var
  NewWindow: TForm1;
begin
  {OpenDocument(ExtractFilePath(Application.ExeName) + 'LICENSE')}
  NewWindow := TForm1.Create(Application);
  with NewWindow do begin
    HLSwitch.Switch(ViewText);
    OpenFile(ExtractFilePath(Application.ExeName) + 'LICENSE');
    SynEdit.ReadOnly := True;
    Show
  end;
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  if FontDialog.Execute then SynEdit.Font := FontDialog.Font;
end;

procedure TForm1.FormsHideClick(Sender: TObject);
begin
  Hide
end;

procedure TForm1.HelpContentsClick(Sender: TObject);
var
  ErrMsg: string;
  R: TShowHelpResult;
begin
  R := HTMLHelpDatabase.ShowHelpFile(nil, nil, 'Inhaltsverzeichnis', 'index.html', ErrMsg);
  case R of
    shrSuccess:;
    else ShowMessageFmt('%d: %s', [R, ErrMsg]);
  end;
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
    case MessageDlg(Format('%s wurde noch nicht gespeichert. Soll die Datei jetzt gespeichert werden?', [x]),
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

procedure TForm1.XMLPropStorageRestoreProperties(Sender: TObject);
begin
  {HLSwitch.Switch(HLSwitch.ItemIndex);}
end;

procedure TForm1.XMLPropStorageRestoringProperties(Sender: TObject);
begin
  HLSwitch.Switch(HLSwitch.ItemIndex)
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
  SynEdit.Lines.LoadFromFile(AFileName);
  FileName := AFileName
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

RegisterForStreaming(TForm1);
RegisterForStreaming(THighlighterData);
RegisterForStreaming(TFontDialog);
RegisterForStreaming(THTMLBrowserHelpViewer);
RegisterForStreaming(THTMLHelpDatabase);
RegisterForStreaming(TMainMenu);
RegisterForStreaming(TMenuItem);
RegisterForStreaming(TPrintDialog);
RegisterForStreaming(TStatusBar);
RegisterForStreaming(TSynCompletion);
RegisterForStreaming(TSynFreePascalSyn);
RegisterForStreaming(TSynLFMSyn);
RegisterForStreaming(TPrinterSetupDialog);
RegisterForStreaming(TSynCppSyn);
RegisterForStreaming(TSynMultiSyn);
RegisterForStreaming(TSynHTMLSyn);
RegisterForStreaming(TSynXMLSyn);
RegisterForStreaming(TSynJScriptSyn);
RegisterForStreaming(TOpenDialog);
RegisterForStreaming(TSaveDialog);
RegisterForStreaming(TSynEdit);
RegisterForStreaming(TSynPasSyn);
RegisterForStreaming(TSynMakefileSyn);
RegisterForStreaming(THighlighterSwitch);

end.

