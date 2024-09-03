/* import 'package:flutter/material.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_registro.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_recuperar_senha.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_login.dart';
import 'package:contas_compartilhadas/features/home/presentation/pages/home.dart';



const String login = '/login';
const String cadastro = '/cadastro';
const String recuperarSenha = '/recuperacao_senha';
const String home = '/home';

Route controller(RouteSettings settings) {
  switch (settings.name) {
    case login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case cadastro:
      return MaterialPageRoute(builder: (_) => const TelaRegistro());
    case recuperarSenha:
      return MaterialPageRoute(builder: (_) => const PaginaRecuperacaoSenha());
    case home:
      return MaterialPageRoute(builder: (_) => const HomePage());
    default:
      return MaterialPageRoute(builder: (_) => const LoginPage());
  }
}

 */
// rotas.dart
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/presentation/pages/leitor_de_qrcode.dart';
import 'package:contas_compartilhadas/features/group/presentation/pages/pagina_detalhes_grupo.dart';
import 'package:contas_compartilhadas/features/group/presentation/pages/tela_listar_grupos.dart';
import 'package:contas_compartilhadas/features/home/presentation/pages/home.dart';
import 'package:contas_compartilhadas/features/transaction/presentation/pages/tela_criar_transacao.dart';
import 'package:flutter/material.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_login.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_registro.dart';
import 'package:contas_compartilhadas/features/auth/presentation/pages/tela_recuperar_senha.dart';
import 'package:contas_compartilhadas/features/home/presentation/pages/tela_principal.dart';
// import 'package:contas_compartilhadas/features/group/presentation/pages/tela_adicionar_membro.dart';
import 'package:contas_compartilhadas/features/group/presentation/pages/tela_criar_grupo.dart';
import 'package:contas_compartilhadas/features/home/presentation/pages/tela_relatorios.dart';

const String login = '/login';
const String cadastro = '/cadastro';
const String recuperarSenha = '/recuperacao_senha';
const String home = '/home';
const String paginaGrupos = '/pagina_grupos';
const String telaDetalhesGrupo = '/tela_detalhes_grupo';
const String telaAdicionarMembro = '/tela_adicionar_membro';
const String telaCriarGrupo = '/tela_criar_grupo';
const String telaAjudaSuporte = '/tela_ajuda_suporte';
const String telaConfiguracoes = '/tela_configuracoes';
const String telaPerfil = '/tela_perfil';
const String telaRelatorios = '/tela_relatorios';
const String telaCriarTransacao = '/tela_criar_transacao';
const String leitorDeQrCode = '/leitor_de_qr_code';

Route controller(RouteSettings settings) {
  switch (settings.name) {
    case login:
      return MaterialPageRoute(builder: (_) => LoginPage());
    case cadastro:
      return MaterialPageRoute(builder: (_) => TelaRegistro());
    case recuperarSenha:
      return MaterialPageRoute(builder: (_) => PaginaRecuperacaoSenha());
    case home:
      return MaterialPageRoute(builder: (_) => TelaPrincipal());
    case telaDetalhesGrupo:
      final args = settings.arguments as Grupo;
      return MaterialPageRoute(
        builder: (_) => TelaDetalhesGrupo(
          grupo: args,
        ),
      );
    // case telaAdicionarMembro:
    //   return MaterialPageRoute(builder: (_) => TelaAdicionarMembro(grupoId: settings.arguments as String));
    case telaCriarGrupo:
      return MaterialPageRoute(builder: (_) => TelaCriarGrupo());
    case telaRelatorios:
      return MaterialPageRoute(builder: (_) => TelaRelatorios());
    case telaCriarTransacao:
      return MaterialPageRoute(
        builder: (_) => TelaCriarTransacao(),
      );
    case paginaGrupos:
      return MaterialPageRoute(
        builder: (_) => TelaListarGrupos(),
      );
      case leitorDeQrCode:
      return MaterialPageRoute(
        builder: (_) =>LeitorDeQrcode(),
      );
    default:
      return MaterialPageRoute(builder: (_) => HomePage());
  }
}
