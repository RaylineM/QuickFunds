
import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';


class AtualizarRendaFixaUsuario implements CasoDeUso<void, ParametrosAtualizarRendaFixaUsuario> {
  final RepositorioAuth _repositorioAuth;

  AtualizarRendaFixaUsuario(this._repositorioAuth);

  @override
  Future<Either<Falha, Usuario>> call(ParametrosAtualizarRendaFixaUsuario params) async {
    return _repositorioAuth.atualizarRendaFixaUsuario(
      usuarioId: params.usuarioId,
      novaRendaFixa: params.novaRendaFixa,
    );
  }
}

class ParametrosAtualizarRendaFixaUsuario {
  final String usuarioId;
  final double novaRendaFixa;

  ParametrosAtualizarRendaFixaUsuario({
    required this.usuarioId,
    required this.novaRendaFixa,
  });
}