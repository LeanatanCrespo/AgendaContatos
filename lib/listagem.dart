import 'package:agenda_contatos/contato.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:agenda_contatos/editar.dart';
import 'package:agenda_contatos/cadastro.dart'; // Importe a tela de cadastro
import 'package:flutter/material.dart';

// Tela com a lista de contatos
class Listagem extends StatefulWidget {
  final ContatosRepository contatos;

  Listagem({required this.contatos});

  @override
  State<Listagem> createState() => ListagemState(contatos: contatos);
}

class ListagemState extends State<Listagem> {
  final ContatosRepository contatos;

  ListagemState({required this.contatos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatinhos'),
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
        actions: [
          // Botão para adicionar novos contatos
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cadastro(contatos: contatos),
                ),
              ).then((_) {
                setState(() {}); // Atualiza a lista ao voltar da tela de cadastro
              });
            },
          ),
        ],
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
        child: contatos.getContatos().isNotEmpty
            ? ListView.builder(
                itemCount: contatos.getContatos().length,
                itemBuilder: (context, index) {
                  Contato c = contatos.getContatos()[index];
                  return ListTile(
                    title: Text(c.nome),
                    subtitle: Text('${c.email} | ${c.telefone}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Editar(
                            contatos: contatos,
                            index: index,
                          ),
                        ),
                      ).then((_) {
                        setState(() {}); // Atualiza a lista após edição
                      });
                    },
                  );
                },
              )
            : Center(child: Text('Nenhum contato cadastrado.')),
      ),
    );
  }
}
