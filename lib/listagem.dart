import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:agenda_contatos/editar.dart';
import 'package:flutter/material.dart';


//tela com a lista de contatos
class Listagem extends StatefulWidget {
  final ContatosRepository contatos;
  Listagem({required this.contatos});

  @override
  State<Listagem> createState() => ListagemState(contatos: contatos);
}

class ListagemState extends State<Listagem> {
  //cria a variavel contatos a partir do contato repositorio
  final ContatosRepository contatos;
  ListagemState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //edição da barra superior da tela
      appBar: AppBar(
        title: Text('Lista de contatinhos'),
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
      ),

      //corpo da tela atual
      body: Container(

        //edição do fundo da tela
        decoration: BoxDecoration(//cor em degrade
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight, 
            colors: [
              const Color.fromARGB(255, 192, 224, 219), // Cor inicial 
              const Color.fromARGB(255, 80, 124, 206), // Cor final
            ],
          ),
        ),

        // ListView.builder para exibir os contatos
        child: ListView.builder(
          itemCount: contatos.getContatos().length,
          itemBuilder: (context, index) {
            //busca pelos contatos
            Contato c = contatos.getContatos()[index];
            //mostra o contato buscado
            return ListTile(
              title: Text(c.nome),
              subtitle: Text('${c.email} | ${c.telefone}'),
              //permite acessar a edição de contato ao clicar em cima
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(//acessa a tela de edição
                    builder: (context) => Editar(contatos: contatos, index: index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}