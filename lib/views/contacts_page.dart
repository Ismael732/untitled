import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final List<Map<String, String>> _contacts = [
    {'name': 'João Silva', 'phone': '(11) 1234-5678'},
    {'name': 'Maria Oliveira', 'phone': '(21) 9876-5432'},
    {'name': 'Carlos Souza', 'phone': '(31) 4444-5555'},
    {'name': 'Ana Martins', 'phone': '(41) 2222-3333'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.blue[700],
      ),
      body: ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          final contact = _contacts[index];
          return ListTile(
            leading: Icon(Icons.person),
            title: Text(contact['name']!),
            subtitle: Text(contact['phone']!),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                _showContactDialog(contact);
              },
            ),
          );
        },
      ),
    );
  }

  void _showContactDialog(Map<String, String> contact) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ligar para ${contact['name']}?'),
        content: Text('Número: ${contact['phone']}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Ligar'),
          ),
        ],
      ),
    );
  }
}
