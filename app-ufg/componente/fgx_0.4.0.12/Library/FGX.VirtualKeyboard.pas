{*********************************************************************
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Autor: Brovin Y.D.
 * E-mail: y.brovin@gmail.com
 *
 ********************************************************************}

unit FGX.VirtualKeyboard;

interface

uses
  System.Classes, FMX.VirtualKeyboard, FGX.VirtualKeyboard.Types, FMX.Types,
  System.Types, System.Messaging;

type

  { TfgVirtualKeyboard }

  TfgVirtualKeyboardEvent = procedure (Sender: TObject; const Bounds: TRect) of object;

  TfgVirtualKeyboardVisible = (Unknow, Shown, Hidden);

  TfgCustomVirtualKeyboard = class (TComponent)
  private
    FButtons: TfgButtonsCollection;
    FEnabled: Boolean;
    FKeyboardService: IFMXVirtualKeyboardToolbarService;
    FVKStateChangedMessageId: Integer;
    FVKLastState: TfgVirtualKeyboardVisible;
    FOnShow: TfgVirtualKeyboardEvent;
    FOnHide: TfgVirtualKeyboardEvent;
    FOnSizeChanged: TfgVirtualKeyboardEvent;
  protected
    procedure SetEnabled(const Value: Boolean); virtual;
    procedure SetButtons(const Value: TfgButtonsCollection); virtual;
    procedure RefreshKeyboardButtons; virtual;
    { Virtual Keyboard Events }
    procedure DoShow(const Bounds: TRect); virtual;
    procedure DoSizeChanged(const Bounds: TRect); virtual;
    procedure DoHide(const Bounds: TRect); virtual;
    { Message Handler }
    procedure DoVirtualKeyboardChangeHandler(const Sender: TObject; const AMessage: TMessage);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Supported: Boolean;
  public
    property Buttons: TfgButtonsCollection read FButtons write SetButtons;
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property OnShow: TfgVirtualKeyboardEvent read FOnShow write FOnShow;
    property OnHide: TfgVirtualKeyboardEvent read FOnHide write FOnHide;
    property OnSizeChanged: TfgVirtualKeyboardEvent read FOnSizeChanged write FOnSizeChanged;
  end;

  [ComponentPlatformsAttribute(pidAndroid or pidiOSDevice or pidiOSSimulator)]
  TfgVirtualKeyboard = class (TfgCustomVirtualKeyboard)
  published
    property Buttons;
    property Enabled;
    property OnShow;
    property OnHide;
    property OnSizeChanged;
  end;

implementation

uses
  FMX.Platform, FMX.Forms;

{ TfgCustomVirtualKeyboard }

constructor TfgCustomVirtualKeyboard.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButtons := TfgButtonsCollection.Create(Self, RefreshKeyboardButtons);
  FEnabled := True;
  FVKLastState := TfgVirtualKeyboardVisible.Unknow;
  TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardToolbarService, IInterface(FKeyboardService));
  { Subriptions }
  FVKStateChangedMessageId := TMessageManager.DefaultManager.SubscribeToMessage(TVKStateChangeMessage, DoVirtualKeyboardChangeHandler);
end;

destructor TfgCustomVirtualKeyboard.Destroy;
begin
  TMessageManager.DefaultManager.Unsubscribe(TVKStateChangeMessage, FVKStateChangedMessageId);
  FButtons.Free;
  FKeyboardService := nil;
  inherited Destroy;
end;

procedure TfgCustomVirtualKeyboard.DoHide(const Bounds: TRect);
begin
  if Assigned(FOnHide) then
    FOnHide(Self, Bounds);
end;

procedure TfgCustomVirtualKeyboard.DoShow(const Bounds: TRect);
begin
  if Assigned(FOnShow) then
    FOnShow(Self, Bounds);
end;

procedure TfgCustomVirtualKeyboard.DoSizeChanged(const Bounds: TRect);
begin
  if Assigned(FOnSizeChanged) then
    FOnSizeChanged(Self, Bounds);
end;

procedure TfgCustomVirtualKeyboard.DoVirtualKeyboardChangeHandler(const Sender: TObject; const AMessage: TMessage);
var
  VKMessage: TVKStateChangeMessage;
begin
  Assert(AMessage is TVKStateChangeMessage);

  VKMessage := AMessage as TVKStateChangeMessage;
  case FVKLastState of
    Unknow:
      begin
        if VKMessage.KeyboardVisible then
          DoShow(VKMessage.KeyboardBounds)
        else
          DoHide(VKMessage.KeyboardBounds);
      end;
    Shown:
      begin
        if VKMessage.KeyboardVisible then
          DoSizeChanged(VKMessage.KeyboardBounds)
        else
          DoHide(VKMessage.KeyboardBounds);
      end;
    Hidden:
      begin
        if VKMessage.KeyboardVisible then
          DoShow(VKMessage.KeyboardBounds)
        else
          DoSizeChanged(VKMessage.KeyboardBounds);
      end;
  end;

  if VKMessage.KeyboardVisible then
    FVKLastState := TfgVirtualKeyboardVisible.Shown
  else
    FVKLastState := TfgVirtualKeyboardVisible.Hidden;
end;

procedure TfgCustomVirtualKeyboard.RefreshKeyboardButtons;
var
  I: Integer;
  Button: TfgButtonsCollectionItem;
begin
  Assert(FButtons <> nil);

  if not Supported then
    Exit;

  FKeyboardService.ClearButtons;
  for I := 0 to FButtons.Count - 1 do
  begin
    Button := FButtons.GetButton(I);
    if Button.Visible then
      FKeyboardService.AddButton(Button.Caption, Button.OnClick);
  end;
end;

procedure TfgCustomVirtualKeyboard.SetButtons(const Value: TfgButtonsCollection);
begin
  Assert(Value <> nil);
  FButtons.Assign(Value);
end;

procedure TfgCustomVirtualKeyboard.SetEnabled(const Value: Boolean);
begin
  FEnabled := Value;
  if Supported then
    FKeyboardService.SetToolbarEnabled(Value);
end;

function TfgCustomVirtualKeyboard.Supported: Boolean;
begin
  Result := FKeyboardService <> nil;
end;

initialization
  RegisterFmxClasses([TfgCustomVirtualKeyboard, TfgVirtualKeyboard]);
end.
