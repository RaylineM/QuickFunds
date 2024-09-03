import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class RecuperarSenhaUsuario implements CasoDeUso<void, ParametrosRecuperarSenha> {
  final RepositorioAuth _repositorioAuth;

  RecuperarSenhaUsuario(this._repositorioAuth);

  @override
  Future<Either<Falha, void>> call(ParametrosRecuperarSenha params) async {
    return await _repositorioAuth.recuperar(
      email: params.email,
    );
  }
}

class ParametrosRecuperarSenha {
  final String email;

  ParametrosRecuperarSenha({
    required this.email,
  });
}
