import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class AdicionarMembro implements CasoDeUso<void, ParametrosAdicionarMembro> {
  final RepositorioGrupo repositorioGrupo;

  AdicionarMembro(this.repositorioGrupo);

  @override
  Future<Either<Falha, void>> call(ParametrosAdicionarMembro parametros) {
    return repositorioGrupo.adicionarMembro(
      grupoId: parametros.grupoId,
      usuarioId: parametros.usuarioId,
    );
  }
}

class ParametrosAdicionarMembro {
  final String grupoId;
  final String usuarioId;

  ParametrosAdicionarMembro({
    required this.grupoId,
    required this.usuarioId,
  });
}
