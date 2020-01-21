unit MasterFm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs;

type
  
  { TMasterForm }

  TMasterForm = class(TForm)
  private
    FSlaveList: TFpList;
    function GetSlaveList: TFpList;
  private
    FSlaveIndex: Integer;
    function GetSlaveCount: Integer;
    function GetSlaveForms(I: Integer): TForm;
    function GetSlaveIndex: Integer;
    procedure SetSlaveIndex(AValue: Integer);
    property SlaveList: TFpList read GetSlaveList;
  protected
    procedure Activate; override;
  public
    constructor Create(AnOwner: TComponent); override;
    destructor Destroy; override;
    function AddSlave(ASlave: TForm): Integer;
    function CloseQuery: Boolean; override;
    procedure RemoveSlave(ASlave: TForm);
    property SlaveCount: Integer read GetSlaveCount;
    property SlaveIndex: Integer read GetSlaveIndex write SetSlaveIndex;
    property SlaveForms[I: Integer]: TForm read GetSlaveForms;
  end;

var
  MasterForm: TMasterForm;

implementation

{$R *.lfm}

{ TMasterForm }

function TMasterForm.GetSlaveList: TFpList;
begin
  if not Assigned(FSlaveList) then FSlaveList := TFpList.Create;
  Result := FSlaveList
end;

function TMasterForm.GetSlaveForms(I: Integer): TForm;
begin
  Pointer(Result) := SlaveList[i]
end;

function TMasterForm.GetSlaveCount: Integer;
begin
  if Assigned(FSlaveList) then Result := FSlaveList.Count
  else Result := 0
end;

function TMasterForm.GetSlaveIndex: Integer;
begin
  if FSlaveIndex >= SlaveCount then FSlaveIndex := SlaveCount - 1;
  Result := FSlaveIndex
end;

procedure TMasterForm.SetSlaveIndex(AValue: Integer);
begin
  SlaveForms[AValue].Show;
  SlaveForms[AValue].BringToFront;
  FSlaveIndex := AValue;
end;

procedure TMasterForm.Activate;
begin
  Hide;
  inherited Activate;
end;

constructor TMasterForm.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
  WindowState := wsMinimized
end;

destructor TMasterForm.Destroy;
begin
  if Assigned(FSlaveList) then begin
    FreeAndNil(FSlaveList);
  end;
  inherited Destroy;
end;

function TMasterForm.AddSlave(ASlave: TForm): Integer;
begin
  if ASlave <> nil then begin
    Result := SlaveList.Add(ASlave);
    ASlave.Show;
    ASlave.BringToFront;
    SendToBack;
    Hide
  end;
end;

function TMasterForm.CloseQuery: Boolean;
var
  i: Integer;
begin
  for i := 0 to SlaveCount - 1 do begin
    Result := SlaveForms[i].CloseQuery;
    if not Result then Exit
  end;
  Result := inherited CloseQuery ;
end;

procedure TMasterForm.RemoveSlave(ASlave: TForm);
var
  i: Integer;
begin
  i := SlaveList.IndexOf(ASlave);
  if i > -1 then
    SlaveList.Delete(i);
  if (SlaveCount = 0) then Close
  else begin
    {if i >= SlaveCount then i := SlaveCount - 1;
    with SlaveForms[i] do begin
      Show;
      BringToFront
    end;}
  end;
end;

end.

