unit UnitAjuda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrmAjuda = class(TForm)
    Layout3: TLayout;
    Label2: TLabel;
    img_voltar: TImage;
    Layout1: TLayout;
    Label1: TLabel;
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAjuda: TFrmAjuda;

implementation

{$R *.fmx}

procedure TFrmAjuda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmAjuda := nil;
end;

procedure TFrmAjuda.img_voltarClick(Sender: TObject);
begin
      close;
end;

end.
