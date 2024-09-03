part of 'grupo_bloc.dart';

@immutable
abstract class GrupoState {
  const GrupoState();
}

class GrupoEstadoInicial extends GrupoState {}

class GrupoEstadoCarregando extends GrupoState {}

class GrupoEstadoErro extends GrupoState {
  final String mensagem;
  const GrupoEstadoErro(this.mensagem);
}

class GrupoEstadoSucesso extends GrupoState {
  final List<Grupo> grupos;
  const GrupoEstadoSucesso(this.grupos);
}

class GrupoEstadoCriadoComSucesso extends GrupoState {
  final Grupo grupo;
  const GrupoEstadoCriadoComSucesso(this.grupo);
}

class GrupoEstadoRemovidoComSucesso extends GrupoState {}

class GrupoEstadoObtidoComSucesso extends GrupoState {
  final Grupo grupo;
  const GrupoEstadoObtidoComSucesso(this.grupo);
}

class GrupoEstadoMembrosObtidosComSucesso extends GrupoState {
  final List<Usuario> membros;
  const GrupoEstadoMembrosObtidosComSucesso(this.membros);
}

class GrupoEstadoMembroAdicionadoComSucesso extends GrupoState {}

class GrupoEstadoMembroRemovidoComSucesso extends GrupoState {}

class GrupoEstadoTransacoesObtidasComSucesso extends GrupoState {
  final List<Transacao> transacoes;
  const GrupoEstadoTransacoesObtidasComSucesso(this.transacoes);
}
