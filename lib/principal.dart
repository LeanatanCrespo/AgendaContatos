import 'package:flutter/material.dart';
import 'package:agenda_contatos/listagem.dart'; // Para a tela de listagem
import 'package:agenda_contatos/cadastro.dart'; // Para a tela de cadastro
import 'package:agenda_contatos/contatosRepository.dart'; // Certifique-se de que este é o caminho correto

class Principal extends StatelessWidget {
  final ContatosRepository contatos = ContatosRepository();

  @override
  Widget build(BuildContext context) {
    // Obter o tamanho da tela atual
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 71, 61),
        centerTitle: true,
        title: Text(
          "Agenda de Contatinhos",
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 1, 30, 25),
          ),
        ),
        toolbarHeight: 120.0,
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
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cadastro(contatos: contatos)),
                  );
                },
                child: Text(
                  "Cadastrar",
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.6, screenHeight * 0.07),
                  foregroundColor: const Color.fromARGB(255, 1, 30, 25),
                  backgroundColor: const Color.fromARGB(255, 16, 71, 61),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Listagem(contatos: contatos)),
                  );
                },
                child: Text(
                  "Contatos",
                  style: TextStyle(fontSize: screenWidth * 0.05),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.6, screenHeight * 0.07),
                  foregroundColor: const Color.fromARGB(255, 1, 30, 25),
                  backgroundColor: const Color.fromARGB(255, 16, 71, 61),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
