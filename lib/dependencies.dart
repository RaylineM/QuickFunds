/* Pacotes Externos */
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

/* Core */
import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/core/conexao.dart';

/* Repositorios */  
import 'package:contas_compartilhadas/features/auth/data/repos/repositorio_auth_impl.dart';
import 'package:contas_compartilhadas/features/auth/domain/repos/repositorio_auth.dart';
import 'package:contas_compartilhadas/features/transaction/data/repos/repositorio_transacao_impl.dart';
import 'package:contas_compartilhadas/features/transaction/domain/repos/repositorio_transacao.dart';
import 'package:contas_compartilhadas/features/group/data/repos/repositorio_grupo_impl.dart';
import 'package:contas_compartilhadas/features/group/domain/repos/repositorio_grupo.dart';

/* Data Sources */
import 'package:contas_compartilhadas/features/auth/data/datasources/remote.dart';
import 'package:contas_compartilhadas/features/transaction/data/datasources/transacao_datasource.dart';
import 'package:contas_compartilhadas/features/transaction/data/datasources/transacao_datasource_impl.dart';
import 'package:contas_compartilhadas/features/group/data/datasources/grupo_datasource.dart';
import 'package:contas_compartilhadas/features/group/data/datasources/grupo_datasource_impl.dart';

/* Casos de Uso */
import 'package:contas_compartilhadas/features/auth/domain/usecases/login_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/logout_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/atualizar_renda_fixa_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/registrar_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/atualizar_tipo_conta_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/recuperar_senha_usuario.dart';
import 'package:contas_compartilhadas/features/auth/domain/usecases/usuario_atual.dart';
import 'package:contas_compartilhadas/features/transaction/domain/usecases/criar_transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/usecases/remover_transacao.dart';
import 'package:contas_compartilhadas/features/transaction/domain/usecases/obter_transacoes.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/criar_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_grupos.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/remover_grupo.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/adicionar_membro.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/remover_membro.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_membros.dart';
import 'package:contas_compartilhadas/features/group/domain/usecases/obter_transacoes_grupo.dart';

/* Blocos */
import 'package:contas_compartilhadas/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:contas_compartilhadas/features/transaction/presentation/bloc/transacao_bloc.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';

/* Outros */
part 'dependencies.main.dart';