unit EventMap;

{$mode delphi}{$H+}

interface

uses
  FGL, Classes, ArrayList;

type

  { TGenericEventMap }

  TGenericEventMap<T> = class
  public
    type
      TEvent = procedure(Data: T) of object;
      TEventList = TArrayList<TEvent>;
  protected
    fEvents: TFPGMap<AnsiString, TEventList>;
  public
    constructor Create;
    destructor Destroy; Override;

    procedure AddListener(Name: AnsiString; Event: TEvent);
    procedure RemoveListener(Name: AnsiString);

    function Exists(Name: AnsiString): Boolean;

    procedure Trigger(Name: AnsiString; Data: T);
  end;

  //TEventMap = TGenericEventMap<String>;

implementation

{ TGenericEventMap<T> }

constructor TGenericEventMap<T>.Create;
begin
  inherited Create;

  fEvents := TFPGMap<AnsiString, TEventList>;
end;

destructor TGenericEventMap<T>.Destroy;
begin
  inherited Destroy;

  fEvents.Destroy;
end;

procedure TGenericEventMap<T>.AddListener(Name: AnsiString; Event: TEvent);
begin
  if Exists(Name) then
  begin
    fEvents.KeyData[Name].Push(Event);
  end else
  begin
    fEvents.Add(TArrayList.Create([Event]));
  end;
end;

procedure TGenericEventMap<T>.RemoveListener(Name: AnsiString);
begin
  fEvents.Remve(Name);
end;

function TGenericEventMap<T>.Exists(Name: AnsiString): Boolean;
begin
  Result := (fEvents.IndexOf(Name) >= 0);
end;

procedure TGenericEventMap<T>.Trigger(Name: AnsiString; Data: T);
begin
  if Exists(Name) then fEvents.KeyData[Name](Data);
end;

end.

