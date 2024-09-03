import 'package:contas_compartilhadas/features/group/presentation/widgets/transacao_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:contas_compartilhadas/features/group/presentation/widgets/grupo_membro_card.dart';

class PaginaDetalhesGrupo extends StatefulWidget {
  final Grupo grupo;

  const PaginaDetalhesGrupo({super.key, required this.grupo});

  @override
  State<PaginaDetalhesGrupo> createState() => _PaginaDetalhesGrupoState();
}

class _PaginaDetalhesGrupoState extends State<PaginaDetalhesGrupo> {
  List<Usuario> membros = [];
  List<Transacao> transacoes = [];

  @override
  void initState() {
    super.initState();
    _carregarDetalhesGrupo();
  }

  void _carregarDetalhesGrupo() {
    context
        .read<GrupoBloc>()
        .add(EventoObterMembros(grupoId: widget.grupo.grupoId));
    context
        .read<GrupoBloc>()
        .add(EventoObterTransacoes(grupoId: widget.grupo.grupoId));
  }

  void _mostrarConfirmacaoExcluirGrupo() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir grupo'),
          content: const Text('Deseja realmente excluir o grupo?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                context
                    .read<GrupoBloc>()
                    .add(EventoRemoverGrupo(grupoId: widget.grupo.grupoId));
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.grupo.nome),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _mostrarConfirmacaoExcluirGrupo,
          ),
        ],
      ),
      body: BlocConsumer<GrupoBloc, GrupoState>(
        listener: (context, state) {
          if (state is GrupoEstadoMembrosObtidosComSucesso) {
            setState(() {
              membros = state.membros;
            });
          }
          if (state is GrupoEstadoTransacoesObtidasComSucesso) {
            setState(() {
              transacoes = state.transacoes;
            });
          }
        },
        builder: (context, state) {
          if (state is GrupoEstadoCarregando) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.grupo.descricao,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Membros',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: membros.length,
                          itemBuilder: (context, index) {
                            return GrupoMembroCard(membro: membros[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Transações',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: transacoes.length,
                          itemBuilder: (context, index) {
                            return TransacaoCard(transacao: transacoes[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
