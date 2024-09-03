import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class RemoverMembro implements CasoDeUso<void, ParametrosRemoverMembro> {
  final RepositorioGrupo repositorioGrupo;

  RemoverMembro(this.repositorioGrupo);

  @override
  Future<Either<Falha, void>> call(ParametrosRemoverMembro parametros) {
    return repositorioGrupo.removerMembro(
      grupoId: parametros.grupoId,
      usuarioId: parametros.usuarioId,
    );
  }
}

class ParametrosRemoverMembro {
  final String grupoId;
  final String usuarioId;

  ParametrosRemoverMembro({
    required this.grupoId,
    required this.usuarioId,
  });
}
