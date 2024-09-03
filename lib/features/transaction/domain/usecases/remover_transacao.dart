import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/core/usecases/caso_de_uso.dart';
import 'package:contas_compartilhadas/features/transaction/domain/repos/repositorio_transacao.dart';
import 'package:fpdart/fpdart.dart';

class RemoverTransacao implements CasoDeUso<void, ParametrosRemoverTransacao> {
  final RepositorioTransacao repositorio;

  RemoverTransacao(this.repositorio);

  @override
  Future<Either<Falha, void>> call(ParametrosRemoverTransacao parametros) {
    return repositorio.removerTransacao(
      transacaoId: parametros.transacaoId,
    );
  }
}

class ParametrosRemoverTransacao {
  final String transacaoId;

  ParametrosRemoverTransacao({
    required this.transacaoId,
  });
}
