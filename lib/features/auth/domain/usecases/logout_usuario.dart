import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class UsuarioLogout implements CasoDeUso<void, SemParametros> {
  final RepositorioAuth _repositorioAuth;

  UsuarioLogout(this._repositorioAuth);

  @override
  Future<Either<Falha, void>> call(SemParametros params) async {
    return await _repositorioAuth.logout();
  }
}