unit UnitTransacoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView;

type
  TFrmTransacoes = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label2: TLabel;
    Rectangle1: TRectangle;
    Layout3: TLayout;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    lv_transacao: TListView;
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lv_transacaoUpdateObjects(const Sender: TObject;
      const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTransacoes: TFrmTransacoes;

implementation

{$R *.fmx}

uses UnitPrincipal;

procedure TFrmTransacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmTransacoes := nil;
end;

procedure TFrmTransacoes.FormShow(Sender: TObject);
var
      foto :TStream;
      x : integer;
begin
      foto := TMemoryStream.Create;
      FrmPrincipal.img_categoria.Bitmap.SaveToStream(foto);
      foto.Position := 0;

      for x := 1 to 10 do
      FrmPrincipal.AddTransacao(FrmTransacoes.lv_transacao, '0001', 'Compra de App', 'Tecnologia', -45, date, foto);

      foto.DisposeOf;
end;

procedure TFrmTransacoes.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmTransacoes.lv_transacaoUpdateObjects(const Sender: TObject;
  const AItem: TListViewItem);
begin
      FrmPrincipal.SetupTransacao(FrmTransacoes.lv_transacao ,AItem);
end;

end.
