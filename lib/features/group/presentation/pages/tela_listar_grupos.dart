import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:contas_compartilhadas/core/rotas.dart' as rotas;

class TelaListarGrupos extends StatefulWidget {
  const TelaListarGrupos({super.key});

  @override
  State<TelaListarGrupos> createState() => _TelaListarGruposState();
}

class _TelaListarGruposState extends State<TelaListarGrupos> {
  List<Grupo> grupos = [];
  bool carregouGrupos = false;

  @override
  void initState() {
    super.initState();
    carregarGrupos();
  }

  void carregarGrupos() {
    final usuarioId = context.read<UsuarioCubit>().state.id;
    context.read<GrupoBloc>().add(EventoCarregarGrupos(usuarioId: usuarioId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grupos'),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.black,),
            onPressed: () async {
              Navigator.of(context).pushNamed(rotas.leitorDeQrCode);
            },
          ),
        ],
      ),
      body: BlocConsumer<GrupoBloc, GrupoState>(
        listener: (context, state) {
          if (state is GrupoEstadoErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.mensagem)),
            );
          } else if (state is GrupoEstadoSucesso) {
            setState(() {
              grupos = state.grupos;
              carregouGrupos = true;
            });
          }
        },
        builder: (context, state) {
          if (!carregouGrupos) {
            if (state is GrupoEstadoCarregando) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GrupoEstadoErro) {
              return Center(child: Text(state.mensagem));
            }
          }

          if (grupos.isNotEmpty) {
            return ListView.builder(
              itemCount: grupos.length,
              itemBuilder: (context, index) {
                final grupo = grupos[index];
                return ListTile(
                  title: Text(grupo.nome),
                  subtitle: Text(grupo.descricao),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      rotas.telaDetalhesGrupo,
                      arguments: grupo,
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text('Nenhum grupo encontrado'));
        },
      ),
    );
  }
}
