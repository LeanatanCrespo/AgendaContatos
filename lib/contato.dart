
//classe contato
class Contato {
  String nome;
  String telefone;
  String email;

  Contato({required this.nome, required this.email, required this.telefone});

  // Converte um Contato para um Map (para JSON)
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'telefone': telefone,
      'email': email,
    };
  }

  // Cria um Contato a partir de um Map (de JSON)
  factory Contato.fromJson(Map<String, dynamic> json) {
    return Contato(
      nome: json['nome'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }

  @override
  String toString() {
    return 'Contato(nome: $nome, telefone: $telefone, email: $email)';
  }
}