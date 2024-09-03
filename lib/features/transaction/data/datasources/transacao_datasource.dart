import 'package:contas_compartilhadas/features/transaction/data/models/transacao_modelo.dart';

abstract interface class TransacaoDataSource {
  Future<TransacaoModelo> criarTransacao({
    required TransacaoModelo transacaoModelo,
  });

  Future<List<TransacaoModelo>> obterTransacoes({
    required String usuarioId,
  });

  Future<void> removerTransacao({
    required String transacaoId,
  });
}
