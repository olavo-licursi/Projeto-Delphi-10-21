unit UnitComprar;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView,FireDAC.Comp.Client, FireDAC.DApt, Data.DB;

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
    procedure lv_comprarUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure lv_comprarItemClick(const Sender: TObject;
      const AItem: TListViewItem);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    procedure AddProduto(listview: TListView; id_produto: integer; titulo,
      categoria: string; valor: double; imagem: TStream);
    procedure ListarProdutos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmComprar: TFrmComprar;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitCarrinho, UnitProduto, cUsuario, cProdutoServico,
  UnitDM;

procedure TFrmComprar.AddProduto(
listview: TListView;
id_produto: integer;
titulo, categoria: string;
valor: double;
imagem: TStream);

var
      img : TListItemImage;
      bmp : TBitMap;
begin
      with listview.Items.Add do
      begin
            TListItemText(Objects.FindDrawable('TxtTitulo')).Text := titulo;
            TListItemText(Objects.FindDrawable('TxtCategoria')).Text := categoria;
            TListItemText(Objects.FindDrawable('TxtValor')).Text := FormatFloat('#,##0.00', valor);

            // Icone...
            img := TListItemImage(Objects.FindDrawable('ImgIcone'));
            if imagem <> nil then
            begin
              bmp :=  TBitmap.Create;
              bmp.LoadFromStream(imagem);

              img.OwnsBitmap := true;
              img.Bitmap := bmp;
            end;
      end;
end;


procedure TFrmComprar.ListarProdutos;
var
      prod : TProdutoServico;
      usuario : TUsuario;
      qryProd : TFDQuery;
      qryUsuario : TFDQuery;
      erro : string;
      imagem : TStream;
begin
      try
            prod := TProdutoServico.Create(dm.conn);
            qryProd := prod.ListarProdutoServico(erro);
            usuario := TUsuario.Create(dm.conn);
            qryUsuario := usuario.ListarUsuario(erro);


            while NOT qryProd.Eof do
            begin
                  //Icone
                  if qryProd.FieldByName('IMAGEM').AsString <> '' then
                        imagem := qryProd.CreateBlobStream(qryProd.FieldByName('IMAGEM'),
                        TBlobStreamMode.bmRead)
                  else
                  begin
                        imagem := TMemoryStream.Create;
                        FrmPrincipal.img_categoria.Bitmap.SaveToStream(imagem);
                        imagem.Position := 0;
                  end;


                  AddProduto(lv_comprar,
                             qryProd.FieldByName('ID_PRODUTO').AsInteger,
                             qryProd.FieldByName('TITULO').AsString,
                             qryProd.FieldByName('CATEGORIA').AsString,
                             qryProd.FieldByName('VALOR').AsFloat,
                             imagem);

                  if imagem <> nil then
                        imagem.DisposeOf;

                  qryProd.Next;
            end;
      finally
            qryProd.DisposeOf;
            qryUsuario.DisposeOf;
            prod.DisposeOf;
      end;

end;

procedure TFrmComprar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmComprar := nil;
end;

procedure TFrmComprar.FormShow(Sender: TObject);
begin
      ListarProdutos;
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
