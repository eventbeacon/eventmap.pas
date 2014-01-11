unit ArrayList;

{$ifdef fpc}
  {$mode delphi}
{$endif}

interface

uses
  SysUtils, Classes;

type
  TArrayList<T> = class
  private
    fArray: array of T;
    fSize: Integer;

    function Grow(): Integer;
    function Shrink(): Integer;

    function GetValue(anIndex: Integer): T;
    procedure SetValue(anIndex: Integer; aValue: T);
  public
    constructor Create(); Overload;
    constructor Create(aValue: array of T); Overload;

    destructor Destroy(); Override;

    procedure Clear();

    procedure Push(const aValue: T);
    function Pop(): T;
  public
    property Value[Index: Integer]: T read GetValue write SetValue; default;
  published
    property Size: Integer read fSize;
  end;

implementation

function TArrayList<T>.Grow(): Integer;
var
  oldLength: Integer;
begin
  oldLength := fSize;

  fSize := fSize + 1;
  SetLength(fArray, fSize);
  
  Result := oldLength;
end;

function TArrayList<T>.Shrink(): Integer;
var
  oldLength: Integer;
begin
  oldLength := fSize;

  fSize := fSize - 1;
  SetLength(fArray, fSize);
  
  Result := oldLength;
end;

function TArrayList<T>.GetValue(anIndex: Integer): T;
begin
  if anIndex < 0 then anIndex := 0;
  if anIndex > fSize - 1 then anIndex := fSize - 1;
  Result := fArray[anIndex];
end;

procedure TArrayList<T>.SetValue(anIndex: Integer; aValue: T);
begin
  if anIndex < 0 then anIndex := 0;
  if anIndex > fSize - 1 then anIndex := fSize - 1;
  fArray[anIndex] := aValue;
end;

constructor TArrayList<T>.Create();
begin
  Self.Clear();
end;

constructor TArrayList<T>.Create(aValue: array of T);
var
  i, len: Integer;
begin
  Create;

  len := Length(aValue) - 1;

  for i := 0 to len do
  begin
    Self.Push(aValue[i]);
  end;
end;

destructor TArrayList<T>.Destroy;
begin
  inherited Destroy;
end;

procedure TArrayList<T>.Clear();
begin
  fSize := 0;
  SetLength(fArray, fSize);
end;

procedure TArrayList<T>.Push(const aValue: T);
var
  newPos: Integer;
begin
  newPos := Self.Grow();
  fArray[newPos] := aValue;
end;

function TArrayList<T>.Pop(): T;
var
  poppedValue: T;
begin
  poppedValue := fArray[fSize - 1];

  Result := poppedValue;

  Self.Shrink();
end;

end.
