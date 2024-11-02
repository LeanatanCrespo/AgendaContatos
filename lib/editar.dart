import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:flutter/material.dart';

// Tela de edição de contatos
class Editar extends StatefulWidget {
  final ContatosRepository contatos;
  final int index;

  Editar({required this.contatos, required this.index});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  late TextEditingController nomeController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;
  
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Contato contato = widget.contatos.getContatos()[widget.index];
    nomeController = TextEditingController(text: contato.nome);
    telefoneController = TextEditingController(text: contato.telefone);
    emailController = TextEditingController(text: contato.email);
  }

  @override
  void dispose() {
    // Libera os controladores quando não forem mais necessários
    nomeController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Contato'),
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                controller: nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome não pode ser vazio.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone'),
                controller: telefoneController,
                validator: (value) {
                  final regex = RegExp(r'^\d{2} \d{8,9}$');
                  if (value == null || !regex.hasMatch(value)) {
                    return 'Formato inválido. Use XX XXXXXXXX ou XX XXXXXXXXX.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O email não pode ser vazio.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    try {
                      widget.contatos.editaContato(
                        widget.index,
                        Contato(
                          nome: nomeController.text,
                          telefone: telefoneController.text,
                          email: emailController.text,
                        ),
                      );
                      Navigator.pop(context, true); // Retorna um valor indicando que houve alteração
                    } catch (e) {
                      print("Erro ao editar contato: $e");
                      // Adicione tratamento de erro conforme necessário
                    }
                  }
                },
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 1, 30, 25),
                  backgroundColor: const Color.fromARGB(255, 16, 71, 61),
                ),
              ),
              SizedBox(height: 10), // Espaçamento entre os botões
              ElevatedButton(
                onPressed: () {
                  try {
                    widget.contatos.deleteContato(widget.index);
                    Navigator.pop(context, true); // Retorna um valor indicando que o contato foi deletado
                  } catch (e) {
                    print("Erro ao deletar contato: $e");
                    // Adicione tratamento de erro conforme necessário
                  }
                },
                child: Text('Deletar'),
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
}