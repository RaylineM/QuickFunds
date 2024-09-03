import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class ObterGrupo implements CasoDeUso<Grupo, ParametrosObterGrupo> {
  final RepositorioGrupo repositorio;

  ObterGrupo(this.repositorio);

  @override
  Future<Either<Falha, Grupo>> call(ParametrosObterGrupo parametros) async {
    return await repositorio.obterGrupo(grupoId: parametros.grupoId);
  }
}

class ParametrosObterGrupo {
  final String grupoId;

  ParametrosObterGrupo({required this.grupoId});
}
