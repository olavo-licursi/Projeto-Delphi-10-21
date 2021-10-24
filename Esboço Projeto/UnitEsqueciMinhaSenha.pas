unit UnitEsqueciMinhaSenha;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.Layouts;

type
  TFrmEsqueciMinhaSenha = class(TForm)
    Layout2: TLayout;
    Layout1: TLayout;
    RoundRect1: TRoundRect;
    edt_login_email: TEdit;
    Layout4: TLayout;
    rect_login: TRoundRect;
    Label1: TLabel;
    Layout3: TLayout;
    Label2: TLabel;
    img_voltar: TImage;
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEsqueciMinhaSenha: TFrmEsqueciMinhaSenha;

implementation

{$R *.fmx}

uses UnitLogin;

procedure TFrmEsqueciMinhaSenha.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmEsqueciMinhaSenha := nil;
end;

procedure TFrmEsqueciMinhaSenha.img_voltarClick(Sender: TObject);
begin
      close;
end;

end.
