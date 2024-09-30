import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:flutter/material.dart';

//tela de edição de cintatos
class Editar extends StatefulWidget {
  final ContatosRepository contatos;
  final int index;
  Editar({required this.contatos, required this.index});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  //pega o valor que sera digitado (nome, telefone e email)
  late TextEditingController nomeController;
  late TextEditingController telefoneController;
  late TextEditingController emailController;

  final _formKey = GlobalKey<FormState>();

  //deixa o formulario de contato ja preenchido
  @override
  void initState() {
    super.initState();
    Contato contato = widget.contatos.getContatos()[widget.index];
    nomeController = TextEditingController(text: contato.nome);
    telefoneController = TextEditingController(text: contato.telefone);
    emailController = TextEditingController(text: contato.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //edita a barrinha superior da tela
      appBar: AppBar(
        title: Text('Editar Contato'),
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
      ),

      //corpo da tela
      body: Container(
        //edição do fundo da tela
        decoration: BoxDecoration(
          gradient: LinearGradient(//cor em degrade
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 192, 224, 219), // Cor inicial 
              const Color.fromARGB(255, 80, 124, 206), // Cor final
            ],
          ),
        ),

        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,

          //campos a ser preenchido do contato
          child: Column(
            children: [

              //nome contato
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

              //telefone do contato
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

              //email do contato
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

              //tamanho  da caixa de campos
              SizedBox(height: 20),

              //botão mpara salvar contato editado
              ElevatedButton(
                onPressed: () {
                  //validação
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      widget.contatos.editaContato(
                          widget.index,
                          //contato editado
                          Contato(
                              nome: nomeController.text,
                              telefone: telefoneController.text,
                              email: emailController.text));
                    });
                    Navigator.pop(context);
                  }
                },
                //edição do botao
                child: Text('Salvar'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 1, 30, 25),
                  backgroundColor: const Color.fromARGB(255, 16, 71, 61),
                ),
              ),

              //botao para deletar contato
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    widget.contatos.deleteContato(widget.index);
                  });
                  Navigator.pop(context);
                },
                //edicção do contato
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