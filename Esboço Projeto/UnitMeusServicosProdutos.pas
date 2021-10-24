unit UnitMeusServicosProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFrmMeusServicosProdutos = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    edt_pesquisar: TEdit;
    Line1: TLine;
    Label2: TLabel;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Label3: TLabel;
    lv_meus_servicos_produtos: TListView;
    procedure FormShow(Sender: TObject);
    procedure lv_meus_servicos_produtosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure lv_meus_servicos_produtosItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMeusServicosProdutos: TFrmMeusServicosProdutos;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitCriarVenda;


procedure TFrmMeusServicosProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmMeusServicosProdutos := nil;
end;

procedure TFrmMeusServicosProdutos.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.img_categoria.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmPrincipal.AddTransacao(lv_meus_servicos_produtos, '0001', 'Vendo App', 'Tecnologia', 4500, date, foto);

      foto.DisposeOf;
end;

procedure TFrmMeusServicosProdutos.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmMeusServicosProdutos.lv_meus_servicos_produtosItemClick(
  const Sender: TObject; const AItem: TListViewItem);
begin
      FrmPrincipal.EditarVenda('');
end;

procedure TFrmMeusServicosProdutos.lv_meus_servicos_produtosUpdateObjects(
  const Sender: TObject; const AItem: TListViewItem);
begin
      FrmPrincipal.SetupTransacao(lv_meus_servicos_produtos ,AItem);
end;

end.
