class Contato {
  final String nome;
  final String telefone;
  final String email;

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

  // Sobrescreve o operador == e o hashCode para comparação de objetos
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contato &&
          runtimeType == other.runtimeType &&
          nome == other.nome &&
          telefone == other.telefone &&
          email == other.email;

  @override
  int get hashCode => nome.hashCode ^ telefone.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'Contato(nome: $nome, telefone: $telefone, email: $email)';
  }

  // Método para validar email (opcional)
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  // Método para validar telefone (opcional)
  bool isValidTelefone() {
    final telefoneRegex = RegExp(r'^\d{2} \d{8,9}$');
    return telefoneRegex.hasMatch(telefone);
  }
}