program Project1;

uses
  {$IFDEF EurekaLog}
  EMemLeaks,
  EResLeaks,
  EDebugExports,
  EDebugJCL,
  EFixSafeCallException,
  EMapWin32,
  EAppFMX,
  EDialogWinAPIMSClassic,
  EDialogWinAPIEurekaLogDetailed,
  EDialogWinAPIStepsToReproduce,
  ExceptionLog7,
  {$ENDIF EurekaLog}
  System.StartUpCopy,
  FMX.Forms,
  UnitLogin in 'UnitLogin.pas' {FrmLogin},
  u99Permissions in 'Units\u99Permissions.pas',
  UnitPrincipal in 'UnitPrincipal.pas' {FrmPrincipal},
  UnitTransacoes in 'UnitTransacoes.pas' {FrmTransacoes},
  UnitCriarVenda in 'UnitCriarVenda.pas' {FrmCriarVendas},
  UnitComprar in 'UnitComprar.pas' {FrmComprar},
  UnitMeusServicosProdutos in 'UnitMeusServicosProdutos.pas' {FrmMeusServicosProdutos},
  UnitOrcamentosRecebidos in 'UnitOrcamentosRecebidos.pas' {FrmOrcamentosRecebidos},
  UnitEsqueciMinhaSenha in 'UnitEsqueciMinhaSenha.pas' {FrmEsqueciMinhaSenha},
  UnitAjuda in 'UnitAjuda.pas' {FrmAjuda},
  UnitMeuPerfil in 'UnitMeuPerfil.pas' {FrmMeuPerfil},
  UnitFavoritos in 'UnitFavoritos.pas' {FrmFavoritos},
  UnitDM in 'UnitDM.pas' {dm: TDataModule},
  UnitNotificacao in 'UnitNotificacao.pas' {FrmNotificacao},
  UnitProduto in 'UnitProduto.pas' {FrmProduto},
  cUsuario in 'Classes\cUsuario.pas',
  cProdutoServico in 'Classes\cProdutoServico.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.

