unit cProdutoServico;

interface

uses FireDAC.Comp.Client, FireDAC.DApt, System.SysUtils, FMX.Graphics;

type
    TProdutoServico = class
private
      Fconn: TFDConnection;
      FTITULO: string;
      FID_PRODUTO: Integer;
      FVALOR: double;
      FDESCRICAO: string;
      FCATEGORIA: string;
      FIMAGEM: TBitmap;
      FQUANTIDADE: Integer;
      FID_USUARIO: Integer;

public
    constructor Create(conn: TFDConnection);
      property ID_PRODUTO: Integer read FID_PRODUTO write FID_PRODUTO;
      property TITULO: string read FTITULO write FTITULO;
      property DESCRICAO: string read FDESCRICAO write FDESCRICAO;
      property VALOR: double read FVALOR write FVALOR;
      property IMAGEM: TBitmap read FIMAGEM write FIMAGEM;
      property QUANTIDADE: Integer read FQUANTIDADE write FQUANTIDADE;
      property CATEGORIA: string read FCATEGORIA write FCATEGORIA;
      property ID_USUARIO: Integer read FID_USUARIO write FID_USUARIO;

      function ListarProdutoServico(out erro: string): TFDQuery;
      function Inserir(out erro: string): Boolean;
      function Alterar(out erro: string): Boolean;
      function Excluir(out erro: string): Boolean;

end;

implementation

{ TProdutoServico }

constructor TProdutoServico.Create(conn: TFDConnection);
begin
      Fconn := conn;
end;

function TProdutoServico.Excluir(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if ID_PRODUTO < 0 then
      begin
        erro := 'Informe o ID do Produto';
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
              sql.Add('DELETE FROM TAB_PRODUTO');
              sql.Add('WHERE ID_PRODUTO=:ID_PRODUTO');
              ParamByName('ID_PRODUTO').Value := ID_PRODUTO;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao deletar dados: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TProdutoServico.Alterar(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if ID_PRODUTO < 0 then
      begin
        erro := 'Informe o ID do Produto';
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
              sql.Add('UPDATE TAB_PRODUTO SET TITULO=:TITULO, DESCRICAO=:DESCRICAO, VALOR=:VALOR, IMAGEM=:IMAGEM, ');
              sql.Add('QUANTIDADE=:QUANTIDADE, CATEGORIA=:CATEGORIA,');
              sql.Add('ID_USUARIO=:ID_USUARIO');
              sql.Add('WHERE ID_PRODUTO=:ID_PRODUTO');
              ParamByName('TITULO').Value := TITULO;
              ParamByName('DESCRICAO').Value := DESCRICAO;
              ParamByName('VALOR').Value := VALOR;
              ParamByName('IMAGEM').Assign(IMAGEM);
              ParamByName('QUANTIDADE').Value := QUANTIDADE;
              ParamByName('CATEGORIA').Value := CATEGORIA;
              ParamByName('ID_USUARIO').Value := ID_USUARIO;
              ParamByName('ID_PRODUTO').Value := ID_PRODUTO;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao alterar produto: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TProdutoServico.Inserir(out erro: string): Boolean;
var
      qry : TFDQuery;
begin
      //Validações...
      if TITULO = '' then
      begin
        erro := 'Insira um Titulo';
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
              sql.Add('INSERT INTO TAB_PRODUTO(TITULO,DESCRICAO,VALOR,IMAGEM,QUANTIDADE,CATEGORIA,ID_USUARIO)');
              sql.Add('VALUES(:TITULO,:DESCRICAO,:VALOR,:IMAGEM,:QUANTIDADE,:CATEGORIA,:ID_USUARIO)');
              ParamByName('TITULO').Value := TITULO;
              ParamByName('DESCRICAO').Value := DESCRICAO;
              ParamByName('VALOR').Value := VALOR;
              ParamByName('IMAGEM').Assign(IMAGEM);
              ParamByName('QUANTIDADE').Value := QUANTIDADE;
              ParamByName('CATEGORIA').Value := CATEGORIA;
              ParamByName('ID_USUARIO').Value := ID_USUARIO;
              ExecSQL;
            end;

            Result := true;
            erro := '';
        except on ex:exception do
        begin
            Result := false;
            erro := 'Erro ao inserir produto: ' + ex.Message;
        end;
        end;

      finally
        qry.DisposeOf;
      end;

end;

function TProdutoServico.ListarProdutoServico(out erro: string): TFDQuery;
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
          sql.Add('SELECT * FROM TAB_PRODUTO');
          sql.Add('WHERE 1=1');

          if ID_PRODUTO > 0 then
          begin
                SQL.Add('AND ID_PRODUTO = :ID_PRODUTO');
                ParamByName('ID_PRODUTO').Value := ID_PRODUTO;
          end;

          Active := true;
        end;

        Result := qry;
        erro := '';

      except on ex:exception do
      begin
            Result := nil;
            erro := 'Erro ao consultar produto: ' + ex.Message;
      end;

      end;

end;

end.
