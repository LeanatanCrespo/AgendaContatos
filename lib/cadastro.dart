import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:flutter/material.dart';


//tela para cadastro de contatos
class Cadastro extends StatefulWidget {
  final ContatosRepository contatos;
  Cadastro({required this.contatos});

  @override
  State<StatefulWidget> createState() => _CadastroState(contatos: contatos);
}

class _CadastroState extends State<Cadastro> {
  //pega o valor que sera digitado (nome, telefone, email e a classe inteira)
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ContatosRepository contatos;

  final _formKey = GlobalKey<FormState>();

  _CadastroState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       //edita a barra de cima da pagina atual
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
        title: Text('Cadastrar Contato'),
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

              //nome do contato
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

              //botão para salvar contato
              ElevatedButton(
                onPressed: () {
                  //validação
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      contatos.addContatos(
                        //contato cadastrado
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
            ],
          ),
        ),
      ),
    );
  }
}