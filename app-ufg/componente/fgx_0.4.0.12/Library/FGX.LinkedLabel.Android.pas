unit FGX.LinkedLabel.Android;

interface

uses
  System.Classes, FMX.Platform, FGX.LinkedLabel;

type

{ TAndroidLaunchService }

  TAndroidLaunchService = class sealed (TInterfacedObject, IFGXLaunchService)
  public
    { IFMXLaunchService }
    function OpenURL(const AUrl: string): Boolean;
  end;

procedure RegisterService;

implementation

uses
  FMX.Helpers.Android, Androidapi.Helpers, Androidapi.JNI.Net, Androidapi.JNI.GraphicsContentViewText;

{ TAndroidLaunchService }

function TAndroidLaunchService.OpenURL(const AUrl: string): Boolean;
var
  Uri: Jnet_Uri;
  OpenLinkIntent: JIntent;
begin
  Uri := StrToJURI(AUrl);
  OpenLinkIntent := TJIntent.JavaClass.init(TJIntent.JavaClass.ACTION_VIEW, Uri);
  OpenLinkIntent.setType(StringToJString('text/html'));
  OpenLinkIntent.addCategory(TJIntent.JavaClass.CATEGORY_BROWSABLE);
  SharedActivity.startActivity(OpenLinkIntent);
  Result := True;
end;

procedure RegisterService;
begin
  TPlatformServices.Current.AddPlatformService(IFGXLaunchService, TAndroidLaunchService.Create);
end;

end.
