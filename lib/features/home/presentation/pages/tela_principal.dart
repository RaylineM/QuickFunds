import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:contas_compartilhadas/core/rotas.dart' as rotas;
import 'package:fl_chart/fl_chart.dart';

enum TipoTransacao { variavel, fixa }
enum CategoriaTransacao { alimentacao, educacao, saude, lazer, transporte, outros }

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  DateTime _selectedDate = DateTime.now();
  TipoTransacao _selectedTipoTransacao = TipoTransacao.variavel;
  List<PieChartSectionData> _gastos = [];

  final List<Color> _colors = [
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
  ];

  final Map<CategoriaTransacao, String> _categoriaNomes = {
    CategoriaTransacao.alimentacao: "Alimentação",
    CategoriaTransacao.educacao: "Educação",
    CategoriaTransacao.saude: "Saúde",
    CategoriaTransacao.lazer: "Lazer",
    CategoriaTransacao.transporte: "Transporte",
    CategoriaTransacao.outros: "Outros",
  };

  @override
  void initState() {
    super.initState();
    _atualizarDadosGrafico();
  }

  void _atualizarDadosGrafico() {
    setState(() {
      _gastos = List.generate(
        CategoriaTransacao.values.length,
        (index) {
          final categoria = CategoriaTransacao.values[index];
          return PieChartSectionData(
            color: _colors[index % _colors.length],
            value: (index % 5 + 1).toDouble(),
            title: _categoriaNomes[categoria]!,
            radius: 120,
            titleStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final state = authBloc.state;
    final nomeUsuario = state is AuthEstadoSucesso ? state.usuario.nome : 'Usuário';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'QuickFunds',
          style: TextStyle(color: Colors.white), 
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white), 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _buildDateSelector(),
            const SizedBox(height: 16),
            _buildTransactionFilter(),
            const SizedBox(height: 24),
            _buildPieChart(),
            const SizedBox(height: 24),
            _buildGastosCompartilhados(),
          ],
        ),
      ),
      drawer: _buildDrawer(context, nomeUsuario),
    );
  }

  Widget _buildDateSelector() {
    return ElevatedButton(
      onPressed: () async {
        final selectedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime(2020, 1),
          lastDate: DateTime(2101, 12),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.blueGrey[600],
                buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

        if (selectedDate != null && selectedDate != _selectedDate) {
          setState(() {
            _selectedDate = DateTime(selectedDate.year, selectedDate.month);
            _atualizarDadosGrafico();
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[700],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        minimumSize: Size(double.infinity, 50.0),
      ),
      child: Text(
        'Selecionar Mês: ${_selectedDate.month}/${_selectedDate.year}',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildTransactionFilter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterChip('Variável', TipoTransacao.variavel),
        const SizedBox(width: 16.0),
        _buildFilterChip('Fixa', TipoTransacao.fixa),
      ],
    );
  }

  Widget _buildFilterChip(String label, TipoTransacao tipo) {
    return FilterChip(
      label: Text(label),
      selected: _selectedTipoTransacao == tipo,
      onSelected: (selected) {
        setState(() {
          _selectedTipoTransacao = tipo;
          _atualizarDadosGrafico();
        });
      },
      selectedColor: Colors.blueGrey[600],
      backgroundColor: Colors.grey[300],
      labelStyle: TextStyle(color: Colors.blueGrey[900]),
    );
  }

  Widget _buildPieChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 300,
        child: PieChart(
          PieChartData(
            sections: _gastos,
            borderData: FlBorderData(show: false),
            sectionsSpace: 0,
            centerSpaceRadius: 50,
          ),
        ),
      ),
    );
  }

  Widget _buildGastosCompartilhados() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gastos Compartilhados',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Aqui será exibida a lista de gastos compartilhados dos usuários.',
            style: TextStyle(color: Colors.blueGrey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, String nomeUsuario) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey[700]!, Colors.blueGrey[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_circle, size: 80.0, color: Colors.white),
                SizedBox(height: 16.0),
                Text(
                  'Olá, $nomeUsuario!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(context, 'Ver Grupos', rotas.paginaGrupos, Icons.group),
          _buildDrawerItem(context, 'Criar Grupo', rotas.telaCriarGrupo, Icons.add_circle),
          _buildDrawerItem(context, 'Cadastrar Nova Despesa', rotas.telaCriarTransacao, Icons.add),
          _buildDrawerItem(context, 'Sair', null, Icons.exit_to_app, isLogout: true),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, String? route, IconData icon, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueGrey[600]),
      title: Text(title, style: TextStyle(color: Colors.blueGrey[800])),
      onTap: () {
        if (isLogout) {
          final authBloc = BlocProvider.of<AuthBloc>(context);
          authBloc.add(EventoUsuarioLogout());
          Navigator.pushNamedAndRemoveUntil(context, rotas.login, (route) => false);
        } else if (route != null) {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
