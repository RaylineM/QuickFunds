import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/repos/repositorio_transacao.dart';
import 'package:fpdart/fpdart.dart';

class ObterTransacoes
    implements CasoDeUso<List<Transacao>, ParametrosObterTransacoes> {
  final RepositorioTransacao _repositorioTransacao;

  ObterTransacoes(this._repositorioTransacao);

  @override
  Future<Either<Falha, List<Transacao>>> call(
      ParametrosObterTransacoes parametros) async {
    return await _repositorioTransacao.obterTransacoes(
      usuarioId: parametros.usuarioId,
    );
  }
}

class ParametrosObterTransacoes {
  final String usuarioId;

  ParametrosObterTransacoes({
    required this.usuarioId,
  });
}
