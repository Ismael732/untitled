import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Tema'),
            subtitle: Text('Alterar o tema do aplicativo'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Lógica para alterar o tema pode ser implementada aqui
              _showThemeOptions(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Notificações'),
            subtitle: Text('Gerenciar notificações'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Lógica para gerenciar notificações pode ser implementada aqui
              _showNotificationSettings(context);
            },
          ),
          Divider(),
          ListTile(
            title: Text('Sobre'),
            subtitle: Text('Informações sobre o aplicativo'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Lógica para mostrar informações sobre o aplicativo
              _showAboutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showThemeOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Escolha o Tema'),
        content: Text('Aqui você pode escolher o tema do aplicativo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Configurações de Notificações'),
        content: Text('Aqui você pode gerenciar suas notificações.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Sobre o Aplicativo'),
        content: Text('Este é um aplicativo exemplo.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
