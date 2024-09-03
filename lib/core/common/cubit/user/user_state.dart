part of 'user_cubit.dart';

@immutable
sealed class UsuarioState {
  get id => null;
  double get balance => 0;
  bool get prime => false;
}

class UsuarioStateInicial extends UsuarioState {}

class UsuarioStateLogado
 extends UsuarioState {
  final Usuario usuario;

  UsuarioStateLogado
  (this.usuario);

  @override
  String get id => usuario.id;

  @override
  double get balance => 0.0;

  @override
  bool get  prime => false;
}