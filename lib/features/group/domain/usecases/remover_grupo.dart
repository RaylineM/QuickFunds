import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:fpdart/fpdart.dart';

class RemoverGrupo implements CasoDeUso<void, ParametrosRemoverGrupo> {
  final RepositorioGrupo _repositorioGrupo;

  RemoverGrupo(this._repositorioGrupo);

  @override
  Future<Either<Falha, void>> call(ParametrosRemoverGrupo parametros) async {
    return await _repositorioGrupo.removerGrupo(
      grupoId: parametros.grupoId,
    );
  }
}

class ParametrosRemoverGrupo {
  final String grupoId;

  ParametrosRemoverGrupo({required this.grupoId});
}
