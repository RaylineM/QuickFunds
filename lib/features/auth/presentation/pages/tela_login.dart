import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:contas_compartilhadas/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:contas_compartilhadas/core/rotas.dart' as rotas;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50], // Cor de fundo
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthEstadoSucesso) {
            Navigator.pushReplacementNamed(context, rotas.home);
          } else if (state is AuthEstadoErro) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.mensagem)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.money_off, size: 40, color: Colors.blueGrey[700]),
                    const SizedBox(width: 10),
                    Text(
                      'QuickFunds',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[800],
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Faça login para continuar',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueGrey[600],
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 40),
                _loginForm(),
                const SizedBox(height: 20),
                _buildForgotPasswordButton(),
                const SizedBox(height: 20),
                _buildRegisterRedirect(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, rotas.recuperarSenha);
      },
      child: Text(
        'Esqueceu a senha?',
        style: TextStyle(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  Widget _buildRegisterRedirect() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, rotas.cadastro);
      },
      child: Text(
        'Não tem uma conta? Registre-se',
        style: TextStyle(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;
      final password = _passwordController.text;

      context.read<AuthBloc>().add(
            EventoLogin(
              email: email,
              senha: password,
            ),
          );
    }
  }
}
