import 'package:contas_compartilhadas/features/auth/domain/entities/usuario.dart';
import 'package:contas_compartilhadas/features/group/domain/entities/grupo.dart';
import 'package:contas_compartilhadas/features/transaction/domain/entities/transacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';


class TelaDetalhesGrupo extends StatefulWidget {
  final Grupo grupo;

  const TelaDetalhesGrupo({
    super.key,
    required this.grupo,
  });

  @override
  State<TelaDetalhesGrupo> createState() => _TelaDetalhesGrupoState();
}

class _TelaDetalhesGrupoState extends State<TelaDetalhesGrupo> {
  List<Usuario> membros = [];
  List<Transacao> transacoes = [];

  @override
  void initState() {
    super.initState();
    carregarDadosDoGrupo();
  }

  void carregarDadosDoGrupo() {
    final grupoBloc = context.read<GrupoBloc>();
    grupoBloc.add(EventoObterMembros(grupoId: widget.grupo.grupoId));
    grupoBloc.add(EventoObterTransacoes(grupoId: widget.grupo.grupoId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Grupo'),
        backgroundColor: Colors.blueGrey[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black,),
            onPressed: carregarDadosDoGrupo,
          ),
        ],
      ),
      body: BlocConsumer<GrupoBloc, GrupoState>(
        listener: (context, state) {
          if (state is GrupoEstadoMembrosObtidosComSucesso) {
            setState(() {
              membros = state.membros;
              print("Membros: $membros");
            });
          } else if (state is GrupoEstadoTransacoesObtidasComSucesso) {
            setState(() {
              transacoes = state.transacoes;
              print("Transações: $transacoes");
            });
          } else if (state is GrupoEstadoErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.mensagem)),
            );
          }
        },
        builder: (context, state) {
          if (state is GrupoEstadoCarregando &&
              membros.isEmpty &&
              transacoes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: QrImageView(data: widget.grupo.grupoId,),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.grupo.descricao,
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    membros.isNotEmpty
                        ? Column(
                            children: membros
                                .map((membro) => ListTile(
                                      title: Text(membro.nome),
                                    ))
                                .toList(),
                          )
                        : const Center(
                            child: Text('Nenhum membro encontrado'),
                          ),
                    const Divider(),
                    transacoes.isNotEmpty
                        ? Column(
                            children: transacoes
                                .map((transacao) => ListTile(
                                      title: Text(transacao.titulo),
                                      subtitle: Text('R\$ ${transacao.valor}'),
                                    ))
                                .toList(),
                          )
                        : const Center(
                            child: Text('Nenhuma transação encontrada'),
                          ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
