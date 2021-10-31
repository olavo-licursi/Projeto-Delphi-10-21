unit UnitCriarVenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, u99Permissions,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.ListBox, FMX.EditBox, FMX.NumberBox, FireDAC.Comp.Client, FireDAC.DApt;

type
  TFrmCriarVendas = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    img_save: TImage;
    Layout2: TLayout;
    Label2: TLabel;
    edt_titulo: TEdit;
    Line1: TLine;
    Layout3: TLayout;
    Label3: TLabel;
    Layout4: TLayout;
    Label4: TLabel;
    Layout5: TLayout;
    Label5: TLabel;
    edt_valor: TEdit;
    Line4: TLine;
    rect_imagem_venda: TRectangle;
    lbl_imagem: TLabel;
    ActionList1: TActionList;
    ActLibrary: TTakePhotoFromLibraryAction;
    Rectangle1: TRectangle;
    Layout6: TLayout;
    Image1: TImage;
    cb_categoria: TComboBox;
    nb_quantidade: TNumberBox;
    lbl_quantidade: TLabel;
    Layout7: TLayout;
    Label6: TLabel;
    edt_descricao: TEdit;
    Line2: TLine;
    procedure img_voltarClick(Sender: TObject);
    procedure rect_imagem_vendaClick(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb_categoriaChange(Sender: TObject);
    procedure img_saveClick(Sender: TObject);
  private
    { Private declarations }
    permissao : T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
    id_user: integer;
  end;

var
  FrmCriarVendas: TFrmCriarVendas;

implementation

{$R *.fmx}

uses UnitPrincipal, UnitDM, cProdutoServico;

procedure TFrmCriarVendas.ActLibraryDidFinishTaking(Image: TBitmap);
begin
      rect_imagem_venda.Fill.Bitmap.Bitmap := Image;
      lbl_imagem.Text := '';
end;

procedure TFrmCriarVendas.cb_categoriaChange(Sender: TObject);
var
      item: String;
begin
      item := cb_categoria.Items[cb_categoria.ItemIndex];
      if item = 'Produto' then
      begin
            lbl_quantidade.Visible := True;
            nb_quantidade.Visible := True;
      end
      else if item = 'Serviço' then
      begin
            lbl_quantidade.Visible := False;
            nb_quantidade.Visible := False;
      end;
end;

procedure TFrmCriarVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmCriarVendas := nil;
end;

procedure TFrmCriarVendas.FormCreate(Sender: TObject);
begin
      permissao := T99Permissions.Create;
end;

procedure TFrmCriarVendas.FormDestroy(Sender: TObject);
begin
      permissao.DisposeOf;
end;

procedure TFrmCriarVendas.img_saveClick(Sender: TObject);
var
      perfil : TProdutoServico;
      erro : string;
      item : string;
begin
      perfil := TProdutoServico.Create(dm.conn);

      item := cb_categoria.Items[cb_categoria.ItemIndex];

      perfil.TITULO := edt_titulo.Text;
      perfil.DESCRICAO := edt_descricao.Text;
      perfil.VALOR := StrToFloat(edt_valor.Text);
      perfil.QUANTIDADE := StrToInt(nb_quantidade.Text);
      perfil.CATEGORIA := item;
      perfil.IMAGEM := rect_imagem_venda.Fill.Bitmap.Bitmap;
      perfil.ID_USUARIO := id_user;


      perfil.Inserir(erro);

      if erro <> '' then
      begin
        ShowMessage(erro);
        exit;
      end;

      ShowMessage('Venda Criada!');
      close;

end;

procedure TFrmCriarVendas.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmCriarVendas.TrataErroPermissao(Sender: TObject);
begin
      showmessage('Você não possui permissao de acesso para esse recurso');
end;

procedure TFrmCriarVendas.rect_imagem_vendaClick(Sender: TObject);
begin
      permissao.PhotoLibrary(ActLibrary, TrataErroPermissao);
end;

end.
