import 'package:contas_compartilhadas/core/conexao.dart';
import 'package:contas_compartilhadas/core/errors/excecoes.dart';
import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/auth/data/datasources/remote.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:fpdart/fpdart.dart';

class RepositorioAuthImpl implements RepositorioAuth {
  final VerificadorConexao _verificadorConexao;
  final AuthRemoteDataSource _authRemoteDataSource;

  const RepositorioAuthImpl(
    this._authRemoteDataSource,
    this._verificadorConexao,
  );

  @override
  Future<Either<Falha, Usuario>> obterUsuarioAtual() async {
    try {
      if (!await _verificadorConexao.connected) {
        return left(Falha("Sem conexão com a internet"));
      }
      final usuario = await _authRemoteDataSource.getCurrentUserData();
      if (usuario == null) {
        return left(Falha('Usuário não logado'));
      }
      return right(usuario);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem.toString()));
    }
  }

  @override
  Future<Either<Falha, Usuario>> login({
    required String email,
    required String password,
  }) async {
    return _obterUsuario(
      () async => await _authRemoteDataSource.login(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Falha, Usuario>> registrar({
    required String email,
    required String nome,
    required String password,
  }) async {
    return _obterUsuario(
      () async => await _authRemoteDataSource.registrar(
        email: email,
        nome: nome,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Falha, void>> logout() async {
    try {
      if (!await _verificadorConexao.connected) {
        return left(Falha("Sem conexão com a internet"));
      }
      await _authRemoteDataSource.logout();
      return right(null);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem.toString()));
    }
  }

  @override
  Future<Either<Falha, void>> recuperar({required String email}) async {
    try {
      if (!await _verificadorConexao.connected) {
        return left(Falha("Sem conexão com a internet"));
      }
      await _authRemoteDataSource.recuperar(email: email);
      return right(null);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem.toString()));
    }
  }

  @override
  Future<Either<Falha, Usuario>> atualizarRendaFixaUsuario({
    required String usuarioId,
    required double novaRendaFixa,
  }) async {
    return _obterUsuario(
      () async => await _authRemoteDataSource.atualizarRendaFixaUsuario(
        usuarioId: usuarioId, 
        novaRendaFixa: novaRendaFixa,
      ),
    );
  }

  @override
  Future<Either<Falha, Usuario>> atualizarTipoContaUsuario({
    required String usuarioId,
    required bool prime,
  }) async {
    return _obterUsuario(
      () async => await _authRemoteDataSource.atualizarTipoContaUsuario(
        usuarioId: usuarioId, 
        prime: prime,
      ),
    );
  }

  Future<Either<Falha, Usuario>> _obterUsuario(
    Future<Usuario> Function() obterUsuarioFunc,
  ) async {
    try {
      if (!await _verificadorConexao.connected) {
        return left(Falha("Sem conexão com a internet"));
      }
      final resultado = await obterUsuarioFunc();
      return right(resultado);
    } on ExcecoesDoServidor catch (e) {
      return left(Falha(e.mensagem.toString()));
    }
  }
}
