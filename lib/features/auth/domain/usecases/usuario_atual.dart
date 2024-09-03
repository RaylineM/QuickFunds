import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class UsuarioAtual implements CasoDeUso<Usuario, SemParametros> {
  final RepositorioAuth _repositorioAuth;

  UsuarioAtual(this._repositorioAuth);

  @override
  Future<Either<Falha, Usuario>> call(SemParametros params) async {
    return await _repositorioAuth.obterUsuarioAtual();
  }
}