unit UnitDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.FMXUI.Wait, Data.DB,
  FireDAC.Comp.Client, System.IOUtils;

type
  Tdm = class(TDataModule)
    conn: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    with Conn do
    begin
        {$IFDEF MSWINDOWS}
        try
            Params.Values['Database'] := 'D:\Projetos\Esbo?o Projeto\DB\banco_permuta.db';
            Connected := true;
        except on E:Exception do
                raise Exception.Create('Erro de conex?o com o banco de dados no Windows: ' + E.Message);
        end;

        {$ELSE}

        Params.Values['DriverID'] := 'SQLite';
        try
            Params.Values['Database'] := TPath.Combine(TPath.GetDocumentsPath, 'banco_permuta.db');
            Connected := true;
        except on E:Exception do
            raise Exception.Create('Erro de conex?o com o banco de dados: ' + E.Message);
        end;
        {$ENDIF}
    end;
end;

end.
