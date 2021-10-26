unit UnitMeuPerfil;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts,FireDAC.Comp.Client, FireDAC.DApt;

type
  TFrmMeuPerfil = class(TForm)
    Layout1: TLayout;
    Label1: TLabel;
    img_voltar: TImage;
    Layout2: TLayout;
    Label2: TLabel;
    edt_nome: TEdit;
    Line1: TLine;
    Layout3: TLayout;
    Label3: TLabel;
    edt_cnpj: TEdit;
    Line2: TLine;
    Layout4: TLayout;
    Label4: TLabel;
    edt_empresa: TEdit;
    Line3: TLine;
    Layout5: TLayout;
    Label5: TLabel;
    edt_telefone: TEdit;
    Line4: TLine;
    Layout8: TLayout;
    rect_conta_proximo: TRoundRect;
    Label6: TLabel;
    Layout6: TLayout;
    Label7: TLabel;
    edt_endereco: TEdit;
    Line5: TLine;
    procedure img_voltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure rect_conta_proximoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id_user: integer;
  end;

var
  FrmMeuPerfil: TFrmMeuPerfil;

implementation

{$R *.fmx}

uses UnitPrincipal, cUsuario, UnitDM;


procedure TFrmMeuPerfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      Action := TCloseAction.caFree;
      FrmMeuPerfil := nil;
end;

procedure TFrmMeuPerfil.FormShow(Sender: TObject);
var
      perfil : TUsuario;
      qry : TFDQuery;
      erro : string;
begin
      try
            perfil := TUsuario.Create(dm.conn);
            perfil.ID_USUARIO := id_user;

            qry := perfil.ListarUsuario(erro);

            edt_nome.Text := qry.FieldByName('NOME').AsString;
            edt_cnpj.Text := qry.FieldByName('CNPJ').AsString;
            edt_empresa.Text := qry.FieldByName('EMPRESA').AsString;
            edt_telefone.Text := qry.FieldByName('TELEFONE').AsString;
            edt_endereco.Text := qry.FieldByName('ENDERECO').AsString;

      finally
            qry.DisposeOf;
            perfil.DisposeOf;
      end;

end;

procedure TFrmMeuPerfil.img_voltarClick(Sender: TObject);
begin
      close;
end;

procedure TFrmMeuPerfil.rect_conta_proximoClick(Sender: TObject);
var
      perfil : TUsuario;
      erro : string;
begin
      perfil := TUsuario.Create(dm.conn);

      perfil.ID_USUARIO := id_user;
      perfil.NOME := edt_nome.Text;
      perfil.CNPJ := StrToFloat(edt_cnpj.Text);
      perfil.EMPRESA := edt_empresa.Text;
      perfil.TELEFONE := StrToFloat(edt_telefone.Text);
      perfil.ENDERECO := edt_endereco.Text;


      perfil.Alterar(erro);

      if erro <> '' then
      begin
        ShowMessage(erro);
        exit;
      end;

      ShowMessage('Dados Salvos!');
      close;

end;

end.
