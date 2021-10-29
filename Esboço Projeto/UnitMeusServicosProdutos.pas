unit UnitMeusServicosProdutos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView,FireDAC.Comp.Client, FireDAC.DApt, Data.DB;

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
    procedure lv_meus_servicos_produtosUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure lv_meus_servicos_produtosItemClick(const Sender: TObject;
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
  FrmMeusServicosProdutos: TFrmMeusServicosProdutos;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitCriarVenda, cProdutoServico, UnitDM;

procedure TFrmMeusServicosProdutos.AddProduto(
listview: TListView;
id_produto: integer;
titulo, categoria: string;
valor: double;
imagem: TStream);

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

procedure TFrmMeusServicosProdutos.ListarProdutos;
var
      prod : TProdutoServico;
      qry : TFDQuery;
      erro : string;
      imagem : TStream;
begin
      try
            prod := TProdutoServico.Create(dm.conn);
            qry := prod.ListarProdutoServico(erro);

            while NOT qry.Eof do
            begin
                  //Icone
                  if qry.FieldByName('IMAGEM').AsString <> '' then
                        imagem := qry.CreateBlobStream(qry.FieldByName('IMAGEM'), TBlobStreamMode.bmRead)
                  else
                        imagem := nil;

                  AddProduto(lv_meus_servicos_produtos,
                             qry.FieldByName('ID_PRODUTO').AsInteger,
                             qry.FieldByName('TITULO').AsString,
                             qry.FieldByName('CATEGORIA').AsString,
                             qry.FieldByName('VALOR').AsFloat,
                             imagem);

                  if imagem <> nil then
                        imagem.DisposeOf;

                  qry.Next;
            end;
      finally
            qry.DisposeOf;
            prod.DisposeOf;
      end;

end;


procedure TFrmMeusServicosProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmMeusServicosProdutos := nil;
end;

procedure TFrmMeusServicosProdutos.FormShow(Sender: TObject);
begin
      ListarProdutos;
end;

procedure TFrmMeusServicosProdutos.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmMeusServicosProdutos.lv_meus_servicos_produtosItemClick(
  const Sender: TObject; const AItem: TListViewItem);
begin
      //FrmPrincipal.Vender(1);
end;

procedure TFrmMeusServicosProdutos.lv_meus_servicos_produtosUpdateObjects(
  const Sender: TObject; const AItem: TListViewItem);
begin
      FrmPrincipal.SetupTransacao(lv_meus_servicos_produtos ,AItem);
end;

end.
