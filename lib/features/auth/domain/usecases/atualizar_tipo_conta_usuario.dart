import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class AtualizarTipoContaUsuario
    implements CasoDeUso<void, ParamentrosAtualizarTipoContaUsuario> {
  final RepositorioAuth _repositorioAuth;

  AtualizarTipoContaUsuario(this._repositorioAuth);

  @override
  Future<Either<Falha, Usuario>> call(
      ParamentrosAtualizarTipoContaUsuario params) async {
    return _repositorioAuth.atualizarTipoContaUsuario(
      usuarioId: params.usuarioId,
      prime: params.prime, 
    );
  }
}

class ParamentrosAtualizarTipoContaUsuario {
  final String usuarioId;
  final bool prime; 

  ParamentrosAtualizarTipoContaUsuario({
    required this.usuarioId,
    required this.prime, 
  });
}
