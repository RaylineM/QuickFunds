import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class ObterMembros implements CasoDeUso<List<Usuario>, ParametrosObterMembros> {
  final RepositorioGrupo repositorioGrupo;

  ObterMembros(this.repositorioGrupo);

  @override
  Future<Either<Falha, List<Usuario>>> call(
      ParametrosObterMembros parametros) async {
    return await repositorioGrupo.obterMembros(grupoId: parametros.grupoId);
  }
}

class ParametrosObterMembros {
  final String grupoId;

  ParametrosObterMembros({required this.grupoId});
}
