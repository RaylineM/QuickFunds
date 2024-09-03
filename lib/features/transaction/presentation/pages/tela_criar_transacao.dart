import 'package:contas_compartilhadas/core/common/cubit/user/user_cubit.dart';
import 'package:contas_compartilhadas/features/group/data/models/grupo_modelo.dart';
import 'package:contas_compartilhadas/features/group/presentation/bloc/grupo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/transaction/presentation/bloc/transacao_bloc.dart';
import 'package:contas_compartilhadas/core/enums/categoria_transacao.dart';
import 'package:contas_compartilhadas/core/enums/tipo_transacao.dart';
import 'package:intl/intl.dart';


class TelaCriarTransacao extends StatefulWidget {
  const TelaCriarTransacao({
    super.key,
  });

  @override
  State<TelaCriarTransacao> createState() => _TelaCriarTransacaoState();
}

class _TelaCriarTransacaoState extends State<TelaCriarTransacao> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  TipoTransacao? _tipoSelecionado;
  CategoriaTransacao? _categoriaSelecionada;
  final TextEditingController _grupoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tipoSelecionado = TipoTransacao.variavel;
    _categoriaSelecionada = CategoriaTransacao.outros;
    carregarGrupos();
  }

  void selecionarData() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (dataSelecionada != null) {
      _dataController.text = DateFormat('yyyy-MM-dd').format(dataSelecionada);
    }
  }

  void carregarGrupos() {
    BlocProvider.of<GrupoBloc>(context).add(EventoCarregarGrupos(
      usuarioId: context.read<UsuarioCubit>().state.id,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Transação'),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: BlocConsumer<TransacaoBloc, TransacaoState>(
        listener: (context, state) {
          if (state is TransacaoEstadoErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.mensagem),
              ),
            );
          } else if (state is TransacaoEstadoCriadaComSucesso) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transação criada com sucesso.'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is TransacaoEstadoCarregando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _tituloController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _valorController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextField(
                    controller: _dataController,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                    ),
                    onTap: selecionarData,
                  ),
                  const SizedBox(height: 16.0),
                  BlocBuilder<GrupoBloc, GrupoState>(
                    builder: (context, state) {
                      if (state is GrupoEstadoCarregando) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is GrupoEstadoSucesso) {
                        final grupos = state.grupos;
                        final gruposFiltrados = grupos
                            .where((grupo) => grupo.grupoId != 0)
                            .toList();

                        gruposFiltrados.insert(
                            0,
                            GrupoModelo(
                                grupoId: '0',
                                nome: 'Selecione um grupo',
                                descricao: '',
                                membrosId: [],
                                administradorId: '',
                                transacoesId: []));

                        return DropdownButton<String>(
                          value: gruposFiltrados.any((grupo) =>
                                  grupo.grupoId == _grupoController.text)
                              ? _grupoController.text
                              : gruposFiltrados.first.grupoId,
                          onChanged: (String? newValue) {
                            setState(() {
                              _grupoController.text = newValue!;
                            });
                          },
                          items: gruposFiltrados.toSet().map((opcao) {
                            return DropdownMenuItem<String>(
                              value: opcao.grupoId,
                              child: Text(opcao.nome),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Text('Erro ao carregar grupos');
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButton<TipoTransacao>(
                    value: _tipoSelecionado,
                    onChanged: (TipoTransacao? newValue) {
                      setState(() {
                        _tipoSelecionado = newValue;
                      });
                    },
                    items: TipoTransacao.values.map((TipoTransacao tipo) {
                      return DropdownMenuItem<TipoTransacao>(
                        value: tipo,
                        child: Text(tipo.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  DropdownButton<CategoriaTransacao>(
                    value: _categoriaSelecionada,
                    onChanged: (CategoriaTransacao? newValue) {
                      setState(() {
                        _categoriaSelecionada = newValue;
                      });
                    },
                    items: CategoriaTransacao.values
                        .map((CategoriaTransacao categoria) {
                      return DropdownMenuItem<CategoriaTransacao>(
                        value: categoria,
                        child: Text(categoria.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      final titulo = _tituloController.text;
                      final valor =
                          double.tryParse(_valorController.text) ?? 0.0;

                      if (titulo.isEmpty ||
                          valor == 0.0 ||
                          _tipoSelecionado == null ||
                          _categoriaSelecionada == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Todos os campos devem ser preenchidos.')),
                        );
                        return;
                      }

                      final user = context.read<UsuarioCubit>().state;
                      final usuarioId = user.id;

                      BlocProvider.of<TransacaoBloc>(context).add(
                        EventoCriarTransacao(
                          titulo: titulo,
                          valor: valor,
                          usuarioId: usuarioId,
                          data: DateTime.parse(_dataController.text),
                          tipo: _tipoSelecionado!,
                          categoria: _categoriaSelecionada!,
                          grupoId: _grupoController.text,
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text('Criar Transação'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
