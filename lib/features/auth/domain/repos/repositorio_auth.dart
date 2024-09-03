import 'package:contas_compartilhadas/core/errors/falhas.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class RepositorioAuth {
  Future<Either<Falha, Usuario>> login({
    required String email,
    required String password,
  });

  Future<Either<Falha, Usuario>> registrar({
    required String email,
    required String nome,
    required String password,
  });

  Future<Either<Falha, void>> recuperar({
    required String email,
  });

  Future<Either<Falha, void>> logout();

  Future<Either<Falha, Usuario>> obterUsuarioAtual();

  Future<Either<Falha, Usuario>> atualizarRendaFixaUsuario({
    required String usuarioId,
    required double novaRendaFixa,
  });

  Future<Either<Falha, Usuario>> atualizarTipoContaUsuario({
    required String usuarioId,
    required bool prime, 
  });
}
