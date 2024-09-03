/* class Usuario {
  final String id;
  final String email;
  final String nome;

  Usuario({
    required this.id,
    required this.email,
    required this.nome,
    bool prime = false,
  });
}
 */

class Usuario {
  final String id;
  final String email;
  final String nome;
  final bool prime;
  final double renda; // Adicionando propriedade renda
  final List<double> gastos; // Adicionando propriedade gastos

  Usuario({
    required this.id,
    required this.email,
    required this.nome,
    this.prime = false, // Agora armazenamos o valor prime
    this.renda = 0.0, // Definindo um valor padrão para renda
    this.gastos = const [], // Definindo uma lista vazia como padrão para gastos
  });

  // Método para calcular a soma dos gastos
  double get totalGastos => gastos.fold(0.0, (sum, item) => sum + item);
}
