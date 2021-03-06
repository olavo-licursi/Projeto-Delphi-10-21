unit cUsuario;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
      TUsuario = class
private
      Fconn: TFDConnection;
      FID_USUARIO: Integer;
      FCNPJ: double;
      FEMAIL: string;
      FIMAGEM: TBitmap;
      FEMPRESA: string;
      FSENHA: string;
      FNOME: string;
      FENDERECO: string;
      FTELEFONE: double;



public
      constructor Create(conn: TFDConnection);
      property ID_USUARIO: Integer read FID_USUARIO write FID_USUARIO;
      property NOME: string read FNOME write FNOME;
      property EMAIL: string read FEMAIL write FEMAIL;
      property SENHA: string read FSENHA write FSENHA;
      property CNPJ: double read FCNPJ write FCNPJ;
      property EMPRESA: string read FEMPRESA write FEMPRESA;
      property TELEFONE: double read FTELEFONE write FTELEFONE;
      property ENDERECO: string read FENDERECO write FENDERECO;
      property IMAGEM: TBitmap read FIMAGEM write FIMAGEM;

      function ListarUsuario(out erro: string): TFDQuery;
      function Inserir(out erro: string): Boolean;
      function Alterar(out erro: string): Boolean;
      function Excluir(out erro: string): Boolean;
end;

implementation

{ TUsuario }

constructor TUsuario.Create(conn: TFDConnection);
begin
      Fconn := conn;
end;

function TUsuario.Excluir(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if ID_USUARIO < 0 then
      begin
        erro := 'Informe o ID do Usuario';
        Result := false;
        exit;
      end;

      try
        try
            qry := TFDQuery.Create(nil);
            qry.Connection := Fconn;

            with qry do
            begin
              Active := false;
              sql.Clear;
              sql.Add('DELETE FROM TAB_USUARIO');
              sql.Add('WHERE ID_USUARIO = : ID_USUARIO');
              ParamByName('ID_USUARIO').Value := ID_USUARIO;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao alterar dados: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TUsuario.Alterar(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if ID_USUARIO < 0 then
      begin
        erro := 'Informe o ID do Usuario';
        Result := false;
        exit;
      end;

      try
        try
            qry := TFDQuery.Create(nil);
            qry.Connection := Fconn;

            with qry do
            begin
              Active := false;
              sql.Clear;
              sql.Add('UPDATE TAB_USUARIO SET NOME=:NOME, CNPJ=:CNPJ, EMPRESA=:EMPRESA, TELEFONE=:TELEFONE, ENDERECO=:ENDERECO');
              sql.Add('WHERE ID_USUARIO=:ID_USUARIO');
              ParamByName('NOME').Value := NOME;
              ParamByName('CNPJ').Value := CNPJ;
              ParamByName('EMPRESA').Value := EMPRESA;
              ParamByName('TELEFONE').Value := TELEFONE;
              ParamByName('ENDERECO').Value := ENDERECO;
              ParamByName('ID_USUARIO').Value := ID_USUARIO;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao alterar dados: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TUsuario.Inserir(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if EMAIL = '' then
      begin
        erro := 'Insira um E-mail';
        Result := false;
        exit;
      end;

      try
        try
            qry := TFDQuery.Create(nil);
            qry.Connection := Fconn;

            with qry do
            begin
              Active := false;
              sql.Clear;
              sql.Add('INSERT INTO TAB_USUARIO(EMAIL, SENHA)');
              sql.Add('VALUES(:EMAIL, :SENHA)');
              ParamByName('EMAIL').Value := EMAIL;
              ParamByName('SENHA').Value := SENHA;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao inserir dados: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TUsuario.ListarUsuario(out erro: string): TFDQuery;
var
      qry : TFDQuery;
begin
      try
        qry := TFDQuery.Create(nil);
        qry.Connection := Fconn;

        with qry do
        begin
          Active := false;
          sql.Clear;
          sql.Add('SELECT * FROM TAB_USUARIO');
          sql.Add('WHERE 1=1');

          if ID_USUARIO > 0 then
          begin
                SQL.Add('AND ID_USUARIO = :ID_USUARIO');
                ParamByName('ID_USUARIO').Value := ID_USUARIO;
          end;

          Active := true;
        end;

        Result := qry;
        erro := '';

      except on ex:exception do
      begin
            Result := nil;
            erro := 'Erro ao consultar dados: ' + ex.Message;
      end;

      end;

end;

end.
