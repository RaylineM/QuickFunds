import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class RegistrarUsuario implements CasoDeUso<Usuario, ParametrosRegistrar> {
  final RepositorioAuth _repositorioAuth;

  RegistrarUsuario(this._repositorioAuth);

  @override
  Future<Either<Falha, Usuario>> call(ParametrosRegistrar params) async {
    return await _repositorioAuth.registrar(
      nome: params.nome,
      email: params.email,
      password: params.password,
    );
  }
}

class ParametrosRegistrar {
  final String nome;
  final String email;
  final String password;

  ParametrosRegistrar({
    required this.nome,
    required this.email,
    required this.password,
  });
}