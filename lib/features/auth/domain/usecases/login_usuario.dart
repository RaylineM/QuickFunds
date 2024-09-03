import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class LoginUsuarios implements CasoDeUso<Usuario, ParametrosLogin> {
  final RepositorioAuth _repositorioAuth;

  LoginUsuarios(this._repositorioAuth);

  @override
  Future<Either<Falha, Usuario>> call(ParametrosLogin params) async {
    return await _repositorioAuth.login(
      email: params.email,
      password: params.password,
    );
  }
}

class ParametrosLogin {
  final String email;
  final String password;

  ParametrosLogin({
    required this.email,
    required this.password,
  });
}