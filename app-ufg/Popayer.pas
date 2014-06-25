unit Popayer;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Media,
  FMX.StdCtrls, FMX.Ani, FMX.Objects, FMX.Layouts, FMX.ListBox;

type
  TFormPopeyer = class(TForm)
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
    procedure SpeedButtonPlayStopClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPopeyer: TFormPopeyer;

implementation

{$R *.fmx}

uses
  System.iOUtils, PlayAudioFile;

procedure TFormPopeyer.btnStopClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormPopeyer.ListBoxItem1Click(Sender: TObject);
begin
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'popeye.mp3');
end;

procedure TFormPopeyer.SpeedButtonPlayStopClick(Sender: TObject);
begin
  {Under Project-Deployment, we added the media file and set the remote path.
  When the program starts, everything in the directory that is set under remote path is
   copied over to the Documents folder on the device. The MediaPlayer loads the file from
   the Documents folder

   Sob Project-implantação, nós adicionamos o arquivo de mídia e definir o caminho remoto.
   Quando o programa começa, tudo no diretório que está definido em caminho remoto é
    copiados para a pasta Documentos no dispositivo. O MediaPlayer carrega o arquivo de
    a pasta Documentos
   }

  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'popeye.mp3');

  {if SpeedButtonPlayStop.StyleLookup = 'playtoolbuttonbordered' then
  begin
    SpeedButtonPlayStop.StyleLookup := 'stoptoolbutton';
    AudioPlayBackForm.MediaPlayer1.FileName := TPath.GetMusicPath + PathDelim + 'popeye.mp3';
    AudioPlayBackForm.MediaPlayer1.Play;
  end
  else
  begin
    SpeedButtonPlayStop.StyleLookup := 'playtoolbuttonbordered';
    AudioPlayBackForm.MediaPlayer1.Stop;
  end;}
end;

end.
