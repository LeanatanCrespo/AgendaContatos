import 'package:agenda_contatos/cadastro.dart';
import 'package:agenda_contatos/contatosRepository.dart';
import 'package:agenda_contatos/listagem.dart';
import 'package:flutter/material.dart';


//tela inicial
class Principal extends StatelessWidget {
  final ContatosRepository contatos = ContatosRepository();

  @override
  Widget build(BuildContext context) {
    //Obter o tamanho da tela atual
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(

      //edição da barra superior na tela
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

      //corpo da tela atual
      body: Container(

        //edição do fundo da tela
        decoration: BoxDecoration(//cor em degrade para o fundo
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 192, 224, 219),
              const Color.fromARGB(255, 80, 124, 206),
            ],
          ),
        ),

        //padding adaptativo com a tela atual
        padding: EdgeInsets.all(screenWidth * 0.05), 
        
        //edição do enfeite da tela principal
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: screenHeight * 0.05,
              alignment: Alignment.center,
              width: screenWidth,
              color: const Color.fromARGB(255, 16, 71, 61),
            ),
            SizedBox(height: screenHeight * 0.03),

            //botão para a tela de cadastro
            Expanded(
              flex: 2,
              //funcionalidade
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Cadastro(contatos: contatos)),
                  );
                },
                //edição
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

            // Espaçamento adaptativo
            SizedBox(height: screenHeight * 0.03), 

            //botão para a tela de cadastro
            Expanded(
              flex: 2,
              //funcionalidade
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Listagem(contatos: contatos)),
                  );
                },
                //edição
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