import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class ObterGrupos implements CasoDeUso<List<Grupo>, ParametrosObterGrupos> {
  final RepositorioGrupo repositorio;

  ObterGrupos(this.repositorio);

  @override
  Future<Either<Falha, List<Grupo>>> call(ParametrosObterGrupos parametros) {
    return repositorio.obterGrupos(usuarioId: parametros.usuarioId);
  }
}

class ParametrosObterGrupos {
  final String usuarioId;

  ParametrosObterGrupos({required this.usuarioId});
}
