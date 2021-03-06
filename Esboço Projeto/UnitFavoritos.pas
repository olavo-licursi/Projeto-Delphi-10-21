unit UnitFavoritos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Ani, FMX.ListView, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  FMX.Layouts;

type
  TFrmFavoritos = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    lv_favoritos: TListView;
    RectAnimation1: TRectAnimation;
    procedure FormShow(Sender: TObject);
    procedure lv_favoritosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFavoritos: TFrmFavoritos;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFrmFavoritos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmFavoritos := nil;
end;

procedure TFrmFavoritos.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.c_perfil.Fill.Bitmap.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmPrincipal.AddTransacao(lv_favoritos, '0001', 'Fulano', 'Empresa Ciclano', 4500, date, foto);

      foto.DisposeOf;
end;

procedure TFrmFavoritos.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmFavoritos.lv_favoritosUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
      FrmPrincipal.SetupTransacao(lv_favoritos ,AItem);
end;

end.
