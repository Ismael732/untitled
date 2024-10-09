import 'package:flutter/material.dart';
import '../views/home_page.dart'; // Importação da HomePage
import '../views/login_page.dart'; // Importação da LoginPage

class AuthController {
  // Verifica se o usuário está logado e navega para a HomePage
  void checkLoginStatus(BuildContext context) {
    bool isLoggedIn = false; // Exemplo de verificação de login

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  // Realiza logout e navega para a tela de login
  void logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
