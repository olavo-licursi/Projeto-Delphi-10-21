unit UnitCarrinho;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrmCarrinho = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Rectangle1: TRectangle;
    Layout6: TLayout;
    Label2: TLabel;
    lv_carrinho: TListView;
    procedure img_voltarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_carrinhoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    procedure ListViewCarrinho(listview: TListView; id_carrinho, titulo,
      empresa, quantidade: string; valor: double;  foto: TStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarrinho: TFrmCarrinho;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFrmCarrinho.ListViewCarrinho(
listview: TListView;
id_carrinho, titulo, empresa, quantidade: string;
valor: double;
foto: TStream);
var
      txt : TListItemText;
      img : TListItemImage;
      bmp : TBitMap;
begin
      with listview.Items.Add do
      begin
            txt := TListItemText(Objects.FindDrawable('TxtTitulo'));
            txt.Text := titulo;

            TListItemText(Objects.FindDrawable('TxtEmpresa')).Text := empresa;
            TListItemText(Objects.FindDrawable('TxtQuantidade')).Text := quantidade;
            TListItemText(Objects.FindDrawable('TxtValor')).Text := FormatFloat('#,##0.00', valor);

            // Icone...
            img := TListItemImage(Objects.FindDrawable('ImgIcone'));
            if foto <> nil then
            begin
              bmp :=  TBitmap.Create;
              bmp.LoadFromStream(foto);

              img.OwnsBitmap := true;
              img.Bitmap := bmp;
            end;
      end;
end;

procedure TFrmCarrinho.lv_carrinhoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
      FrmPrincipal.SetupLimitadorDescricao(lv_carrinho ,AItem, 'TxtTitulo', 'TxtEmpresa');
end;

procedure TFrmCarrinho.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.img_categoria.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmCarrinho.ListViewCarrinho(lv_carrinho, '0001', 'Vendo App', 'Z?zinho Ltda',
      'Quantidade: 1', 4500, foto);

      foto.DisposeOf;
end;

procedure TFrmCarrinho.img_voltarClick(Sender: TObject);
begin
      close;
end;

end.
