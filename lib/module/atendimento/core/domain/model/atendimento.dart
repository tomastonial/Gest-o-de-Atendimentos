class Atendimento {
  int id;
  String nome;
  String? descricao;
  String? data;
  bool ativo;
  double preco;
  String? foto;

  Atendimento({
    required this.id,
    required this.nome,
    this.descricao,
    this.data,
    required this.ativo,
    required this.preco,
    this.foto,
  });

  factory Atendimento.fromJson(Map<String, dynamic> json) {
    return Atendimento(
      id: json['id'],
      nome: json['nome'],
      descricao: json['descricao'],
      data: json['data'],
      ativo: json['ativo'] == 1,
      preco: json['preco']?.toDouble() ?? 0.0,
      foto: json['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descricao': descricao,
      'data': data,
      'ativo': ativo ? 1 : 0,
      'preco': preco,
      'foto': foto,
    };
  }
}
