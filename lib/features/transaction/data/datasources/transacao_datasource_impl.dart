import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contas_compartilhadas/core/errors/excecoes.dart';
import 'package:contas_compartilhadas/features/transaction/data/datasources/transacao_datasource.dart';
import 'package:contas_compartilhadas/features/transaction/data/models/transacao_modelo.dart';

class TransacaoDataSourceImpl implements TransacaoDataSource {
  final FirebaseFirestore _firestore;

  TransacaoDataSourceImpl(this._firestore);

  @override
  Future<TransacaoModelo> criarTransacao({
    required TransacaoModelo transacaoModelo,
  }) async {
    try {
      final transacaoId = transacaoModelo.transacaoId;
      final grupoId = transacaoModelo.grupoId;
      final colecao = _firestore.collection('transacoes');

      await colecao.doc(transacaoId).set(transacaoModelo.toJson());

      if (grupoId != "0") {
        final grupoColecao = _firestore.collection('grupos');
        final grupoDoc = grupoColecao.doc(grupoId);
        final grupo = await grupoDoc.get();
        final grupoData = grupo.data();
        final transacoes = grupoData!['transacoesId'] as List;
        transacoes.add(transacaoId);
        await grupoDoc.update({'transacoesId': transacoes});
      }

      return transacaoModelo;
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<List<TransacaoModelo>> obterTransacoes({
    required String usuarioId,
  }) async {
    try {
      final colecao = _firestore.collection('transacoes');
      final query =
          await colecao.where('usuarioId', isEqualTo: usuarioId).get();
      final transacoes = query.docs
          .map((doc) => TransacaoModelo.fromJson(doc.data()))
          .toList();
      return transacoes;
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<void> removerTransacao({
    required String transacaoId,
  }) async {
    try {
      final colecao = _firestore.collection('transacoes');
      await colecao.doc(transacaoId).delete();

      final grupoColecao = _firestore.collection('grupos');
      final grupos = await grupoColecao.get();

      for (final grupo in grupos.docs) {
        final grupoData = grupo.data();

        if (grupoData.containsKey('transacoes')) {
          final transacoes = grupoData['transacoes'] as List;

          if (transacoes.contains(transacaoId)) {
            transacoes.remove(transacaoId);
            await grupoColecao.doc(grupo.id).update({'transacoes': transacoes});
            break;
          }
        }
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }
}
