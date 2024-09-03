import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:fpdart/fpdart.dart';

class ObterTransacoesGrupo
    implements CasoDeUso<List<Transacao>, ParametrosObterTransacoesGrupo> {
  final RepositorioGrupo repositorioGrupo;

  ObterTransacoesGrupo(this.repositorioGrupo);

  @override
  Future<Either<Falha, List<Transacao>>> call(
      ParametrosObterTransacoesGrupo parametros) async {
    return await repositorioGrupo.obterTransacoes(grupoId: parametros.grupoId);
  }
}

class ParametrosObterTransacoesGrupo {
  final String grupoId;

  ParametrosObterTransacoesGrupo({required this.grupoId});
}
