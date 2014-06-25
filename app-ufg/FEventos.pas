unit FEventos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.ListBox, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TFormEventos = class(TForm)
    ToolBar1: TToolBar;
    ListBox1: TListBox;
    UFG: TLabel;
    btnStop: TSpeedButton;
    SearchBox1: TSearchBox;
    ListBoxItem1: TListBoxItem;
    ListBoxItem2: TListBoxItem;
    procedure btnStopClick(Sender: TObject);
    procedure ListBoxItem1Click(Sender: TObject);
    procedure ListBoxItem2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEventos: TFormEventos;

implementation

{$R *.fmx}

procedure TFormEventos.btnStopClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFormEventos.ListBoxItem1Click(Sender: TObject);
begin
  ListBoxItem1.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
end;

procedure TFormEventos.ListBoxItem2Click(Sender: TObject);
begin
  ListBoxItem2.ItemData.Accessory := TListBoxItemData.TAccessory.aCheckmark;
end;

end.
