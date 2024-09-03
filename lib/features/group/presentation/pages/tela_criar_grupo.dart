import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';

class TelaCriarGrupo extends StatelessWidget {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();

  TelaCriarGrupo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Grupo'),
        backgroundColor: Colors.blueGrey[800], 
        elevation: 0,
      ),
      body: BlocConsumer<GrupoBloc, GrupoState>(
        listener: (context, state) {
          if (state is GrupoEstadoErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.mensagem),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state is GrupoEstadoCriadoComSucesso) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Grupo criado com sucesso!'),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Informações do Grupo',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome do Grupo',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _descricaoController,
                      decoration: InputDecoration(
                        labelText: 'Descrição',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        final nome = _nomeController.text;
                        final descricao = _descricaoController.text;

                        final user = context.read<UsuarioCubit>().state;
                        final administradorId = user.id;
                        BlocProvider.of<GrupoBloc>(context).add(
                          EventoCriarGrupo(
                            nome: nome,
                            descricao: descricao,
                            administradorId: administradorId,
                            membrosId: [],
                            transacoesId: [],
                          ),
                        );

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[800], 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: const Text('Criar Grupo'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
