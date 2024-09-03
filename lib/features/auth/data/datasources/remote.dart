import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contas_compartilhadas/features/auth/data/models/usuario.dart';
import 'package:contas_compartilhadas/core/errors/excecoes.dart';

abstract class AuthRemoteDataSource {
  Future<ModeloUsuario> login({
    required String email,
    required String password,
  });

  Future<ModeloUsuario> registrar({
    required String email,
    required String nome, 
    required String password,
  });

  Future<void> recuperar({
    required String email,
  });

  Future<void> logout();

  Future<ModeloUsuario?> getCurrentUserData();

  Future<ModeloUsuario> atualizarRendaFixaUsuario({
    required String usuarioId,
    required double novaRendaFixa,
  });

  Future<ModeloUsuario> atualizarTipoContaUsuario({
    required String usuarioId,
    required bool prime, 
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl(this._auth, this._firestore);

  @override
  Future<ModeloUsuario> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _getUserModelFromFirestore(userCredential.user!);
    } on firebase.FirebaseAuthException catch (e) {
      throw ExcecoesDoServidor(e.message ?? 'Erro desconhecido');
    } catch (e) {
      throw ExcecoesDoServidor(e.toString());
    }
  }

  @override
  Future<ModeloUsuario> registrar({
    required String email,
    required String nome, 
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(nome);

      await userCredential.user!.reload();
      final updatedUser = _auth.currentUser;

      await _createUserDocument(updatedUser!);

      return _getUserModelFromFirestore(updatedUser);
    } on firebase.FirebaseAuthException catch (e) {
      throw ExcecoesDoServidor(e.message ?? 'Erro desconhecido');
    } catch (e) {
      throw ExcecoesDoServidor(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Future<void> recuperar({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on firebase.FirebaseAuthException catch (e) {
      throw ExcecoesDoServidor(e.message ?? 'Erro desconhecido');
    } catch (e) {
      throw ExcecoesDoServidor(e.toString());
    }
  }

  @override
  Future<ModeloUsuario?> getCurrentUserData() async {
    final usuario = _auth.currentUser;
    if (usuario != null) {
      return _getUserModelFromFirestore(usuario);
    }
    return null;
  }

  @override
  Future<ModeloUsuario> atualizarRendaFixaUsuario({
    required String usuarioId,
    required double novaRendaFixa,
  }) async {
    try {
      await _firestore.collection('usuarios').doc(usuarioId).update({
        'rendaFixa': novaRendaFixa,
      });
      return _getUserModelFromFirestore(_auth.currentUser!);
    } catch (e) {
      throw ExcecoesDoServidor(e.toString());
    }
  }

  @override
  Future<ModeloUsuario> atualizarTipoContaUsuario({
    required String usuarioId,
    required bool prime,
  }) async {
    try {
      await _firestore.collection('usuarios').doc(usuarioId).update({
        'prime': prime,
      });
      return _getUserModelFromFirestore(_auth.currentUser!);
    } catch (e) {
      throw ExcecoesDoServidor(e.toString());
    }
  }

  Future<ModeloUsuario> _getUserModelFromFirestore(firebase.User user) async {
    final doc = await _firestore.collection('usuarios').doc(user.uid).get();
    return ModeloUsuario.fromJson(doc.data()!);
  }

  Future<void> _createUserDocument(firebase.User user) async {
    await _firestore.collection('usuarios').doc(user.uid).set({
      'id': user.uid,
      'email': user.email,
      'nome': user.displayName, 
      'rendaFixa': 0.0,
      'prime': false,
    });
  }
}
