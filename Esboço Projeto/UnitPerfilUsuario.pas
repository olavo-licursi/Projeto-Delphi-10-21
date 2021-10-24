unit UnitPerfilUsuario;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TFrmPerfilUsuario = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    Circle1: TCircle;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Rectangle1: TRectangle;
    Label6: TLabel;
    Rectangle2: TRectangle;
    Label7: TLabel;
    Layout3: TLayout;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    layout_pedido: TLayout;
    procedure img_voltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPerfilUsuario: TFrmPerfilUsuario;

implementation

{$R *.fmx}

procedure TFrmPerfilUsuario.img_voltarClick(Sender: TObject);
begin
      close;
end;

end.
