unit tomJerry;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.Layouts, FMX.ListBox;

type
  TFormTomJerry = class(TForm)
    ColorAnimation3: TColorAnimation;
    Image1: TImage;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    SpeedButtonPlayStop: TSpeedButton;
    ListBoxItem2: TListBoxItem;
    Label1: TLabel;
    btnStop: TSpeedButton;
    Label2: TLabel;
    ListBoxItem4: TListBoxItem;
    Curiosidade: TListBoxItem;
    ListBoxItem3: TListBoxItem;
    Label3: TLabel;
    ListBoxItem5: TListBoxItem;
    SpeedButton1: TSpeedButton;
    ListBoxItem6: TListBoxItem;
    SpeedButton2: TSpeedButton;
    ListBoxItem7: TListBoxItem;
    SpeedButton3: TSpeedButton;
    ListBoxItem8: TListBoxItem;
    SpeedButton4: TSpeedButton;
    ListBoxItem9: TListBoxItem;
    SpeedButton5: TSpeedButton;
    ListBoxItem10: TListBoxItem;
    SpeedButton6: TSpeedButton;
    procedure SpeedButtonPlayStopClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTomJerry: TFormTomJerry;

implementation

{$R *.fmx}

uses
  System.iOUtils, PlayAudioFile;

procedure TFormTomJerry.btnStopClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormTomJerry.SpeedButton1Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia3.mp3');
end;

procedure TFormTomJerry.SpeedButton2Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia2.mp3');
end;

procedure TFormTomJerry.SpeedButton3Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia4.mp3');
end;

procedure TFormTomJerry.SpeedButton4Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia5.mp3');
end;

procedure TFormTomJerry.SpeedButton5Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia6.mp3');
end;

procedure TFormTomJerry.SpeedButton6Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia7.mp3');
end;

procedure TFormTomJerry.SpeedButtonPlayStopClick(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'tomjerrymedia1.mp3');
end;

end.
