import 'package:agenda_contatos/contatosRepository.dart';
import 'package:agenda_contatos/fSS.dart';
import 'package:agenda_contatos/tcadastro.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/listagem.dart';
import 'persistenciaLogin.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final SecureStorage _secureStorage = SecureStorage(); // Instância de SecureStorage

  // Função de login
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      bool isAuthenticated = await _dbHelper.login(username, password); // Certifique-se de que a função de login está correta

      if (isAuthenticated) {
        await _secureStorage.saveUserToken(username); // Salva o token
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Listagem(contatos: ContatosRepository()),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nome de usuário ou senha incorretos')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Color.fromARGB(255, 16, 71, 61),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Campo de nome de usuário
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Nome de Usuário'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome de usuário é obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Campo de senha
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A senha é obrigatória';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Botão de login
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 16, 71, 61),
                ),
                child: Text('Login'),
              ),

              // Botão para redirecionar para a tela de cadastro
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroScreen()),
                  );
                },
                child: Text('Não tem uma conta? Cadastre-se'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
