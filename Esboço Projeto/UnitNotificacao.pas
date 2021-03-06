unit UnitNotificacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrmNotificacao = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    lv_notificacao: TListView;
    procedure FormShow(Sender: TObject);
    procedure lv_notificacaoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ListViewNotificacao(listview: TListView; id_limitador, nome,
      descricao, tipo_notificacao: string; foto: TStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotificacao: TFrmNotificacao;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFrmNotificacao.ListViewNotificacao(
listview: TListView;
id_limitador, nome, descricao, tipo_notificacao: string;
foto: TStream);
var
      txt : TListItemText;
      img : TListItemImage;
      bmp : TBitMap;
begin
      with listview.Items.Add do
      begin
            txt := TListItemText(Objects.FindDrawable('TxtNome'));
            txt.Text := nome;

            TListItemText(Objects.FindDrawable('TxtDescricao')).Text := descricao;
            TListItemText(Objects.FindDrawable('TxtTipoNotificacao')).Text := tipo_notificacao;

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

procedure TFrmNotificacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmNotificacao := nil;
end;

procedure TFrmNotificacao.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.c_perfil.Fill.Bitmap.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      ListViewNotificacao(lv_notificacao, '0001', 'Fulano', 'Gostaria de entrar em contato', 'Mensagem', foto);

      foto.DisposeOf;
end;

procedure TFrmNotificacao.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmNotificacao.lv_notificacaoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
      FrmPrincipal.SetupLimitadorDescricao(lv_notificacao ,AItem, 'TxtNome', 'TxtDescricao');
end;

end.
