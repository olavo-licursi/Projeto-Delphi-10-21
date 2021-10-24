unit UnitComprar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView;

type
  TFrmComprar = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    edt_pesquisar: TEdit;
    Line1: TLine;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Label3: TLabel;
    Layout3: TLayout;
    Rectangle2: TRectangle;
    Layout6: TLayout;
    Label4: TLabel;
    lv_comprar: TListView;
    procedure Rectangle2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lv_comprarUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure lv_comprarItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ListViewComprar(listview: TListView; id_comprar, titulo,
      categoria, empresa: string; valor: double; foto: TStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmComprar: TFrmComprar;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitCarrinho, UnitProduto;

procedure TFrmComprar.ListViewComprar(
listview: TListView;
id_comprar, titulo, categoria, empresa: string;
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

            TListItemText(Objects.FindDrawable('TxtCategoria')).Text := categoria;
            TListItemText(Objects.FindDrawable('TxtEmpresa')).Text := empresa;
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

procedure TFrmComprar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmComprar := nil;
end;

procedure TFrmComprar.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.img_categoria.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmComprar.ListViewComprar(lv_comprar, '0001', 'Vendo App', 'Tecnologia', 'Zézinho Ltda',
      4500, foto);

      foto.DisposeOf;
end;

procedure TFrmComprar.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmComprar.lv_comprarItemClick(const Sender: TObject;
  const AItem: TListViewItem);
begin
      if NOT Assigned(FrmProduto) then
            Application.CreateForm(TFrmProduto, FrmProduto);

      FrmProduto.Show;
end;

procedure TFrmComprar.lv_comprarUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
      FrmPrincipal.SetupLimitadorDescricao(lv_comprar ,AItem, 'TxtTitulo', 'TxtCategoria');
end;

procedure TFrmComprar.Rectangle2Click(Sender: TObject);
begin
      if NOT Assigned(FrmCarrinho) then
          Application.CreateForm(TFrmCarrinho, FrmCarrinho);

     FrmCarrinho.Show;
end;

end.
