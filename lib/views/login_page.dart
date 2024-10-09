import 'package:flutter/material.dart';
import 'package:untitled/views/sign_up_page.dart';
import '../helpers/database_helper.dart'; // Importa o helper do banco de dados

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper(); // Instância do DatabaseHelper

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nome de usuário',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
              ),
            ),
            TextButton(
              onPressed: () {
                _navigateToSignUp(context);
              },
              child: Text('Cadastrar-se'),
            ),
            TextButton(
              onPressed: () {
                _resetPassword(context);
              },
              child: Text('Esqueceu a senha?'),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Buscar usuários no banco de dados
    List<Map<String, dynamic>> users = await _dbHelper.getUsers();

    // Verificar se o usuário existe
    bool userFound = false;
    for (var user in users) {
      if (user['username'] == username && user['password'] == password) {
        userFound = true;
        break;
      }
    }

    if (userFound) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login ou senha incorretos')),
      );
    }
  }

  void _navigateToSignUp(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  void _resetPassword(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Recuperar senha'),
        content: Text('Entre em contato com o suporte para recuperar a senha.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
