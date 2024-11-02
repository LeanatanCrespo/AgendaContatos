
import 'package:agenda_contatos/persistenciaLogin.dart';
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 16, 71, 61);
  static const Color accent = Color.fromARGB(255, 1, 30, 25);
}

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper();
  bool _isLoading = false; // Para mostrar o indicador de carregamento

  // Função para cadastrar o usuário no banco de dados
  Future<void> _cadastrarUsuario() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Iniciar o carregamento
      });

      String username = _usernameController.text;
      String password = _passwordController.text;

      try {
        await _dbHelper.insertUser(username, password);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cadastro realizado com sucesso!')),
        );
        // Redireciona para a tela de login após o cadastro
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao cadastrar usuário: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Finalizar o carregamento
        });
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose(); // Libera os controladores
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  if (value == null || value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Botão de cadastro
              ElevatedButton(
                onPressed: _isLoading ? null : _cadastrarUsuario,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: _isLoading
                    ? CircularProgressIndicator() // Indicador de carregamento
                    : Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}