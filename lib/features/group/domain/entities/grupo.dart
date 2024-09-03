class Grupo {
  final String grupoId;
  final String nome;
  final String descricao;
  final String administradorId;
  final List<String> membrosId;
  final List<String> transacoesId;

  Grupo({
    required this.grupoId,
    required this.nome,
    required this.descricao,
    required this.administradorId,
    required this.membrosId,
    required this.transacoesId,
  });
}
