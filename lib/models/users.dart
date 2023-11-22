class User {
  String id;
  final String nome;
  final String email;
  final String data;
  final String cargo;

  User({
    this.id = '',
    required this.nome,
    required this.email,
    required this.data,
    required this.cargo,
  });

  Map<String, dynamic> toJson() =>
      {'id': id, 'nome': nome, 'email': email, 'data': data, 'cargo': cargo};
}
