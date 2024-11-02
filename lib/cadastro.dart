import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:flutter/material.dart';

class Cadastro extends StatefulWidget {
  final ContatosRepository contatos;
  Cadastro({required this.contatos});

  @override
  State<StatefulWidget> createState() => _CadastroState(contatos: contatos);
}

class _CadastroState extends State<Cadastro> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ContatosRepository contatos;

  final _formKey = GlobalKey<FormState>();

  _CadastroState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
        title: Text('Cadastrar Contato'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 192, 224, 219),
              const Color.fromARGB(255, 80, 124, 206),
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField('Nome', nomeController, 'O nome não pode ser vazio.'),
              _buildTextField(
                'Telefone',
                telefoneController,
                'Formato inválido. Use XX XXXXXXXX ou XX XXXXXXXXX.',
                pattern: r'^\d{2} \d{8,9}$',
              ),
              _buildTextField('Email', emailController, 'O email não pode ser vazio.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      contatos.addContatos(
                        Contato(
                          nome: nomeController.text,
                          telefone: telefoneController.text,
                          email: emailController.text,
                        ),
                      );
                    });
                    _clearFields();
                    Navigator.pop(context);
                  }
                },
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 1, 30, 25),
                  backgroundColor: const Color.fromARGB(255, 16, 71, 61),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método para construir cada campo de entrada com validação personalizada
  Widget _buildTextField(
      String label, TextEditingController controller, String errorMessage,
      {String? pattern}) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) return errorMessage;
        if (pattern != null && !RegExp(pattern).hasMatch(value)) return errorMessage;
        return null;
      },
    );
  }

  // Limpa os controladores após salvar o contato
  void _clearFields() {
    nomeController.clear();
    telefoneController.clear();
    emailController.clear();
  }
}
