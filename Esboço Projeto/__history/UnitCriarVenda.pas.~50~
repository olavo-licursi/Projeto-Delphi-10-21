unit UnitCriarVenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit, u99Permissions,
  System.Actions, FMX.ActnList, FMX.StdActns, FMX.MediaLibrary.Actions,
  FMX.ListBox, FMX.EditBox, FMX.NumberBox;

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
    Edit3: TEdit;
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
    Edit1: TEdit;
    Line2: TLine;
    procedure img_voltarClick(Sender: TObject);
    procedure rect_imagem_vendaClick(Sender: TObject);
    procedure ActLibraryDidFinishTaking(Image: TBitmap);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cb_categoriaChange(Sender: TObject);
  private
    { Private declarations }
    permissao : T99Permissions;
    procedure TrataErroPermissao(Sender: TObject);
  public
    { Public declarations }
  end;

var
  FrmCriarVendas: TFrmCriarVendas;

implementation

{$R *.fmx}

uses UnitPrincipal;

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
