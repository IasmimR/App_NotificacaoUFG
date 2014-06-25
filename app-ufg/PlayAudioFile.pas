unit PlayAudioFile;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Media, FMX.StdCtrls,
  FMX.ListBox, FMX.Layouts, FMX.Edit, FMX.Notification, FMX.Advertising, 
  FMX.Objects, FMX.TabControl, FAulas, FEventos, IniFiles, FGX.ProgressDialog;

type
  TAudioPlayBackForm = class(TForm)
    MediaPlayer1: TMediaPlayer;
    Layout1: TLayout;
    Image1: TImage;
    Notifica: TLabel;
    UFG: TLabel;
    TabControl1: TTabControl;
    TabItemCategorias: TTabItem;
    TabItemConfiguracao: TTabItem;
    ListBox1: TListBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    Switch1: TSwitch;
    Label1: TLabel;
    Timer1: TTimer;
    ListBoxItem3: TListBoxItem;
    ListBoxItem4: TListBoxItem;
    ListBoxItem5: TListBoxItem;
    NotificationCenter1: TNotificationCenter;
    TabItemCadastro: TTabItem;
    EditMatricula: TEdit;
    Label3: TLabel;
    EditEmail: TEdit;
    Label4: TLabel;
    ButtonLogar: TButton;
    EditNome: TEdit;
    Label5: TLabel;
    PanelAcademico: TPanel;
    Label6: TLabel;
    Label7: TLabel;
    LabelAcademico: TLabel;
    LabelMatricula: TLabel;
    SpeedButton1: TSpeedButton;
    fgActivityDialog: TfgActivityDialog;
    procedure Switch1Click(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
    procedure ListBoxItem3Click(Sender: TObject);
    procedure ListBoxItem4Click(Sender: TObject);
    procedure ListBoxItem5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Switch1Switch(Sender: TObject);
    procedure ButtonLogarClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    arquivoIni  : string;
    formAulas   : TFormAulas;
    formEventos : TFormEventos;
    procedure gravaDados;
    procedure lerDados;
    procedure configurarTela;
    procedure resetaCadastro;
    { Private declarations }
  public
    function tocarMusica(media: string): boolean;
    function notificarSistema(cabecalhoMensagem: string; corpoMensagem: string): Boolean;
    { Public declarations }
  end;
var
  AudioPlayBackForm: TAudioPlayBackForm;


implementation

{$R *.fmx}

uses
  System.iOUtils,
  FMX.Platform,
  {$IFDEF ANDROID}
    Androidapi.JNI.Provider,
    AndroidApi.JNI.JavaTypes,
    Androidapi.JNI.App,
    AndroidApi.JNI.GraphicsContentViewText,
    Androidapi.JNI.Net,
    Androidapi.JNI.Media,
    FMX.Helpers.Android,
    Androidapi.Helpers
  {$ENDIF};

procedure TAudioPlayBackForm.ButtonLogarClick(Sender: TObject);
begin
  if trim(EditNome.text) = '' then
  begin
    ShowMessage('Acadêmico informe seu Nome!');
    Exit;
  end;

  if trim(EditMatricula.text) = '' then
  begin
    ShowMessage('Acadêmico informe sua Matrícula!');
    Exit;
  end;
  gravaDados;

  fgActivityDialog.Message := 'Por favor, Aguarde';
  fgActivityDialog.Show;
  try
    Sleep(1000);
    fgActivityDialog.Message := 'Conectando servidor UFG...';
    Sleep(3000);
    fgActivityDialog.Message := 'Conectado';
    Sleep(1000);
    fgActivityDialog.Message := 'Localizando Matrícula no Servidor';
    Sleep(4000);
    fgActivityDialog.Message := 'Acadêmico Autorizado.';
    Sleep(1000);
    fgActivityDialog.Message := 'Finalizando Conexão';
    Sleep(100);
  finally
    fgActivityDialog.Hide;
  end;

  configurarTela;
end;

procedure TAudioPlayBackForm.gravaDados;
var
  ioFile : TIniFile;
begin
  ioFile := TIniFile.Create(arquivoIni);
  ioFile.WriteString('UFG', 'NOME'     , trim(EditNome.Text));
  ioFile.WriteString('UFG', 'EMAIL'    , trim(EditEmail.Text));
  ioFile.WriteString('UFG', 'MATRICULA', trim(EditMatricula.Text));
  ioFile.Free;
end;

procedure TAudioPlayBackForm.lerDados;
var
  ioFile : TIniFile;
begin
  ioFile := TIniFile.Create(arquivoIni);

  LabelAcademico.Text := ioFile.ReadString('UFG', 'NOME', '');
  LabelMatricula.Text := ioFile.ReadString('UFG', 'MATRICULA', '');
  ioFile.Free;
end;

procedure TAudioPlayBackForm.resetaCadastro;
begin
  case MessageDlg('Excluir Acadêmico:', System.UITypes.TMsgDlgType.mtInformation,
    [
      System.UITypes.TMsgDlgBtn.mbYes,
      System.UITypes.TMsgDlgBtn.mbNo
    ], 0) of
    { Detectar qual botão foi pressionado e mostrar uma mensagem diferente }
    mrYES:
    begin
      DeleteFile(arquivoIni);
      configurarTela;
      Exit;
    end;
  end;
end;

procedure TAudioPlayBackForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if formAulas <> nil then
   FreeAndNil(formAulas);

 if FormEventos <> nil then
   FreeAndNil(FormEventos);
end;

procedure TAudioPlayBackForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = vkHardwareBack then
  begin
    if TabControl1.ActiveTab = TabItemConfiguracao then
    begin
      TabControl1.ActiveTab := TabItemCategorias;
      Key := 0;
    end;
  end;
end;

procedure TAudioPlayBackForm.FormShow(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItemCategorias;
  arquivoIni := GetHomePath + PathDelim + 'academico.ini';
  configurarTela;
end;

procedure TAudioPlayBackForm.configurarTela;
begin
  if not(FileExists(arquivoIni)) then
  begin
    TabItemCategorias.Visible   := False;
    TabItemConfiguracao.Visible := False;
    TabItemCadastro.Visible     := True;
    TabControl1.ActiveTab       := TabItemCadastro;
    PanelAcademico.Visible      := False;
  end
  else
  begin
    TabItemCategorias.Visible   := True;
    TabItemConfiguracao.Visible := True;
    TabItemCadastro.Visible     := False;
    TabControl1.ActiveTab       := TabItemCategorias;
    PanelAcademico.Visible      := True;
    lerDados;
  end;
end;


procedure TAudioPlayBackForm.ListBoxItem1Click(Sender: TObject);
begin
  if formAulas = nil then
    formAulas := TFormAulas.Create(self);
  try
    FormAulas.Show;
  finally
    //FreeAndNil(FormAulas);
  end;
end;

procedure TAudioPlayBackForm.SpeedButton1Click(Sender: TObject);
begin
  resetaCadastro;
end;

procedure TAudioPlayBackForm.Switch1Click(Sender: TObject);
begin
//  if not(Switch1.IsChecked) then
//  begin
//    Timer1.Enabled := True;
//    notificarSistema('Aulas - Avaliação ', 'Avaliação de docentes pelos discentes Período: de 01/05/2014 a 01/07/2014.');
//  end
//  else
//    Timer1.Enabled := False;
end;
                 //teste de notificação recebida.
procedure TAudioPlayBackForm.Switch1Switch(Sender: TObject);
begin
  if Switch1.IsChecked then
  begin
    Timer1.Enabled := True;
    AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'what.mp3');    
    notificarSistema('Aulas - Avaliação ', 'Avaliação de docentes pelos discentes Período: de 01/05/2014 a 01/07/2014.');
  end
  else
    Timer1.Enabled := False;
end;

procedure TAudioPlayBackForm.Timer1Timer(Sender: TObject);
begin
  notificarSistema('Aulas - Avaliação ', 'Última aula do 1º Semestre 30/05/14');
  AudioPlayBackForm.tocarMusica(TPath.GetDocumentsPath + PathDelim + 'what.mp3');      
end;

function TAudioPlayBackForm.tocarMusica(media: string):boolean;
begin
  MediaPlayer1.FileName := media;
  MediaPlayer1.Play;
end;

procedure TAudioPlayBackForm.ListBoxItem2Click(Sender: TObject);
begin

  if FormEventos = nil then
    FormEventos := TFormEventos.Create(self);    
    
  //Application.CreateForm(TFormEventos, FormEventos);
  try
    FormEventos.Show;
  finally
    //FreeAndNil(FormEventos);
  end;
end;

procedure TAudioPlayBackForm.ListBoxItem3Click(Sender: TObject);
begin
  ShowMessage('Esta categoria não tem mensagem !' + sLineBreak + 'Quando tiver você será notificado.');
end;

procedure TAudioPlayBackForm.ListBoxItem4Click(Sender: TObject);
begin
  ShowMessage('Esta categoria não tem mensagem !' + sLineBreak + 'Quando tiver você será notificado.');
end;

procedure TAudioPlayBackForm.ListBoxItem5Click(Sender: TObject);
begin
  ShowMessage('Esta categoria não tem mensagem !' + sLineBreak + 'Quando tiver você será notificado.');
end;

function TAudioPlayBackForm.notificarSistema(cabecalhoMensagem: string; corpoMensagem: string): Boolean;
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := cabecalhoMensagem;
    MyNotification.AlertBody := corpoMensagem;
    // Set Icon Badge Number (for iOS) or message number (for Android) as well
    MyNotification.Number := 18;
    MyNotification.EnableSound := False;
    // Send message to Notification Center
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.DisposeOf;
  end;
end;

end.

{

 TESTANDO SE A MUSICA TA TOCANDO
   MediaPlayer1.FileName := IncludeTrailingPathDelimiter(TPath.GetDocumentsPath) + 'Ocean.mp4';
   MediaPlayer1.Play;
end;

procedure TForm20.FormResize(Sender: TObject);
begin
  if MediaPlayer1.State = TMediaState.Playing then
    TOpenMedia(MediaPlayer1.Media).UpdateMediaFromControl;
end

}
