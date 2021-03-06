unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Ani, System.Actions, FMX.ActnList;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    img_menu: TImage;
    c_perfil: TCircle;
    Image1: TImage;
    Label1: TLabel;
    Layout2: TLayout;
    lbl_saldo: TLabel;
    Label3: TLabel;
    layout_lancamentos: TLayout;
    Layout4: TLayout;
    Image2: TImage;
    Label4: TLabel;
    Label5: TLabel;
    Layout5: TLayout;
    Layout6: TLayout;
    Image3: TImage;
    Label6: TLabel;
    Label7: TLabel;
    rect_transacoes: TRectangle;
    layout_listview: TLayout;
    Label8: TLabel;
    lbl_todos_trans: TLabel;
    lv_transacao: TListView;
    img_categoria: TImage;
    StyleBook1: TStyleBook;
    rect_menu: TRectangle;
    layout_principal: TLayout;
    AnimationMenu: TFloatAnimation;
    img_fechar_menu: TImage;
    rect_comprar: TRectangle;
    Label10: TLabel;
    rect_vender: TRectangle;
    Label9: TLabel;
    rect_servicos_produtos: TRectangle;
    Label11: TLabel;
    rect_orcamentos_recebidos: TRectangle;
    Label12: TLabel;
    rect_carrinho: TRectangle;
    Label13: TLabel;
    ActionList1: TActionList;
    img_saldo: TImage;
    img_olho_aberto: TImage;
    img_olho_fechado: TImage;
    rect_ajuda: TRectangle;
    Label2: TLabel;
    rect_perfil: TRectangle;
    AnimationPerfil: TFloatAnimation;
    img_fechar_perfil: TImage;
    Layout8: TLayout;
    Layout9: TLayout;
    rect_meu_perfil: TRectangle;
    Label14: TLabel;
    rect_favoritos: TRectangle;
    Label15: TLabel;
    AnimationListView: TFloatAnimation;
    procedure FormShow(Sender: TObject);
    procedure lv_transacaoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure lbl_todos_transClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure img_menuClick(Sender: TObject);
    procedure AnimationMenuFinish(Sender: TObject);
    procedure AnimationMenuProcess(Sender: TObject);
    procedure img_fechar_perfilClick(Sender: TObject);
    procedure rect_venderClick(Sender: TObject);
    procedure rect_comprarClick(Sender: TObject);
    procedure rect_servicos_produtosClick(Sender: TObject);
    procedure rect_orcamentos_recebidosClick(Sender: TObject);
    procedure rect_carrinhoClick(Sender: TObject);
    procedure img_saldoClick(Sender: TObject);
    procedure rect_ajudaClick(Sender: TObject);
    procedure c_perfilClick(Sender: TObject);
    procedure AnimationPerfilFinish(Sender: TObject);
    procedure AnimationPerfilProcess(Sender: TObject);
    procedure rect_meu_perfilClick(Sender: TObject);
    procedure rect_favoritosClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure AnimationListViewFinish(Sender: TObject);
  private
    procedure MeuPerfil(id_user: integer);


    { Private declarations }
  public
    { Public declarations }
    procedure AddTransacao(listview: TListView;id_transacao, descricao, categoria: string;
      valor: double; dt: TDateTime; foto: TStream);
    procedure SetupTransacao(lv: TListView;Item: TListViewItem);
    procedure SetupLimitadorDescricao(lv: TListView; Item: TListViewItem; item1,
      item2: string);
    procedure Vender(id_user: integer);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitTransacoes, UnitCriarVenda, UnitComprar, UnitMeusServicosProdutos,
  UnitOrcamentosRecebidos, UnitCarrinho, UnitAjuda, UnitMeuPerfil,
  UnitFavoritos, UnitNotificacao;

//*************** UNIT GLOBAIS ****************

procedure TFrmPrincipal.AddTransacao(
listview: TListView;
id_transacao, descricao, categoria: string;
valor: double;
dt: TDateTime;
foto: TStream);

var
      txt : TListItemText;
      img : TListItemImage;
      bmp : TBitMap;
begin
      with listview.Items.Add do
      begin
            txt := TListItemText(Objects.FindDrawable('TxtDescricao'));
            txt.Text := descricao;

            TListItemText(Objects.FindDrawable('TxtCategoria')).Text := categoria;
            TListItemText(Objects.FindDrawable('TxtValor')).Text := FormatFloat('#,##0.00', valor);
            TListItemText(Objects.FindDrawable('TxtData')).Text := FormatDateTime('dd/mm', dt);

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



procedure TFrmPrincipal.SetupTransacao(lv: TListView; Item: TListViewItem);
var
      txt_titulo : TListItemText;
begin
      txt_titulo := TListItemText(Item.Objects.FindDrawable('TxtDescricao'));
      txt_titulo.Width := lv.Width - txt_titulo.PlaceOffset.X - 100;
end;


procedure TFrmPrincipal.SetupLimitadorDescricao(lv: TListView; Item: TListViewItem; item1, item2: string);
var
      txt_titulo : TListItemText;
      txt_descricao : TListItemText;
begin
      txt_titulo := TListItemText(Item.Objects.FindDrawable(item1));
      txt_titulo.Width := lv.Width - txt_titulo.PlaceOffset.X - 130;
      txt_descricao := TListItemText(Item.Objects.FindDrawable(item2));
      txt_descricao.Width := lv.Width - txt_descricao.PlaceOffset.X - 130;
end;

// ************************************************************************

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      if Assigned(FrmTransacoes) then
      begin
            FrmTransacoes.DisposeOf;
            FrmTransacoes := nil;
      end;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
      rect_menu.Margins.Left := -260;
      rect_menu.Align := TAlignLayout.Left;
      rect_menu.Visible := true;
      rect_perfil.Margins.Right := -260;
      rect_perfil.Align := TAlignLayout.Right;
      rect_perfil.Visible := true;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      img_categoria.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      AddTransacao(FrmPrincipal.lv_transacao, '0001', 'Compra de App', 'Tecnologia', -4500, date, foto);

      foto.DisposeOf;
end;

procedure TFrmPrincipal.Image1Click(Sender: TObject);
begin
      if NOT Assigned(FrmNotificacao) then
            Application.CreateForm(TFrmNotificacao, FrmNotificacao);

      FrmNotificacao.Show;
end;

procedure TFrmPrincipal.img_fechar_perfilClick(Sender: TObject);
begin
      AnimationPerfil.Start;
end;

procedure TFrmPrincipal.img_menuClick(Sender: TObject);
begin
      AnimationMenu.Start;
end;


procedure TFrmPrincipal.img_saldoClick(Sender: TObject);
begin
      var
      olho_aberto,olho_fechado : TBitmap;
      if lbl_saldo.Visible = true then
      begin
            //Esconde o saldo e muda o icone
            olho_aberto := img_olho_aberto.Bitmap;
            FrmPrincipal.lbl_saldo.Visible := False;
            FrmPrincipal.img_saldo.Bitmap := olho_aberto;

            //Esconde receitas e despesas
            layout_lancamentos.Visible := False;
            rect_transacoes.Visible := False;
      end
      else if lbl_saldo.Visible = false then
      begin
            //Revela o saldo e muda o icone
            olho_fechado := img_olho_fechado.Bitmap;
            FrmPrincipal.lbl_saldo.Visible := True;
            FrmPrincipal.img_saldo.Bitmap := olho_fechado;

            //Revela receitas e despesas
            layout_lancamentos.Visible := True;
            rect_transacoes.Visible := True;
      end;


end;

procedure TFrmPrincipal.lbl_todos_transClick(Sender: TObject);
begin
      if NOT Assigned(FrmTransacoes) then
            Application.CreateForm(TFrmTransacoes, FrmTransacoes);

      FrmTransacoes.Show;
end;

procedure TFrmPrincipal.lv_transacaoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
  SetupTransacao(FrmPrincipal.lv_transacao,AItem);
end;

procedure TFrmPrincipal.rect_ajudaClick(Sender: TObject);
begin
      if NOT Assigned(FrmAjuda) then
          Application.CreateForm(TFrmAjuda, FrmAjuda);

     FrmAjuda.Show;
end;

procedure TFrmPrincipal.rect_carrinhoClick(Sender: TObject);
begin
      if NOT Assigned(FrmCarrinho) then
          Application.CreateForm(TFrmCarrinho, FrmCarrinho);

     FrmCarrinho.Show;
end;

procedure TFrmPrincipal.rect_comprarClick(Sender: TObject);
begin
      if NOT Assigned(FrmComprar) then
          Application.CreateForm(TFrmComprar, FrmComprar);

     FrmComprar.Show;
end;

procedure TFrmPrincipal.rect_favoritosClick(Sender: TObject);
begin
      if NOT Assigned(FrmFavoritos) then
          Application.CreateForm(TFrmFavoritos, FrmFavoritos);

     FrmFavoritos.Show;
end;

procedure TFrmPrincipal.MeuPerfil(id_user: integer);
begin
      if NOT Assigned(FrmMeuPerfil) then
          Application.CreateForm(TFrmMeuPerfil, FrmMeuPerfil);

     FrmMeuPerfil.id_user := id_user;

     FrmMeuPerfil.Show;
end;

procedure TFrmPrincipal.rect_meu_perfilClick(Sender: TObject);
begin
      MeuPerfil(1);
end;

procedure TFrmPrincipal.rect_orcamentos_recebidosClick(Sender: TObject);
begin
      if NOT Assigned(FrmOrcamentosRecebidos) then
          Application.CreateForm(TFrmOrcamentosRecebidos, FrmOrcamentosRecebidos);

     FrmOrcamentosRecebidos.Show;
end;

procedure TFrmPrincipal.rect_servicos_produtosClick(Sender: TObject);
begin
      if NOT Assigned(FrmMeusServicosProdutos) then
          Application.CreateForm(TFrmMeusServicosProdutos, FrmMeusServicosProdutos);

     FrmMeusServicosProdutos.Show;
end;

procedure TFrmPrincipal.rect_venderClick(Sender: TObject);
begin
      Vender(1);
end;

procedure TFrmPrincipal.AnimationListViewFinish(Sender: TObject);
begin
      AnimationListView.Inverse := NOT AnimationListView.Inverse;
end;

procedure TFrmPrincipal.AnimationMenuFinish(Sender: TObject);
begin
      layout_principal.Enabled := AnimationMenu.Inverse;
      AnimationMenu.Inverse := NOT AnimationMenu.Inverse;
end;

procedure TFrmPrincipal.AnimationMenuProcess(Sender: TObject);
begin
      layout_principal.Margins.Right := -260 -rect_menu.Margins.Left;
end;

procedure TFrmPrincipal.AnimationPerfilFinish(Sender: TObject);
begin
      layout_principal.Enabled := AnimationPerfil.Inverse;
      AnimationPerfil.Inverse := NOT AnimationPerfil.Inverse;
end;

procedure TFrmPrincipal.AnimationPerfilProcess(Sender: TObject);
begin
      layout_principal.Margins.Left := -260 - rect_perfil.Margins.Right;
end;

procedure TFrmPrincipal.c_perfilClick(Sender: TObject);
begin
      AnimationPerfil.Start;
end;

procedure TFrmPrincipal.Vender(id_user: integer);
begin
      if NOT Assigned(FrmCriarVendas) then
          Application.CreateForm(TFrmCriarVendas, FrmCriarVendas);

     FrmCriarVendas.id_user := id_user;

     FrmCriarVendas.Show;
end;

end.
