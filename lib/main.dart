import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/dependencies.dart';
import 'package:contas_compartilhadas/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:contas_compartilhadas/features/transaction/presentation/bloc/transacao_bloc.dart';
import 'package:contas_compartilhadas/core/rotas.dart' as rotas;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup dependencies
  await iniciarDependencias();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => localizadorDeServicos<UsuarioCubit>(),
        ),
        BlocProvider(
          create: (context) => localizadorDeServicos<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => localizadorDeServicos<TransacaoBloc>(),
        ),
        BlocProvider(
          create: (context) => localizadorDeServicos<GrupoBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(EventoUsuarioLogado());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     
      title: 'Contas Compartilhadas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: rotas.controller,
      initialRoute: rotas.home,
       debugShowCheckedModeBanner: false,
    );
  }
}
