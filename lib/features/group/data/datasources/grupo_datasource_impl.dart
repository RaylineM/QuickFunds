import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contas_compartilhadas/core/errors/excecoes.dart';
import 'package:contas_compartilhadas/features/auth/data/models/usuario.dart';
import 'package:contas_compartilhadas/features/group/data/datasources/grupo_datasource.dart';
import 'package:contas_compartilhadas/features/group/data/models/grupo_modelo.dart';
import 'package:contas_compartilhadas/features/transaction/data/models/transacao_modelo.dart';

class GrupoDatasourceImpl implements GrupoDatasource {
  final FirebaseFirestore _firestore;

  GrupoDatasourceImpl(this._firestore);

  @override
  Future<GrupoModelo> criarGrupo({
    required GrupoModelo grupoModelo,
  }) async {
    try {
      final grupoId = grupoModelo.grupoId;
      final colecao = _firestore.collection('grupos');
      await colecao.doc(grupoId).set(grupoModelo.toJson());

      return grupoModelo;
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<void> removerGrupo({
    required String grupoId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      await colecao.doc(grupoId).delete();
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<GrupoModelo> obterGrupo({
    required String grupoId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupo = await colecao.doc(grupoId).get();

      if (grupo.exists) {
        return GrupoModelo.fromJson(grupo.data() as Map<String, dynamic>);
      } else {
        throw ExcecoesDoServidor('Grupo não encontrado');
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<List<GrupoModelo>> obterGrupos({
    required String usuarioId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupos =
          await colecao.where('membrosId', arrayContains: usuarioId).get();

      return grupos.docs
          .map((grupo) => GrupoModelo.fromJson(grupo.data()))
          .toList();
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<void> adicionarMembro({
    required String grupoId,
    required String usuarioId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupo = await colecao.doc(grupoId).get();

      if (grupo.exists) {
        final membros = List<String>.from(grupo.data()!['membrosId']);
        membros.add(usuarioId);

        await colecao.doc(grupoId).update({'membrosId': membros});
      } else {
        throw ExcecoesDoServidor('Grupo não encontrado');
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<void> removerMembro({
    required String grupoId,
    required String usuarioId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupo = await colecao.doc(grupoId).get();

      if (grupo.exists) {
        final membros = List<String>.from(grupo.data()!['membrosId']);
        membros.remove(usuarioId);

        await colecao.doc(grupoId).update({'mebrosId': membros});
      } else {
        throw ExcecoesDoServidor('Grupo não encontrado');
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<List<ModeloUsuario>> obterMembros({
    required String grupoId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupo = await colecao.doc(grupoId).get();

      if (grupo.exists) {
        final membros = List<String>.from(grupo.data()!['membrosId']);

        print("Membros: $membros");

        final usuarios = await _firestore
            .collection('usuarios')
            .where('id', whereIn: membros)
            .get();

        return usuarios.docs
            .map((usuario) => ModeloUsuario.fromJson(usuario.data()))
            .toList();
      } else {
        throw ExcecoesDoServidor('Grupo não encontrado');
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }

  @override
  Future<List<TransacaoModelo>> obterTransacoes({
    required String grupoId,
  }) async {
    try {
      final colecao = _firestore.collection('grupos');
      final grupo = await colecao.doc(grupoId).get();

      if (grupo.exists) {
        final transacoes =
            List<String>.from(grupo.data()!['transacoesId']);

        final transacoesModelo = <TransacaoModelo>[];

        for (final transacaoId in transacoes) {
          final transacao = await _firestore
              .collection('transacoes')
              .doc(transacaoId)
              .get();

          if (transacao.exists) {
            transacoesModelo.add(
              TransacaoModelo.fromJson(transacao.data() as Map<String, dynamic>),
            );
          }
          return transacoesModelo;
        }
        return transacoesModelo;
      } else {
        throw ExcecoesDoServidor('Grupo não encontrado');
      }
    } on FirebaseException catch (e) {
      throw ExcecoesDoServidor(e.message.toString());
    }
  }
}
