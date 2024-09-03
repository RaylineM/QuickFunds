part of 'dependencies.dart';

final localizadorDeServicos = GetIt.instance;

Future<void> iniciarDependencias() async {
  _iniciarAuth();
  _iniciarTransacoes();
  _iniciarGrupos();

  localizadorDeServicos.registerLazySingleton(
    () => FirebaseAuth.instance,
  );

  localizadorDeServicos.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );

  localizadorDeServicos.registerLazySingleton(
    () => UsuarioCubit(),
  );

  localizadorDeServicos.registerFactory(
    () => Connectivity(),
  );

  localizadorDeServicos.registerFactory<VerificadorConexao>(
    () => VerificadorConexaoImpl(
      localizadorDeServicos(),
    ),
  );
}

void _iniciarAuth() {
  localizadorDeServicos
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        localizadorDeServicos(),
        localizadorDeServicos(),
      ),
    )
    ..registerFactory<RepositorioAuth>(
      () => RepositorioAuthImpl(
        localizadorDeServicos(),
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => RegistrarUsuario(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => LoginUsuarios(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => UsuarioLogout(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => RecuperarSenhaUsuario(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => AtualizarRendaFixaUsuario(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => AtualizarTipoContaUsuario(
        localizadorDeServicos(),
      ),
    )
    ..registerFactory(
      () => UsuarioAtual(
        localizadorDeServicos(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        registrarUsuario: localizadorDeServicos(),
        loginUsuarios: localizadorDeServicos(),
        usuarioAtual: localizadorDeServicos(),
        usuarioLogout: localizadorDeServicos(),
        recuperarSenhaUsuario: localizadorDeServicos(),
        atualizarRendaFixaUsuario: localizadorDeServicos(),
        atualizarTipoContaUsuario: localizadorDeServicos(),
        usuarioCubit: localizadorDeServicos(),
      ),
    );
}

void _iniciarTransacoes() {
  localizadorDeServicos
  ..registerFactory<TransacaoDataSource>(
    () => TransacaoDataSourceImpl(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory<RepositorioTransacao>(
    () => RepositorioTransacaoImpl(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => CriarTransacao(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => RemoverTransacao(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => ObterTransacoes(
      localizadorDeServicos(),
    ),
  )
  ..registerLazySingleton(
    () => TransacaoBloc(
      criarTransacao: localizadorDeServicos(),
      removerTransacao: localizadorDeServicos(),
      obterTransacoes: localizadorDeServicos(),
    ),
  );
}

void _iniciarGrupos() {
  localizadorDeServicos
  ..registerFactory<GrupoDatasource>(
    () => GrupoDatasourceImpl(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory<RepositorioGrupo>(
    () => RepositorioGrupoImpl(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => CriarGrupo(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => RemoverGrupo(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => ObterGrupo(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => ObterGrupos(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => AdicionarMembro(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => RemoverMembro(
      localizadorDeServicos(),
    )
  )
  ..registerFactory(
    () => ObterMembros(
      localizadorDeServicos(),
    ),
  )
  ..registerFactory(
    () => ObterTransacoesGrupo(
      localizadorDeServicos(),
    ),
  )
  ..registerLazySingleton(
    () => GrupoBloc(
      criarGrupo: localizadorDeServicos(),
      removerGrupo: localizadorDeServicos(),
      obterGrupos: localizadorDeServicos(),
      obterGrupo: localizadorDeServicos(),
      adicionarMembro: localizadorDeServicos(),
      removerMembro: localizadorDeServicos(),
      obterMembros: localizadorDeServicos(),
      obterTransacoes: localizadorDeServicos(),
    ),
  );
}