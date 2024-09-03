part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EventoLogin extends AuthEvent {
  final String email;
  final String senha;

  EventoLogin({
    required this.email,
    required this.senha,
  });
}

class EventoRegistrar extends AuthEvent {
  final String nome;
  final String email;
  final String senha;

  EventoRegistrar({
    required this.nome,
    required this.email,
    required this.senha,
  });
}

class EventoRecuperarSenha extends AuthEvent {
  final String email;

  EventoRecuperarSenha({
    required this.email,
  });
}

class EventoAtualizarRendaFixa extends AuthEvent {
  final String usuarioId;
  final double novaRendaFixa;

  EventoAtualizarRendaFixa({
    required this.usuarioId,
    required this.novaRendaFixa,
  });
}

class EventoAtualizarTipoConta extends AuthEvent {
  final String usuarioId;
  final bool novoTipoConta;

  EventoAtualizarTipoConta({
    required this.usuarioId,
    required this.novoTipoConta,
  });
}

class EventoUsuarioLogado extends AuthEvent {}

class EventoUsuarioLogout extends AuthEvent {}
