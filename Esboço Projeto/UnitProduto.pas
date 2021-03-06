unit UnitProduto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit, FMX.EditBox,
  FMX.NumberBox;

type
  TFrmProduto = class(TForm)
    VertScrollBox1: TVertScrollBox;
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    Label2: TLabel;
    Layout3: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Layout4: TLayout;
    Layout5: TLayout;
    Layout6: TLayout;
    Image7: TImage;
    Image8: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Layout7: TLayout;
    Label5: TLabel;
    NumberBox1: TNumberBox;
    Label6: TLabel;
    Layout8: TLayout;
    rect_conta_proximo: TRoundRect;
    Label7: TLabel;
    Layout9: TLayout;
    RoundRect1: TRoundRect;
    Label8: TLabel;
    Layout10: TLayout;
    Label9: TLabel;
    Label10: TLabel;
    img_coracao_vazio: TImage;
    img_coracao_cheio: TImage;
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure img_coracao_vazioClick(Sender: TObject);
    procedure img_coracao_cheioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

{$R *.fmx}

procedure TFrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmProduto := nil;
end;

procedure TFrmProduto.img_coracao_cheioClick(Sender: TObject);
begin
      img_coracao_cheio.Visible := false;
      img_coracao_cheio.HitTest := false;

      img_coracao_vazio.Visible := true;
      img_coracao_vazio.HitTest := true;
end;

procedure TFrmProduto.img_coracao_vazioClick(Sender: TObject);
begin
      img_coracao_vazio.Visible := false;
      img_coracao_vazio.HitTest := false;

      img_coracao_cheio.Visible := true;
      img_coracao_cheio.HitTest := true;
end;

procedure TFrmProduto.img_voltarClick(Sender: TObject);
begin
      close;
end;

end.
