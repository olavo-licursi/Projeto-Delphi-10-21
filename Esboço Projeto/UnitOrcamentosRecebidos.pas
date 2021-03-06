unit UnitOrcamentosRecebidos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView, FMX.Ani;

type
  TFrmOrcamentosRecebidos = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    lv_orcamentos_produtos: TListView;
    RectAnimation1: TRectAnimation;
    procedure img_voltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_orcamentos_produtosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lv_orcamentos_produtosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOrcamentosRecebidos: TFrmOrcamentosRecebidos;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitPerfilUsuario;

procedure TFrmOrcamentosRecebidos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmOrcamentosRecebidos := nil;
end;

procedure TFrmOrcamentosRecebidos.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.c_perfil.Fill.Bitmap.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmPrincipal.AddTransacao(lv_orcamentos_produtos, '0001', 'Fulano', 'Empresa Ciclano', 4500, date, foto);

      foto.DisposeOf;
end;

procedure TFrmOrcamentosRecebidos.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmOrcamentosRecebidos.lv_orcamentos_produtosItemClick(
  const Sender: TObject; const AItem: TListViewItem);
begin
      if NOT Assigned(FrmPerfilUsuario) then
          Application.CreateForm(TFrmPerfilUsuario, FrmPerfilUsuario);

     FrmPerfilUsuario.Show;
end;

procedure TFrmOrcamentosRecebidos.lv_orcamentos_produtosUpdateObjects(
  const Sender: TObject; const AItem: TListViewItem);
begin
      FrmPrincipal.SetupTransacao(lv_orcamentos_produtos ,AItem);
end;

end.
