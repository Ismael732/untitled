import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final List<Map<String, String>> settingsOptions = [
    {'title': 'Tema', 'subtitle': 'Alterar o tema do aplicativo'},
    {'title': 'Notificações', 'subtitle': 'Gerenciar notificações'},
    {'title': 'Sobre', 'subtitle': 'Informações sobre o aplicativo'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: settingsOptions.length,
        itemBuilder: (context, index) {
          final option = settingsOptions[index];
          return ListTile(
            title: Text(option['title']!),
            subtitle: Text(option['subtitle']!),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => _showSettingDialog(context, option['title']!),
          );
        },
      ),
    );
  }

  void _showSettingDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text('Configurações para $title.'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Fechar')),
        ],
      ),
    );
  }
}
