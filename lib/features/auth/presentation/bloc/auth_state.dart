part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

class AuthEstadoInicial extends AuthState {}

class AuthEstadoCarregando extends AuthState {}

class AuthEstadoErro extends AuthState {
  final String mensagem;

  const AuthEstadoErro(this.mensagem);
}

class AuthEstadoSucesso extends AuthState {
  final Usuario usuario;

  const AuthEstadoSucesso(this.usuario);
}

class AuthEstadoAtualizacaoRendaFixaComSucesso extends AuthState {
  final Usuario usuario;

  const AuthEstadoAtualizacaoRendaFixaComSucesso(this.usuario);
}

class AuthEstadoAtualizacaoTipoContaComSucesso extends AuthState {
  final Usuario usuario;

  const AuthEstadoAtualizacaoTipoContaComSucesso(this.usuario);
}

class AuthEstadoRecuperacaoSenhaComSucesso extends AuthState {}
